<?php
/**
 * Created by PhpStorm.
 * User: yl
 * Date: 15/7/13
 * Time: 订单支付
 */
$actions = explode('/', Core::$urls['action'], 2);
$paymentId = strtoupper($actions[1]);
$payment = Finance_Payment::getPaymentInfoById($paymentId);
if (empty($payment['id']) || empty($payment['payment_detail']['order_no'])) {
    Func_Header::notFound();
}
if (!empty($payment['payment_time'])) {
    Func_Header::back('该笔款项已支付!');
}
$args['payment']=$payment;
$args['action']=$actions[0];

//初始化支付页面
$pay1=Api_Order_Pay::handleSelectBank($payment);

//获取订单信息
$order=Api_Order_Info::getOrderInfo($payment['payment_detail']['order_no']);
$orderInfo= $order['data'];

//处理支付动作
$rs=Api_Order_Pay::handlePay($args);
if($actions[0] != 'bank'){
    if($rs['status']==0){
        Func_Header::back($rs['msg']);
    }elseif($rs['status']==1){
        Func_Header::to($rs['msg'],Core::$urls['root'] . 'order_info_new/'.$payment['payment_detail']['order_no']);
    }
}


//收款人账户信息
if(!empty($pay1['account']['bank_account']) && !empty($orderInfo['order_detail']['bank_cash'])){
    $target_bank_info=$pay1['account']['bank_account'];
    $target_bank_no=$target_bank_info[$orderInfo['order_detail']['bank_cash']][2];
    $target_bank_name=Web_User_Center_Money::$banks[$target_bank_info[$orderInfo['order_detail']['bank_cash']][1]];
    $payment['target']='【'.$target_bank_name.'】 尾号 '.substr($target_bank_no,-4);

}

//Tpl_Smarty::assign('paymentInfo', $pay1['payment_info']);
Tpl_Smarty::assign('account', $pay1['account']);
Tpl_Smarty::assign('banks', Api_Order_Pay::$banks);
Tpl_Smarty::assign('payment', $payment);
Tpl_Smarty::assign('orderinfo', $orderInfo);
Tpl_Smarty::assign('info', $orderInfo['order_detail']['object_info']);
Tpl_Smarty::display('Web_Static', 'order/order_info.tpl');
