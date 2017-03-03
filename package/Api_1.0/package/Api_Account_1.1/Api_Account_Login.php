<?php

/**
 * 用户登录
 *
 */
@session_start();

class Api_Account_Login extends Api
{


    //用户登录
    static function handle($args)
    {
        //接受参数

        //返回结果：提交结果，
        //插入成功 1  失败0 失败原因
        $result = self::doLogin($_REQUEST);
        return $result;
    }

    static $access_code = 'yunspace123';

    static function doLogin($args = '')
    {
        $request = Func_Input::filter(array(
            'username' => 'string',
            'password' => 'string',
            'remember' => 'string',
            'access_url' => 'url',
            'user_id' => 'int',
            'from' => 'int',
        ), $args);
        //默认是pc  0 web版本 是-1  云经纪是-2 云管家是-3 微信 -4 短网址登录 -5  快速登录 -6
        $request['from'] = !empty($request['from']) ? $request['from'] : "0";
        /***
         *pc端登录。主要有用户名（用户名/手机号/邮箱）登录，可能的会有的操作上记住用户名
         * web版登录 没有特殊 要求
         * 手机端客户端。会有两种登录 返回 用户信息
         *          1.正常登录。验证用户名和密码、并且把token存入APP登录表（更新一个用户名，用户ID只有一条数据）返回 用户信息
         *          2.token登录。接收用户id和token  和app登录表 比较。存在并未过期，返回 用户信息  如果不存在或过期。返回正常登录
         * 微信登录：授权登录。首先判断是否有openid。如果有。就会判断微信表里是否存在该微信openid。并且绑定有账号id。就返回该用户信息
         *                                          如果不存在openid或者没有绑定账户id 跳转到注册页面
         *
         *              如果没有openid 就会获取当前openid 并插入微信表里。
         *                  接受手机号和验证码。判断手机号对应的账户是否存在。如果存在就更新微信表里。当前openid的数据，
         *                                                          如果不存在该账号。就自动创建一个账号。然后更新到当前openid的数据
         */
        switch ($request['from']) {
            case -1 :
                $result = self::pcLogin($request);
                break;
            case -2 :
                //接受token 还有设备信息。 正常登录 token登录
                if (!empty($request['username'])) {
                    $result = self::appNormalLogin();
                } elseif (!empty($request['user_id'])) {
                    $result = self::appTokenLogin();
                } else {
                    $result = self::request('error', '', "请填写用户名或传递正确的参数");
                }
                break;
            case -3 :
                //接受token 还有设备信息。 正常登录 token登录
                if (!empty($request['username'])) {
                    $result = self::appNormalLogin();
                } elseif (!empty($request['user_id'])) {
                    $result = self::appTokenLogin();
                } else {
                    $result = self::request('error', '', "请填写用户名或传递正确的参数");
                }
                break;
            case -4 :
                //微信授权登录
                $result = self::weChatLogin();
                break;
            //短网址登录
            case -5:
                $result = self::dwzLogin();
                break;
            case -6:
                $result = self::quickLogin();
                break;
            case -7:
                $result = self::AppQuickLogin();
                break;
            default:
                $result = self::pcLogin($request);
                //默认登录方式
                break;
        }
        return $result;

    }

    //pc端登录（web端登录）
    static function pcLogin($request)
    {
        if (empty($request['username'])) {
            $result = self::request('error', '', "用户名/手机/邮箱必须填写");
            return $result;
        }
        if (empty($request['password'])) {
            $result = self::request('error', '', "密码必须填写");
            return $result;
        }
        if (strpos($request['username'], '@')) {
            return self::handleLoginSubAccount();
        }
        $rs = Data_Mysql_Table_Account::select("{table}.*,{prefix}vendor_info_update.id as vendor_id,{prefix}vendor_info_update.vendor_name", array("{table}.username=? OR {table}.email= ? OR {table}.phone= ?" => array($request['username'], $request['username'], $request['username'])), '', 10, '{table} LEFT JOIN {prefix}vendor_info_update ON {table}.id= {prefix}vendor_info_update.vendor_account_id');
        if (empty($rs[0]['id'])) {
//            Func_Header::back('账号不存在!');
            $result = self::request('error', '', "账号不存在");
            return $result;
        }
        foreach ($rs as $r) {
            if ($rs[0]['password'] == Data_Mysql_Table_Account::makePassword($request['password'])) {
                self::mkSession($r);
                if (!empty($request['remember'])) {
                    session_set_cookie_params(86400 * 7);
                    //设置cookie
                    $_COOKIE['reusername'] = $r['username'];
                    setcookie("reusername", $_COOKIE['reusername'], time() + 86400 * 7, "/");
                } else {
                    $_COOKIE['reusername'] = '';
                    setcookie("reusername", '', time() - 86400, "/");
                }
                Data_Mysql_Table_Account::update($r['id'], array("login_times = login_times + 1"));
                unset($_SESSION['url_back']);
                $_SESSION['user']['super_vendor'] = $r['username'] == 'vendor';
                Data_Mysql_Table_StaticLog::log('login', 0, $_SESSION['user']['id'], '');
                Data_Mysql_Table_Dwz_Record::updataRecord(); //更新通过分享url点击的记录
                $result = self::request('success', $request, "登录成功");
                return $result;
//                Func_Header::to('', !empty($_POST['url_back']) ? $_POST['url_back'] : Core::$urls['root'] . 'user_admin');
            }
        }
        $result = self::request('error', '', "密码不正确");
        return $result;
    }

    //app正常登录。用户名 密码 和设备信息
    static function appNormalLogin()
    {
        $data = array();//返回数据
        $request = Func_Input::filter(array(
            'username' => 'string',
            'password' => 'string',
            'device_platform' => '50',
            'device_uuid' => 'string',
            'device_version' => '20',
            'device_model' => 'string',
            'app_version' => 'string',
            'jpush_register_id' => 'string',
            'device_token_iphone' => '100',
        ), $_REQUEST);
        if (empty($request['username'])) {
            $result = self::request('error', '', "用户名/手机/邮箱必须填写");
            return $result;
        }
        if (empty($request['password'])) {
            $result = self::request('error', '', "密码必须填写");
            return $result;
        }
        $makePassword = Data_Mysql_Table_Account::makePassword($request['password']);
        $conditions = array(
            'username =? OR email =? OR phone =? ' => array($request['username'], $request['username'], $request['username'])
        );
        $rs = Data_Mysql_Table_Account::select('id,password,fullname,username,phone', $conditions);
        if (!empty($rs[0]) && $rs[0]['password'] == $makePassword) {

            $time = time();
            $token = md5($time . $rs[0]['id'] . $makePassword);//时间-用户ID-数据库密码 生成token
            $access_token = md5($time . $rs[0]['id'] . self::$access_code);//用户id-access_code生成access_token
            $data = array(
                'token' => $token,
                'access_token' => $access_token,
                'status' => 'success',
                'user_id' => $rs[0]['id'],
                'login_time' => $time,
                'fullname' => $rs[0]['fullname'],
                'username' => $rs[0]['username'],
                'avatar' => 'http://' . Core::$urls['host'] . Core::$urls['root'] . 'user_center/avatar/' . $rs[0]['id'] . '.jpg',
                'phone' => $rs[0]['phone'],
            );
            $insertLoginData = array(
                'username' => $request['username'],
                'fullname' => $rs[0]['fullname'],
                'user_id' => $rs[0]['id'],
                'token' => $token,
                'device_platform' => $request['device_platform'],
                'device_uuid' => $request['device_uuid'],
                'device_version' => $request['device_version'],
                'device_model' => $request['device_model'],
                'app_version' => $request['app_version'],
                'login_time' => $time,
                'jpush_register_id' => $request['jpush_register_id'],
                'device_token_iphone' => $request['device_token_iphone'],
            );
            $doInsert = Data_Mysql_Table_App_Login::update('', $insertLoginData);
            $result = self::request('success', $data, "登录成功");
            return $result;
        } else {
            $result = self::request('error', '', "用户名或密码不正确");
            return $result;
        }
    }


    //app token登录
    static function  appTokenLogin()
    {
        $effective_time = 15 * 24 * 60 * 60;//token有效期15天
        $request = Func_Input::filter(array(
            'user_id' => 'int',
            'token' => 'string',
            'login_time' => 'string'
        ), $_REQUEST);
        if (empty($request['user_id'])) {
            $result = self::request('error', '', "用户id传递错误");
            return $result;
        }
        if (empty($request['token'])) {
            $result = self::request('error', '', "token错误");
            return $result;
        }
        if (empty($request['login_time'])) {
            $result = self::request('error', '', "有效期传递错误");
            return $result;
        }
        $rs = Data_Mysql_Table_App_Login::select('token,login_time,fullname,username,user_id', array('user_id' => $request['user_id']));
        if (empty($rs[0]['user_id'])) {
            $result = self::request('error', '', "账号不存在");
            return $result;
        }
        $finish_time = $effective_time + $rs[0]['login_time'];
        if (time() <= $finish_time) {
            if ($rs[0]['token'] == $request['token']) {
                $rsAccount = Data_Mysql_Table_Account::select('id,password,fullname,username,phone', array('user_id' => $request['user_id']));
                $access_token = md5($request['login_time'] . $rs[0]['user_id'] . self::$access_code);//用户id-access_code生成access_token
                $data = array(
                    'status' => 1,//token登录成功
                    'info' => 'token登陆成功',
                    'fullname' => $rsAccount[0]['fullname'],
                    'username' => $rsAccount[0]['username'],
                    'avatar' => 'http://' . Core::$urls['host'] . Core::$urls['root'] . 'user_center/avatar/' . $request['user_id'] . '.jpg',
                    'token' => $request['token'],
                    'access_token' => $access_token,
                    'user_id' => $rsAccount[0]['id'],
                    'login_time' => $request['login_time'],
                    'phone' => $rsAccount[0]['phone'],
                );
                $result = self::request('success', $data, "token登陆成功");
                return $result;
            } else {
                $data = array(
                    'status' => -2,//token不正确
                    'info' => 'token不正确'
                );
                $result = self::request('error', $data, "token不正确");
                return $result;
            }
        } else {
            $data = array(
                'status' => -1,//token超期失效
                'info' => 'token超期失效'
            );
            $result = self::request('error', $data, "token超期失效");
            return $result;
        }
    }

    static function weChatLogin()
    {
        if (empty($_SESSION['openid'])) {
            $result = self::request('error', '', "openid不存在");
            return $result;
        }
        //判断是否已绑定
        $data_weChat = Data_Mysql_Table_Account_Wechat::select('id, account_id', array('openid' => $_SESSION['openid']));
        if (!empty($data_weChat[0]['account_id'])) {
            $rs = Data_Mysql_Table_Account::select("{table}.*,{prefix}vendor_info_update.id as vendor_id", array("{table}.id=? AND {table}.status IN (0, 1)" => array($data_weChat[0]['account_id'])), '', 1, '{table} LEFT JOIN {prefix}vendor_info_update ON {table}.id= {prefix}vendor_info_update.vendor_account_id');
            if (!empty($rs[0])) {
                $r = $rs[0];
                self::mkSession($r);
                Data_Mysql_Table_Account::update($r['id'], array("login_times = login_times + 1"));
                $result = self::request('success', '', "微信授权登录成功！");
                return $result;
            } else {
                $result = self::request('error', '', "获取用户信息失败！");
                return $result;
            }
        } else {
            $result = self::request('error', '', "openid未绑定！");
            return $result;
        }
    }

    //子帐号登录
    static function handleLoginSubAccount()
    {
        $account = explode('@', $_POST['username']);
        $rs = Data_Mysql_Table_Account::select("{table}.*,{prefix}vendor_info_update.id as vendor_id,{prefix}vendor_info_update.vendor_name", array("username=? OR email= ? OR phone= ?" => array($account[1], $account[1], $account[1])), '', 10, '{table} LEFT JOIN {prefix}vendor_info_update ON {table}.id= {prefix}vendor_info_update.vendor_account_id');
        if (empty($rs[0]['id'])) {
            $result = self::request('error', '', "账号不存在");
            return $result;
        }
        foreach ($rs as $r) {
            $subAccount = json_decode($r['sub_account'], 1);
            if (!empty($subAccount[$account[0]]) && $subAccount[$account[0]][0] == Data_Mysql_Table_Account::makePassword($_POST['password'])) {
                self::mkSession($r, $account);
                Data_Mysql_Table_StaticLog::log('login', 1, $_SESSION['user']['id'], $account[0]);
                unset($_SESSION['url_back']);
                $_SESSION['user']['super_vendor'] = $r['username'] == 'vendor';
                Data_Mysql_Table_StaticLog::log('login', 0, $_SESSION['user']['id'], '');
                Data_Mysql_Table_Dwz_Record::updataRecord(); //更新通过分享url点击的记录
                $result = self::request('success', $_REQUEST, "登录成功");
                return $result;
//                Func_Header::to('', !empty($_POST['url_back']) ? $_POST['url_back'] : 'user_admin');
            }
        }
        $result = self::request('error', '', "密码不正确");
        return $result;
    }

    static function dwzLogin()
    {
        $request = Func_Input::filter(array(
            'account_id' => 'int',
            'access_url' => 'url',
        ), $_REQUEST);

        $rs = Data_Mysql_Table_Account::select("{table}.*,{prefix}vendor_info.id as vendor_id,{prefix}vendor_info.vendor_name", array("id" => $request['account_id']), '', 1, '{table} LEFT JOIN {prefix}vendor_info ON {table}.id= {prefix}vendor_info.vendor_account_id');
        if (empty($rs[0]['id'])) {
            $result = self::request('error', '', "账号不存在");
            return $result;
        } else {
            self::mkSession($rs[0]);
            $u = parse_url($request['access_url']);
            $_SESSION['access_url'] = dirname($u['path'].'index');
            Data_Mysql_Table_Account::update($rs[0]['id'], array("login_times = login_times + 1"));
            Data_Mysql_Table_StaticLog::log('login', 0, $_SESSION['user']['id'], '');
//            Data_Mysql_Table_Dwz_Record::updataRecord(); //更新通过分享url点击的记录
            unset($_SESSION['url_back']);
            $result = self::request('success', $request, "登录成功");
            return $result;
        }
    }

//快速登录
    static function quickLogin()
    {
        $request = Func_Input::filter(array(
            'phone' => 'string',
            'auth_code' => 'string',
        ), $_REQUEST);

        if (empty($request['phone'])) {
            $result = self::request('error', '', "手机号码不能为空！");
            return $result;
        }
        //兼容短网址校验码 一天之内的短网址校验码可以登录
        $table = "{table} as t1 LEFT JOIN {prefix}login_dwz as t2 ON t1.id = t2.account_id";
        $dwz_conditions['(t1.phone =? OR t1.username=?)'] = array($request['phone'], $request['phone']);
        $dwzRs = Data_Mysql_Table_Account::select('t1.id,t1.username, t1.phone,t2.auth_code,t2.overdue_time', $dwz_conditions, '', 1, $table);
        if (!empty($dwzRs) && isset($dwzRs[0]['auth_code']) && isset($dwzRs[0]['auth_code']) && $dwzRs[0]['overdue_time'] > time() - 86400) {
            if (empty($request['auth_code']) || $request['auth_code'] != $dwzRs[0]['auth_code']) {
                $result = self::request('error', '', "验证码错误!");
                return $result;
            }
        } else {
            //        if (!Func_Input::isLocal()) {
            if (empty($_SESSION['auth_code'][0]) || empty($request['phone']) || $request['phone'] != $_SESSION['auth_code'][0]) {
                $result = self::request('error', '', "验证手机不一致！");
                return $result;
            }
            if (empty($_SESSION['auth_code'][1]) || empty($request['auth_code']) || $request['auth_code'] != $_SESSION['auth_code'][1]) {
                $result = self::request('error', '', "验证码错误!");
                return $result;
            }
            //        }
        }
        $condition["{table}.phone = ?"] = $request['phone'];
        $rs = Data_Mysql_Table_Account::select("{table}.*,{prefix}vendor_info_update.id as vendor_id,{prefix}vendor_info_update.vendor_name", $condition, '', 1, '{table} LEFT JOIN {prefix}vendor_info_update ON {table}.id= {prefix}vendor_info_update.vendor_account_id');
        if (empty($rs[0]['id'])) {
            if(isset($_REQUEST['new_login'])){
                    $data = array(
                        'phone' => $request['phone'],
                        'auth_code' => $request['auth_code'],
                        'from' => -5,
                    );
                $rs = Api_Account_Register::doRegister($data);
                if($rs['status']==1){
                    $request['username']= $_SESSION['user']['username'];
                    $result = self::request('success', $request, "登录成功");
                    return $result;
                }else{
                    return $rs;
                }
            }else{
                $result = self::request('error', '', "账号不存在");
                return $result;
            }
        } else {
            self::mkSession($rs[0]);
            Data_Mysql_Table_Account::update($rs[0]['id'], array("login_times = login_times + 1"));
            Data_Mysql_Table_StaticLog::log('login', 0, $_SESSION['user']['id'], '');
            Data_Mysql_Table_Dwz_Record::updataRecord(); //更新通过分享url点击的记录

            //激活账号（数据拓展用  add by yl)
            Api_Common_Account_Activate::handleAccountActivate(array('phone' => Func_String::encrypt($request['phone'], 'phone'), 'account_id' => Func_String::encrypt($rs[0]['id'], 'account')));

            unset($_SESSION['url_back']);
            $request['username']= $_SESSION['user']['username'];
            $result = self::request('success', $request, "登录成功");
            return $result;
        }
    }
    static function appQuickLogin()
    {
        $request = Func_Input::filter(array(
            'phone' => 'string',
            'auth_code' => 'string',
            'token'=>'string',
        ), $_REQUEST);
        if (empty($request['phone'])) {
            $result = self::request('error', '', "手机号码不能为空！");
            return $result;
        }
        if (empty($request['auth_code'])) {
            $result = self::request('error', '', "验证码不能为空");
            return $result;
        }
        if (empty($request['token'])) {
            $result = self::request('error', '', "参数错误");
            return $result;
        }
        $makeToken = md5($request['auth_code'] . $request['phone']);
        if ($request['token']==$makeToken ) {

            $conditions = array(
                'phone =? ' => array($request['phone'])
            );
            $rs = Data_Mysql_Table_Account::select('id,password,fullname,username,phone', $conditions);
            $makePassword = Data_Mysql_Table_Account::makePassword($rs[0]['password']);
            $time = time();
            $token = md5($time . $rs[0]['id'] . $makePassword);//时间-用户ID-数据库密码 生成token
            $access_token = md5($time . $rs[0]['id'] . self::$access_code);//用户id-access_code生成access_token
            //获取微信息
            $accountInfo = Api_Account_GetBaseInfo::getBaseInfoById(array('account_id' => $rs[0]['id']));
            $_fullname = empty($accountInfo['fullname'])?$rs[0]['phone']:$accountInfo['fullname'];
            if($_fullname==$rs[0]['phone']){
                $_fullname =  substr_replace($_fullname,'****',3,4);
            }
            $data = array(
                'token' => $token,
                'access_token' => $access_token,
                'status' => 'success',
                'user_id' => $rs[0]['id'],
                'login_time' => $time,
                'fullname' => $_fullname,
                'username' => empty($accountInfo['username'])?$rs[0]['username']:$accountInfo['username'],
                'avatar' => 'http://' . Core::$urls['host'] . Core::$urls['root'] . 'user_center/avatar/' . $rs[0]['id'] . '.jpg',
                'phone' => $rs[0]['phone'],
            );
            $insertLoginData = array(
                'username' => $request['username'],
                'fullname' => $rs[0]['fullname'],
                'user_id' => $rs[0]['id'],
                'token' => $token,
                'device_platform' => $request['device_platform'],
                'device_uuid' => $request['device_uuid'],
                'device_version' => $request['device_version'],
                'device_model' => $request['device_model'],
                'app_version' => $request['app_version'],
                'login_time' => $time,
                'jpush_register_id' => $request['jpush_register_id'],
                'device_token_iphone' => $request['device_token_iphone'],
            );
            Data_Mysql_Table_App_Login::insert($insertLoginData,1);
            $result = self::request('success', $data, "登录成功");
            return $result;
        } else {
            $result = self::request('error', '', "参数错误469");
            return $result;
        }
    }

    static function mkSession($rs, $account = '')
    {

        if (!empty($account)) {
            $subAccount = json_decode($rs['sub_account'], 1);
            $_SESSION['user'] = array(
                'id' => $rs['id'],
                'fullname' => $rs['fullname'],
                'email' => $rs['email'],
                'phone' => $rs['phone'],
                'username' => $account[0] . '@' . $rs['username'],
                'account_type' => $rs['account_type'],
                'pnr_account' => $rs['pnr_account'],
                'password' => $rs['password'],
                'password2' => $rs['password2'],
                'attr' => $rs['attr'] ? json_decode($rs['attr'], 1) : '',
                'register_time' => $rs['register_time'],
                'login_time' => time(),
                'sub_account' => array(
                    'account' => $account[0],
                    'auth' => $subAccount[$account[0]][1],
                ),
                'vendor_id' => $rs['vendor_id'],
                'vendor_name' => $rs['vendor_name'],
                'avatar' => $rs['avatar']
            );
        } else {
            $_SESSION['user'] = array(
                'id' => $rs['id'],
                'fullname' => $rs['fullname'],
                'email' => $rs['email'],
                'phone' => $rs['phone'],
                'username' => $rs['username'],
                'avatar' => $rs['avatar'],
                'account_type' => $rs['vendor_id'] ? 21 : 1,
                'identity_time' => $rs['identity_time'],
                'pnr_account' => $rs['pnr_account'],
                'password' => $rs['password'],
                'password2' => $rs['password2'],
                'attr' => $rs['attr'] ? json_decode($rs['attr'], 1) : '',
                'register_time' => $rs['register_time'],
                'login_time' => time(),
                'sub_account' => false,
                'vendor_id' => $rs['vendor_id'],
                'vendor_name' => $rs['vendor_name'],
                'openid' => empty($_SESSION['openid']) ? '' : $_SESSION['openid'],
            );

        }

    }

}

