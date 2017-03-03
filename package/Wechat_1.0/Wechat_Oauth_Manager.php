<?php
/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/6/24
 * Time: 16:12
 */
@session_start();

Class Wechat_Oauth_Manager
{
    static function handle()
    {

        if (empty($_SESSION['url_back'])) {
            if (!empty(Core::$urls['referer'])) {
                $_SESSION['url_back'] = Core::$urls['referer'];
            } else {
                $_SESSION['url_back'] = 'http://' . Core::$urls['host'] . Core::$urls['root'];
            }
        }
        if (!empty($_SESSION['user']['id']) && !empty($_SESSION['openid']) && !empty($_SESSION['user']['isWechatManage'])) {
            $urlBack = $_SESSION['url_back'];
            unset($_SESSION['url_back']);
            header("location:" . $urlBack);
        }
        if (empty($_SESSION['openid'])) {
            self::handleGetOpenid();
        }
        $request = Func_Input::filter(array(
            'phone' => 'phone',
            'code' => 'code'
        ));
        if ($request['phone'] && $request['code']) {
            self::handleRegisterAjaxSubmit();
        } else {
            self::handleCheckOpenid();
            if (strpos($_SESSION['url_back'], 'site_management')) {
                Tpl_Smarty::display("Web_Mobile_Static::site_management/site_login.tpl");
            } else {
                Tpl_Smarty::display("Web_Mobile_Static::wechat.v1.0/register_wechat_manager.tpl");
            }
            die;
        }
    }

    static function handleGetOpenid()
    {
        $AppID = Wechat_Config::$ManagerAppID;
        $AppSecret = Wechat_Config::$ManagerAppSecret;
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
            Data_Mysql_Table_Account_Wechat_Manager::update(array(
                'openid' => $_SESSION['openid'],
                'user_info' => $userInfo_data,
                'status' => 1,
            ));
        } else {
            //第一步
            if (Func_Input::isLocal()) {

                $redirect_url = "http://d18.yunspace.com.cn/wechat/oauth_manager?rhost=d18.yunspace.com.cn";

            } else {
                if (Core::$urls['host'] == 'www.yunspace.com.cn') {
                    $redirect_url = "http://www.yunspace.com.cn" . Core::$urls['root'] . "wechat/oauth_manager";
                } else {
                    $redirect_url = "http://" . Core::$urls['host'] . Core::$urls['root'] . "wechat/oauth_manager?rhost=" . Core::$urls['host'];
                }
            }
            $oauth2_url = 'https://open.weixin.qq.com/connect/oauth2/authorize?appid=' . $AppID . '&redirect_uri=' . urlencode($redirect_url) . '&response_type=code&scope=snsapi_userinfo&state=1#wechat_redirect';

            header('location:' . $oauth2_url);
            die();
        }
    }

    static function handleCheckOpenid()
    {
        //判断是否已绑定
        $data_wechat = Data_Mysql_Table_Account_Wechat_Manager::select('id, account_id', array('openid' => $_SESSION['openid']));
        if (!empty($data_wechat[0]['account_id'])) {
            $rs = Data_Mysql_Table_Account::select("{table}.*,{prefix}vendor_info.id as vendor_id", array("{table}.id=? AND {table}.status IN (0, 1)" => array($data_wechat[0]['account_id'])), '', 1, '{table} LEFT JOIN {prefix}vendor_info ON {table}.id= {prefix}vendor_info.vendor_account_id');
            if (!empty($rs[0])) {
                $r = $rs[0];
                $_SESSION['user'] = array(
                    'id' => $r['id'],
                    'fullname' => $r['fullname'],
                    'email' => $r['email'],
                    'phone' => $r['phone'],
                    'username' => $r['username'],
                    'avatar' => $r['avatar'],
                    'account_type' => $r['vendor_id'] ? 21 : 1,
                    'identity_time' => $r['identity_time'],
                    'pnr_account' => $r['pnr_account'],
                    'password' => $r['password'],
                    'password2' => $r['password2'],
                    'attr' => $r['attr'] ? json_decode($r['attr'], 1) : '',
                    'register_time' => $r['register_time'],
                    'login_time' => time(),
                    'sub_account' => false,
                    'vendor_id' => $r['vendor_id'],
                    'avatar' => $r['avatar'],
                    'openid' => $_SESSION['openid'],
                    'isWechatManage' => 1,  //微信管家服务号
                );
                Data_Mysql_Table_Account::update($r['id'], array("login_times = login_times + 1"));
                $urlBack = $_SESSION['url_back'];
                Func_Header::to('', $urlBack);
            }
        }
    }

    static function handleRegisterAjaxSubmit()
    {
        $callback['url'] = $_SESSION['url_back'];
        unset($_SESSION['url_back']);
        $request = Func_Input::filter(array(
            'phone' => 'phone',
            'code' => 'code'
        ));
        if (empty($_SESSION['openid'])) {
            Func_Output::json('error', '', '参数异常');
        }
        if (empty($request['phone'])) {
            Func_Output::json('error', '', '手机号不正确');
        }
        if (empty($_SESSION['auth_code'][1]) || $request['code'] != $_SESSION['auth_code'][1]) {
            Func_Output::json('error', '', '*验证码错误！！' . $request['code'] . ' ' . $_SESSION['auth_code'][1]);
        }
        if (empty($_SESSION['auth_code'][0]) || $request['phone'] != $_SESSION['auth_code'][0]) {
            Func_Output::json('error', '', '*验证手机不一致！！');
        }
        $rs = Data_Mysql_Table_Account::select('id', array('phone=?' => $request['phone']));
        if (!empty($rs[0])) {
            $rwos_wechat = Data_Mysql_Table_Account_Wechat_Manager::update(array(
                'openid' => $_SESSION['openid'],
                'account_id' => $rs[0]['id'],
                'status' => 1));
            if ($rwos_wechat > 0) {
                Func_Output::json('success', $callback, '绑定成功');
            }

        } elseif (empty($rs[0])) {
            $pwd = rand(100000, 999999) . rand(10, 99);
            $md5Pwd = Data_Mysql_Table_Account::makePassword($pwd);
            $data = array(
                'fullname' => $_SESSION['wechat']['nickname'],
                'phone' => $request['phone'],
                'username' => $request['phone'],
                'attr' => array(
                    'register_ip' => Func_Input::ip(),
                    'email' => '',
                    'phone' => $request['phone'],
                    'marks' => '微信注册',
                ),
                'password' => $md5Pwd,
                'register_time' => time(),
            );
            $insert = Data_Mysql_Table_Account::insert($data);
            if ($insert[0] > 0) {
                $_SESSION['user'] = $data;
                $_SESSION['user']['id'] = $insert[0];
                //发送密码到 用户手机号中
                Func_Message::sendSMS($request['phone'], array($request['phone'], $pwd), 23705);
                $rwos_wechat = Data_Mysql_Table_Account_Wechat_Manager::update(array('openid' => $_SESSION['openid'], 'account_id' => $insert[0], 'status' => 1));
                if ($rwos_wechat > 0) {
                    Func_Output::json('success', $callback, '激活我的云·Space成功！');
                }
            } else {
                Func_Output::json('error', '', '激活我的云·Space失败，请稍后重试哦！');
            }

        }
        Func_Output::json('error', '', '操作失败请重试！');
    }
}