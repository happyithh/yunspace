<?php

/**
 * Created by PhpStorm.
 * User: adu
 * Date: 15/6/10
 * Time: 11:18
 */
@session_start();

class Web_Mobile_WeChat_Ticket extends Base
{

    //默认活动列表
    static function handle()
    {
//        q($_SESSION);
        if (Core::$urls['host'] == 'd15.yunspace.com.cn'|| Core::$urls['host'] =='d16.yunspace.com.cn') {
            $_SESSION['openid'] = 'oP1nzsnpi1hOyBeYbpvcwBBZiMvQ';
        }
       Api_Session::user_info();
        //判断是否登录。没有登录就跳转到登录哪里
        Web_Account::handleIsLogin('');
        $ticketType = array(
            "0" => "电子票",
            "1" => "纸质实体票",
        );

        //正在售票的活动列表
        $res = Api_Wechat_Ticket_Event_List::getEventList($_REQUEST);
//        Q($res);
        //最低价
        Tpl_Smarty::assign("ticket_type", $ticketType);
        Tpl_Smarty::assign("event_list", $res['data']);
        Tpl_Smarty::display("Web_Mobile_Static::wechat.v2.0/booking_index1.0.tpl");
    }

    //活动详情
    static function eventInfo()
    {
        $request = Func_Input::filter(array(
            'event_id' => 'int',
        ), $_REQUEST);
        if (empty($request['event_id'])) {
            Func_Header::back("请求错误");
        }
        $res = Api_Wechat_Ticket_Event_Info::getEventInfo($_REQUEST);
//        Q($res);
        if ($res['status'] == 0) {
            Func_Header::back("此活动不存在或已结束！");
        }
        $ticketType = array(
            "0" => "电子票",
            "1" => "纸质实体票",
        );
        Tpl_Smarty::assign("ticket_type", $ticketType);
        Tpl_Smarty::assign("event_info", $res['data']);
//        Tpl_Smarty::display("Web_Mobile_Static::wechat.v2.0/booking_details1.0.tpl");
        Tpl_Smarty::display("Web_Mobile_Static::wechat.v3.1/booking_details1.0.tpl");
//        if (isset($_POST['conn_id'])) {
//            if (!empty($_SESSION['conn_id']) && $_POST['conn_id'] == $_SESSION['conn_id']) {
//                Func_Header::back("不要重复提交");
//            } else {
//                $_SESSION['conn_id'] = $_POST['conn_id']; //存储code
//            }
//        }
    }

    static function eventTicketList()
    {
//        q($_SESSION);
        $request = Func_Input::filter(array(
            'event_id' => 'int',
            'address_id' => 'int',
        ), $_REQUEST);

        if (empty($request['event_id'])) {
            Func_Header::back("请求错误");
        }
        $res = Api_Wechat_Ticket_Event_Info::getEventInfo($_REQUEST);
//        Q($res);
        if ($res['status'] == 0) {
            Func_Header::back($res['msg']);
        }
        Tpl_Smarty::assign("event_info", $res['data']);
        $rs = Api_Wechat_Ticket_Event_Ticket_List::getTicketList($_REQUEST);
//        q($rs);
        if ($rs['status'] == 0) {
            Func_Header::back($rs['msg']);
        }
        $eventTime = array();
        if (!empty($rs['data'])) {
            foreach ($rs['data'] as $k => $v) {
                $eventTime[] = $v['event_time'];
            }

        }
        $eventTime = array_unique($eventTime);
        $newTicketList = array();
        foreach ($eventTime as $k => $v) {
            foreach ($rs['data'] as $kk => $vv) {
                if ($vv['event_time'] == $v) {
                    $newTicketList[$v][] = $vv;
                }
            }
        }
        $is_active = false;
        foreach ($newTicketList as $k => $v) {
            foreach ($v as $kk => $vv) {
                if ((0 === $kk && $vv['stock'] > 0) || ($vv['stock'] > 0 && !$is_active)) {
                    $newTicketList[$k][$kk]['active'] = 1;
                    $is_active = true;
                } else {
                    $newTicketList[$k][$kk]['active'] = 0;
                }
            }
        }
//        q($newTicketList);
        $ticketAddress = Api_Wechat_Ticket_Get_Address::getSendAddress(array('address_id'=>$request['address_id']));
        if($ticketAddress){
            $checkAddress = $ticketAddress;
        }else{
            $checkAddress = '';
        }
        //查询该账户下有多少积分
        $rs_account = Data_Mysql_Table_Account::select('integral',array('id=?'=> $_SESSION['user']['id']));
        Tpl_Smarty::assign('integral',$rs_account[0]['integral']);

//        q(array_values($newTicketList));
        Tpl_Smarty::assign('ticketAddress', $checkAddress);
        Tpl_Smarty::assign("event_info", $res['data']);
        Tpl_Smarty::assign("conn_id", time());
        Tpl_Smarty::assign("event_time", $eventTime);
        Tpl_Smarty::assign("new_ticket_lists", json_encode($newTicketList));
        Tpl_Smarty::assign("new_ticket_list", $newTicketList);
        $new_ticket_list_array_value = array_values($newTicketList);
//        q($new_ticket_list_array_value);
        Tpl_Smarty::assign("new_ticket_list_array_value", $new_ticket_list_array_value[0]);
//        Tpl_Smarty::display("Web_Mobile_Static::wechat.v2.0/booking_choice1.0.tpl");
        Tpl_Smarty::display("Web_Mobile_Static::wechat.v3.1/booking_choice1.0.tpl");
    }

    static function  createOrder()
    {
//        q($_REQUEST);
        //判断是否登录
        Web_Account::handleIsLogin('');
        //生成订单
        $rs = Api_Wechat_Ticket_Create_Order::createOrder($_REQUEST);
//        q($rs);
        if ($rs['status'] == 0) {
            Func_Header::to($rs['msg']);
        }
        $ticketType = array(
            "0" => "电子票",
            "1" => "纸质实体票",
        );
        Tpl_Smarty::assign("ticket_type", $ticketType);
        $request = Func_Input::filter(array(
            'address_id' => 'int',
        ));


        $agent = strtolower($_SERVER['HTTP_USER_AGENT']);
        $type = 'other';
        if (strpos($agent, 'iphone') || strpos($agent, 'ipad')) {
            $type = 'ios';
        }
        //为了兼容app
        if (strpos($agent, 'android') && strpos($agent, 'micromessenger') == false) {
            $type = 'android';
        }
        //微信支付数据
        if ($type == "ios" || $type == 'android') {
            //如果不是积分购票，则走微信支付接口
            if($_REQUEST['price_is_score']!=1) {
                $wxData = array(
                    "id" => $rs['data']['order_info']['id'],
                    "body" => $rs['data']['event_info']['title'], ////商品描述
                    "out_trade_no" => $rs['data']['order_info']['order_no'],
                    "total_fee" => $rs['data']['order_info']['order_price'],
                );
                self::wxPayNew($wxData);
            }
            if($type == 'android'){
                Tpl_Smarty::assign("agent_type",'android');
            }
            $price_is_score = $rs['data']['ticket_info']['price_is_score'];
            Tpl_Smarty::assign("price_is_score", $price_is_score);
            Tpl_Smarty::assign("order_info", $rs['data']);
            Tpl_Smarty::assign("integral", $_REQUEST['integral']);
//            Tpl_Smarty::assign("check_ticket_list", $checkticketlist);
            Tpl_Smarty::display("Web_Mobile_Static::wechat.v2.0/booking_tobepay_new1.0.tpl");
        } else {
            if($_REQUEST['price_is_score']!=1) {
                $wxData = array(
                    "id" => $rs['data']['order_info']['id'],
                    "body" => $rs['data']['event_info']['title'], ////商品描述
                    "out_trade_no" => $rs['data']['order_info']['order_no'],
                    "total_fee" => $rs['data']['order_info']['order_price'],
//            "notify_url"=>WxPayConf_pub::NOTIFY_URL,
                    "trade_type" => "JSAPI",
                    "event_id" => $rs['data']['event_info']['id'],
                );
                self::wxPay($wxData);
            }

            $price_is_score = $rs['data']['ticket_info']['price_is_score'];
            Tpl_Smarty::assign("price_is_score", $price_is_score);
//        q($rs['data']);
            Tpl_Smarty::assign("order_info", $rs['data']);
            Tpl_Smarty::assign("integral", $_REQUEST['integral']);
//            Tpl_Smarty::assign("order_price", $order_price);
//            Tpl_Smarty::assign("check_ticket_list", $checkticketlist);
//            Tpl_Smarty::display("Web_Mobile_Static::wechat.v2.0/booking_tobepay1.0.tpl");
            Tpl_Smarty::display("Web_Mobile_Static::wechat.v3.1/booking_tobepay1.0.tpl");
        }

    }

    static function orderList()
    {
        //判断是否登录。没有登录就跳转到登录哪里
        Web_Account::handleIsLogin('');

        $rs = Api_Wechat_Ticket_Get_Order_List_By_Account_Id::getOrderList($_REQUEST);

        if ($rs['status'] == 0) {
            Func_Header::to($rs['msg']);
        }

        //查询该账户下有多少积分，手机号，头像，用户名
//        Data_Mysql_Table_Account::debug(1);
        $rs_account = Data_Mysql_Table_Account::select('{table}.username,{table}.phone,{table}.avatar,{table}.integral,{prefix}account_wechat.user_info',array('{table}.id=?'=> $_SESSION['user']['id']),'',1,'{table} LEFT JOIN {prefix}account_wechat ON {table}.id={prefix}account_wechat.account_id');
        if(!empty($rs_account[0]['user_info'])) {
            $rs_account[0]['user_info'] = json_decode($rs_account[0]['user_info'],1);
        }
//        q($rs_account);
        Tpl_Smarty::assign('account_data',$rs_account[0]);

        @Tpl_Smarty::assign("order_status", $_REQUEST['order_status']);
        Tpl_Smarty::assign("order_list", $rs['data']);
//        Tpl_Smarty::display('Web_Mobile_Static::wechat.v2.0/booking_check1.0.tpl');
        Tpl_Smarty::display('Web_Mobile_Static::wechat.v3.1/booking_check1.0.tpl');
    }

    static function cancelOrder()
    {
        $rs = Api_Wechat_Ticket_Cancel_Order::cancelOrder($_REQUEST);
        if ($rs['status'] == 0) {
            Func_Header::to($rs['msg']);
        } else {
            Func_Header::to($rs['msg']);
        }
    }

    static function  payOrderList()
    {
//        q($_REQUEST);
        $rs = Api_Wechat_Ticket_Order_Info::getOrderInfo($_REQUEST);
        if ($rs['status'] == 0) {
            Func_Header::to($rs['msg']);
        }
        if(isset( $rs['data']['order_info']['addressInfo'])&&!empty( $rs['data']['order_info']['addressInfo'])){
            $rs['data']['order_info']['addressInfo'] = json_decode($rs['data']['order_info']['addressInfo'],1);
        }
//        q($rs['data']);
        $ticketType = array(
            "0" => "电子票",
            "1" => "纸质实体票",
        );
        Tpl_Smarty::assign("ticket_type", $ticketType);
        $agent = strtolower($_SERVER['HTTP_USER_AGENT']);
        $type = 'other';
        if (strpos($agent, 'iphone') || strpos($agent, 'ipad')) {
            $type = 'ios';
        }
        //为了兼容app
        if (strpos($agent, 'android') && strpos($agent, 'micromessenger') == false) {
            $type = 'android';
        }
        if ($type == 'ios' || $type == 'android') {
            if(empty($_REQUEST['price_is_score'])) {
                $wxData = array(
                    "id" => $rs['data']['order_info']['id'],
                    "body" => $rs['data']['event_info']['title'], ////商品描述
                    "out_trade_no" => $rs['data']['order_info']['order_no'],
                    "total_fee" => $rs['data']['order_info']['order_price'],
                );
                self::wxPayNew($wxData);
            } else {
                $rs_account = Data_Mysql_Table_Account::select('integral',array('id=?'=>$_SESSION['user']['id']));
                Tpl_Smarty::assign('integral',$rs_account[0]['integral']);
            }
            if($type == 'android'){
                Tpl_Smarty::assign("agent_type",'android');
            }
            Tpl_Smarty::assign("price_is_score", $_REQUEST['price_is_score']);
            Tpl_Smarty::assign("order_info", $rs['data']);
            Tpl_Smarty::display("Web_Mobile_Static::wechat.v2.0/booking_tobepay_new1.0.tpl");
//            Tpl_Smarty::display("Web_Mobile_Static::wechat.v3.1/booking_tobepay_new1.0.tpl");
        } else {
            if(empty($_REQUEST['price_is_score'])) {
                $wxData = array(
                    "id" => $rs['data']['order_info']['id'],
                    "body" => $rs['data']['event_info']['title'], ////商品描述
                    "out_trade_no" => $rs['data']['order_info']['order_no'],
                    "total_fee" => $rs['data']['order_info']['order_price'],
                    "trade_type" => "JSAPI",
                    "event_id" => $rs['data']['event_info']['id'],
                );
                self::wxPay($wxData);
            } else {
                $rs_account = Data_Mysql_Table_Account::select('integral',array('id=?'=>$_SESSION['user']['id']));
                Tpl_Smarty::assign('integral',$rs_account[0]['integral']);
            }
            Tpl_Smarty::assign("price_is_score", $_REQUEST['price_is_score']);
            Tpl_Smarty::assign("order_info", $rs['data']);
//            Tpl_Smarty::display("Web_Mobile_Static::wechat.v2.0/booking_tobepay1.0.tpl");
            Tpl_Smarty::display("Web_Mobile_Static::wechat.v3.1/booking_tobepay1.0.tpl");
        }
    }

    static function orderInfo()
    {
        $rs = Api_Wechat_Ticket_Order_Info_By_Order_No::getOrderInfo($_REQUEST);
        if ($rs['status'] == 0) {
            Func_Header::to($rs['msg']);
        }
        $ticketType = array(
            "0" => "电子票",
            "1" => "纸质实体票",
        );
        @Tpl_Smarty::assign("price_is_score", $_REQUEST['price_is_score']);
        Tpl_Smarty::assign("ticket_type", $ticketType);
        Tpl_Smarty::assign("order_info", $rs['data']);
//        Tpl_Smarty::display("Web_Mobile_Static::wechat.v2.0/booking_order_list1.0.tpl");
        Tpl_Smarty::display("Web_Mobile_Static::wechat.v3.1/booking_order_list1.0.tpl");
    }
//    static function handle()
//    {
//        if (Core::$urls['host'] == 'd15.yunspace.com.cn') {
//            $_SESSION['openid'] = 'oP1nzsnpi1hOyBeYbpvcwBBZiMvQ';
//        }
//        //判断是否登录。没有登录就跳转到登录哪里
//        Web_Account::handleIsLogin('');
//        $request = Func_Input::filter(array(
//            'event_id' => 'int',
//        ), $_REQUEST);
//        if (empty($request['event_id'])) {
//            Func_Header::back("请求错误");
//        }
////        $cols = "{table}.id,{table}.title,content,{prefix}weixin_ticket_info.stock";
////        Data_Mysql_Table_Weixin_Event_Info::debug(1);
//        $eventinfo = Data_Mysql_Table_Weixin_Event_Info::select('*', array("id" => $request['event_id']), '', 1);
//        //如果活动结束或下线 跳转到票务查询页面
//        //如果不存在就跳出
//        if (empty($eventinfo[0]['id']) || (!empty($eventinfo[0]['id']) && $eventinfo[0]['status']<0)) {
//            Func_Header::back("此活动不存在");
//        }
//        if (!empty($eventinfo[0]['id']) && ($eventinfo[0]['end_time']<time() || $eventinfo[0]['status']==0)) {
//            Func_Header::to("此活动已结束或下线","http://".Core::$urls['host']."/m/ticket/orderlist?event_id=".$request['event_id']);
//        }
//        $ticket = Data_Mysql_Table_Weixin_Ticket_Info::select("*", array("envent_id" => $eventinfo[0]['id'], "status" => 1), 'ORDER BY id asc', 100);
//        if (!empty($ticket)) {
//            $eventinfo[0]['ticketlist'] = $ticket;
//        } else {
//            $eventinfo[0]['ticketlist'] = $ticket;
//        }
//        $userinfo = Data_Mysql_Table_Account_Wechat::select("user_info", array("openid" => $_SESSION['openid']), '', 1);
//        $userinfo[0]['user_info'] = json_decode($userinfo[0]['user_info'], 1);
//        Tpl_Smarty::assign("headimgurl", $userinfo[0]['user_info']['headimgurl']);
//        Tpl_Smarty::assign("conn_id", time());
//        Tpl_Smarty::assign("event_info", $eventinfo[0]);
//        Tpl_Smarty::display("Web_Mobile_Static::wechat.v1.0/ticket.tpl");
//    }

    /**
     * 创建订单
     */

//    static function  createOrder()
//    {
//        $request = Func_Input::filter(array(
//            'event_id' => 'int',
//            'ticket' => 'array',
//        ), $_REQUEST);
//        if (empty($request['event_id'])) {
//            Func_Header::back("请求错误");
//        }
//        $eventinfo = Data_Mysql_Table_Weixin_Event_Info::select("*", array("id" => $request['event_id'], "status" => 1));
//        if (empty($eventinfo[0]['id'])) {
//            Func_Header::back("此活动不存在或已结束！");
//        }
//        if (isset($_POST['conn_id'])) {
//            if (!empty($_SESSION['conn_id']) && $_POST['conn_id'] == $_SESSION['conn_id']) {
//                Func_Header::back("不要重复提交");
//            } else {
//                $_SESSION['conn_id'] = $_POST['conn_id']; //存储code
//            }
//        }
//        $ticketlist = Data_Mysql_Table_Weixin_Ticket_Info::select("*", array("envent_id" => $eventinfo[0]['id'], "status" => 1), 'ORDER BY id asc', 100);
////        q($ticketlist);
//        //生成显示内容
//        if (!empty($request['ticket'])) {
//            $order_ticket_num = 0;
//            $order_price = 0;
//            $order_detail = array();
//            $checkticketlist = array();
//            $i = 0;
//            foreach ($request['ticket'] as $k => $v) {
//                $order_ticket_num += $v;
//                foreach ($ticketlist as $kk => $vv) {
//                    if ($vv['id'] == $k && $v != 0) {
//                        $order_price += $v * $vv['price'];
//                        $vv['ticket_num'] = $v;
//                        $checkticketlist[] = $vv;
//                        $order_detail[$i]['ticket_num'] = $v;
//                        $order_detail[$i]['ticket_id'] = $vv['id'];
//                        $order_detail[$i]['ticket_price'] = $vv['price'];
//                        $order_detail[$i]['ticket_name'] = $vv['name'];
//                        $i++;
//                    }
//                }
//            }
//            if ($order_ticket_num <= 0) {
//                Func_Header::to("请选择你要购买的票");
//            }
//        }
//        //生产订单插入数据库
//        $data = array();
//        $data['order_no'] = 'tmp_' . uniqid();
//        $data['buyer_account_id'] = $_SESSION['user']['id'];
//        $data['buyer_account_name'] = $_SESSION['user']['username'];
//        $data['buyer_account_phone'] = $_SESSION['user']['phone'];
//        $data['event_id'] = $eventinfo[0]['id'];
//        $data['event_title'] = $eventinfo[0]['title'];
//        $data['order_price'] = $order_price;
//        $data['order_ticket_num'] = $order_ticket_num;
//        $data['order_detail'] = $order_detail;
//        $data['create_time'] = $data['update_time'] = time();
//        $data['order_status'] = 0;
//        $data['status'] = 1;
//        $r = Data_Mysql_Table_Weixin_Ticket_Order_Info::insert($data);
//        if (!empty($r[0])) {
//            //更新 订单号 order_no
//            $data['order_no'] = 'W' . str_pad(Func_Input::str2num($r[0], 10), 10, '0', STR_PAD_LEFT);
//            Data_Mysql_Table_Weixin_Ticket_Order_Info::update($r[0], array('order_no' => $data['order_no']));
//        }
//        $agent = strtolower($_SERVER['HTTP_USER_AGENT']);
//        $type = 'other';
//        if (strpos($agent, 'iphone') || strpos($agent, 'ipad')) {
//            $type = 'ios';
//        }
//        //微信支付数据
//        if ($type == "ios") {
//            $wxData = array(
//                "id" => $r[0],
//                "body" => $eventinfo[0]['title'], ////商品描述
//                "out_trade_no" => $data['order_no'],
//                "total_fee" => $order_price,
////            "notify_url"=>WxPayConf_pub::NOTIFY_URL,
//            );
//            self::wxPayNew($wxData);
//
//
////        q($checkticketlist);
//            Tpl_Smarty::assign("order_price", $order_price);
//            Tpl_Smarty::assign("check_ticket_list", $checkticketlist);
//            Tpl_Smarty::display("Web_Mobile_Static::wechat.v1.0/ticket_pay_new.tpl");
//        } else {
//            $wxData = array(
//                "id" => $r[0],
//                "body" => $eventinfo[0]['title'], ////商品描述
//                "out_trade_no" => $data['order_no'],
//                "total_fee" => $order_price,
////            "notify_url"=>WxPayConf_pub::NOTIFY_URL,
//                "trade_type" => "JSAPI",
//                "event_id" => $request['event_id'],
//            );
//            self::wxPay($wxData);
//
//
////        q($checkticketlist);
//            Tpl_Smarty::assign("event_title", $eventinfo[0]['title']);
//            Tpl_Smarty::assign("order_price", $order_price);
//            Tpl_Smarty::assign("check_ticket_list", $checkticketlist);
//            Tpl_Smarty::display("Web_Mobile_Static::wechat.v1.0/ticket_pay.tpl");
//        }
//
//    }

    /**
     * 订单列表内点击支付，跳转到列表
     */
//
//    static function  payOrderList()
//    {
//        $request = Func_Input::filter(array(
//            'order_no' => 'string',
//        ), $_REQUEST);
//        if (empty($request['order_no'])) {
//            Func_Header::back("订单号错误！");
//        }
//        $orderinfo = Data_Mysql_Table_Weixin_Ticket_Order_Info::select('*', array("order_no" => $request['order_no']), "", 1);
//        if (empty($orderinfo[0]['id'])) {
//            Func_Header::back("未找到该订单");
//        }
//        $orderinfo[0]['order_detail'] = json_decode($orderinfo[0]['order_detail'], 1);
////        //微信支付数据
//        $agent = strtolower($_SERVER['HTTP_USER_AGENT']);
//        $type = 'other';
//        if (strpos($agent, 'iphone') || strpos($agent, 'ipad')) {
//            $type = 'ios';
//        }
//        if ($type == 'ios') {
////            unset($_COOKIE['from_type']);
//            $wxData = array(
//                "id" => $orderinfo[0]['id'],
//                "body" => $orderinfo[0]['event_title'], ////商品描述
//                "out_trade_no" => $orderinfo[0]['order_no'],
//                "total_fee" => $orderinfo[0]['order_price'],
//            );
//            self::wxPayNew($wxData);
//            Tpl_Smarty::assign("order_info", $orderinfo[0]);
//            Tpl_Smarty::display("Web_Mobile_Static::wechat.v1.0/ticket_pay_list_new.tpl");
//        } else {
//            $wxData = array(
//                "id" => $orderinfo[0]['id'],
//                "body" => $orderinfo[0]['event_title'], ////商品描述
//                "out_trade_no" => $orderinfo[0]['order_no'],
//                "total_fee" => $orderinfo[0]['order_price'],
//                "trade_type" => "JSAPI",
//                "event_id" => $orderinfo[0]['event_id'],
//            );
//            self::wxPay($wxData);
//            Tpl_Smarty::assign("order_info", $orderinfo[0]);
//            Tpl_Smarty::display("Web_Mobile_Static::wechat.v1.0/ticket_pay_list.tpl");
//        }
//
//
//    }


    /**
     * 更新订单付款状态，并生成票号 ，回调函数---->【积分购票】
     */
    static function payOrder_byScore($redata)
    {
        //此处应该更新一下订单状态，商户自行增删操作
        Core::log("weixinbackinfo", "微信积分购票成功", '');
        //微信售票
        $redata['order_no'] = substr($redata['order_no'], 0, 11);
        $orderinfo = Data_Mysql_Table_Weixin_Ticket_Order_Info::select("*", array("order_no" => $redata['order_no']), '', 1);
        //有订单号，并且没有支付完成
        if (!empty($orderinfo[0]) && $orderinfo[0]['order_status'] == 0) {
            //例如：更新订单状态
            Data_Mysql_Table_Weixin_Ticket_Order_Info::update(
                array("order_no" => $redata['order_no']),
                array(
                    "order_price_pay" => $redata['order_price'],
                    "order_status" => 1,
                    "create_time2" => time(),
                    "update_time" => time()
                ));

            $orderinfo[0]['order_detail'] = json_decode($orderinfo[0]['order_detail'], 1);
            //根据订单详情生成票号，并插入票号表
            foreach ($orderinfo[0]['order_detail'] as $k => $v) {
                $phdata['order_no'] = $orderinfo[0]['order_no'];
                $phdata['event_id'] = $orderinfo[0]['event_id'];
                $phdata['create_time'] = $phdata['update_time'] = time();
                $phdata['status'] = 0;
                for ($i = 1; $i <= $v['ticket_num']; $i++) {
                    $phdata['ticket_num'] = $phdata['order_no'] . $v['ticket_id'] . $i;
                    $phdata['ticket_price'] = $v['ticket_price'];
                    $phdata['ticket_detail'] = $v['ticket_name'];
                    $phdata['ticket_id'] = $v['ticket_id'];
                    Data_Mysql_Table_Weixin_Ticket_Num_Info::insert($phdata);
                }
                //更新一下库存
                Data_Mysql_Table_Weixin_Ticket_Info::update(array('id' => $v['ticket_id']), array('stock =stock-' . $v['ticket_num']));
            }
            //发短信
            $_REQUEST['order_no'] = $orderinfo[0]['order_no'];
            $_REQUEST['order_event'] = $orderinfo[0]['event_id'];
            $_SESSION['user']['id'] = $orderinfo[0]['buyer_account_id'];
            self::sendOrderMessage(1);
        }
    }




    /**
     * 更新订单付款状态，并生成票号 ，回调函数
     */
    static function payOrder()
    {
        //获取订单号。和付款状态 以及付款金额。和订单金额相比较。如果等于就付款成功。不等于就付款失败
        //判断是否成功。如果成功生成票号并跳转到订单列表页
        //生成票号的方法 yph+票类型id+票张数+价格

        //支付未成功就返回到当前页，也跳转到订单列表页
        include_once(dirname(__FILE__) . "/WxPayPubHelper/WxPayPubHelper.php");

        //使用通用通知接口
        $notify = new Notify_pub();

        //存储微信的回调
        $xml = $GLOBALS['HTTP_RAW_POST_DATA'];
        $notify->saveData($xml);

        //验证签名，并回应微信。
        //对后台通知交互时，如果微信收到商户的应答不是成功或超时，微信认为通知失败，
        //微信会通过一定的策略（如30分钟共8次）定期重新发起通知，
        //尽可能提高通知的成功率，但微信不保证通知最终能成功。
        if ($notify->checkSign() == FALSE) {
            $notify->setReturnParameter("return_code", "FAIL");//返回状态码
            $notify->setReturnParameter("return_msg", "签名失败");//返回信息
        } else {
            $notify->setReturnParameter("return_code", "SUCCESS");//设置返回码
        }
        $returnXml = $notify->returnXml();
        echo $returnXml;

        //==商户根据实际情况设置相应的处理流程，此处仅作举例=======
        Core::log("weixinbackinfo", "微信支付反馈通知", $xml);
        if ($notify->checkSign() == TRUE) {
            if ($notify->data["return_code"] == "FAIL") {
                //此处应该更新一下订单状态，商户自行增删操作
                Core::log("weixinbackinfo", "微信支付通信出错", $xml);
            }
//            elseif($notify->data["result_code"] == "FAIL"){
//                //此处应该更新一下订单状态，商户自行增删操作
//                Core::log("weixinbackinfo","微信支付业务出错",$xml);
//            }
            else {
                //此处应该更新一下订单状态，商户自行增删操作
                Core::log("weixinbackinfo", "微信支付支付成功", $xml);
                $redata = $notify->data;
                $pc_order = substr($redata['out_trade_no'], 0, 1);
                if ($pc_order == 'P') {
                    //PC订单
                    $paymentId = substr($redata['out_trade_no'], 0, 16);
                    $amount = $redata['total_fee'] / 100;
                    Api_Order_Pay::handleWechatPay($paymentId, $amount);

                } else {
                    //微信售票
                    $redata['out_trade_no'] = substr($redata['out_trade_no'], 0, 11);
                    $orderinfo = Data_Mysql_Table_Weixin_Ticket_Order_Info::select("*", array("order_no" => $redata['out_trade_no']), '', 1);
                    //有订单号，并且没有支付完成
                    if (!empty($orderinfo[0]) && $orderinfo[0]['order_status'] == 0 && $redata['total_fee'] / 100 == $orderinfo[0]['order_price']) {
                        //例如：更新订单状态
                        Data_Mysql_Table_Weixin_Ticket_Order_Info::update(
                            array("order_no" => $redata['out_trade_no']),
                            array(
                                "order_price_pay" => $redata['total_fee'] / 100,
                                "order_status" => 1,
                                "create_time2" => time(),
                                "update_time" => time()
                            ));

                        $orderinfo[0]['order_detail'] = json_decode($orderinfo[0]['order_detail'], 1);
                        //根据订单详情生成票号，并插入票号表
                        foreach ($orderinfo[0]['order_detail'] as $k => $v) {
                            $phdata['order_no'] = $orderinfo[0]['order_no'];
                            $phdata['event_id'] = $orderinfo[0]['event_id'];
//                        $phdata['buyer_account_id'] = $_SESSION['user']['id'];  //回调生成票号，用户id会出现存不进去的现象
//                        $phdata['buyer_account_name'] = $_SESSION['user']['username'];
//                        $phdata['buyer_account_phone'] = $_SESSION['user']['phone'];
                            $phdata['create_time'] = $phdata['update_time'] = time();
                            $phdata['status'] = 0;
                            for ($i = 1; $i <= $v['ticket_num']; $i++) {
                                $phdata['ticket_num'] = $phdata['order_no'] . $v['ticket_id'] . $i;
                                $phdata['ticket_price'] = $v['ticket_price'];
                                $phdata['ticket_detail'] = $v['ticket_name'];
                                $phdata['ticket_id'] = $v['ticket_id'];
                                Data_Mysql_Table_Weixin_Ticket_Num_Info::insert($phdata);
                            }
                            //更新一下库存
                            Data_Mysql_Table_Weixin_Ticket_Info::update(array('id' => $v['ticket_id']), array('stock =stock-' . $v['ticket_num']));
                        }
                        //发短信
                        $_REQUEST['order_no'] = $orderinfo[0]['order_no'];
                        $_REQUEST['order_event'] = $orderinfo[0]['event_id'];
                        $_SESSION['user']['id'] = $orderinfo[0]['buyer_account_id'];
                        self::sendOrderMessage(1);
                    }
                }


            }

            //商户自行增加处理流程,
            //例如：更新订单状态
            //例如：数据库操作
            //例如：推送支付完成信息
        }
    }

    /***
     * 订单列表 显示订单详情
     */
//    static function orderList()
//    {
//        //判断是否登录。没有登录就跳转到登录哪里
//        Web_Account::handleIsLogin('');
//        //修改为显示当前活动的订单。并且大于五天没有支付的订单不显示
//        $request = Func_Input::filter(array(
//            'event_id' => 'int',
//        ), $_REQUEST);
//        if (empty($request['event_id'])) {
//            Func_Header::back("请求错误");
//        }
//        //显示订单列表 订单状态。可能要订单合并支付（暂时不写合并支付）
//        $condition = array(
//            "buyer_account_id" => $_SESSION['user']['id'],
//            "buyer_account_phone" => $_SESSION['user']['phone'],
//            "order_status >=0",
//            "event_id " => $request['event_id'],
//        );
////        Data_Mysql_Table_Weixin_Ticket_Order_Info::debug(1);
//        $orderlist = Data_Mysql_Table_Weixin_Ticket_Order_Info::select("*", $condition, "order by order_status", 100);
//        $list = array();
//        $event_id = array();
//        if(!empty($orderlist)){
//            foreach ($orderlist as $k => $v) {
//                $v['order_detail'] = json_decode($v['order_detail'], 1);
//                $orderlist[$k]['order_detail'] = $v['order_detail'];
//                if ($v['order_status'] == 0 && $v['create_time'] > time() - 5 * 86400) {
//                    $list['waiting'][$k] = $v;
//                }
//                if ($v['order_status'] == 1) {
//                    $list['done'][$k] = $v;
//                    $event_id[$k] = $v['event_id'];
//                }
//            }
//        }
//
//        $event = array_unique($event_id);
//        if (!empty($list['done'])) {
////            $order_info = array();
//            $order_done = array();
//            $order_done['ticketlist'] = array();
//            $order_done['ids'] = '';
//            $order_done['event_title'] = '';
//            $order_done['total_price'] = 0;
//            $order_done['total_num'] = 0;
//            $ids = array();
//            foreach ($list['done'] as $k => $v) {
//                if (empty($order_done['event_title'])) {
//                    $order_done['event_title'] = $v['event_title'];
//                }
//                foreach ($v['order_detail'] as $kk => $vv) {
//                    $order_done['ticketlist'][] = $vv;
//                    $order_done['total_price'] += $vv['ticket_price'];
//                    $order_done['total_num'] += $vv['ticket_num'];
//                }
//                $ids[] = $v['id'];
//            }
//            $order_done['event_id'] = $request['event_id'];
//            $order_done['ids'] = implode(',', $ids);
//            Tpl_Smarty::assign('order_done', $order_done);
////            foreach ($list['done'] as $k => $v) {
////                foreach ($event as $kk => $vv) {
////                    if ($vv == $v['event_id']) {
////                        $order_info[$vv][] = $v;
////                    }
////                }
////            }
////            $order_price = 0;
////            $order_ids = array();
////            foreach ($order_info as $k => $v) {
////                foreach ($v as $kk => $vv) {
////                    $order_price += $vv['order_price'];
////                    $order_ids[$k][] = $vv['id'];
////                }
////                $order_info[$k]['ids'] = implode(',', $order_ids[$k]);
////            }
////            Tpl_Smarty::assign('order_price', $order_price);
////            Tpl_Smarty::assign('order_info', $order_info);
//        }
//        //头像信息
//        $userinfo = Data_Mysql_Table_Account_Wechat::select("user_info", array("openid" => $_SESSION['openid']), '', 1);
//        $userinfo[0]['user_info'] = json_decode($userinfo[0]['user_info'], 1);
//        Tpl_Smarty::assign("headimgurl", $userinfo[0]['user_info']['headimgurl']);
//        Tpl_Smarty::assign('event', $event);
//        Tpl_Smarty::assign("order_list", $list);
////        Tpl_Smarty::assign("order_list", $list['waiting']);
//        Tpl_Smarty::display("Web_Mobile_Static::wechat.v1.0/ticket_tobepaid.tpl");
//    }

    /**
     * 查看票号
     */

    static function ticketList()
    {
        Web_Account::handleIsLogin('');
        //接受订单号。查看门票详情
        $request = Func_Input::filter(array(
            'order_id' => 'string',
            'event_id' => 'int'
        ), $_REQUEST);
        if (empty($request['order_id'])) {
            Func_Header::back("订单号错误！");
        }
        $conditions[] = 'id IN(' . $request['order_id'] . ')';
        $conditions['buyer_account_id'] = $_SESSION['user']['id'];
        $orderinfo = Data_Mysql_Table_Weixin_Ticket_Order_Info::select('*', $conditions, "", 999);
        if (empty($orderinfo)) {
            Func_Header::back("未找到订单信息");
        }
        $event_title = $orderinfo[0]['event_title'];
        //暂时使用活动ID查询该活动ID下所有门票 20150630
        $table = "{table} AS t1 LEFT JOIN {prefix}weixin_ticket_order_info AS t2 ON t1.order_no = t2.order_no";
        $ticketlists = Data_Mysql_Table_Weixin_Ticket_Num_Info::select("*", array('t2.buyer_account_id=?' => $_SESSION['user']['id'], 't2.event_id=?' => $request['event_id']), '', 1000, $table);
        Tpl_Smarty::assign('title', $event_title);
        Tpl_Smarty::assign("ticket_lists", $ticketlists);
        Tpl_Smarty::display("Web_Mobile_Static::wechat.v1.0/ticket_list.tpl");
    }

    /**
     * 查看二维码
     */
    static function ticketQrCode()
    {
        Web_Account::handleIsLogin('');
        //接受订单号。显示门票列表。二维码显示票号链接
        $request = Func_Input::filter(array(
            'order_id' => 'string',
            'event_id' => 'int'
        ), $_REQUEST);
        if (empty($request['order_id'])) {
            Func_Header::back("订单号错误！");
        }
        $conditions[] = 'id IN(' . $request['order_id'] . ')';
        $conditions['buyer_account_id'] = $_SESSION['user']['id'];
        $orderinfo = Data_Mysql_Table_Weixin_Ticket_Order_Info::select('*', $conditions, "", 999);
        if (empty($orderinfo)) {
            Func_Header::back("未找到订单信息");
        }
        $event_title = $orderinfo[0]['event_title'];
        $table = "{table} AS t1 LEFT JOIN {prefix}weixin_ticket_order_info AS t2 ON t1.order_no = t2.order_no";
        $ticketlists = Data_Mysql_Table_Weixin_Ticket_Num_Info::select("*", array('t2.buyer_account_id=?' => $_SESSION['user']['id'], 't2.event_id=?' => $request['event_id']), '', 1000, $table);
        Tpl_Smarty::assign('title', $event_title);
        Tpl_Smarty::assign("ticket_lists", $ticketlists);
        Tpl_Smarty::display("Web_Mobile_Static::wechat.v1.0/ticket_code.tpl");
    }

    /**
     * 发送票号短信
     */
    static function sendOrderMessage($nologin = 0)
    {
        //接受订单号。发送短信订单信息
        //短信模板编号 :   23793     【云SPACE】您购买的{1}活动门票,总数{2}张,票号为:{3}
        if (!$nologin) {
            Web_Account::handleIsLogin('');
        }
        //接受订单号。显示门票列表。二维码显示票号链接
        $request = Func_Input::filter(array(
            'order_no' => 'string',
            'order_event' => 'int'
        ), $_REQUEST);
//        q($request);
        if (empty($request['order_no'])) {
            Func_Output::json(0, '', "订单号错误！");
            // die("订单号错误！");
        }
        if (!empty($_SESSION['auth_code_over']) && $_SESSION['auth_code_over'][1] > time()) {
            Func_Output::json(0, '', "请求太过频繁,请稍候再试!");
        }
        $order_info = Api_Wechat_Ticket_Order_Info_By_Order_No::getOrderInfo($_REQUEST);
        if ($order_info['status'] == 0) {
            Func_Output::json(0, '', "未找到该订单！");
        }
        $countNum = $order_info['data']['order_info']['order_ticket_num'];
        $ticket_num = array();
        if (!empty($order_info['data']['ticket_list'])) {
            foreach ($order_info['data']['ticket_list'] as $k => $v) {
                $ticket_num[] = $v['ticket_num'];
            }
        } else {
            Func_Output::json(0, '', "该订单没有选购门票！");
        }
        $ticketNum = implode(",", $ticket_num);
//        $start_time = !empty($order_info['data']['event_info']['activity_time']) ? $order_info['data']['event_info']['activity_time'] : $order_info['data']['event_info']['start_time'];
        $ticket_use_time = !empty($order_info['data']['event_info']['is_showtime'])?date('Y-m-d',$order_info['data']['event_info']['activity_time']).'至'.date('Y-m-d',$order_info['data']['event_info']['activity_end_time']):$order_info['data']['ticket_info']['event_time'];
        $event_title = $order_info['data']['event_info']['title'] . ",门票使用时间：" . $ticket_use_time . ",活动地址：" . $order_info['data']['event_info']['addr'].",";
        $phone = $order_info['data']['order_info']['buyer_account_phone'];
        $_SESSION['auth_code_over'] = array(
            $phone,
            time() + 30
        );
//        q($phone, $event_title, $countNum, $ticketNum);
        Web_Message::wxEventTicketNum($phone, $event_title, $countNum, $ticketNum);
    }

    /**
     * 门票信息
     */
    static function ticketInfo()
    {
        Web_Account::handleIsLogin('');
        $request = Func_Input::filter(array(
            'ticket_num' => 'string',
        ), $_REQUEST);
        if (empty($request['ticket_num'])) {
            Func_Header::back("票号错误！");
        }
        $ticketinfo = Data_Mysql_Table_Weixin_Ticket_Num_Info::select('*', array(
            "ticket_num" => $request['ticket_num'],
        ), "", 1);
        if (empty($ticketinfo[0]['id'])) {
            Func_Header::back("未找到该门票号");
        }
        $orderinfo = Data_Mysql_Table_Weixin_Ticket_Order_Info::select("*", array('order_no' => $ticketinfo[0]['order_no']), '', 1);
        $ticketinfo[0]['buyer_account_id'] = $orderinfo[0]['buyer_account_id'];
        $ticketinfo[0]['buyer_account_name'] = $orderinfo[0]['buyer_account_name'];
        $ticketinfo[0]['buyer_account_phone'] = $orderinfo[0]['buyer_account_phone'];
        Tpl_Smarty::assign("ticket_info", $ticketinfo[0]);
        Tpl_Smarty::display("Web_Mobile_Static::wechat.v1.0/ticket_texted_detail.tpl");
    }


    static function wxPay($wxData)
    {
        include_once(dirname(__FILE__) . "/WxPayPubHelper/WxPayPubHelper.php");
        //使用jsapi接口
        $jsApi = new JsApi_pub();
        if (empty($_SESSION['openid'])) {
            Func_Header::back('请求异常!');
        }
        $openid = $_SESSION['openid'];
        //=========步骤2：使用统一支付接口，获取prepay_id============
        //使用统一支付接口
        $unifiedOrder = new UnifiedOrder_pub();

        //设置统一支付接口参数
        //设置必填参数
        //appid已填,商户无需重复填写
        //mch_id已填,商户无需重复填写
        //noncestr已填,商户无需重复填写
        //spbill_create_ip已填,商户无需重复填写
        //sign已填,商户无需重复填写
        $unifiedOrder->setParameter("openid", "$openid");//商品描述
        $body = $wxData["body"];
        $unifiedOrder->setParameter("body", "$body");//商品描述
        //自定义订单号，此处仅作举例
        $out_trade_no = $wxData["out_trade_no"] . substr(time(), -6);
        $unifiedOrder->setParameter("out_trade_no", "$out_trade_no");//商户订单号
        $total_fee = $wxData["total_fee"] * 100;
        $unifiedOrder->setParameter("total_fee", "$total_fee");//总金额
        $unifiedOrder->setParameter("notify_url", WxPayConf_pub::NOTIFY_URL);//通知地址
        $unifiedOrder->setParameter("trade_type", "JSAPI");//交易类型
        $prepay_id = $unifiedOrder->getPrepayId();
        //=========步骤3：使用jsapi调起支付============
        $jsApi->setPrepayId($prepay_id);

        $jsApiParameters = $jsApi->getParameters();
        Tpl_Smarty::assign("jsApiParameters", $jsApiParameters);
        Tpl_Smarty::assign("loactionurl", "http://" . Core::$urls['host'] . "/m/" . Core::$urls['route'] . "order_list");
    }

    static function wxPayNew($wxData)
    {
        include_once(dirname(__FILE__) . "/WxPayPubHelper/WxPayPubHelper.php");


        //使用统一支付接口
        $unifiedOrder = new UnifiedOrder_pub();
        //设置统一支付接口参数
        //设置必填参数
        //appid已填,商户无需重复填写
        //mch_id已填,商户无需重复填写
        //noncestr已填,商户无需重复填写
        //spbill_create_ip已填,商户无需重复填写
        //sign已填,商户无需重复填写
        $body = $wxData["body"];
        $unifiedOrder->setParameter("body", "$body");//商品描述
        //自定义订单号，此处仅作举例
        $timeStamp = time();
        $out_trade_no = $wxData["out_trade_no"] . substr(time(), -6);
        $unifiedOrder->setParameter("out_trade_no", "$out_trade_no");//商户订单号
        $total_fee = $wxData["total_fee"] * 100;
        $unifiedOrder->setParameter("total_fee", "$total_fee");//总金额
        $unifiedOrder->setParameter("notify_url", WxPayConf_pub::NOTIFY_URL);//通知地址
        $unifiedOrder->setParameter("trade_type", "NATIVE");//交易类型
        //非必填参数，商户可根据实际情况选填
        //$unifiedOrder->setParameter("sub_mch_id","XXXX");//子商户号
        //$unifiedOrder->setParameter("device_info","XXXX");//设备号
        //$unifiedOrder->setParameter("attach","XXXX");//附加数据
        //$unifiedOrder->setParameter("time_start","XXXX");//交易起始时间
        //$unifiedOrder->setParameter("time_expire","XXXX");//交易结束时间
        //$unifiedOrder->setParameter("goods_tag","XXXX");//商品标记
        //$unifiedOrder->setParameter("openid","XXXX");//用户标识
        //$unifiedOrder->setParameter("product_id","XXXX");//商品ID

        //获取统一支付接口结果
        $unifiedOrderResult = $unifiedOrder->getResult();

        //商户根据实际情况设置相应的处理流程
        if ($unifiedOrderResult["return_code"] == "FAIL") {
            //商户自行增加处理流程
            //echo "通信出错：".$unifiedOrderResult['return_msg']."<br>";
        } elseif ($unifiedOrderResult["result_code"] == "FAIL") {
            //商户自行增加处理流程
            //echo "错误代码：".$unifiedOrderResult['err_code']."<br>";
            //echo "错误代码描述：".$unifiedOrderResult['err_code_des']."<br>";
        } elseif ($unifiedOrderResult["code_url"] != NULL) {
            //从统一支付接口获取到code_url
            $code_url = $unifiedOrderResult["code_url"];
            Tpl_Smarty::assign("code_url", $code_url);
            //商户自行增加处理流程
            //......
        }
    }



    // 新建收货地址
    static function createTicketAddress()
    {
        if(isset($_GET['url_back'])&&!empty($_GET['url_back'])){
            $url_back =$_GET['url_back'];
        }else{
            $url_back = Core::$urls['referer'];
        }
        Tpl_Smarty::assign('url_back',$url_back);
        Tpl_Smarty::display('Web_Mobile_Static::wechat.v3.1/booking_adress3.tpl');
    }

    // 提交收货地址
    static function submitTicketAddress()
    {
        $data = Api_Wechat_Ticket_Add_Address::addAddress($_REQUEST);
        if ($data['status'] == 1) {
            Func_Header::to('', $_REQUEST['url_back']);
        } else
            Func_Header::back($data['msg']);
        }


    //选择收货地址
    static function selectTicketAddress()
    {
        $request = Func_Input::filter(array(
            'event_id' => 'int',
        ));
        if (!empty($request['event_id'])) {
            Tpl_Smarty::assign('event_id', $request['event_id']);
        } else {
            Func_Header::back('请求异常！');
        }
        if (empty($ticketListUrl)) {
            $ticketListUrl = Core::$urls['referer'];     //
        }
        $_REQUEST['account_id'] = $_SESSION['user']['id'];
        $addr = Api_Wechat_Ticket_Get_Address_List::getAddressList($_REQUEST);

        if ($addr['status'] == 1 && !empty($addr['data'])) {

            Tpl_Smarty::assign('address', $addr['data']);
            Tpl_Smarty::display('Web_Mobile_Static::wechat.v3.1/booking_adress4.tpl');
        } else {

            Func_Header::back($addr['msg']);
        }

    }

    // 管理收获地址
    static function manageTicketAddress()
    {
        $_REQUEST['account_id'] = $_SESSION['user']['id'];
        $addr = Api_Wechat_Ticket_Get_Address_List::getAddressList($_REQUEST);

        if ($addr['status'] == 1 && !empty($addr['data'])) {
            if(!isset($addr['data'][1]) && $addr['data'][0]['is_default']==1){
                Tpl_Smarty::assign('hideStyle',1);
            }
            Tpl_Smarty::assign('address', $addr['data']);
            Tpl_Smarty::display('Web_Mobile_Static::wechat.v3.1/booking_adress2.tpl');
        } else {
            Func_Header::back($addr['msg']);
        }
    }
    // 编辑收货地址 (模板显示)
    static function editTicketAddress()
    {
        $_REQUEST['account_id'] = $_SESSION['user']['id'];
        $addressInfo = Api_Wechat_Ticket_Get_Address_Info::getAddressInfo($_REQUEST);
        if ($addressInfo['status'] == 1 && !empty($addressInfo['data'])) {
            Tpl_Smarty::assign('address', $addressInfo['data']);
        } else {
            Func_Header::back($addressInfo['msg']);
        }
        Tpl_Smarty::display('Web_Mobile_Static::wechat.v3.1/booking_adress1.tpl');
    }
    // 编辑收货地址 （提交）
    static function updateAddress()
    {

        $addressInfo = Api_Wechat_Ticket_Update_Address::updateAddress($_REQUEST);
        if ($addressInfo['status'] == 1) {
            Func_Header::to('', 'manage_address?');
        } else {
            Func_Header::back($addressInfo['msg']);
        }
    }

    //路跑活动临时表单
    static  function showEventForm(){
        Tpl_Smarty::display('Web_Mobile_Static::wechat.v3.1/lupao_form.tpl');
    }

    //增加特定活动的表单
    static  function submitEventForm(){
        $_REQUEST['data']['Phone'] = $_SESSION['user']['phone'];
        $data = Api_General_Form_User_Submit_Form::userSubmitForm($_REQUEST);
        if (isset($data['status']) && $data['status'] == 1)
        {
            $userFormId['user_form_id'] = $data['data'][0];
            Api_General_Form_SendMsg_To_Backemail::sendMsg($userFormId);
            Func_Header::to('您的信息已经提交，感谢您的参与', 'http://'.Core::$urls['host'].'/m/event_ticket/order_list');
        } else {
            Func_Header::back($data['msg']);
        }
    }
}