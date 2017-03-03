<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/2/27
 * Time: 10:26
 */
Web_Account::handleIsLogin();
//如果是供应商账号则转向供应商后台
//
//if(Core::$urls['action'] != 'logout' && $_SESSION['user']['account_type'] == 21) {
//    if (empty($_SESSION['user']['attr']['vendor_id'])) {
//        $_SESSION['user']['attr']['vendor_id'] = 1;
//    }
//    Func_Header::to('', Core::$urls['root'] . 'vendor_center/' . (Core::$urls['action'] ? 'vendor_admin/' . Core::$urls['action'] : ''));
//}


if (!empty($_SESSION['user'])) {
    Tpl_Smarty::assign('__user', $_SESSION['user']);
}
Tpl_Smarty::assign('_web_config', array(
    '网页标题' => '云·Space - 用户管理后台',
));
switch (Core::$urls['action']) {
    case '':
        Web_User_Center_User::handle();
        break;
    case 'order':
        Web_User_Center_Order::handle();
        break;
    case 'services':
        Tpl_Smarty::assign('tab_index', 'services');
        Web_User_Center_Services::handle();
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
        Web_User_Center_Collection::handle();
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
        unset($_SESSION['url_back']);
        Func_Header::location(Core::$urls['root']);
        break;
    case 'money':
        Web_User_Center_Money::handle();
        break;
    case 'money_detail':
        Web_User_Center_Money::handledetail();
        break;
    case 'money_confirm':
        Web_User_Center_Money::handleconfirm();
        break;
    case 'money_choice':
        Web_User_Center_Money::handlechoice();
        break;
    default:
        Func_Header::notFound();
        break;
}