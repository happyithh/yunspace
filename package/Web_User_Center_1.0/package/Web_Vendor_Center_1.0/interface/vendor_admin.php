<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/2/27
 * Time: 10:26
 */
session_start();
if (empty($_SESSION['user']['id'])) {
    Func_Header::to('请先登录!', Core::$urls['root'] . 'user_center/login?url_back=' . Core::$urls['uri']);
}
//如果是不是供应商账号则转向用户后台
if ($_SESSION['user']['account_type'] != 21) {
    Func_Header::to('', Core::$urls['root'] . 'user_center/');
}
if (!empty($_SESSION['user'])) {
    Tpl_Smarty::assign('__user', $_SESSION['user']);
}
Tpl_Smarty::assign('_web_config', array(
    '网页标题' => '云·Space - 供应商管理后台',
));

//供应商状态
Tpl_Smarty::assign('vendor_status', Api_Vendor_isFirstCheck::vendorStatic(array('vendor_id' => $_SESSION['user']['vendor_id'])));

if (Api_Vendor_Join_IsVendorJoinAccount::check(array('account_id' => $_SESSION['user']['id']))) {
    Tpl_Smarty::assign('from_vendor_join', 1);
}
$actions = explode('/', Core::$urls['action'] . '//');
switch ($actions[0]) {
    case '':
        Web_User_Center_User::handle();
        break;
    case 'order':
        Web_User_Center_Order::handle();
        break;
    case 'product':
        Tpl_Smarty::assign('tab_index', 'product');
        Web_Vendor_Center_Product_List::handle();
        break;
    case 'product_edit':
        Tpl_Smarty::assign('tab_index', 'product');
        Web_Vendor_Center_Product_Edit::handle();
        break;
    case 'set_edit':
        Tpl_Smarty::assign('tab_index', 'product');
        Web_Vendor_Center_Set_Edit::handle();
        break;
    case 'vendor_edit':
        Tpl_Smarty::assign('tab_index', 'product');
        Web_Vendor_Center_Vendor_Edit::handle();
        break;
//    case 'case_add':
//        Tpl_Smarty::assign('tab_index', 'product');
//        if (!empty($_REQUEST['product_id'])) {
//            Web_Vendor_Center_Case_Edit::handle('product');
//        } elseif (!empty($_REQUEST['set_id'])) {
//            Web_Vendor_Center_Case_Edit::handle('set');
//        }
//    case 'case_edit':
//        Tpl_Smarty::assign('tab_index', 'product');
//        if (!empty($_REQUEST['product_id'])) {
//            Web_Vendor_Center_Case_Edit::handle('product');
//        } elseif (!empty($_REQUEST['set_id'])) {
//            Web_Vendor_Center_Case_Edit::handle('set');
//        }
//        break;
    case 'deliver':
        Web_Vendor_Center_Deliver::handle();
        break;
    case 'product_marketing':
        Tpl_Smarty::assign('tab_index', 'product_marketing');
        Web_Vendor_Center_Product_Marketing::handle();
        break;
    case 'message':
        Web_User_Center_Message::handle();
        break;
    case 'message_list':
        Tpl_Smarty::assign('tab_index', 'message');
        Web_User_Center_Message_List::handle();
        break;
    case 'send_message':
        Web_User_Center_Message_List::sendMessage();
        break;
    case 'collection':
        Tpl_Smarty::assign('tab_index', 'collection');
        Web_User_Center_Collection::handle();
        break;
    case 'money':
        Web_User_Center_Money::handle();
        break;
    case 'account':
        Tpl_Smarty::assign('tab_index', 'account');
        Web_User_Center_Account::handle();
        break;
    case 'account_bind':
        Tpl_Smarty::assign('tab_index', 'account');
        Web_User_Center_Account_Bind::handle();
        break;
    case 'account_identity':
        Tpl_Smarty::assign('tab_index', 'account');
        Web_User_Center_Account::handleIdentity();
        break;
    case 'account_security':
        Tpl_Smarty::assign('tab_index', 'account');
        Web_User_Center_Account::handleSecurity();
        break;
    case 'account_sub_account':
        Tpl_Smarty::assign('tab_index', 'account');
        Web_User_Center_Account::handleSubAccount();
        break;
    case 'account_bank_account':
        Tpl_Smarty::assign('tab_index', 'account');
        Web_User_Center_Account::handleBankAccount();
        break;
    case 'logout':
        unset($_SESSION['user']);
        Func_Header::location(Core::$urls['root']);
        break;
    default:
        Func_Header::notFound();
        break;

}