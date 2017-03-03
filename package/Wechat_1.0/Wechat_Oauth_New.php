<?php
/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/6/24
 * Time: 16:12
 */
@session_start();

Class Wechat_Oauth_New
{
    static function handle()
    {
        if (empty($_SESSION['url_back'])) {
            if (!empty(Core::$urls['referer'])) {
                $_SESSION['url_back'] = Core::$urls['referer'];
            } else {
                $_SESSION['url_back'] = Core::$urls['root'];
            }
        }
        if (!empty($_SESSION['openid'])) {
            $urlBack = $_SESSION['url_back'];
            unset($_SESSION['url_back']);
            header("location:" . $urlBack);
        }
        if (empty($_SESSION['openid'])) {
            self::handleGetOpenid();
        }
        Tpl_Smarty::display('Web_Mobile_Static::retail_special/retail_special.tpl');
        die();
    }

    static function handleGetOpenid()
    {
        $AppID = Wechat_Config::$AppID;
        $AppSecret = Wechat_Config::$AppSecret;
        //去微信的授权确认页面.
        if (isset($_GET['code'])) {
            $code = $_GET['code'];
            // 第二步  取 access_token
            $access_token_url = 'https://api.weixin.qq.com/sns/oauth2/access_token?appid=' . $AppID . '&secret=' . $AppSecret . '&code=' . $code . '&grant_type=authorization_code';
            $access_token_json = file_get_contents($access_token_url);
            $access_token_data = json_decode($access_token_json, 1);
            if (empty($access_token_data['openid'])) {
                Func_Header::to(Core::$urls['host'], '无法获得微信授权!');
            }
            //第四步 取 用户信息
            $openid = $access_token_data['openid'];
            $access_token = $access_token_data['access_token'];
            $userInfo_url = 'https://api.weixin.qq.com/sns/userinfo?access_token=' . $access_token . '&openid=' . $openid . '&lang=zh_CN';
            $userInfo_data_json = file_get_contents($userInfo_url);
            $userInfo_data = json_decode($userInfo_data_json, 1);

            if (empty($userInfo_data['openid'])) {
                Func_Header::to(Core::$urls['host'], '无法获得微信授权!!');
            }
            //更新用户信息
            $_SESSION['openid'] = $userInfo_data['openid'];
            $_SESSION['wechat'] = $userInfo_data;
           $rs =  Data_Mysql_Table_Account_Wechat::update(array(
                'openid' => $_SESSION['openid'],
                'user_info' => $userInfo_data,
                'status' => 1,
            ));
            $_SESSION['wechat_id'] =$rs[0];
        } else {
            //第一步
            if (Core::$urls['host'] == 'www.yunspace.com.cn') {
                $redirect_url = "http://www.yunspace.com.cn" . Core::$urls['root'] . "m/adm";
            } else {
                $redirect_url = "http://www.yunspace.com.cn" . Core::$urls['root'] . "m/adm?rhost=" . Core::$urls['host'];
            }
            $oauth2_url = 'https://open.weixin.qq.com/connect/oauth2/authorize?appid=' . $AppID . '&redirect_uri=' . urlencode($redirect_url) . '&response_type=code&scope=snsapi_userinfo&state=1#wechat_redirect';
            header('location:' . $oauth2_url);
            die();
        }
    }



}