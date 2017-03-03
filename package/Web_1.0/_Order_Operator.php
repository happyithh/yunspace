<?php

/**
 * Created by PhpStorm.
 * User: liushengchun
 * Date: 15/3/10
 * Time: 11:18
 */
class Web_Order_Operator extends Base
{
    static $_orderInfo;

    static function checkPassword2()
    {
        if (empty($_REQUEST['password2']) || !Data_Mysql_Table_Account::checkPassword2($_REQUEST['password2'])) {
            Func_Header::back('交易密码错误');
        }
    }

    static function handle($orderNo)
    {
        Web_Order_Info::handle($orderNo);
        self::$_orderInfo = &Web_Order_info::$_orderInfo;
    }

    static function handlePending()
    {
        Web_Account::handleAccountHasAuth('审核', 21);
        //判断是否是卖家
        if (!self::$_orderInfo['is_vendor']) {
            Func_Header::back('参数异常1!');
        }
        $r = Data_Mysql_Table_Order_Info::update(self::$_orderInfo['id'], array(
            'vendor_account_id' => $_SESSION['user']['id'],
            'create_time2' => time(),
            'order_status' => 5,
        ));
        if (empty($r[0])) {
            Func_Header::back('操作失败，请稍候再试或联系客服人员！');
        }
        Data_Mysql_Table_Product_Schedule::update(array(
            'order_id' => self::$_orderInfo['id'],
        ), array(
            'status' => 1,
        ));

        //发短消息和邮件通知采购方订单已审核
        if (!self::$_orderInfo['buyer_account_id']) {
            //通知超级供应商账号的手机号码, 和客服
            $vendorInfo = Data_Mysql_Table_Account::select("username,phone,email", array('username' => 'vendor'));
        } else {
            $vendorInfo = Data_Mysql_Table_Account::select("username,phone,email", array('id' => self::$_orderInfo['buyer_account_id']));
        }
        if (!empty($vendorInfo[0]['phone'])) {
            Web_Message::orderPending($vendorInfo[0]['phone'], self::$_orderInfo['order_no']);
        }
        if (!empty($vendorInfo[0]['email'])) {
            Web_Message::orderPendingEmail($vendorInfo[0]['email'], $vendorInfo[0]['username'], self::$_orderInfo['order_no']);
        }

        Func_Header::to('操作成功', Core::$urls['root'] . 'order_info/' . self::$_orderInfo['order_no']);
    }

    static function handleCancle()
    {
        Web_Account::handleAccountHasAuth('下单', 1);
        //判断是否是买家
        if (!self::$_orderInfo['is_buyer'] && !self::$_orderInfo['is_vendor']) {
            Func_Header::back('参数异常2!');
        }
        if (self::$_orderInfo['create_time3']) {
            Func_Header::back('已签约订单不能关闭!');
        }
        $r = Data_Mysql_Table_Order_Info::update(self::$_orderInfo['id'], array(
            'order_status' => $_SESSION['user']['id'] == self::$_orderInfo['buyer_account_id'] ? -1 : -2,
            'cancel_time' => time(),
        ));
        if (empty($r[0])) {
            Func_Header::back('操作失败，请稍候再试或联系客服人员！');
        }
        Func_Header::to('操作成功', Core::$urls['root'] . 'order_info/' . self::$_orderInfo['order_no']);
    }

    static function handleConform()
    {
        Web_Account::handleAccountHasAuth('签约', 21);
        unset($_REQUEST['data']['支付节点']['$$'], $_REQUEST['data']['附件']['$$'], $_REQUEST['data']['订单外款项']['$$']);
        if (empty($_REQUEST['data']['协议标题'])) {
            Func_Header::back('协议标题 必须填写');
        }
        if (empty($_REQUEST['data']['供应商签约代表'])) {
            Func_Header::back('供应商签约代表 必须填写');
        }
        if (empty($_REQUEST['data']['服务名称'])) {
            Func_Header::back('服务名称 必须填写');
        }
        if (empty($_REQUEST['data']['服务内容'])) {
            Func_Header::back('服务内容 必须填写');
        }
        if (empty($_REQUEST['data']['交易单价'])) {
            Func_Header::back('交易单价 必须填写');
        }
        if (empty($_REQUEST['data']['交易数量'])) {
            Func_Header::back('交易数量 必须填写');
        }
        if (empty($_REQUEST['data']['支付节点'])) {
            Func_Header::back('支付节点 必须填写');
        }
        $_REQUEST['data']['交易总计'] = $_REQUEST['data']['交易单价'] * $_REQUEST['data']['交易数量'];
        if (empty($_REQUEST['data']['交付时间']) || strtotime($_REQUEST['data']['交付时间']) < (time() + 500)) {
            Func_Header::back('交付时间 必须正确填写');
        }
        $totalPercent = 0;
        foreach ($_REQUEST['data']['支付节点'] as $k => $v) {
            if(empty($v['名称'])){
                Func_Header::back('支付节点名称 必须正确填写');
            }
            if (empty($v['比例'])) {
                unset($_REQUEST['data']['支付节点'][$k]);
            } else {
                $totalPercent += $v['比例'];
                $_REQUEST['data']['支付节点'] [$k]['金额'] = $_REQUEST['data']['交易总计'] / 100 * $v['比例'];
            }
        }
        $_REQUEST['data']['支付节点'] = array_values($_REQUEST['data']['支付节点']);
        if (empty($_REQUEST['data']['支付节点'][0])) {
            Func_Header::back('支付节点 必须正确填写');
        }
        if ($totalPercent != 100) {
            Func_Header::back('支付节点的比例总和不等于100%');
        }
        $_REQUEST['data']['附件'] = array_values($_REQUEST['data']['附件']);
        $_REQUEST['data']['订单外款项'] = array_values($_REQUEST['data']['订单外款项']);
        foreach ($_REQUEST['data']['订单外款项'] as $k => $v) {
            if (empty($v['名称']) || empty($v['金额']) || empty($v['期限']) || !is_numeric($v['金额'])) {
                Func_Header::back('订单外款项的节点信息 必须正确填写');
            }
        }
        //判断是否是买家
        if (!self::$_orderInfo['is_vendor']) {
            Func_Header::back('参数异常4!');
        }
        if (self::$_orderInfo['create_time3']) {
            Func_Header::back('已签约订单不能修改!');
        }
        $r = Data_Mysql_Table_Order_Info::update(self::$_orderInfo['id'], array(
            'order_price' => $_REQUEST['data']['交易总计'],
            'order_conform' => $_REQUEST['data'],
        ));
        if (empty($r[0])) {
            Func_Header::back('操作失败，请稍候再试或联系客服人员！');
        }
        Func_Header::to('操作成功', Core::$urls['root'] . 'order_info/' . self::$_orderInfo['order_no']);
    }

    static function handleVendorSigning()
    {
        Web_Account::handleAccountHasAuth('签约', 21);
        //判断是否是买家
        if (!self::$_orderInfo['is_vendor']) {
            Func_Header::back('参数异常5!');
        }
        if (self::$_orderInfo['create_time3']) {
            Func_Header::back('已签约订单不能修改!');
        }
        if (empty($_REQUEST['password2'])) {
            Func_Header::back('交易密码必须填写');
        }
        $r = Data_Mysql_Table_Account::select('id, password2', array('id' => $_SESSION['user']['id']));
        if (empty($r[0]['id'])) {
            Func_Header::back('登录异常,请重新登录.');
        }
        self::checkPassword2();
        Web_Order_Info::handleStep2();
        self::$_orderInfo['order_conform']['vendor_signing'] = time();
        $r = Data_Mysql_Table_Order_Info::update(self::$_orderInfo['id'], array(
            'vendor_account_id' => self::$_orderInfo['vendor_account_id'] ? self::$_orderInfo['vendor_account_id'] : $_SESSION['user']['id'],
            'order_conform' => self::$_orderInfo['order_conform'],
            'order_status' => 11,
        ));
        if (empty($r[0])) {
            Func_Header::back('操作失败，请稍候再试或联系客服人员！');
        }


        //发短消息和邮件通知采购方供应商已完善合同并签约
        if (!self::$_orderInfo['buyer_account_id']) {
            //通知超级供应商账号的手机号码, 和客服
            $vendorInfo = Data_Mysql_Table_Account::select("username,phone,email", array('username' => 'vendor'));
        } else {
            $vendorInfo = Data_Mysql_Table_Account::select("username,phone,email", array('id' => self::$_orderInfo['buyer_account_id']));
        }
        if (!empty($vendorInfo[0]['phone'])) {
            Web_Message::orderVendorSigning($vendorInfo[0]['phone'], self::$_orderInfo['order_no']);
        }
        if (!empty($vendorInfo[0]['email'])) {
            Web_Message::orderVendorSigningEmail($vendorInfo[0]['email'], $vendorInfo[0]['username'], self::$_orderInfo['order_no']);
        }

        Func_Header::to('操作成功', Core::$urls['root'] . 'order_info/' . self::$_orderInfo['order_no']);
    }

    static function handleBuyerSigning()
    {
        Web_Account::handleAccountHasAuth('签约', 1);
        //判断是否是买家
        if (!self::$_orderInfo['is_buyer']) {
            Func_Header::back('参数异常6!');
        }
        if (self::$_orderInfo['create_time3']) {
            Func_Header::back('已签约订单不能修改!');
        }
        if (empty($_REQUEST['password2'])) {
            Func_Header::back('交易密码必须填写');
        }
        $r = Data_Mysql_Table_Account::select('id, password2', array('id' => $_SESSION['user']['id']));
        if (empty($r[0]['id'])) {
            Func_Header::back('登录异常,请重新登录.');
        }
        self::checkPassword2();
        Web_Order_Info::handleStep2();
        self::$_orderInfo['order_conform']['buyer_signing'] = time();
        $r = Data_Mysql_Table_Order_Info::update(self::$_orderInfo['id'], array(
            'order_conform' => self::$_orderInfo['order_conform'],
            'create_time3' => time(),
            'order_status' => 12,
        ));
        if (empty($r[0])) {
            Func_Header::back('操作失败，请稍候再试或联系客服人员！');
        }
        Web_Order_Info::resolveCreatePaymentInfo();
        Data_Mysql_Table_Product_Schedule::update(array(
            'order_id' => self::$_orderInfo['id'],
        ), array(
            'status' => 2,
        ));
        //发短消息和邮件通知供应商采购方已签约
        if (!self::$_orderInfo['vendor_account_id']) {
            //通知超级供应商账号的手机号码, 和客服
            $vendorInfo = Data_Mysql_Table_Account::select("username,phone,email", array('username' => 'vendor'));
        } else {
            $vendorInfo = Data_Mysql_Table_Account::select("username,phone,email", array('id' => self::$_orderInfo['buyer_account_id']));
        }
        if (!empty($vendorInfo[0]['phone'])) {
            Web_Message::orderBuyerSigning($vendorInfo[0]['phone'], self::$_orderInfo['order_no']);
        }
        if (!empty($vendorInfo[0]['email'])) {
            Web_Message::orderBuyerSigningEmail($vendorInfo[0]['email'], $vendorInfo[0]['username'], self::$_orderInfo['order_no']);
        }
        Func_Header::to('操作成功', Core::$urls['root'] . 'order_info/' . self::$_orderInfo['order_no']);
    }

    static function handleBuyerComplete()
    {
        Web_Account::handleAccountHasAuth('结算', 1);
        //判断是否是买家
        if (!self::$_orderInfo['is_buyer']) {
            Func_Header::back('参数异常6!');
        }
        if (!self::$_orderInfo['create_time4'] || self::$_orderInfo['create_time5']) {
            Func_Header::back('参数异常5!');
        }
        if (empty($_REQUEST['data']['结算金额'])) {
            $_REQUEST['data']['结算金额'] = 0;
        }
        self::$_orderInfo['payment'] = Finance_Payment::getListByOrderId(self::$_orderInfo['id'], self::$_orderInfo['create_time3']);
        self::$_orderInfo['order_price_settle'] = 0;
        self::$_orderInfo['order_price_settle_in'] = 0;
        foreach (self::$_orderInfo['payment'] as $v) {
            if (!$v['payment_detail']['is_in_order']) {
                self::$_orderInfo['order_price_settle'] += $v['amount'];
            } elseif (!empty($v['payment_detail']['is_settle'])) {
                self::$_orderInfo['order_price_settle'] += $v['amount'];
                self::$_orderInfo['order_price_settle_in'] += $v['amount'];
            }
        }
        if (self::$_orderInfo['order_price_settle'] && self::$_orderInfo['order_price_settle'] < $_REQUEST['data']['结算金额']) {
            Func_Header::back('结算金额不能超出待结算金额!');
        }
        self::checkPassword2();
        $r = Data_Mysql_Table_Order_Info::update(self::$_orderInfo['id'], array(
            'order_complete' => $_REQUEST['data'],
            'order_status' => 80,
        ));
        if (empty($r[0])) {
            Func_Header::back('操作失败，请稍候再试或联系客服人员！');
        }
        //TODO: 发消息通知双方订单结算
        //发短消息和邮件通知供应商采购方提交结算信息
//        if (!self::$_orderInfo['vendor_account_id']) {
//            //通知超级供应商账号的手机号码, 和客服
//            $vendorInfo = Data_Mysql_Table_Account::select("username,phone,email", array('username' => 'vendor'));
//        } else {
//            $vendorInfo = Data_Mysql_Table_Account::select("username,phone,email", array('id' => self::$_orderInfo['buyer_account_id']));
//        }
//        if (!empty($vendorInfo[0]['phone'])) {
//            Web_Message::orderBuyerSigning($vendorInfo[0]['phone'], self::$_orderInfo['order_no']);
//        }
//        if (!empty($vendorInfo[0]['email'])) {
//            Web_Message::orderBuyerSigningEmail($vendorInfo[0]['email'], $vendorInfo[0]['username'], self::$_orderInfo['order_no']);
//        }

        Func_Header::to('操作成功', Core::$urls['root'] . 'order_info/' . self::$_orderInfo['order_no']);
    }

    static function handleVendorComplete()
    {
        Web_Account::handleAccountHasAuth('结算', 21);
        //判断是否是买家
        if (!self::$_orderInfo['is_vendor']) {
            Func_Header::back('参数异常6!');
        }
        if (!self::$_orderInfo['create_time4'] || self::$_orderInfo['create_time5']) {
            Func_Header::back('参数异常5!');
        }
        if (!self::$_orderInfo['order_complete']) {
            Func_Header::back('参数异常6!');
        }
        self::checkPassword2();
        self::$_orderInfo['payment'] = Finance_Payment::getListByOrderId(self::$_orderInfo['id'], self::$_orderInfo['create_time3']);
        self::$_orderInfo['order_price_settle'] = 0;
        self::$_orderInfo['order_price_settle_in'] = 0;
        foreach (self::$_orderInfo['payment'] as $v) {
            if (!$v['payment_detail']['is_in_order']) {
                self::$_orderInfo['order_price_settle'] += $v['amount'];
            } elseif (!empty($v['payment_detail']['is_settle'])) {
                self::$_orderInfo['order_price_settle'] += $v['amount'];
                self::$_orderInfo['order_price_settle_in'] += $v['amount'];
            }
        }
        if (self::$_orderInfo['order_price_settle'] < self::$_orderInfo['order_complete']['结算金额']) {
            Func_Header::back('结算金额不能超出待结算金额!');
        }
        $r = Data_Mysql_Table_Order_Info::update(self::$_orderInfo['id'], array(
            'create_time5' => time(),
            'order_price_last' => self::$_orderInfo['order_complete']['实付金额'],
            'order_status' => 90,
        ));
        if (empty($r[0])) {
            Func_Header::back('操作失败，请稍候再试或联系客服人员！');
        }


        //TODO: 发消息通知双方订单结算

        Func_Header::to('操作成功', Core::$urls['root'] . 'order_info/' . self::$_orderInfo['order_no']);
    }

}