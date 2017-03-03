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
Web_Product_Set_Order_Operator::handle($_REQUEST['order_no']);
switch ($_REQUEST['action']) {
    case 'pending':
        Web_Product_Set_Order_Operator::handlePending();
        break;
    case 'cancel':
        Web_Product_Set_Order_Operator::handleCancel();
        break;
    case 'confirm_cancel':
        Web_Product_Set_Order_Operator::handleConfirmCancel();
        break;
    case 'refuse':
        Web_Product_Set_Order_Operator::handleRefuse();
        break;
    case 'evaluate':
        Web_Product_Set_Order_Operator::handleEvaluate();
        break;
    case 'order_tracking':
        Web_Product_Set_Order_Operator::handleTracking();
        break;
    case 'ticket':
        Web_Product_Set_Order_Operator::handleTicket();
        break;
    case 'need_ticket':
        Web_Product_Set_Order_Operator::handleNeedTicket();
        break;
    case 'order_print':
        Web_Product_Set_Order_Operator::handleOrderPrint();
        break;
}