<?php

/**
 * Created by PhpStorm.
 * User: yl
 * Date: 15/5/13
 * 套餐订单操作
 */
class Web_Product_Set_Order_Operator extends Base
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
        Web_Product_Set_Order_Info::handle($orderNo);
        self::$_orderInfo = &Web_Product_Set_Order_Info::$_orderInfo;
    }
    //审核，签约，创建支付节点
    static function handlePending()
    {
        Web_Account::handleAccountHasAuth('审核', 21);
        Web_Account::handleAccountHasAuth('签约', 21);
        //判断是否是卖家
        if (!self::$_orderInfo['is_vendor']) {
            Func_Header::back('参数异常1!');
        }
        //添加签约信息
        Web_Product_Set_Order_Info::handleStep2();
        $r = Data_Mysql_Table_Order_Info::update(self::$_orderInfo['id'], array(
            'vendor_account_id' => $_SESSION['user']['id'],
            'create_time2' => time(),
            'order_conform'=>self::$_orderInfo['order_conform'],
            'order_status' => 12,
        ));
        if (empty($r[0])) {
            Func_Header::back('操作失败，请稍候再试或联系客服人员！');
        }
        //创建支付节点
        Web_Product_Set_Order_Info::resolveCreatePaymentInfo();
        Data_Mysql_Table_Product_Schedule::update(array(
            'order_id' => self::$_orderInfo['id'],
        ), array(
            'status' => 2,
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

        Func_Header::to('操作成功', Core::$urls['root'] . 'product_set_order_info/' . self::$_orderInfo['order_no']);
    }
    //订单取消
    static function handleCancel()
    {
        //判断是否是买家
        if (!self::$_orderInfo['is_buyer']) {
            Func_Header::back('参数异常2!');
        }
        $cancel_reason=Func_Input::filter(array('cancel_reason'=>'string'));
        if(empty($cancel_reason['cancel_reason'])){
            Func_Header::back('请填写取消理由！！');
        }
        $r = Data_Mysql_Table_Order_Info::update(self::$_orderInfo['id'], array(
            'order_status' => -1,
            'cancel_time' => time(),
            'order_close_info'=>array('reason'=>$cancel_reason['cancel_reason']),
        ));
        if (empty($r[0])) {
            Func_Header::back('操作失败，请稍候再试或联系客服人员！');
        }
        Func_Header::to('操作成功', Core::$urls['root'] . 'product_set_order_info/' . self::$_orderInfo['order_no']);
    }
    //确认订单取消
    static function handleConfirmCancel()
    {
        //判断是否是卖家
        if (!self::$_orderInfo['is_vendor']) {
            Func_Header::back('参数异常2!');
        }
        $r = Data_Mysql_Table_Order_Info::update(self::$_orderInfo['id'], array(
            'order_status' => -2,
            'cancel_time' => time(),
        ));
        if (empty($r[0])) {
            Func_Header::back('操作失败，请稍候再试或联系客服人员！');
        }
        Func_Header::to('操作成功', Core::$urls['root'] . 'product_set_order_info/' . self::$_orderInfo['order_no']);
    }
    //订单未通过审核
    static function handleRefuse()
    {
        Web_Account::handleAccountHasAuth('审核', 21);
        //判断是否是买家
        if (!self::$_orderInfo['is_vendor']) {
            Func_Header::back('参数异常2!');
        }
        if (self::$_orderInfo['create_time3']) {
            Func_Header::back('已签约订单不能拒绝!');
        }
        $refuse_reason=Func_Input::filter(array('refuse_reason'=>'string'));
        if(empty($refuse_reason['refuse_reason'])){
            Func_Header::back('请填写拒绝原因！');
        }
        $r = Data_Mysql_Table_Order_Info::update(self::$_orderInfo['id'], array(
            'order_status' => -3,
            'cancel_time' => time(),
            'order_close_info'=>array('reason'=>$refuse_reason['refuse_reason']),
        ));
        if (empty($r[0])) {
            Func_Header::back('操作失败，请稍候再试或联系客服人员！');
        }
        Func_Header::to('操作成功', Core::$urls['root'] . 'product_set_order_info/' . self::$_orderInfo['order_no']);
    }
    //评价
    static function handleEvaluate()
    {
        //判断是否是买家
        if (!self::$_orderInfo['is_buyer'] && !self::$_orderInfo['is_vendor']) {
            Func_Header::back('参数异常2!');
        }
        $evaluate=Func_Input::filter(array(
            '质量效果'=>'string',
            '服务态度'=>'string',
            '响应速度'=>'string',
            '评价备注'=>'string',
        ),$_REQUEST['data']);
        $r = Data_Mysql_Table_Order_Info::update(self::$_orderInfo['id'], array(
            'order_status' => 90,
            'order_complete'=>$evaluate,
            'create_time5' => time(),

        ));
        if (empty($r[0])) {
            Func_Header::back('操作失败，请稍候再试或联系客服人员！');
        }
        Func_Header::to('操作成功', Core::$urls['root'] . 'product_set_order_info/' . self::$_orderInfo['order_no']);
    }
    //订单跟踪
    static function handleTracking()
    {
        $content=Func_Input::filter(array(
            'operate_content'=>'string',
        ));
        $order=Data_Mysql_Table_Order_Info::select('order_detail',self::$_orderInfo['id']);
        $order_detail=json_decode($order[0]['order_detail'],1);
        $track_info=array('更新时间'=>time(),'操作内容'=>$content['operate_content'],'操作人'=>'服务方');
        if(!empty($order_detail['order_tracking'])){
            $order_detail['order_tracking'][count($order_detail['order_tracking'])]=$track_info;
        }else{
            $order_detail['order_tracking'][0]=$track_info;
        }
        $r = Data_Mysql_Table_Order_Info::update(self::$_orderInfo['id'], array(
            'order_detail' => $order_detail,
        ));
        if (empty($r[0])) {
            Func_Header::back('操作失败，请稍候再试或联系客服人员！');
        }
        Func_Header::to('操作成功', Core::$urls['root'] . 'product_set_order_info/' . self::$_orderInfo['order_no'].'?tab=3');
    }
    //发票寄出
    static function handleTicket(){
        Core::output('');
        $order=Data_Mysql_Table_Order_Info::select('order_detail',self::$_orderInfo['id']);
        $order_detail=json_decode($order[0]['order_detail'],1);
        $order_detail['ticket']=1;
        $r=Data_Mysql_Table_Order_Info::update(self::$_orderInfo['id'], array(
            'order_detail' => $order_detail,
        ));
        if (empty($r[0])) {
            echo 'fail';
            die;
        }
        echo 'success';
        die;
    }
    //需要发票
    static function handleNeedTicket(){
        if(empty(self::$_orderInfo['order_price_last'])){
            Func_Header::back('订单尚未支付完成，不能开发票！！');
        }
        $order=Data_Mysql_Table_Order_Info::select('order_detail',self::$_orderInfo['id']);
        $order_detail=json_decode($order[0]['order_detail'],1);
        $order_detail['ticket']=self::$_orderInfo['buyer_fullname'];
        $r=Data_Mysql_Table_Order_Info::update(self::$_orderInfo['id'], array(
            'order_detail' => $order_detail,
        ));
        if (empty($r[0])) {
            Func_Header::back('操作失败，请稍候再试或联系客服人员！');
        }
        Func_Header::to('操作成功', Core::$urls['root'] . 'product_set_order_info/' . self::$_orderInfo['order_no']);
    }
    //套餐订单打印
    static function handleOrderPrint(){
        if (self::$_orderInfo['create_time2']) {
            //加载付款信息
            self::$_orderInfo['payment'] = Finance_Payment::getListByOrderId(self::$_orderInfo['id'], self::$_orderInfo['create_time2']);
            if(!empty(self::$_orderInfo['payment'])){
                foreach(self::$_orderInfo['payment'] as $k=>$v){
                    self::$_orderInfo['payment'][$v['payment_id']]=$v;
                    unset(self::$_orderInfo['payment'][$k]);
                }
            }
            self::$_orderInfo['payment']['buyer_bank_info']=Web_Product_Set_Order_Info::getBankInfo(self::$_orderInfo['buyer_account_id']);
            self::$_orderInfo['payment']['target_bank_info']=Web_Product_Set_Order_Info::getBankInfo(self::$_orderInfo['vendor_account_id']);
        }
        $payment_info=Data_Mysql_Table_Order_Payment::select('*',array('order_id'=>self::$_orderInfo['id']),'',10);
        if(!empty($payment_info)){
            foreach($payment_info as $k=>$v){
                $payment_info[$k]['payment_info']=json_decode($v['payment_info'],1);
            }
        }
        $set_info=self::$_orderInfo['order_detail']['set_info'];
        Tpl_Smarty::assign('data',self::$_orderInfo);
        Tpl_Smarty::assign('payment_info',$payment_info);
        Tpl_Smarty::assign('set_info',$set_info);
        $order_tmp=Tpl_Smarty::fetch('Web','inc/product_set_inc/order_print.tpl');
        $logo=Core::$paths['root'].'package/Web_User_Center_1.0/interface/assets/images/logo.png';
        Func_Pdf::html2pdf('',$order_tmp,$logo);

    }
}