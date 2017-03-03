<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/2/27
 * Time: 15:31
 */

/**
 * 处理手机验证码
 */
$action = !empty($_REQUEST['action']) ? $_REQUEST['action'] : "showRegister";
switch($action){
    case "showRegister":
        Web_User_Center_Register::handle();
        break;
    case 'register' :
        Web_User_Center_Register::doRegister();
        break;
    default:
        Func_Header::to("非法请求");
        break;
}


/*
if (Core::$urls['action'] == 'auth_code') {
    $request = Func_Input::filter(array(
        'phone' => 'phone',
        'auth_code_img' => 'string',
    ));
    if (!$request['phone']) {
        die('参数错误!');
    }
    session_start();
    if (!empty($_SESSION['auth_code']) && $_SESSION['auth_code'][2] > time()) {
        die('请求太过频繁,请稍候再试!');
    }
    $_SESSION['auth_code'] = array(
        $request['phone'],
        rand(10000, 99999),
        time() + 30
    );
    Web_Message::registerAuthCode($request['phone'], $_SESSION['auth_code'][1]);
    die();
}

if (Core::$urls['action'] == 'auth_code_img') {
    session_start();
    $_SESSION['auth_code_img'] = Func_Image::authCode(4);
    die();
}
*/
/**
 * 处理用户注册
 */

//if (empty($_POST['register'])) {
//    /**
//     * 显示注册页面
//     */
//    if (empty($_SESSION['url_back'])) {
//        if (!empty($_REQUEST['url_back'])) {
//            $_SESSION['url_back'] = $_REQUEST['url_back'];
//        } else if (!empty(Core::$urls['referer']) && !strpos(Core::$urls['referer'], '/login')) {
//            $_SESSION['url_back'] = Core::$urls['referer'];
//        } else {
//            $_SESSION['url_back'] = Core::$urls['root'] . 'user_admin';
//        }
//    }
////    Tpl_Smarty::display('Web_User_Center', 'register.tpl');
//    Tpl_Smarty::display('Web_Static::register.v2.0/register.tpl');
//    die();
//} else {
//    /**
//     * 提交注册
//     */
//    if (empty($_POST['tnc'])) {
//        Func_Header::back('请阅读并同意《云SPACE用户协议注册协议》！');
//    }
//    session_start();
//    if (!Func_Input::isLocal()) {
//        if (empty($_SESSION['auth_code'][0]) || empty($_POST['phone']) || $_POST['phone'] != $_SESSION['auth_code'][0]) {
//            Func_Header::back('验证手机不一致！');
//        }
//        if (empty($_SESSION['auth_code'][1]) || empty($_POST['auth_code']) || $_POST['auth_code'] != $_SESSION['auth_code'][1]) {
//            Func_Header::back('验证码错误！');
//        }
//    }
//    $data = Data_Mysql_Table_Account::handleRegister();
//    if (empty($data['id'])) {
//        Func_Header::back('该用户名已被注册!');
//    } else {
//        unset($_SESSION['auth_code']);
//        $_SESSION['user'] = array(
//            'id' => $data['id'],
//            'fullname' => $data['fullname'],
//            'phone' => $data['phone'],
//            'email' => '',
//            'username' => $data['username'],
//            'account_type' => $data['account_type'],
//            'pnr_account' => '',
//            'password2' => !empty($data['password2']),
//            'attr' => $data['attr'],
//            'register_time' => $data['register_time'],
//            'login_time' => time(),
//        );
//        Data_Mysql_Table_Dwz_Record::updataRecord(); //更新通过分享url点击的记录
//        Func_Header::to('', 'register_success');
//    }
//}