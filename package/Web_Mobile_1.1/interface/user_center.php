<?php
/**
 * Created by PhpStorm.
 * User: pzl
 * Date: 2015/6/16
 * Time: 9:58
 */
@session_start();
Mobile_User_Center::handle();
class Mobile_User_Center
{
    static function handle()
    {
        switch (Core::$urls['action']) {
            case '':
                if (empty($_SESSION['user']['id'])) {
                        if (empty($_SESSION['url_back'])) {
                            if (!empty($_REQUEST['url_back'])) {
                                if (!empty($_REQUEST['code'])) {
                                    $url_back = $_REQUEST['url_back'] . '&code=' . $_REQUEST['code'];
                                } else {
                                    $url_back = $_REQUEST['url_back'];
                                }
                                $_SESSION['url_back'] = $url_back;
                            } else if (!empty(Core::$urls['referer']) && !strpos(Core::$urls['referer'], '/login')) {
                                $_SESSION['url_back'] = Core::$urls['referer'];
                            } else {
                                if(Core::$urls['host']=='m.yunspace.com.cn'){
                                    $_SESSION['url_back'] = Core::$urls['root'];
                                }else{
                                    $_SESSION['url_back'] = Core::$urls['root'].'m/';
                                }
                            }
                        }
                        Tpl_Smarty::assign('url_back', $_SESSION['url_back']);
                        Tpl_Smarty::display('Web_Mobile_Static::user_center.v1.0/user1.0.tpl');
                }else{
                    Func_Header::location(Core::$urls['root'] . 'user_center_mobile/user_admin');
                }
                break;
            case 'auth_code':
                self::ajaxSendCode();
                break;
            case 'reg_success':
                self::ajaxHandleRegister();
                break;
            case 'login_success':
                self::ajaxHandleLogin();
                break;
            case 'code_validate':
                self::ajaxCodeValidate();
                break;
            case 'phone_validate':
                self::ajaxPhoneValidate();
                break;
            case 'update_password':
                self::updatePassword();
                break;
            case 'quick_login':
                self::quickLogin();
                break;
        }
    }

    /*发送验证码*/
    static function ajaxSendCode()
    {
        $_REQUEST['type'] = 1;
        Api_Common_Send_Auth_Code::sendAuthCode($_REQUEST);
    }
    static function quickLogin(){
        @session_start();
        //判断手机号是否注册
        $request = Func_Input::filter(array(
            'phone' => 'string',
            'auth_code' => 'string',
        ), $_REQUEST);
        $pattern = "/^((1[3|5|7|8]{1})+\d{9})$/";
        if (empty($request['phone']) && !preg_match($pattern, $request['phone'])) {
            Func_Header::back("*手机号码格式错误！");
        }
        if(empty($request['phone'])|| empty($request['auth_code'])){
            Func_Header::back("手机号和验证必须填写完整！");
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
            Func_Header::to('',!empty($_POST['url_back']) ? $_POST['url_back'] : Core::$urls['root']);
        }
    }

    /*注册*/
    static function ajaxHandleRegister()
    {
        Core::output('');
        session_start();
        if (empty($_REQUEST['account_type']) || $_REQUEST['account_type'] != 21) {
            $_REQUEST['account_type'] = 1;
        }
        if (empty($_REQUEST['phone'])) {
            Func_Output::json('', '', '*手机号码不能为空！');
        }
        if (empty($_REQUEST['username'])) {
            Func_Output::json('', '', '*用户名不能为空！');
        }
//		$_REQUEST['username'] = trim($_REQUEST['username']);
        $_REQUEST['phone'] = trim($_REQUEST['phone']);
        $request = Func_Input::filter(array(
            'username' => 'string',
            'phone' => 'phone',
        ));
        if (empty($request['phone'])) {
            Func_Output::json('', '', '*手机号码格式错误！');
        }
        if (strpos($_REQUEST['username'], '@')) {
            Func_Output::json('', '', '*用户名不能包含@字符！');
        }
        if (strpos($_REQUEST['username'], ' ')) {
            Func_Output::json('', '', '*用户名不能包含空格！');
        }
        if (strlen($_REQUEST['username']) > 50) {
            Func_Output::json('', '', '*用户名不能太长！');
        }
        if (strlen($_REQUEST['username']) < 3) {
            Func_Output::json('', '', '*用户名不能太短！');
        }
        if ($_REQUEST['username'] != $request['username']) {
            Func_Output::json('', '', '*用户名不能包含html特殊字符！');
        }
//		if (empty($_REQUEST['password']) || empty($_REQUEST['rpassword']) || $_REQUEST['password'] != $_REQUEST['rpassword']) {
//			Func_Header::back('密码必须填写，且两次输入必须一致！');
//		}
        if (strlen($_REQUEST['password']) < 8) {
            Func_Output::json('', '', '*密码不能小于8个字符！');
        }
        if (empty($_SESSION['auth_code'][1]) || empty($_REQUEST['auth_code']) || $_REQUEST['auth_code'] != $_SESSION['auth_code'][1]) {
            Func_Output::json('', '', '*验证码错误！！');
        }
        if (empty($_SESSION['auth_code'][0]) || empty($_REQUEST['phone']) || $_REQUEST['phone'] != $_SESSION['auth_code'][0]) {
            Func_Output::json('', '', '*验证手机不一致！！');
        }
        $data = array(
            'fullname' => $_REQUEST['username'],
            'phone' => $_REQUEST['phone'],
            'username' => $_REQUEST['username'],
            'attr' => array(
                'register_ip' => Func_Input::ip(),
                'email' => '',
                'phone' => $_REQUEST['phone'],
                '服务领域' => empty($_REQUEST['category_id']) ? 0 : $_REQUEST['category_id']
            ),
            'account_type' => $_REQUEST['account_type'],
            'password' => Data_Mysql_Table_Account::makePassword($_REQUEST['password']),
            'register_time' => time(),
        );
        $rs = Data_Mysql_Table_Account::select('id, phone, password', array('phone = ?' => array($request['phone'])));
        if (!empty($rs[0]['id'])) {
            if (Data_Mysql_Table_Account::makePassword($request['phone']) == $rs[0]['password']) {
                $data['id'] = $rs[0]['id'];
                $rs = Data_Mysql_Table_Account::update($data);
            } else {
                Func_Output::json('', '', '手机号码已被注册！');
            }
        } else {
            $rs = Data_Mysql_Table_Account::insert($data);
        }
        if (empty($rs[0])) {
            return false;
        }
        $data['id'] = $rs[0];
        if (empty($data['id'])) {
            Func_Output::json('', '', '*该用户名已注册！！');
        } else {
            unset($_SESSION['auth_code']);
//			$data = Data_Mysql_Table_Account::select("id", array("username" => $data['username']), '', 1);
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
        }
        Func_Output::json('', '', '');
//		return $data;
    }

    /*登录*/
    static function ajaxHandleLogin()
    {
        if (empty($_POST['username'])) {
            Func_Output::json('', '', '*用户名/手机/邮箱必须填写!');
        }
        if (empty($_POST['password'])) {
            Func_Output::json('', '', '*密码必须填写!');
        }
        session_start();
        if (!empty($_POST['remember'])) {
            session_set_cookie_params(86400 * 7);
        }
        if (strpos($_POST['username'], '@')) {
            return self::handleLoginSubAccount();
        }
        $rs = Data_Mysql_Table_Account::select("{table}.*,{prefix}vendor_info.id as vendor_id", array("{table}.username=? OR {table}.email= ? OR {table}.phone= ?" => array($_POST['username'], $_POST['username'], $_POST['username'])), '', 10, '{table} LEFT JOIN {prefix}vendor_info ON {table}.id= {prefix}vendor_info.vendor_account_id');
        if (empty($rs[0]['id'])) {
            Func_Output::json('', '', '*账号不存在!');
        }
        foreach ($rs as $r) {
            if ($rs[0]['password'] == Data_Mysql_Table_Account::makePassword($_POST['password'])) {
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
                    'avatar' => $r['avatar']
                );
                Data_Mysql_Table_Account::update($r['id'], array("login_times = login_times + 1"));
                $_SESSION['user']['super_vendor'] = $r['username'] == 'vendor';
                Data_Mysql_Table_StaticLog::log('login', 0, $_SESSION['user']['id'], '');
                Data_Mysql_Table_Dwz_Record::updataRecord(); //更新通过分享url点击的记录
                $url = !empty($_SESSION['url_back']) ? $_SESSION['url_back'] : Core::$urls['root'] . 'user_center/user_admin';
                unset($_SESSION['url_back']);
                Func_Output::json('', $url, '');
            }
        }
        Func_Output::json('', '', '*密码错误!');
    }

    /*验证手机号码是否存在*/
    static function ajaxPhoneValidate()
    {
        session_start();
        $request = Func_Input::filter(array(
            'phone' => 'phone',
        ));
        $pattern = "/^((1[3|5|7|8]{1})+\d{9})$/";
        if (empty($request['phone']) && !preg_match($pattern, $request['phone'])) {
            Func_Output::json('', '', '*手机号码格式错误！');
        }
        $condition = array(
            'phone' => $request['phone']
        );
        $data = Data_Mysql_Table_Account::select("*", $condition);
        if (empty($data)) {
            Func_Output::json('', '', '*手机号码不存在!');
        }
        Func_Output::json('', '', '');
    }

    /*忘记密码，验证码验证*/
    static function ajaxCodeValidate()
    {
        session_start();
        $request = Func_Input::filter(array(
            'phone' => 'phone',
            'code' => 'string'
        ));
        if (empty($request['phone'])) {
            Func_Output::json('', '', '*请填写手机号码！');
        }
        if (empty($_SESSION['auth_code']['0']) || $request['phone'] != $_SESSION['auth_code']['0']) {
            Func_Output::json('', '', '*验证手机不一致！');
        }
        if (empty($_SESSION['auth_code']['0']) || empty($request['code']) || $request['code'] != $_SESSION['auth_code']['1']) {
            Func_Output::json('', '', '*验证码错误！');
        }
        $condition = array(
            'phone' => $request['phone']
        );
        $data = Data_Mysql_Table_Account::select("*", $condition);
        if (empty($data)) {
            Func_Output::json('', '', '*手机号码不存在!');
        }
        Func_Output::json('', '', '');
    }

    /*重新设置密码*/
    static function updatePassword()
    {
        session_start();
        $request = Func_Input::filter(array(
            'phone' => 'phone',
            'password' => 'string'
        ));
        $data = array();
        $pattern = "/^((1[3|5|7|8]{1})+\d{9})$/";
        if (empty($request['phone']) && !preg_match($pattern, $request['phone'])) {
            Func_Output::json('', '', '*手机号码格式错误！');
        }
        if (strlen($request['password']) < 8) {
            Func_Output::json('', '', '*密码长度不能小于8个字符！');
        }
        $data['password'] = Data_Mysql_Table_Account::makePassword($request['password']);
        $condition = array(
            "phone" => $_SESSION['auth_code']['0']
        );
        $update = Data_Mysql_Table_Account::update($condition, $data);
        if ($update) {
            //创建操作日志
            Data_Mysql_Table_Account_Log::insertAccountLog($_SESSION['user']['id'], 0, '修改密码', '更新--修改密码');
            Func_Output::json('', '', '');
        }
    }

}
