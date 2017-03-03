<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 15-8-11
 * Time: 下午4:33
 * 线下支付
 */
//获取订单信息
@session_start();
$request=Func_Input::filter(array(
    'order_no'=>'string',
    'payment_id'=>'string',
));
if (empty($request['order_no'])) {
    Func_Header::notFound();
}

$rs=Api_Order_Info::getOrderInfo($request['order_no']);
if($rs['status']==0){
    Func_Header::notFound();
}
$orderInfo=$rs['data'];

$payment=$paymentInfo=array();
if(!empty($request['payment_id'])){
    //获取支付节点的支付信息
    $payment_info=Api_Order_Info::getPaymentInfoByPayId($request['payment_id']);
    if($payment_info['status']==1){
        $paymentInfo=$payment_info['data'];
    }
}
Tpl_Smarty::assign('paymentInfo',$paymentInfo);
Tpl_Smarty::assign('orderinfo',$orderInfo);
Tpl_Smarty::display('Web_Static::order/inc/order_info_transfer.tpl');


