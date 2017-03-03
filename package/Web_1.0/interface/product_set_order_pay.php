<?php
/**
 * Created by PhpStorm.
 * User: yl
 * Date: 15/5/15
 * Time: 套餐支付页面
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
switch ($actions[0]) {
    case 'bank':
        Web_Account::handleAccountHasAuth('支付', 1);
        Web_Product_Set_Order_Pay::handleSelectBank($payment);
        break;
    case 'pay':
        Web_Account::handleAccountHasAuth('支付', 1);
        $payment['pay_method'] = '在线支付';
        Web_Product_Set_Order_Pay::handlePay($payment);
        break;
    case 'balance_pay':
        Web_Account::handleAccountHasAuth('支付', 1);
        $payment['pay_method'] = '账户支付';
        Web_Product_Set_Order_Pay::handleBalancePay($payment);
        break;
    case 'transfer_pay':
        Web_Account::handleAccountHasAuth('支付', 1);
        $payment['pay_method'] = '银行转账';
        Web_Product_Set_Order_Pay::handleTransferPay($payment);
        break;
    case 'return':
        $payment['pay_method'] = '在线支付';
        Web_Product_Set_Order_Pay::handleReturn($payment);
        break;
    case 'notify':
        Web_Product_Set_Order_Pay::handleNotify($payment);
        break;
    case 'confirm_pay':
        Web_Account::handleAccountHasAuth('支付', 1);
        Web_Product_Set_Order_Pay::handleConfirmPay($payment);
        break;
    case 'not_confirm_pay':
        Web_Account::handleAccountHasAuth('支付', 1);
        Web_Product_Set_Order_Pay::handleNotConfirmPay($payment);
        break;
    default:
        $_REQUEST['tab'] = 5;
        Web_Product_Set_Order_Info::handle($payment['payment_detail']['order_no']);
        $orderInfo = Web_Product_Set_Order_Info::$_orderInfo;
        $products = $orderInfo['order_detail']['products'];
        $total_price = 0;
        foreach ($products as $k => $v) {
            $total_price += $v['price'];
        }
        Tpl_Smarty::assign('orderinfo', $orderInfo);
        Tpl_Smarty::assign('productSet', $orderInfo['order_detail']['set_info']);
        Tpl_Smarty::assign('detail', $orderInfo['order_detail']['detail_data']);
        Tpl_Smarty::assign('days', $orderInfo['order_detail']['days']);
        Tpl_Smarty::assign('total_price', $total_price);
        Tpl_Smarty::assign('banks', Web_Product_Set_Order_Pay::$banks);
        Tpl_Smarty::assign('__user', $_SESSION['user']);
        Tpl_Smarty::assign('payment', $payment);
        Tpl_Smarty::display('Web', 'product_set_order_info.tpl');
        break;
}