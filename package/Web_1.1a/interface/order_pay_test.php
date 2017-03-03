<?php
/**
 * Created by PhpStorm.
 * User: liushengchun
 * Date: 15/3/2
 * Time: 18:43
 */
$actions = explode('/', Core::$urls['action'], 2);
$payment = array('id' => '2', 'account_id' => '1', 'target_account_id' => '4', 'order_id' => '1', 'payment_title' => '拓维创宇文化传播（北京）有限公司 1. 首付款', 'amount' => '20.00', 'payment_time' => '0', 'payment_detail' => array('order_no' => 'A00113000000791504040000001913', 'agreement_title' => '拓维创宇文化传播（北京）有限公司', 'buyer_account_id' => '1', 'buyer_account' => '上海星期网络科技有限公司', 'vendor_account_id' => '4', 'vendor_id' => '479', 'payment_title' => '1. 首付款', 'payment_percent' => 3000, 'payment_deadline' => 1428681600, 'is_first' => true, 'is_in_order' => true, 'is_settle' => false, 'deal_account_id' => '0', 'order_commission_deal' => 0,), 'confirm_time' => '0', 'confirm_detail' => array(), 'admin_id' => '0', 'create_time' => '1430287972', 'payment_id' => 'P201504000000001',);
switch ($actions[0]) {
    case 'bank':
        Web_Account::handleIsLogin();
        Web_Order_Pay2::handleSelectBank($payment);
        break;
    case 'pay':
        Web_Account::handleIsLogin();
        Web_Order_Pay2::handlePay($payment);
        break;
    case 'return':
        Web_Order_Pay2::handleReturn($payment);
        break;
    case 'notify':
        Web_Order_Pay2::handleNotify($payment);
        break;
    default:
        $_REQUEST['tab'] = 7;
        Tpl_Smarty::assign('banks', Web_Order_Pay2::$banks);
        Tpl_Smarty::assign('__user', $_SESSION['user']);
        Tpl_Smarty::assign('payment', $payment);
        Tpl_Smarty::display('Web', 'order-info.tpl');
        break;
}