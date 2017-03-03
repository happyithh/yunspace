<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/2/27
 * Time: 12:18
 */
/**
 * 已登录
 */
session_start();
/**
 * 登录状态
 */
$action = !empty($_REQUEST['islogin']) ? $_REQUEST['islogin'] :"login";
switch($action){
    case "login":
        Web_User_Center_Login::handle();
        break;
    case 'islogin' :
        Web_User_Center_Login::doLogin();
        break;
    case 'quick_login' :
        Web_User_Center_Login::quickLogin();
        break;
    default:
        Func_Header::to("非法请求");
        break;
}
//if (empty($_POST['login'])) {
//    if (empty($_SESSION['url_back'])) {
//        if (!empty($_REQUEST['url_back'])) {
//            if (!empty($_REQUEST['code'])) {
//                $url_back = $_REQUEST['url_back'] . '&code=' . $_REQUEST['code'];
//            } else {
//                $url_back = $_REQUEST['url_back'];
//            }
//            $_SESSION['url_back'] = $url_back;
//        } else if (!empty(Core::$urls['referer']) && !strpos(Core::$urls['referer'], '/login')) {
//            $_SESSION['url_back'] = Core::$urls['referer'];
//        } else {
//            $_SESSION['url_back'] = Core::$urls['root'] . 'user_admin';
//        }
//    }
//    if (!empty($_SESSION['user']['id'])) {
//        Func_Header::location(empty($_SESSION['url_back']) ? 'user_admin' : $_SESSION['url_back']);
//    }
//    Tpl_Smarty::assign('url_back', $_SESSION['url_back']);
//    Tpl_Smarty::display('Web_Static::login.v2.0/login.tpl');
////    Tpl_Smarty::display('Web_User_Center', 'login.tpl');
//} else {
//    Web_User_Center_User::handleLogin();
//}