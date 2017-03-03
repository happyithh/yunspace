<?php
/**
 * Created by PhpStorm.
 * User: zzc        V3版本
 * Date: 2015/11/23
 * Time: 14:34
 * 需求报价-手机
 *
 *
 * 1.   客户查看报价入口
 * 2.   商家报价入口
 */
session_start();
$action = Core::$urls['action'];

//APP请求
if (!empty($_REQUEST['token']) && !empty($_REQUEST['user_id'])) {
    Api_Session::user_info();
}

//如果是商家;
if (!is_bool(strpos($action, 'vendor'))) {
    if (empty($_SESSION['user']) && empty($_SESSION['user']['isWechatManage'])) {
        $_SESSION['url_back'] = 'http://' . Core::$urls['host'] . Core::$urls['uri'];
        Wechat_Oauth_Manager::handle();
    }
} else {
    Web_Account::handleIsLogin('');
}
Tpl_Smarty::assign('__user', Api_Session::user_info());
switch ($action) {
    case 'customer':
        Web_Mobile_Demand_Offer::customer();
        break;
    case 'vendor':
        Web_Mobile_Demand_Offer::vendor();
        break;
    case 'wechatcustomer':
        Web_Mobile_Demand_Offer_Wechat::handleCustomer();
        break;
    case 'wechatvendor':
        Web_Mobile_Demand_Offer_Wechat::handleVendor();
        break;

}