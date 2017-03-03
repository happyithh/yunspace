<?php
/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2015/7/21
 * Time: 14:26
 */
class Web_User_Center_Register extends Base{

    static function handle(){
        session_start();
        if (empty($_SESSION['url_back'])) {
            if (!empty($_REQUEST['url_back'])) {
                $_SESSION['url_back'] = $_REQUEST['url_back'];
            } else if (!empty(Core::$urls['referer']) && !strpos(Core::$urls['referer'], '/login') && Core::$urls['referer']!="http://".Core::$urls['host']."/") {
                $_SESSION['url_back'] = Core::$urls['referer'];
            }else {
                $_SESSION['url_back'] = Core::$urls['root'] . 'user_center/user_admin';
            }
        }
        Data_Config_Site::seo('register');
//    Tpl_Smarty::display('Web_User_Center', 'register.tpl');
        Tpl_Smarty::display('Web_Static::register.v2.0/register.tpl');
    }

    static  function doRegister(){
        if (empty($_POST['tnc'])) {
            Func_Header::back("请阅读并同意《云SPACE用户协议注册协议》！");
        }
        $result = Api_Account_Register::doRegister();
        if ($result['status']==0 ) {
            Func_Header::back($result['msg']);
        } else {
            $data = $result['data'];
            unset($_SESSION['auth_code']);
            $_SESSION['user'] = array(
                'id' => $data['id'],
                'fullname' => $data['fullname'],
                'phone' => $data['phone'],
                'email' => '',
                'username' => $data['username'],
                'account_type' => $data['account_type'],
                'pnr_account' => '',
                'password2' => !empty($data['password2']),
                'attr' => $data['attr'],
                'register_time' => $data['register_time'],
                'login_time' => time(),
            );
            Data_Mysql_Table_Dwz_Record::updataRecord(); //更新通过分享url点击的记录
            Func_Header::to('恭喜你注册成功！', Core::$urls['root'] . 'user_center/user_admin');
        }
    }
}