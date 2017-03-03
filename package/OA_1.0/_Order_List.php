<?php

/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/5/13
 * Time: 13:53
 */
@session_start();
class OA_Order_List
{
    static function handle()
    {
        self::handleOrderAllList();
    }

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
        '4' => array(
            '待结算',
            0
        ),
        '5' => array(
            '已完成',
            0
        ),
        '-1' => array(
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

    //订单列表
    static function handleOrderAllList()
    {
        $conditions=array();
        //订单状态统计
        $search = Func_Input::filter(array(
            'userid' => 'int',
            'text' => 'string',
            'start_time' => 'string',
            'end_time' => 'string',
            'status' => 'int',
            'tab' => 'int',

        ));
        if (empty($search['userid'])) {
            if (!empty($search['start_time']) && !empty($search['end_time'])) {
                if (strtotime($search['start_time'] . "00:00:00") > strtotime($search['end_time'] . "23:59:59")) {
                    Func_Header::back('请正确选择时间范围！！');
                } else {
                    $conditions['create_time between ? and ?'] = array(strtotime($search['start_time'] . "00:00:00"), strtotime($search['end_time'] . "23:59:59"));
                }
            } elseif (!empty($search['start_time']) && empty($search['end_time'])) {
                $conditions['create_time > ?'] = strtotime($search['start_time'] . "00:00:00");
            } elseif (empty($search['start_time']) && !empty($search['end_time'])) {
                $conditions['create_time < ?'] = strtotime($search['end_time'] . "23:59:59");
            }
            if (!empty($search['text']) && (substr($search['text'], 0, 1) == "A" || substr($search['text'], 0, 1) == "S")) {
                $conditions[] = ' order_no like "' . $search['text'] . '%"';
            } elseif (!empty($search['text'])) {
                //关闭订单号的模糊查询
                //$conditions['order_title'] = $search['text'];
                $conditions['order_no'] = $search['text'];
                $conditions = array(
                    "(vendor_name=? or {prefix}account.username=? or order_title=?)" => array(
                        $search['text'], $search['text'], $search['text'])
                );
            }
            self::handleCounter($conditions);
        } else {
            if (!empty($search['tab'])) {
                if ($search['tab'] == 1) {
                    $conditions['buyer_account_id'] = $search['userid'];
                } else {
                    $conditions['vendor_account_id'] = $search['userid'];
                }
            }
            if (!empty($search['start_time']) && !empty($search['end_time'])) {
                if (strtotime($search['start_time'] . "00:00:00") > strtotime($search['end_time'] . "23:59:59")) {
                    Func_Header::back('请正确选择时间范围！！');
                } else {
                    $conditions['create_time between ? and ?'] = array(strtotime($search['start_time'] . "00:00:00"), strtotime($search['end_time'] . "23:59:59"));
                }
            } elseif (!empty($search['start_time']) && empty($search['end_time'])) {
                $conditions['create_time > ?'] = strtotime($search['start_time'] . "00:00:00");
            } elseif (empty($search['start_time']) && !empty($search['end_time'])) {
                $conditions['create_time < ?'] = strtotime($search['end_time'] . "23:59:59");
            }
//            $conditions[] = "((order_status > 11 AND order_status < 15) OR (order_status > 14 AND order_status < 90) OR (order_status > 89))";
            self::handleCounter($conditions);
        }

        if (!empty($search['text']) && (substr($search['text'], 0, 1) == "A" || substr($search['text'], 0, 1) == "S")) {
            //关闭订单号的模糊查询
//            $conditions[] = ' order_no like "' . $search['text'] . '%"';
            $conditions['order_no'] = $search['text'];
        } elseif (!empty($search['text'])) {
            $conditions = array(
                "(vendor_name=? or {prefix}account.username=? or order_title=?)" => array(
                    $search['text'], $search['text'], $search['text'])
            );
        }
        if (!empty($search['start_time']) && !empty($search['end_time'])) {
            if (strtotime($search['start_time'] . "00:00:00") > strtotime($search['end_time'] . "23:59:59")) {
                Func_Header::back('请正确选择时间范围！！');
            } else {
                $conditions['create_time between ? and ?'] = array(strtotime($search['start_time'] . "00:00:00"), strtotime($search['end_time'] . "23:59:59"));
            }
        } elseif (!empty($search['start_time']) && empty($search['end_time'])) {
            $conditions['create_time > ?'] = strtotime($search['start_time'] . "00:00:00");
        } elseif (empty($search['start_time']) && !empty($search['end_time'])) {
            $conditions['create_time < ?'] = strtotime($search['end_time'] . "23:59:59");
        }
        //状态筛选
        if (isset($search['status'])) {
            switch ($search['status']) {
                case -9:
                    $conditions['{table}.status != ?'] = 1;
                    break;
                case -1:
                    $conditions[] = "order_status < 0 AND {table}.status = 1";
                    break;
                case 1:
                    $conditions[] = "order_status < 5 AND order_status >=0 AND {table}.status = 1";
                    break;
                case 2:
                    $conditions[] = "order_status >4 AND order_status < 12 AND {table}.status = 1";
                    break;
                case 3:
                    $conditions[] = "order_status > 11 AND order_status < 15 AND {table}.status = 1";
                    break;
//                case 4:
//                    $conditions[] = "order_status > 14 AND order_status < 90 AND {table}.status = 1";
//                    break;
                case 5:
                    $conditions[] = "order_status > 14 AND order_status <100 AND {table}.status = 1";
                    break;

            }
        }
        //订单状态
        $cols = array(
            '{table}.order_tracking,{table}.status,{table}.id,{table}.vendor_id,{table}.order_no,{table}.vendor_account_id, {table}.product_id,{table}.product_set_id, {table}.vendor_name, {table}.order_title, {table}.remark, {table}.order_price, {table}.order_price_last,{table}.order_price_pay, {table}.order_payment_percent, {table}.order_status, {table}.start_time, {table}.end_time, {table}.create_time,{table}.cancel_time,{table}.create_time2,{table}.create_time3,{table}.create_time4,{table}.create_time5,{table}.cancel_time,{table}.update_time,{table}.buyer_account_id,{prefix}administrator.username as admin_username,{prefix}account.username,{prefix}account.fullname'
        );
        $list = Data_Mysql_Table_Order_Info::page(0, 10, $cols, $conditions, 'ORDER BY id DESC', '{table} LEFT JOIN {prefix}account ON {table}.buyer_account_id = {prefix}account.id LEFT JOIN {prefix}administrator ON {table}.admin_id = {prefix}administrator.id');
        if (!empty($list['rows'])) {
            $list['rows'] = self::handleOrderList($list['rows']);
        }

        $dates = array();
        $timeNow = time();
        do {
            $dates[] = date("Y-m", $timeNow);
            $timeNow -= 86400 * 30;
        } while ($timeNow > '1425279172');

        if (!empty($_REQUEST['action']) && $_REQUEST['action'] == 'user') {
            $data = self::userPrice();
            Tpl_Smarty::assign('data', $data);
        } elseif (!empty($_REQUEST['action']) && $_REQUEST['action'] == 'cancel_order') {
            self::cancelOrderInfo();
        } elseif (!empty($_REQUEST['action']) && $_REQUEST['action'] == 'recover_order') {
            self::recoverOrderInfo();
        } elseif(!empty($_REQUEST['action']) && $_REQUEST['action'] == 'deleteOrderInfo'){
            self::deleteOrderInfo($_REQUEST['id']);
        }elseif(!empty($_REQUEST['action']) && $_REQUEST['action']=="show_tracking"){
            $_REQUEST['text']=$_REQUEST['order_no'];
            Tpl_Smarty::assign('tracking', self::getOrderTracking());
        }else {
            Tpl_Smarty::assign('data', $list['rows']);
        }
        if (!empty($_REQUEST['start_time']) || !empty($_REQUEST['end_time']) || (!empty($_REQUEST['start_time']) && !empty($_REQUEST['end_time']))) {
            //金额总汇
//            $conditions[] = "((order_status > 11 AND order_status < 15) OR (order_status > 14 AND order_status < 90) OR (order_status > 89 AND order_status <100))";
//            q($conditions);
            $conditions[] = "order_status > 11 AND order_status < 100";
            $userPrice = Data_Mysql_Table_Order_Info::select("sum(order_price) as price,sum(order_price_pay) as pay", $conditions);
            Tpl_Smarty::assign("sumData", $userPrice);
        }
        if(!empty($search['status'])){
            Tpl_Smarty::assign('status',$search['status']);
        }
        Tpl_Smarty::assign('_data', $list);
        Tpl_Smarty::assign('dates', $dates);
        Tpl_Smarty::assign('is_admin', Admin_Authority::checkUrl('finance', 0));
        Tpl_Smarty::display('OA_Static::elements/order_list.tpl');
    }

    static function userPrice()
    {
        $request = Func_Input::filter(array(
            'name' => 'string',
            'userid' => 'int',
            'start_time' => 'string',
            'end_time' => 'string',
            'status' => 'string',
            'tab' => 'int'
        ), $_REQUEST);
        if (!empty($request['userid']) && !empty($request['tab'])) {
            if ($request['tab'] == 1) {
                $conditions['buyer_account_id'] = $request['userid'];
            } else {
                $conditions['vendor_account_id'] = $request['userid'];
            }
        }
        if (!empty($request['status'])) {
            switch ($request['status']) {
                case -9:
                    $conditions['{table}.status != ?'] = 1;
                    break;
                case -1:
                    $conditions[] = "order_status < 0 AND {table}.status = 1";
                    break;
                case 1:
                    $conditions[] = "order_status < 5 AND order_status >=0 AND {table}.status = 1";
                    break;
                case 2:
                    $conditions[] = "order_status >4 AND order_status < 12 AND {table}.status = 1";
                    break;
                case 3:
                    $conditions[] = "order_status > 11 AND order_status < 15 AND {table}.status = 1";
                    break;
//                case 4:
//                    $conditions[] = "order_status > 14 AND order_status < 90 AND {table}.status = 1";
//                    break;
                case 5:
                    $conditions[] = "order_status > 14 AND order_status <100 AND {table}.status = 1";
                    break;
            }
        }
        //搜索时间
        if (!empty($request['start_time']) && !empty($request['end_time'])) {
            if (strtotime($request['start_time'] . "00:00:00") > strtotime($request['end_time'] . "23:59:59")) {
                Func_Header::back('请正确选择时间范围！！');
            } else {
                $conditions['create_time between ? and ?'] = array(strtotime($request['start_time'] . "00:00:00"), strtotime($request['end_time'] . "23:59:59"));
            }
        } elseif (!empty($request['start_time']) && empty($request['end_time'])) {
            $conditions['create_time > ?'] = strtotime($request['start_time'] . "00:00:00");
        } elseif (empty($request['start_time']) && !empty($request['end_time'])) {
            $conditions['create_time < ?'] = strtotime($request['end_time'] . "23:59:59");
        }
        $cols = array(
            '{table}.status,{table}.id,{table}.vendor_id, {table}.order_no, {table}.product_id,{table}.vendor_account_id,{table}.vendor_name, {table}.order_title, {table}.remark, {table}.order_price, {table}.order_price_last, {table}.order_price_pay, {table}.order_payment_percent, {table}.order_status, {table}.start_time, {table}.end_time, {table}.create_time,{table}.cancel_time,{table}.create_time2,{table}.create_time3,{table}.create_time4,{table}.create_time5,{table}.cancel_time,{table}.update_time,{table}.buyer_account_id,{prefix}administrator.username as admin_username,{table}.buyer_account_id,{prefix}account.username,{prefix}account.fullname'
        );
        $list = Data_Mysql_Table_Order_Info::select($cols, $conditions, 'ORDER BY id DESC', 100, '{table} LEFT JOIN {prefix}account ON {table}.buyer_account_id = {prefix}account.id LEFT JOIN {prefix}administrator ON {table}.admin_id = {prefix}administrator.id');
//        $conditions[] = "((order_status > 11 AND order_status < 15) OR (order_status > 14 AND order_status < 90) OR (order_status > 89 AND order_status <100))";
        $conditions[] = "order_status > 11 AND order_status < 100";
        $userPrice = Data_Mysql_Table_Order_Info::select("sum(order_price) as price,sum(order_price_pay) as pay", $conditions);
        if (!empty($list)) {
            $list = self::handleOrderList($list);
        }
        $dates = array();
        $timeNow = time();
        do {
            $dates[] = date("Y-m", $timeNow);
            $timeNow -= 86400 * 30;
        } while ($timeNow > '1425279172');
        if (!empty($_REQUEST['action']) && $_REQUEST['action'] == 'deleteOrderInfo') {
            self::deleteOrderInfo($_REQUEST['id']);
        }
        Tpl_Smarty::assign('sumData', $userPrice);
        return $list;
    }

    static function  handleCounter($conditions)
    {
//        Data_Mysql_Table_Order_Info::debug(1);
        //获取所有订单
        $rs = Data_Mysql_Table_Order_Info::select('count({table}.id) as c, order_status', $conditions, 'GROUP BY order_status', 100, '{table} LEFT JOIN {prefix}account ON {table}.buyer_account_id = {prefix}account.id');
        foreach ($rs as $v) {
            self::$counter[0][1] += $v['c'];
        }

        //获取所有未删除订单
        $conditions1=$conditions;
        $conditions1[]="{table}.status = 1";
        $rs1 = Data_Mysql_Table_Order_Info::select('count({table}.id) as c, order_status', $conditions1, 'GROUP BY order_status', 100, '{table} LEFT JOIN {prefix}account ON {table}.buyer_account_id = {prefix}account.id');
        foreach ($rs1 as $v) {
            if ($v['order_status'] < 0) {
                self::$counter[-1][1] += $v['c'];
            } elseif ($v['order_status'] < 5) {
                self::$counter[1][1] += $v['c'];
            } elseif ($v['order_status'] > 4 && $v['order_status'] < 12) {
                self::$counter[2][1] += $v['c'];
            } elseif ($v['order_status'] > 11 && $v['order_status'] < 15) {
                self::$counter[3][1] += $v['c'];
//            } elseif ($v['order_status'] > 14 && $v['order_status'] < 90) {
//                self::$counter[4][1] += $v['c'];
            } elseif ($v['order_status'] > 14 && $v['order_status'] < 100) {
                self::$counter[5][1] += $v['c'];
            }
        }

        //获取所有已关闭（status=-9）的订单
        $conditions2=$conditions;
        $conditions2['status != ?']=1;
        $close_rs = Data_Mysql_Table_Order_Info::select('count(id) as c', $conditions2);
        if(!empty($close_rs)){
            self::$counter[-9][1] += $close_rs[0]['c'];
        }
        Tpl_Smarty::assign('counter', self::$counter);
        return self::$counter;
    }

    static function handleOrderList($rows)
    {
        $vendors = array();
        if (!empty($rows)) {
            foreach ($rows as $k => $v) {
                $vendors[] = $v['vendor_id'];
                if (!empty($v['order_price_last'])) {
                    $rows[$k]['order_price'] = $v['order_price_last'];
                }
//                $rows[$k]['order_detail'] = json_decode($v['order_detail'], 1);
                if ($v['order_status'] < 0) {
                    $rows[$k]['order_status_text'] = self::$counter[-1][0];
                } elseif ($v['order_status'] < 5) {
                    $rows[$k]['order_status_text'] = self::$counter[1][0];
                } elseif ($v['order_status'] > 4 && $v['order_status'] < 12) {
                    $rows[$k]['order_status_text'] = self::$counter[2][0];
                } elseif ($v['order_status'] > 11 && $v['order_status'] < 15) {
                    $rows[$k]['order_status_text'] = self::$counter[3][0];
//                } elseif ($v['order_status'] > 14 && $v['order_status'] < 90) {
//                    $rows[$k]['order_status_text'] = self::$counter[4][0];
                } elseif ($v['order_status'] > 14 && $v['order_status'] < 100) {
                    $rows[$k]['order_status_text'] = self::$counter[5][0];
                }
            }

            //已删除订单
            if ($v['status']!=1) {
                $rows[$k]['order_status_text'] = self::$counter[-9][0];
            }

            $rs = Data_Mysql_Table_Vendor_Info::select("id, vendor_name", array("id IN (" . implode(',', $vendors) . ")"), '', 100);
            $vendors = array();
            foreach ($rs as $v) {
                $vendors[$v['id']] = $v;
            }
        }
        Tpl_Smarty::assign('vendors', $vendors);
        return $rows;
    }

    //删除已关闭的订单
    static function deleteOrderInfo($id)
    {
        if(empty($id)){
            Func_Header::back('参数错误！！');
        }
        $rs = Data_Mysql_Table_Order_Info::select('order_no,id', array('id'=>$id));
        if(empty($rs[0])){
            Func_Header::back('要删除的订单不存在！！');
        }
        $up_rs = Data_Mysql_Table_Order_Info::update(array('id' => $id,'status'=>-9,'admin_id'=>$_SESSION['administrator']['id']));
        if (!empty($up_rs)) {
            //创建订单的操作日志
            Data_Mysql_Table_Order_Log::insertOrderLog($id, $rs[0]['order_no'], $_SESSION['administrator']['id'], '删除关闭时间超过七天的订单', "删除");
            Func_Header::to(' 删除成功!');
        }else{
            Func_Header::back('删除失败!');
        }
    }

    //取消订单
    static function cancelOrderInfo()
    {
        if (empty($_REQUEST['id'])) {
            Func_Header::back('参数错误！！');
        }
        if (!Admin_Authority::checkUrl('finance', 0)) {
            Func_Header::back('没有权限！！');
        }

        $rs = Data_Mysql_Table_Order_Info::update(array('id' => $_REQUEST['id']), array('order_status' => -2,'admin_id'=>$_SESSION['administrator']['id'], 'order_close_info' => array('取消理由' => "管理后台取消订单", '操作者' => "[" . $_SESSION['administrator']['id'] . "]" . $_SESSION['administrator']['username']),'cancel_time'=>time()));
        if (!empty($rs[0])) {
            //删除档期
            //获取product_id和套餐id
            $info = Data_Mysql_Table_Order_Info::select('id,order_no,product_id,product_set_id,start_time,end_time', array('id' => $_REQUEST['id']));
            $conditions = array();
            $conditions['start_time'] = $info[0]['start_time'];
            $conditions['end_time'] = $info[0]['end_time'];
            if (!empty($info[0]['product_id'])) {
                //服务档期
                $conditions['product_id'] = $info[0]['product_id'];
                Data_Mysql_Table_Product_Schedule::update($conditions, array('status' => -1));
            } elseif (!empty($info[0]['product_set_id'])) {
                //套餐档期
                $set_info = Data_Mysql_Table_Product_Set::select('id,schedule_product_id', array('id' => $info[0]['product_set_id']));
                if (!empty($set_info[0]['schedule_product_id'])) {
                    $conditions['product_id'] = $set_info[0]['schedule_product_id'];
                    Data_Mysql_Table_Product_Schedule::update($conditions, array('status' => -1));
                }
            }
            //创建历史记录
            $history_data = array('object_id' => $_REQUEST['id'], 'admin_id' => $_SESSION['administrator']['id'], 'operate_type' => 1, 'data_backup' => $info[0]);
            Data_Mysql_Table_History::subTable('_order' . date("_Ym"))->insert($history_data);
            //创建订单的操作日志
            Data_Mysql_Table_Order_Log::insertOrderLog($_REQUEST['id'], $info[0]['order_no'], $_SESSION['administrator']['id'], '取消订单', "取消");
            Func_Header::to(' 订单取消成功！', "?");
        } else {
            Func_Header::back('订单取消失败!');
        }
    }

    //恢复订单
    static function recoverOrderInfo()
    {
        if (empty($_REQUEST['id'])) {
            Func_Header::back('参数错误！！');
        }
        if (!Admin_Authority::checkUrl('finance', 0)) {
            Func_Header::back('没有权限！！');
        }
        $order = Data_Mysql_Table_Order_Info::select('*', array('id' => $_REQUEST['id']));
        if (empty($order[0])) {
            Func_Header::back('订单不存在!!');
        }
        $order_status = 0;
        //如果是套餐订单
        if (!empty($order[0]['product_set_id'])) {
            if (!empty($order[0]['create_time2'])) {
                $order_status = 12;
            } else {
                $order_status = 0;
            }
        }
        //如果是普通订单
        if (!empty($order[0]['product_id'])) {
            if (!empty($order[0]['create_time3'])) {
                $order_status = 12;
            } elseif (!empty($order[0]['create_time2'])) {
                $order_status = 5;
            } else {
                $order_status = 0;
            }
        }
        $update_data['order_status'] = $order_status;
        $update_data['cancel_time'] = 0;
        $update_data['order_close_info'] = "";
        $update_data['status'] = 1;
        $update_data['admin_id'] = $_SESSION['administrator']['id'];
        $rs = Data_Mysql_Table_Order_Info::update(array('id' => $_REQUEST['id']), $update_data);
        if (!empty($rs[0])) {
            //创建历史记录
            $history_data = array('object_id' => $_REQUEST['id'], 'admin_id' => $_SESSION['administrator']['id'], 'operate_type' => 1, 'data_backup' => $order[0]);
            Data_Mysql_Table_History::subTable('_order' . date("_Ym"))->insert($history_data);
            //创建订单的操作日志
            Data_Mysql_Table_Order_Log::insertOrderLog($_REQUEST['id'], $order[0]['order_no'], $_SESSION['administrator']['id'], "恢复已取消订单", "恢复");
            Func_Header::to(' 订单恢复成功！', "?");
        } else {
            Func_Header::back('订单恢复失败!');
        }
    }

    /*
     *获取订单追踪信息
     */
    static function getOrderTracking(){
        $tracking=array();
        if(empty($_REQUEST['order_no'])){
            Func_Header::back('参数错误！！');
        }
        $order = Data_Mysql_Table_Order_Info::select('id,order_tracking', array('order_no' => $_REQUEST['order_no']));
        if (empty($order[0])) {
            Func_Header::back('订单不存在!!');
        }
        $orderInfo=$order[0];
        if (!empty($orderInfo['order_tracking'])) {
            $tracking=json_decode($orderInfo['order_tracking'],1);
        }
        return $tracking;
    }
}