<?php

/**
 * Created by PhpStorm.
 * account: liushengchun
 * Date: 15/1/28
 * Time: 11:41
 */
class Data_Mysql_Table_Order_Info extends Data_Mysql_Table
{
    public $cols = array(
        'order_no' => '50',
        'buyer_account_id' => 'int',
        'vendor_account_id' => 'int',
        'vendor_id' => 'int',
        'vendor_name' => '100',   //供应商名称
        'product_id' => 'int',
        'product_set_id' => 'int',
        'product_category_id' => 'int',
        'start_time' => 'int',
        'end_time' => 'int',
        'remark' => '500',
        'order_title' => '200',
        'order_price' => '11',     //订单签约价格
        'order_commission' => 'int',  //订单佣金
        'order_commission_is_pay' => 'int',  //订单佣金支付时间
        'deal_account_id' => 'int', //经纪人账户 ID
        'order_commission_deal_per' => 'int',  //订单营销佣金比例
        'order_price_last' => '11',   //订单结算价格
        'order_price_pay' => '11',   //订单支付金额
        'order_detail' => 'array', //预定细节
        'order_conform' => 'array', //
        'order_tracking' => 'array',//订单追踪
        'order_complete' => 'array',
        'order_status' => 'tinyint', //
        'order_payment_percent' => 'tinyint', //0-1000  千分比
        'order_close_info' => 'array', //关闭理由
        'create_time' => 'int',   //1下单时间
        'create_time2' => 'int', //2审核时间
        'create_time3' => 'int', //3签约完成时间
        'create_time4' => 'int', //4支付完成时间
        'create_time5' => 'int', //5结算时间
        'cancel_time' => 'int', //取消合同时间
        'close_time' => 'int', //协议结算时间
        'admin_id' => 'int',    //操作人ID
        'update_time' => 'int',
        'status' => 'tinyint',  //1 正常  3 超时订单已处理  -9 订单已删除,
    );
    public $index = array(
        'order_no' => 'u',
        'order_title,vendor_name' => 'title',
        'buyer_account_id' => 'i',
        'vendor_account_id' => 'i',
        'deal_account_id' => 'i',
        'vendor_id' => 'i',
        'product_id' => 'i',
        'product_set_id' => 'i',
        'product_category_id' => 'i',
        'start_time' => 'i',
        'end_time' => 'i',
        'order_status' => 'i',
        'create_time' => 'i',
        'update_time' => 'i',
        'status' => 'i',
    );
    public $title = array(
        "" => "产品信息",                                                     //空键,表名
        'order_no' => '订单编号',
        'buyer_account_id' => '买家账号 ID',
        'vendor_account_id' => '供应商账号ID',
        'vendor_id' => '供应商 ID',
        'product_id' => '产品 ID',
        'product_category_id' => '产品类型 ID',
        'start_time' => '开始时间',
        'order_price_last' => '最终价格',
        'order_price_pay' => '已支付金额',
        'order_status' => '订单状态',
        'order_payment_percent' => '支付比例',
        'create_time' => '添加时间',
        'update_time' => '更新时间',
    );
    public $titleHidden = array( //    list / form / both
    );
    public $filter = array(
        'status' => array(
            99 => '回收站',
            1 => '正常',
        ),
    );
    //订单状态显示在模板，与order_status  字段 一致
    static $order_status_tpl = array(
        0 => '预定',
        5 => '审核通过',
//        6 => '审核未通过',
//        7 => '管理员转单',
//        10 => '协议确认',
//        11 => '供应商签约',
        12 => '买家签约',
        15 => '买家付款',
//        80 => '待评价',
        90 => '订单完成',
//        91 => '订单结算完成',
//        95 => '订单投拆',
        -1 => '订单关闭',
        110 => '买家发起取消订单需求',
        115 => '卖家发起取消订单需求',
        120 => '卖家拒绝取消订单',
        125 => '买家拒绝取消订单'
    );

    //订单状态码显示
    static
        //订单状态统计
        $counter = array(
        '1' => array(
            '待审核',
            0
        ),
        '2' => array(
            '待签约',
            0
        ),
        '3' => array(
            '待支付',
            0
        ),
//        '4' => array(
//            '待评价',
//            0
//        ),
        '5' => array(
            '已完成',
            0
        ),
        '-10' => array(          //已取消、已拒绝           合并为已取消
            '已取消',
            0
        ),
        '-9' => array(
            '已关闭',
            0
        ),
        '0' => array(
            '全部',
            0
        ),

    );

    //显示订单名称
    static function  tplOrderStatus($order_status)
    {
        if ($order_status >= 0) {
            $status_name = Data_Mysql_Table_Order_Info::$order_status_tpl[$order_status];
        } else {
            $status_name = '关闭';
        }
        return $status_name;
    }

    /*
     *@获取超时订单列表
     *@参数 where
     **/
    static function get_overtime_order_list($over_condition)
    {
        $cols = array('{table}.id,{table}.order_detail,{table}.buyer_account_id,{table}.product_id,{table}.order_title,{table}.order_no,{table}.order_status,{table}.status,{table}.create_time,{table}.update_time,a1.username,
            a1.phone,v1.vendor_name,v1.vendor_account_id');
        $table = '{table} LEFT JOIN {prefix}vendor_info as v1 ON {table}.vendor_id =v1.id
        LEFT JOIN {prefix}account as a1 ON {table}.buyer_account_id =a1.id';
        $data = Data_Mysql_Table_Order_Info::page(0, 15, $cols, $over_condition, 'ORDER BY {table}.create_time desc', $table);
        foreach ($data['rows'] as $k => $v) {
            $data['rows'][$k]['gap'] = time() - $v['create_time'];
        }
        return $data;
    }

    /*
     * @获取超时订单详细
     * @参数  订单编号
     * @返回  data
     * */
    static function get_overtime_order_info($order_no)
    {
        if (empty($order_no)) {
            return false;
        }
        $table = '
        {table} LEFT JOIN {prefix}product_info  as p1  ON {table}.product_id =p1.id
        LEFT JOIN {prefix}vendor_info as v1 ON {table}.vendor_id =v1.id
        LEFT JOIN {prefix}account as a1 ON {table}.buyer_account_id =a1.id
        LEFT JOIN {prefix}account as a2 ON {table}.vendor_account_id =a2.id';
        $cols = array('{table}.id,{table}.product_set_id,{table}.order_no,{table}.buyer_account_id,{table}.vendor_account_id,{table}.vendor_id,
        {table}.product_id,{table}.order_detail,{table}.order_status,{table}.status,{table}.create_time,{table}.create_time2,{table}.create_time3,{table}.create_time4,
        {table}.start_time,{table}.end_time,{table}.update_time,{table}.order_conform,{table}.order_title,{table}.order_complete,{table}.order_close_info,
        a1.username,a1.phone, a2.phone as vendor_phone, v1.vendor_name,v1.base_info,p1.product_name,p1.des,
        p1.attr');

        $data = Data_Mysql_Table_Order_Info:: select($cols, array(
            '{table}.order_no = ?' => $order_no), '', '1', $table);
        return $data;
    }

    /*
     * @获取订单数量
     * @参数  where
     * @返回  array
     * */
    static function  get_order_count($contidions)
    {
        $table = '{table} LEFT JOIN {prefix}vendor_info as v1 ON {table}.vendor_id =v1.id
        LEFT JOIN {prefix}account as a1 ON {table}.buyer_account_id =a1.id';

        $count = Data_Mysql_Table_Order_Info::select('count(*) as c,{table}.status', $contidions, '', '1', $table);
        return $count;
    }

    /*
     *取消未支付的套餐订单
     */
    static function page($page = 0, $num = 0, $cols = "*", $conditions = null, $additionSql = "", $table = "{table}")
    {
        //每天执行一次
        $order_timestamp = Core::readData(Core::$paths["temp"] . "data/order_close." . (Core::$debugToken ? 1 : 0));
        if (empty($order_timestamp)) {
            Core::writeData(Core::$paths["temp"] . "data/order_close." . (Core::$debugToken ? 1 : 0), 1);
        } elseif ($order_timestamp < (time() - 24 * 3600)) {
            self::CancelNotPaySetOrder();
        }
        return self::getInstance()->___handler->page($page, $num, $cols, $conditions, $additionSql, $table);
    }

    static function CancelNotPaySetOrder()
    {
        //关闭已取消的创建时间大于一周的订单
        $A_week = (time() - (60 * 60 * 24 * 7));
        $log_data = Data_Mysql_Table_Order_Info::select('id,order_no', array('create_time < ? AND order_status < ? ' => array($A_week, 0)));
        if (!empty($log_data)) {
            foreach ($log_data as $k => $v) {
                Data_Mysql_Table_Order_Info::exec("UPDATE {table} SET  `status` = '-9' WHERE create_time < " . $A_week . " and order_status < 0 AND id=" . $v['id'], 1);
                //创建历史记录
                $history_data = array('object_id' => $v['id'], 'admin_id' => 0, 'operate_type' => 1, 'data_backup' => $v);
                Data_Mysql_Table_History::subTable('_order' . date("_Ym"))->insert($history_data);
                //创建订单的操作日志
                Data_Mysql_Table_Order_Log::insertOrderLog($v['id'], $v['order_no'], 0, "关闭取消时间超过一周的订单", "关闭");
            }
        }

        /*
         * 订单是否支付的判断条件是create_time3是否为空
         * 获取所有满足条件的订单
         * 更新满足条件的订单状态为-2 即关闭订单
         */
        $condition['create_time3'] = 0;
        $condition['product_set_id != ?'] = 0;
        $condition['create_time < ?'] = strtotime(Func_WorkingDay::getWorkingDays(time(), -5));
        $condition['order_status >= ?'] = 0;
        $orders = array();
        $orders = Data_Mysql_Table_Order_Info::select('id,order_no,order_status,product_set_id,start_time,end_time', $condition, '', 9999999);
        $ids = $setInfo = array();
        foreach ($orders as $k => $val) {
            $ids[] = $val['id'];
            $setInfo[] = array('set_id' => $val['product_set_id'], 'start_time' => $val['start_time'], 'end_time' => $val['end_time']);
        }
        //不关闭create_time3为0的，状态为-1（待审核）的线下支付
        $payment = Data_Mysql_Table_Order_Payment::select('order_id,order_no', array('payment_status = ? AND order_id in ( ? )' => array(-1, implode(',', $ids))), '', 99999);
        if (!empty($payment)) {
            foreach ($ids as $key => $val) {
                foreach ($payment as $k => $v) {
                    if ($val == $v) {
                        unset($ids[$key]);
                    }
                }
            }
        }

        //关闭未支付的超过5个工作日的套餐订单
        Data_Mysql_Table_Order_Info::update('id in (' . implode(',', $ids) . ')', array('order_status' => -2, 'order_close_info' => array('取消理由' => "套餐超过五个工作日未支付")));
        foreach ($orders as $k => $v) {
            //创建历史记录
            $history_data = array('object_id' => $v['id'], 'admin_id' => $_SESSION['administrator']['id'], 'operate_type' => 1, 'data_backup' => $v);
            Data_Mysql_Table_History::subTable('_order' . date("_Ym"))->insert($history_data);
            //创建订单的额操作日志
            Data_Mysql_Table_Order_Log::insertOrderLog($v['id'], $v['order_no'], 0, "关闭超过五个工作日未支付的套餐订单", "关闭");
        }
        //删除满足条件的档期 status=-1
        foreach ($setInfo as $k => $v) {
            //获取product_id
            $set = Data_Mysql_Table_Product_Set::select('id,schedule_product_id', array('id' => $v['set_id']));
            $conditions = array();
            $conditions['start_time'] = $v['start_time'];
            $conditions['end_time'] = $v['end_time'];
            if (!empty($set[0])) {
                $conditions['product_id'] = $set[0]['schedule_product_id'];
                Data_Mysql_Table_Product_Schedule::update($conditions, array('status' => -1));
            }
        }
        //执行完成写入时间戳
        Core::writeData(Core::$paths["temp"] . "data/order_close." . (Core::$debugToken ? 1 : 0), time());
    }

}