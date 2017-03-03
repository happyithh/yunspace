<?php
/**
 * Created by PhpStorm.
 * User: liushengchun
 * Date: 15/3/2
 * Time: 18:43
 */

Web_Account::handleIsLogin();
if (empty($_REQUEST['order_no']) || empty($_REQUEST['action'])) {
    Func_Header::notFound();
}
Web_Order_Operator::handle($_REQUEST['order_no']);

switch ($_REQUEST['action']) {
    case 'pending':
        Web_Order_Operator::handlePending();
        break;
    case 'cancel':
        Web_Order_Operator::handleCancle();
        break;
    case 'vendor_cancel':
        Web_Order_Operator::handleCancle();
        break;
    case 'order_conform':
        Web_Order_Operator::handleConform();
        break;
    case 'vendor_signing':
        Web_Order_Operator::handleVendorSigning();
        break;
    case 'buyer_signing':
        Web_Order_Operator::handleBuyerSigning();
        break;
    case 'buyer_complete':
        Web_Order_Operator::handleBuyerComplete();
        break;
    case 'vendor_complete':
        Web_Order_Operator::handleVendorComplete();
        break;
}