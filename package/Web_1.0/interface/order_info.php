<?php
/**
 * Created by PhpStorm.
 * User: liushengchun
 * Date: 15/3/2
 * Time: 18:43
 */
if(!isset($_REQUEST['token'])&&$_REQUEST['token']!=1){
    Web_Account::handleIsLogin();
}
/**
 * 处理上传
 */
if (Core::$urls['action'] == 'upload') {
    Admin_Upload::handleUploadGlobal(100);
    die();
}
//判断子账号权限
if (!empty($_REQUEST['tab'])) {

}
/**
 * 处理订单信息
 */
$orderNo = strtoupper(Core::$urls['action']);
if (!$orderNo) {
    Func_Header::notFound();
}
if ($orderNo{0} == 'S') {
    Func_Header::location(Core::$urls['root'] . 'product_set_order_info/' . $orderNo);
}
Web_Order_Info::handle($orderNo);
Web_Order_Info::handleTab();

/**
 * 如果是在签约阶段
 */
Web_Order_Info::handleStep2();

/**
 * 如果已经签约
 */
Web_Order_Info::handleStep3();
Tpl_Smarty::assign('__user', $_SESSION['user']);
Tpl_Smarty::assign('orderinfo', Web_Order_Info::$_orderInfo);
Tpl_Smarty::display('Web', 'order-info.tpl');