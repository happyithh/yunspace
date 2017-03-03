<?php
/**
 * Created by PhpStorm.
 * User: yl
 * Date: 15-7-8
 * Time: 下午4:36
 * 订单详情页
 */
Web_Account::handleIsLogin();


//处理上传
if (Core::$urls['action'] == 'upload') {
    Admin_Upload::handleUploadGlobal(100);
    die();
}
//发送验证码
if (Core::$urls['action'] == 'send_code') {
    Api_Common_Send_Auth_Code::sendAuthCode($_REQUEST);
    die();
}

//获取订单信息
$orderNo = strtoupper(Core::$urls['action']);
if (!$orderNo) {
    Func_Header::notFound();
}

$rs=Api_Order_Info::getOrderInfo($orderNo);
if($rs['status']==0){
    Func_Header::notFound();
}
$orderInfo=$rs['data'];
$objectInfo=$orderInfo['order_detail']['object_info'];


if($orderInfo['create_time2']){

    //获取订单的所有合同和总金额
    $all_conform=Api_Order_Normal_Api::getConformAmountAndList($orderInfo['id'],0);

    //获取待签约的合同金额
    $waiting_conform=Api_Order_Normal_Api::getConformAmountAndList($orderInfo['id'],1,0);

    //获取订单的某个合同
    Tpl_Smarty::assign('all_conform',$all_conform);

}

if($orderInfo['create_time3']){
    //获取所有已签约合同
    $assigned_conform=Api_Order_Normal_Api::getConformAmountAndList($orderInfo['id'],1,1);

    //获取所有支付信息
    $payment_return=Api_Order_Info::getPaymentInfo();

    //获取所有已支付信息
    $paymentInfo=array();
    if(!empty($payment_return['data'])){
        $paymentInfo=$payment_return['data']['data'];
    }

    $payment=$not_pay=array();
    if(!empty($orderInfo['payment'])){
        //获取所有支付节点
        $payment=$orderInfo['payment'];
        foreach($payment as $k=>$v){
            if(!empty($paymentInfo[$v['payment_id']])){
                $paymentInfo[$v['payment_id']]['payment_title']=$v['payment_detail']['payment_title'];
            }else{
                $not_pay[$v['payment_id']]=$v;
            }
        }
    }
    Tpl_Smarty::assign('assigned_conform', $assigned_conform);
    Tpl_Smarty::assign('paymentInfo', $paymentInfo);
    Tpl_Smarty::assign('not_pay', $not_pay);
}

//获取供应商所有的银行卡信息
$vendor_bank=Api_Order_Normal_Api::getBankInfo($orderInfo['vendor_account_id']);

Tpl_Smarty::assign('__user', $_SESSION['user']);
Tpl_Smarty::assign('orderinfo', $orderInfo);
Tpl_Smarty::assign('info', $objectInfo);
Tpl_Smarty::assign('bank_info', $vendor_bank);
Tpl_Smarty::assign('full_payment', empty($full_payment_id)?0:$full_payment_id);
Tpl_Smarty::display('Web_Static', 'order/order_info.tpl');