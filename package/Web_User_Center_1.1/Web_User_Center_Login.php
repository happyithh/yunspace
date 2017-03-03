<?php
/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2015/7/21
 * Time: 14:26
 */
@session_start();
class Web_User_Center_Login extends Base{

    static function handle(){
        if (empty($_SESSION['url_back'])) {
            if (!empty($_REQUEST['url_back'])) {
                if (!empty($_REQUEST['code'])) {
                    $url_back = $_REQUEST['url_back'] . '&code=' . $_REQUEST['code'];
                } elseif (!empty($_REQUEST['booking_type'])) {
                    $url_back = $_REQUEST['url_back'] . '&booking_type=' . $_REQUEST['booking_type'];
                } else {
                    $url_back = $_REQUEST['url_back'];
                }
                $_SESSION['url_back'] = $url_back;
            } else if (!empty(Core::$urls['referer']) && !strpos(Core::$urls['referer'], '/login') ) {
                $_SESSION['url_back'] = Core::$urls['referer'];
            } else {
                $_SESSION['url_back'] = Core::$urls['root'] . 'user_center/user_admin';
            }
        }
        if (!empty($_SESSION['user']['id'])) {
            Func_Header::location(empty($_SESSION['url_back']) ? 'user_admin' : $_SESSION['url_back']);
        }
        //判断是否有cookie 用户名自动完成
        if(!empty($_COOKIE['reusername'])){
            Tpl_Smarty::assign('re_username', $_COOKIE['reusername']);
        }
        Data_Config_Site::seo('login');
        Tpl_Smarty::assign('url_back', $_SESSION['url_back']);
//        Tpl_Smarty::display('Web_Static::login.v2.0/login.tpl');
        Tpl_Smarty::display('Web_Static::login.v2.1/login.tpl');
    }

    static  function doLogin(){
        $result = Api_Account_Login::doLogin();
        if($result['status'] == 0){
            Func_Header::back($result['msg']);
        }else{
            Func_Header::to("",!empty($_POST['url_back']) ? $_POST['url_back'] : Core::$urls['root'] . 'user_center/user_admin');
        }
    }
    static function quickLogin(){
        //判断手机号是否注册
        $request = Func_Input::filter(array(
            'phone' => 'string',
            'auth_code' => 'string',
        ), $_REQUEST);
        if(empty($request['phone'])|| empty($request['auth_code'])){
            Func_Header::back("手机号和验证必须填写完整！");
        }
        $pattern = "/^((1[3|5|7|8]{1})+\d{9})$/";
        if (empty($request['phone']) && !preg_match($pattern, $request['phone'])) {
            Func_Header::back("*手机号码格式错误！");
        }
        $phoneStatus = Api_Account_Check_Phone::checkPhoneIsUse($_REQUEST);
        //如果注册了就走登录接口。，没有注册过。就走登录接口
        if($phoneStatus['status']==0){
            //注册
            $_REQUEST['from']=-5;
            $rs = Api_Account_Register::doRegister($_REQUEST);
        }else{
            //登录
            $_REQUEST['from']=-6;
            $rs = Api_Account_Login::doLogin($_REQUEST);
        }
        if($rs['status']==0){
            Func_Header::back($rs['msg']);
        }else{
            $_POST['url_back'] = !empty($_POST['url_back'])?Func_Url::str_urldecode(Func_String::utf8($_POST['url_back'])):$_POST['url_back'];
            Func_Header::to("",!empty($_POST['url_back']) ? $_POST['url_back'] : Core::$urls['root'] . 'user_center/user_admin');
        }

    }
}