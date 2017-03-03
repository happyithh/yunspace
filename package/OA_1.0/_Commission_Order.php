<?php
/**
 * Created by PhpStorm.
 * 佣金订单
 * User: zzc
 * Date: 2015/4/2
 */

$_REQUEST['action'] = empty($_REQUEST['action']) ? "commission_order" : $_REQUEST['action'];

class OA_Commission_Order
{

    static function  handle()
    {
        if ($_REQUEST['action'] == 'commission_order') {
            //佣金订单列表
            self::commission_order();
        } elseif ($_REQUEST['action'] == 'commission_order_detail') {
            //佣金订单详情
            self::commission_order_detail();
        } elseif ($_REQUEST['action'] == 'update_order_commisson_submit') {
            //设置佣金
            self:: update_order_commisson();
        }elseif($_REQUEST['action'] == 'get_order_detail'){
            //获取订单详情
            self:: get_order_detail();
        }

    }

    static function commission_order()
    {
        $type = isset($_REQUEST['type']) ? $_REQUEST['type'] : "waiting";
        //未处理订单佣金
        $commis_condition[] = "{table}.order_status>= 12 and {table}.order_commission = 0";
        $commis_condition['status'] = 1;
        //获取所有当日已处理的订单佣金
        $done_condition[] = strtotime(Date('Y-m-d')) . '< {table}.update_time <= ' . time();
        $done_condition[] = '{table}.order_status>= 12 and {table}.order_commission > 0 ';
        //获取所有历史处理订单佣金
        $history_condition[] = '{table}.update_time <= ' . strtotime(Date('Y-m-d'));
        $history_condition[] = '{table}.order_status >= 12 and {table}.order_commission > 0';

        $count_c = Data_Mysql_Table_Order_Info::get_order_count($commis_condition);
        $count_d = Data_Mysql_Table_Order_Info::get_order_count($done_condition);
        $count_h = Data_Mysql_Table_Order_Info::get_order_count($history_condition);
        //根据类型
        switch ($type) {
            case 'waiting':
                $commission_order_list = self::get_commission_order_list($commis_condition);
                break;
            case 'done':
                $commission_order_list = self::get_commission_order_list($done_condition);
                break;
            case 'history':
                $commission_order_list = self::get_commission_order_list($history_condition);

                break;
            default :
                $commission_order_list = self::get_commission_order_list($commis_condition);
                break;
        }
        if (!empty($commission_order_list['rows'])) {
            $commission_order = self::orderInfoArray($commission_order_list);
        }
        Tpl_Smarty::assign('_data', $commission_order);
        Tpl_Smarty::assign('type', $type);
        Tpl_Smarty::assign('_waitingtotal', $count_c[0]['c']);
        Tpl_Smarty::assign('_donetotal', $count_d[0]['c']);
        Tpl_Smarty::assign('_historytotal', $count_h[0]['c']);
        Tpl_Smarty::display('OA', 'order/commission_order.tpl');
    }

    /*
     *@佣金订单详细
     * */

    static function commission_order_detail()
    {
        Data_Config_Site::isSpace(21);
        $type = empty($_REQUEST['type']) ? 'info' : $_REQUEST['type'];
        if (empty($_REQUEST['order_no'])) {
            return false;
        }
        //获取当前订单信息
        $r = self::get_commission_order_detail($_REQUEST['order_no']);
        if (empty($r[0]['id'])) {
            Func_Header::notFound();
        }
        $orderInfo = self::orderInfoArray($r);
        Tpl_Smarty::assign('type', $type);
        Tpl_Smarty::assign('_order', $orderInfo[0]);
        Tpl_Smarty::display('OA', 'order/commission_order_detail.tpl');
    }

    /*
     * @输入订单佣金
     *
     * */
    static function update_order_commisson()
    {

        if (empty($_REQUEST['order_id'])) {
            return false;
        }
        $request = Func_Input::filter(array(
            'order_id' => 'int',
            'order_commission' => 'int'
        ), $_REQUEST);
        if (empty($request['order_commission'])) {
            Func_Header::back('佣金金额输入错误');
        }
        $order_price_last = Data_Mysql_Table_Order_Info::select('order_price,order_no', array('id' => $request['order_id']));
        if ($request['order_commission'] >= ($order_price_last[0]['order_price'])) {
            Func_Header::back('佣金金额大于订单金额');
        }
        $data['order_commission'] = $request['order_commission'];
        $data['status'] = 10;   //已处理
        $sta = Data_Mysql_Table_Order_Info::update(array('id' => $request['order_id']), $data);

        if ($sta[0] > 0) {
            //创建历史记录
            $history_data=array('object_id'=>$request['order_id'],'admin_id'=>$_SESSION['administrator']['id'],'operate_type'=>1,'data_backup'=>$order_price_last[0]);
            Data_Mysql_Table_History::subTable('_order' . date("_Ym"))->insert($history_data);
            //创建订单的操作日志
            Data_Mysql_Table_Order_Log::insertOrderLog($request['order_id'],$order_price_last[0]['order_no'],$_SESSION['administrator']['id'],'订单设置佣金',"更新");
            Func_Header::to('  设置佣金成功', '?');
        }

    }


    /*
     *订单数组处理
     */
    static function orderInfoArray($arr)
    {
        if (!empty($arr['rows'])) {
            //有分页
            foreach ($arr['rows'] as $key => $value)
            {
                $arr['rows'][$key]['order_detail'] = json_decode($value['order_detail'], 1);
                $arr['rows'][$key]['order_status'] = Data_Mysql_Table_Order_Info::tplOrderStatus($value['order_status']);
            }
        } else {
            //无分页
            foreach ($arr as $key => $value)
            {
                $arr[$key]['order_detail'] = json_decode($value['order_detail'], 1);
                $arr[$key]['order_conform'] = json_decode($value['order_conform'], 1);
                $arr[$key]['order_close_info'] = json_decode($value['order_close_info'], 1);
                $arr[$key]['order_complete'] = json_decode($value['order_complete'], 1);
                $arr[$key]['start_date'] = $value['start_time'] ? date('Y-m-d', $value['start_time']) : '';
                $arr[$key]['update_time'] = $value['update_time'] ? date('Y-m-d H:i:s', $value['update_time']) : '';
                $arr[$key]['order_status'] =  Data_Mysql_Table_Order_Info::tplOrderStatus($value['order_status']);
                $arr[$key]['base_info'] = json_decode($value['base_info'], 1);
            }
        }
        return $arr;
    }

    /*
     *@获取佣金订单列表
     *@参数 where
     **/
    static function get_commission_order_list($condition)
    {
        $cols = array('{table}.id,{table}.order_detail,{table}.order_title,{table}.order_no,{table}.create_time5,{table}.order_price,{table}.order_price_last,{table}.order_commission,{table}.order_status,{table}.status,{table}.create_time,a1.username,
            a1.phone,v1.vendor_name');
        $table = '{table} LEFT JOIN {prefix}vendor_info as v1 ON {table}.vendor_id =v1.id
        LEFT JOIN {prefix}account as a1 ON {table}.buyer_account_id =a1.id';
        $data = Data_Mysql_Table_Order_Info::page(0, 15, $cols, $condition, 'ORDER BY {table}.create_time desc', $table);

        return $data;
    }

    /*
    * @获取超时订单详细
    * @参数  订单编号
    * @返回  data
    * */
    static function get_commission_order_detail($order_no)
    {
        if (empty($order_no)) {
            return false;
        }
        $table = '
        {table} LEFT JOIN {prefix}product_info  as p1  ON {table}.product_id =p1.id
        LEFT JOIN {prefix}vendor_info as v1 ON {table}.vendor_id =v1.id
        LEFT JOIN {prefix}account as a1 ON {table}.buyer_account_id =a1.id';
        $cols = array('{table}.id,{table}.order_no,{table}.buyer_account_id,{table}.vendor_account_id,{table}.vendor_id,
        {table}.product_id,{table}.order_detail,{table}.order_price,{table}.create_time5,{table}.order_commission,{table}.order_status,{table}.status,{table}.create_time,{table}.create_time2,{table}.create_time3,{table}.create_time4,
        {table}.start_time,{table}.end_time,{table}.update_time,{table}.order_conform,{table}.order_title,{table}.order_complete,{table}.order_close_info,
        a1.username,a1.phone,v1.vendor_name,v1.base_info,p1.product_name,p1.des,
        p1.attr');
        $data = Data_Mysql_Table_Order_Info:: select($cols, array(
            '{table}.order_no = ?' => $order_no), '', '1', $table);
        return $data;
    }
    /*
      * @根据订单号显示详情页
      * @ $_RESQUEST 订单号，点击类型，
      * */
    static function get_order_detail()
    {
        if (empty($_REQUEST['order_no'])) {
            return false;
        }
        $type = empty($_REQUEST['type']) ? 'info' : $_REQUEST['type'];
        Data_Config_Site::isSpace(21);
        //获取当前订单信息
        $r = OA_Commission_Order::get_commission_order_detail($_REQUEST['order_no']);
        if (empty($r[0]['id'])) {
            Func_Header::notFound();
        }
        $orderInfo = OA_Commission_Order::orderInfoArray($r);
        Tpl_Smarty::assign('_order', $orderInfo[0]);
        Tpl_Smarty::assign('type', $type);
        Tpl_Smarty::display('OA', 'order/order_detail.tpl');
    }



}