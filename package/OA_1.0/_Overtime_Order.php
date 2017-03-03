<?php
/**
 * Created by PhpStorm.
 * @name  运营部管理 ---超时订单管理
 * User: zzc
 * Date: 2015/4/2
 * Time: 16:14
 */

$_REQUEST['action'] = empty($_REQUEST['action']) ? 'list' : $_REQUEST['action'];

class OA_Overtime_Order
{
    static function handle()
    {
        if ($_REQUEST['action'] == 'create_demand_submit') {
            self::createDemand();

        } elseif ($_REQUEST['action'] == 'detail') {
            self::orderHandle();

        } elseif ($_REQUEST['action'] == 'list') {
            self::orderList();

        } elseif ($_REQUEST['action'] == 'order_del') {
            self::orderDel();
        } elseif ($_REQUEST['action'] == 'order_close_submit') {
            self::orderClose();
        }
    }

    static function orderList()
    {
        $type = isset($_REQUEST['type']) ? $_REQUEST['type'] : "waiting";
        Tpl_Smarty::assign('type', $type);
        //获取所有超时订单（创建时间大于十分钟）
        $tmp_time = time() - (10 * 60);
        $over_condition[] = '({table}.create_time < ' . $tmp_time . ' OR {table}.vendor_account_id < 1)';
//        $over_condition[] = '{table}.create_time < ' . $tmp_time;
        $over_condition['order_status'] = 0;
        $over_condition['status'] = 1;
        //获取所有当日已处理的订单
        $done_condition[] = strtotime(date('Y-m-d' . '00:00:00')) . '< {table}.update_time <= ' . time();
        $done_condition['order_status'] = '-3';
        $done_condition['status'] = 3;
        //获取所有历史处理订单
        $history_condition[] = '{table}.update_time <= ' . strtotime(date('Y-m-d' . '00:00:00'));
        $history_condition['order_status'] = '-3';
        $history_condition['status'] = 3;
        $count_o = Data_Mysql_Table_Order_Info::get_order_count($over_condition);
        $count_d = Data_Mysql_Table_Order_Info::get_order_count($done_condition);
        $count_h = Data_Mysql_Table_Order_Info::get_order_count($history_condition);
        //根据类型
        switch ($type) {
            case 'waiting':
                $order_data_list = Data_Mysql_Table_Order_Info::get_overtime_order_list($over_condition);
                break;
            case 'done':
                $order_data_list = Data_Mysql_Table_Order_Info::get_overtime_order_list($done_condition);
                break;
            case 'history':
                $order_data_list = Data_Mysql_Table_Order_Info::get_overtime_order_list($history_condition);
                break;
            default :
                $order_data_list = Data_Mysql_Table_Order_Info::get_overtime_order_list($over_condition);
                break;
        }

        if (!empty($order_data_list['rows'])) {
            $order_data = self::handleArr($order_data_list);
            Tpl_Smarty::assign('_data', $order_data);
        }
        Tpl_Smarty::assign('type', $type);
        Tpl_Smarty::assign('_overtimetotal', empty($count_o[0]) ? 0 : $count_o[0]['c']);
        Tpl_Smarty::assign('_donetotal', empty($count_d[0]) ? 0 : $count_d[0]['c']);
        Tpl_Smarty::assign('_historytotal', empty($count_h[0]) ? 0 : $count_h[0]['c']);
        Tpl_Smarty::display('OA', 'order/over_time_order.tpl');
    }

    /*
     * @订单超时处理详情页
     * */
    static function orderHandle()
    {
        Data_Config_Site::isSpace(21);

        $type = empty($_REQUEST['type']) ? 'info' : $_REQUEST['type'];
        if (empty($_REQUEST['order_no'])) {
            return false;
        }
        //获取当前订单信息
        $r = Data_Mysql_Table_Order_Info::get_overtime_order_info($_REQUEST['order_no']);
        if (empty($r[0]['id'])) {
            Func_Header::notFound();
        }
        $orderInfo = self::handleArr($r);
        Tpl_Smarty::assign('type', $type);
        Tpl_Smarty::assign('_order', $orderInfo[0]);
        Tpl_Smarty::display('OA', 'order/over_time_order_detail.tpl');

    }

    /**
     * @关闭订单
     *
     */
    static function orderClose()
    {
        $order_id = Func_Input::filter(array(
            'order_id' => 'int'
        ), $_REQUEST);
        if (empty($order_id['order_id'])) {
            Func_Header::back('参数错误！。');
        }

        $conditions['id'] = $order_id['order_id'];
        $conditions['order_status'] = 0;
        $conditions['status'] = 1;
        $s_res = Data_Mysql_Table_Order_Info::select('id,vendor_account_id,status,order_status,order_no', $conditions, '');
        if (!empty($s_res[0]['id'])) {
            $data = array('order_status' => '-3', 'status' => '3',
                'order_close_info' => array('操作者ID' => $_SESSION['administrator']['id'],
                    '操作者名称' => $_SESSION['administrator']['fullname'],
                    '操作内容' => '直接关闭订单没有创建需求'
                ));
            $sta = Data_Mysql_Table_Order_Info::update(array('id=?' => $conditions['id']), $data);
            if ($sta[0] == 1) {
                //创建历史记录
                $history_data = array('object_id' => $s_res[0]['id'], 'admin_id' => $_SESSION['administrator']['id'], 'operate_type' => 1, 'data_backup' => $s_res[0]);
                Data_Mysql_Table_History::subTable('_order' . date("_Ym"))->insert($history_data);
                //创建订单的操作日志
                Data_Mysql_Table_Order_Log::insertOrderLog($s_res[0]['id'], $s_res[0]['order_no'], $_SESSION['administrator']['id'], "关闭订单", "关闭");

                $a = Api_Vendor_Notice_OverTimeOrder::notice(array('account_id' => $s_res[0]['vendor_account_id'],
                    'order_no' => $s_res[0]['order_no']));

                Func_Header::to('  订单关闭成功！。。', '?type=done');

            } else {
                Func_Header::to('订单关闭失败！。。', '?');
            }
        } else {
            Func_Header::to('当前订单不可关闭！。。', '?');
        }
    }

    /*
     *创建需求，添加联系人库，关闭订单
     */
    static function createDemand()
    {
        $request = Func_Input::filter(array(
            'account_id' => 'int',
            'phone' => 'int',
            'vendor_reply' => 'string',
            'account_reply' => 'string',
            'username' => 'string',
            'order_id' => 'int',
            'product_id' => 'int',
            'product_set_id' => 'int',
            'order_no' => 'string',
            'order_title' => 'string',
            'demand' => 'array'
        ), $_REQUEST);
        //关闭订单原因
        if (!empty($request['vendor_reply']) || !empty($request['account_reply'])) {
            $order['order_close_info'] = array(
                '供应商回复' => $request['vendor_reply'],
                '客户回复' => $request['account_reply'],
                '操作者ID' => $_SESSION['administrator']['id'],
                '操作者名称' => $_SESSION['administrator']['username']
            );
        }
        if (empty($request['product_id'])) {

            $demand['demand'] = array(
                'set_id' => $request['product_set_id'],
                '用户ID' => $request['account_id'],
                '手机号' => $request['phone'],
                '联系人' => $request['username'],
                '订单编号' => $request['order_no'],
                '具体要求' => $request['order_title'],
                '业务类型' => '',

            );
        } else {
            $demand['demand'] = array(
                'product_id' => $request['product_id'],
                '用户ID' => $request['account_id'],
                '手机号' => $request['phone'],
                '联系人' => $request['username'],
                '订单编号' => $request['order_no'],
                '具体要求' => $request['order_title'],
                '业务类型' => '',
            );

        }
        if (!empty($order['order_close_info'])) {
            $demand['demand']['订单关闭原因'] = $order['order_close_info'];
        }
        $dd = array(
            'account_id' => $request['account_id'],
            'phone' => $request['phone'],
            'demand_name' => $request['username'],
            'demand_type' => '订单转发',
            'demand_status' => 0,
            'demand' => $demand['demand'],
        );
        $data = Api_Demand_Create::create($dd);
        if ($data) {
            //添加联系人

            $contact = Data_Mysql_Table_Contact_Library::select("account_id", array('account_id' => $request['account_id']), '', 1);
            if (empty($contact[0])) {
                $userInfo = Data_Mysql_Table_Account::select("username,phone,attr", array('id' => $_REQUEST['account_id']));
                $contact = array(
                    'account_id' => $request['account_id'],
                    'username' => $userInfo[0]['username'],
                    'phone' => $userInfo[0]['phone'],
                    'attr' => $userInfo[0]['attr'],
                    'state' => 1,
                    'new_demand_time' => time(),
                    'status' => 1,
                );
                $c = Data_Mysql_Table_Contact_Library::insert($contact);
            } else {
                $c = array('1');
            }
            if ($c[0] > 0) {
                $order['status'] = 3;
                $order['order_status'] = '-3';
                $o = Data_Mysql_Table_Order_Info::update(array('id' => $request['order_id']), $order);

                if ($o[0] > 0) {
                    $log = Data_Mysql_Table_Order_Info::select('id,order_no,order_status', array('id' => $request['order_id']));
                    //创建历史记录
                    $history_data = array('object_id' => $request['order_id'], 'admin_id' => $_SESSION['administrator']['id'], 'operate_type' => 1, 'data_backup' => $log[0]);
                    Data_Mysql_Table_History::subTable('_order' . date("_Ym"))->insert($history_data);
                    //创建订单的操作日志
                    Data_Mysql_Table_Order_Log::insertOrderLog($request['order_id'], $log[0]['order_no'], $_SESSION['administrator']['id'], "关闭订单", "关闭");

                    Func_Header::to('  订单关闭成功。', Core::$urls['root'] . Core::$urls['package'] . 'operation/demand_operate?action=receive&demand_id=' . $data['data']);
                }
            }
        }
    }

    /*
     *@订单删除
     */
    static function  orderDel()
    {
        $request = Func_Input::filter(array(
            'order_id' => 'int'
        ));
        if (empty($request['order_id'])) {
            Func_Header::back('参数错误！');
        }
        $conditions['id'] = $request['order_id'];
        $conditions['order_status'] = '-3';
        $conditions['status'] = '3';
        $rs = Data_Mysql_Table_Order_Info::update($conditions, array('status' => '-9'));
        if (!empty($rs[0])) {
            $log = Data_Mysql_Table_Order_Info::select('id,order_no', array('id' => $request['order_id']));
            //创建历史记录
            $history_data = array('object_id' => $request['order_id'], 'admin_id' => $_SESSION['administrator']['id'], 'operate_type' => 1, 'data_backup' => $log[0]);
            Data_Mysql_Table_History::subTable('_order' . date("_Ym"))->insert($history_data);
            //创建订单的操作日志
            Data_Mysql_Table_Order_Log::insertOrderLog($request['order_id'], $log[0]['order_no'], $_SESSION['administrator']['id'], "删除订单", "删除");
            Func_Header::to(' 操作成功', Core::$urls['root'] . Core::$urls['package'] . 'operation/overtime_order?type=history');
        } else {
            Func_Header::to('操作异常！', '?');
        }
    }

    /*
     *订单数组处理
     */
    static function handleArr($arr)
    {
        if (!empty($arr['rows'])) {
            //有分页
            foreach ($arr['rows'] as $key => $value) {
                $arr['rows'][$key]['order_detail'] = json_decode($value['order_detail'], 1);
                $arr['rows'][$key]['order_status'] = Data_Mysql_Table_Order_Info::tplOrderStatus($value['order_status']);
                $countIds[] = $value['buyer_account_id'];
                $productIds[] = $value['product_id'];
                $vendorIds[] = $value['vendor_account_id'];
                if (@stripos($value['username'], '同立') || @stripos($value['vendor_name'], '同立')) {
                    unset($arr['rows'][$key]);
                }
            }


        } else {
            //无分页
            foreach ($arr as $key => $value) {
                $arr[$key]['order_detail'] = json_decode($value['order_detail'], 1);
                $arr[$key]['order_conform'] = json_decode($value['order_conform'], 1);
                $arr[$key]['order_close_info'] = json_decode($value['order_close_info'], 1);
                $arr[$key]['order_complete'] = json_decode($value['order_complete'], 1);
                $arr[$key]['start_date'] = $value['start_time'] ? date('Y-m-d', $value['start_time']) : '';
                $arr[$key]['update_time'] = $value['update_time'] ? date('Y-m-d H:i:s', $value['update_time']) : '';
                $arr[$key]['order_status'] = Data_Mysql_Table_Order_Info::tplOrderStatus($value['order_status']);
                $arr[$key]['base_info'] = json_decode($value['base_info'], 1);
                $countIds[] = $value['buyer_account_id'];
                $productIds[] = $value['product_id'];
                $vendorIds[] = $value['vendor_account_id'];
                if (@stripos($value['username'], '同立') || @stripos($value['vendor_name'], '同立')) {
                    unset($arr[$key]);
                }
            }
        }

        return $arr;
    }

}
