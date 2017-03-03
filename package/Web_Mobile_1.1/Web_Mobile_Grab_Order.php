<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/12/10
 * Time: 18:39
 * 抢单
 */
@session_start();

//$_REQUEST['id']
class Web_Mobile_Grab_Order
{
    /**
     * 处理抢单
     *  1.已抢单
     *  2.未抢单
     *
     */

    static function  handleGrabOrder()
    {
        $request = Func_Input::filter(array(
            'type' => 'string',
            'action' => 'string',

        ));
        if (@$request['action'] == 'detail') {
            self::handleOrderDetail();
            die();
        } elseif (@$request['action'] == 'needs') {

            self::handleNeeds();
            die();

        } elseif (@$request['action'] == 'needsTags') {

            self::handleNeedsTags();
            die();

        } elseif (@$request['action'] == 'needsSubmit') {
            //
            self::handleNeedsSubmit();
            die();
        } else {
            self::handleOrderList();
            die();
        }
    }

    /**
     * 详情
     */
    static function  handleOrderDetail()
    {
        $request = Func_Input::filter(array(
            'id' => 'int',
            'type' => 'string',
        ));
        if (empty($request['id'])) {
            Func_Header::back('请刷新重试~');
        }
        //我的订单详情
        if (@$request['type'] == "B") {
            $args = array('id' => $request['id'], 'phone' => $_SESSION['user']['phone']);

            $data = Api_Grab_Order_Get_Info::getInfo($args);
            if ($data['status'] == 0) {
                Data_Mysql_Table_Grab_Order::update(array('id=?' => $request['id']), array('status' => '-1'));
            }
            @$sum = Api_Demand_Offer_GetData::getSchemeSum(array('demand_id' => $request['id']));
            Tpl_Smarty::assign('sum', $sum);
            Tpl_Smarty::assign('data', $data['data']);
            //联系记录
            if (!empty($data['data']['gather_offer_time'])) {
                Tpl_Smarty::assign('look_offer', 1);
            }
            //客户意向的场地
            $events = Api_Demand_GetEventsById::getEvents(array('id' => $request['id']));
            if ($events['status'] == 1) {
                Tpl_Smarty::assign('events', $events['data']);
            }

            $record = Api_Grab_Order_GetContactRecord::handleRecord(array('demand_id' => $request['id']));
            Tpl_Smarty::assign('record', $record['data']);
            Tpl_Smarty::assign('step', Data_Mysql_Table_Demand::$grab_order_step);

            Tpl_Smarty::display('Web_Mobile_Static::grab_order.php.v1.0/grab_order_my_detail.php.tpl');


        } else {
            //抢单
            $args = array('id' => $request['id']);
            $data = Api_Grab_Order_Get_Info::getInfo($args);
            if ($data['status'] == 0) {
                Func_Header::back('您来晚了，该订单已被抢！');
            }
            $myIntegral = Api_Grab_Order_OperationIntegral::getIntegralByPhone(array('phone' => @$_SESSION['user']['phone']));
            Tpl_Smarty::assign('data', $data['data']);
            Tpl_Smarty::assign('myIntegral', $myIntegral['data']);
            Tpl_Smarty::display('Web_Mobile_Static::grab_order.php.v1.0/grab_order_ready_detail.php.tpl');

        }

    }

    static function  handleOrderList()
    {
        $request = Func_Input::filter(array(
            'type' => 'string',
        ));

        $data = Api_Grab_Order_Get_Wait_List::handle(array('type' => $request['type'], 'phone' => @$_SESSION['user']['phone']));
        Tpl_Smarty::assign('list', $data['data']);
        Tpl_Smarty::assign('step', Data_Mysql_Table_Demand::$grab_order_step);
        Tpl_Smarty::display('Web_Mobile_Static::grab_order.php.v1.0/grab_order.php.tpl');

    }

    /***
     * 收集报价
     */
    static function  handleNeeds()
    {
        $request = Func_Input::filter(array(
            'id' => 'int',
        ));
        if (empty($request['id'])) {
            Func_Header::back('请返回刷新');
        }

        $data = Api_Grab_Order_Get_Info::getInfo(array(
            'id' => $request['id'],
            'phone' => @$_SESSION['user']['phone'],
        ));
        Tpl_Smarty::assign('data', $data['data']);
        $option = Data_Demand_Option_Config::all();
        $attr = Data_Config_Vendor_Attr::get('attr');
        $option['活动类型'] = $attr['活动类型'];
        Tpl_Smarty::assign('option', $option);
        Tpl_Smarty::display('Web_Mobile_Static::grab_order.php.v1.0/grab_order_needs.php.tpl');
    }

    /**
     *标签处理
     */
    static function  handleNeedsTags()
    {
        $data = Data_Mysql_Table_Demand_Tag::select('*', '', '', 999);
        $string = '';
        if (!empty($data[0])) {

            foreach ($data as $val) {
                $string = $string . $val['tag_value'] . ',';
            }
        }

        Tpl_Smarty::assign('tags', $string);
        Tpl_Smarty::display('Web_Mobile_Static::grab_order.php.v1.0/grab_order_needsTags.php.tpl');

    }

    /**
     * 需求提交
     */
    static function  handleNeedsSubmit()
    {
        @session_start();


    }

    /**
     * 积分
     */
    static function handleCredit()
    {
        $request = Func_Input::filter(array(
            'type' => 'string'
        ));
        if ($request['type'] == 'rule') {
            Tpl_Smarty::display('Web_Mobile_Static::grab_order.php.v1.0/grab_credit_rule.php.tpl');
            die();
        }
        $myIntegral = Api_Grab_Order_OperationIntegral::getIntegralByPhone(array('phone' => $_SESSION['user']['phone']));
        $data = Data_Mysql_Table_Integral_Record::select('integral,intro,create_time', array('account_id=?' => $_SESSION['user']['id']), 'ORDER BY create_time DESC ', 10);
        foreach ($data as $k => $val) {
            $data[$k]['create_time'] = date('Y-m-d H:i:s', $val['create_time']);
            $data[$k]['integral'] = $val['integral'] > 0 ? '+' . $val['integral'] : $val['integral'];
        }
        Tpl_Smarty::assign('list', $data);
        Tpl_Smarty::assign('myIntegral', $myIntegral['data']);
        Tpl_Smarty::display('Web_Mobile_Static::grab_order.php.v1.0/grab_credit.php.tpl');

    }

    /**
     *公告
     */
    static function  handleNotice()
    {
        $data = Data_Mysql_Table_System_Notice::select('*', array(), 'ORDER BY create_time DESC', 5);
        Tpl_Smarty::assign('list', $data);
        Tpl_Smarty::assign('is_new_msg', array('is_notice' => 1));
        Data_Mysql_Table_LiveChat_Message_Recent::update(array('to_account_id=? AND from_account_id=?' => array(Api_Session::user_id(), '-1')), array('is_notice' => 1));
        Tpl_Smarty::display('Web_Mobile_Static::grab_order.php.v1.0/notice.php.tpl');

    }

    /**
     * 创建需求订单
     */
    static function  handleOrderCreate()
    {
        $option = Data_Demand_Option_Config::all();
        $attr = Data_Config_Vendor_Attr::get('attr');
        $option['活动类型'] = $attr['活动类型'];
        Tpl_Smarty::assign('option', $option);
        Tpl_Smarty::display('Web_Mobile_Static::grab_order.php.v1.0/create_order.php.tpl');

    }


    /**
     *销售的领导分配订单
     */
    static function  handleLeaderAllot()
    {
        //超时未抢的订单的sale_phone  值为 1 ；

//        $where['(t1.sale_phone =? OR t1.sale_phone=?) AND t1.create_time <?'] = array('1', '', time() - 1209);
        $where['(t1.sale_phone =? OR t1.sale_phone=?) '] = array('1', '');
//        $list = Data_Mysql_Table_Grab_Order::select('*', $where, '', 10);

        $cols = "t1.id ,t1.step,t1.create_time,t2.price_up,t2.price_down,t2.demand";
        $table = "{table} as t1 LEFT JOIN {prefix}demand as t2 ON t1.id = t2.id";
        $data = Data_Mysql_Table_Grab_Order::select($cols, $where, 'ORDER BY t1.create_time DESC', 40, $table);

        Tpl_Smarty::assign('list', Data_Mysql_Table_Grab_Order::format($data));
        /**
         * 销售人员
         *
         */
        $_COOKIE['city'] = empty($_COOKIE['city']) ? '上海' : $_COOKIE['city'];
        $sale = OA_Demand_Lists::getMemberList('销售部', $_COOKIE['city']);

        Tpl_Smarty::assign('sale_people', $sale);
        Tpl_Smarty::display('Web_Mobile_Static::grab_order.php.v1.0/allot/order_allot.php.tpl');
    }


} 