<?php

/**
 * 用户注册
 *
 */
@session_start();

class Api_Account_Register extends Api
{


    // 用户注册
    static function handle($args)
    {
        //接受参数

        //返回结果：提交结果，
        //插入成功 1  失败0 失败原因
        $result = self::doRegister($_REQUEST);
        return $result;
    }

    static function doRegister($args = '')
    {
        $request = Func_Input::filter(array(
            'account_type' => 'int',
            'username' => 'string',
            'phone' => 'string',
            'auth_code' => 'string',
            'password' => 'string',
            'rpassword' => 'string',
            'from' => 'int',
        ), $args);
        //默认是pc  0 web版本 是-1  云经纪是-2 云管家是-3 微信 -4  快速注册-5
        $request['from'] = !empty($request['from']) ? $request['from'] : "0";
        if (empty($request['account_type']) || $request['account_type'] != 21) {
            $request['account_type'] = 1;
        }
        /***
         * 默认pc 直接写入数据库表。注册来源为pc端
         * web版本和pc端类似。只是来源是web端 如果没有确认密码的话 默认赋值为 rpassword
         * 云经纪  来源是云经纪  需要插入经济人表数据   需要返回token
         * 云管家  来源是云关键  需要返回token
         * 微信（快速注册） ，用户名和实名都是手机号。还有密码要随机生成 并发短信给用户临时密码
         * 快速注册，主要接受手机号和验证码  使用场景 手机端快速注册，下单时快速注册
         */
        $regFrom = '';
        switch ($request['from']) {
            case -1 :
                $request['admin_id'] = -1;
                $request['rpassword'] = empty($request['rpassword']) ? $request['password'] : $request['rpassword'];
                $regFrom = "手机web端注册";
                break;
            case -2 :
                $request['admin_id'] = -2;
                $regFrom = "云经纪客户端注册";
//                $request['rpassword'] = empty($request['rpassword']) ? $request['password'] : $request['rpassword'];
                break;
            case -3 :
                $request['admin_id'] = -3;
                $regFrom = "云管家客户端注册";
                $request['account_type'] = 21;
//                $request['rpassword'] = empty($request['rpassword']) ? $request['password'] : $request['rpassword'];
                break;
            case -4 :
                $request['admin_id'] = -4;
                $regFrom = "微信注册";
                $request['rpassword'] = $request['password'] = self::mkRandPassword();  //随机密码
                $request['username'] = $request['phone'];
                break;
            case -5 :
                $request['admin_id'] = -5;
                $regFrom = "快速注册";
                $request['rpassword'] = $request['password'] = self::mkRandPassword();  //随机密码
                $request['username'] = $request['phone'];
                break;
            default:
                $request['admin_id'] = 0;
                $regFrom = "PC端注册";
                break;
        }

//        if (empty($_POST['tnc'])) {
//            $result =self::request('error','',"请阅读并同意《云SPACE用户协议注册协议》！");
//            return $result;
//        }
        if (empty($request['phone'])) {
            $result = self::request('error', '', "手机号码不能为空！");
            return $result;
        }
        if (!Func_Input::isLocal() && $request['from'] != -2 && $request['from'] != -3) {
            if (empty($_SESSION['auth_code'][0]) || empty($request['phone']) || $request['phone'] != $_SESSION['auth_code'][0]) {
                $result = self::request('error', '', "验证手机不一致！");
                return $result;
            }
            if (empty($_SESSION['auth_code'][1]) || empty($request['auth_code']) || $request['auth_code'] != $_SESSION['auth_code'][1]) {
                $result = self::request('error', '', "验证码错误!");
                return $result;
            }
        }
        $request['username'] = trim($request['username']);
        if (empty($request['username'])) {
            $result = self::request('error', '', "用户名不能为空！");
            return $result;
        }

        $request['phone'] = trim($request['phone']);
        if (empty($request['phone'])) {
            $result = self::request('error', '', "手机号码格式错误！");
            return $result;
        }
        if (strpos($request['username'], '@')) {
            $result = self::request('error', '', "用户名不能包含@字符！！");
            return $result;
        }
        if (strpos($request['username'], ' ')) {
            $result = self::request('error', '', "用户名不能包含空格！");
            return $result;
        }
        if (strlen($request['username']) > 50) {
            $result = self::request('error', '', "用户名不能太长(不能大于五十字符)！");
            return $result;
        }
        if (strlen($request['username']) < 2) {
            $result = self::request('error', '', "用户名不能太短（不能小于两个字符）！");
            return $result;
        }
        if (isset($_REQUEST['username']) && $_REQUEST['username'] != $request['username'] && $request['from'] != -4 && $request['from'] != -5) {
            $result = self::request('error', '', "用户名不能包含html特殊字符！");
            return $result;
        }
        if (empty($request['password']) || empty($request['rpassword']) || $request['password'] != $request['rpassword']) {
            $result = self::request('error', '', "密码必须填写，且两次输入必须一致！");
            return $result;
        }
        if (strlen($request['password']) < 6) {
            $result = self::request('error', '', "密码不能小于6个字符");
            return $result;
        }
        $data = array(
            'fullname' => $request['username'],
            'phone' => $request['phone'],
            'username' => $request['username'],
            'attr' => array(
                'register_ip' => Func_Input::ip(),
                'email' => '',
                'phone' => $request['phone'],
                '服务领域' => empty($request['category_id']) ? 0 : $request['category_id'],
                '注册来源' => $regFrom,
            ),
            'account_type' => $request['account_type'],
            'password' => Data_Mysql_Table_Account::makePassword($request['password']),
            'register_time' => time(),
            'admin_id' => $request['admin_id']
        );
        $rs = Data_Mysql_Table_Account::select('id, phone, password', array('phone = ?' => array($request['phone'])));
        if (!empty($rs[0]['id'])) {
//            if (Data_Mysql_Table_Account::makePassword($request['phone']) == $rs[0]['password']) {
//                $data['id'] = $rs[0]['id'];
//                $rs = Data_Mysql_Table_Account::update($data);
//            } else {
            $result = self::request('error', '', "手机号码已被注册");
            return $result;
//            }
        } else {
            if (!empty($_SESSION['administrator']['id'])) {
                $data['admin_id'] = $_SESSION['administrator']['id'];
            }
//            else {
//                $data['admin_id'] = 0;
//            }
            $rsNew = Data_Mysql_Table_Account::insert($data);
        }
        if (empty($rsNew[0])) {
            $result = self::request('error', '', "该用户名已注册");
            return $result;
        } else {
            //如果是手机端就返回token
            if ($request['from'] == -2 || $request['from'] == -3) {
                $code = rand(100000, 999999);
                $token = md5($code . $request['phone']);
                $data['code'] = $code;
                $data['token'] = $token;
            }
            //如果是微信就需要发送密码短信
            if ($request['from'] == -4 || $request['from'] == -5) {
                Func_Message::sendSMS($request['phone'], array($request['phone'], $request['password']), 23705);
            }
            $data['id'] = $rsNew[0];
            $result = Data_Mysql_Table_Account::select("{table}.*,{prefix}vendor_info.id as vendor_id,{prefix}vendor_info.vendor_name", array("{table}.id=?" => array($data['id'])), '', 10, '{table} LEFT JOIN {prefix}vendor_info ON {table}.id= {prefix}vendor_info.vendor_account_id');
            Api_Account_Login::mkSession($result[0]);
            $result = self::request('success', $data, "注册成功");
            return $result;
        }
    }

    static function mkRandPassword()
    {
        return rand(100000, 999999) . rand(10, 99);
    }

    /**
     * 快速注册账号  只限内部调用
     *
     * $args =array(
     *               phone=>''  手机号
     *               password=>''  密码
     * )
     */
    static function  quickRegister($args)
    {

        $request = Func_Input::filter(array(
            'phone' => 'phone',
            'username' => 'string',
            'fullname' => 'string',
            'password' => 'string',
            'email' => 'email',
        ), $args);
        if (empty($request['phone'])) {
            return Api::request('error', '', '请填写正确的手机号');
        }
        //判断用户名是否存在
        $username_exists = Data_Mysql_Table_Account::select('id,username', array('username' => $request['username']));
        if (!empty($username_exists[0])) {
            $request['username'] = $request['phone'];
        }

        $conditions['(phone =? OR username=?)'] = array($request['phone'], $request['phone']);
        $rs = Data_Mysql_Table_Account::select('t1.id,t1.username, t1.phone,t2.id as vendor_id ,t2.vendor_name', $conditions);
        if (!empty($rs[0]['id'])) {
            return Api::request('error', $rs[0], '手机号已被注册');
        }
        $data = array(
            'fullname' => $request['fullname'],
            'phone' => $request['phone'],
            'username' => empty($request['username']) ? $request['phone'] : $request['username'],
            'attr' => array(
                'register_ip' => Func_Input::ip(),
                'email' => empty($request['email']) ? '' : $request['email'],
                'phone' => $request['phone'],
                '注册来源' => "内部快速注册",
            ),
            'password' => Data_Mysql_Table_Account::makePassword($request['password']),
            'register_time' => time(),
            'admin_id' => -5
        );
        $status = Data_Mysql_Table_Account::insert($data);
        if ($status[0] > 0) {
            $data['id'] = $status[0];
            return Api::request('success', $data, '注册成功');
        }
        return Api::request('error', '', '注册失败');
    }

    /**
     * Spacepedia
     * 快速注册账号  只限内部调用
     *
     */
    static function  SpacepediaQuickRegister($args)
    {
        $request = Func_Input::filter(array(
            'phone' => 'phone',
            'username' => 'string',
            'password' => 'string',
            'email' => 'email',
        ), $args);
        if (empty($request['phone'])) {
            return Api::request('error', '', '请填写正确的手机号');
        }
        if (empty($request['password'])) {
            $request['password'] = substr($request['phone'], 4);
        }
        //判断用户名是否存在
        $username_exists = Data_Mysql_Table_Account::select('id,username', array('username' => $request['username']));
        if (!empty($username_exists[0])) {
            $request['username'] = $request['phone'];
        }
        $conditions['(phone =? OR username=?)'] = array($request['phone'], $request['phone']);
        $rs = Data_Mysql_Table_Account::select('id,username,phone', $conditions);
        if (!empty($rs[0]['id'])) {
            return Api::request('error', $rs[0], '手机号已被注册');
        }
        $data = array(
            'fullname' => '',
            'phone' => $request['phone'],
            'username' => empty($request['username']) ? $request['phone'] : $request['username'],
            'attr' => array(
                'register_ip' => Func_Input::ip(),
                'email' => empty($request['email']) ? '' : $request['email'],
                'phone' => $request['phone'],
                '注册来源' => "空间百科联系人注册-内部",
            ),
            'password' => Data_Mysql_Table_Account::makePassword($request['password']),
            'register_time' => time(),
            'admin_id' => -5
        );
        $status = Data_Mysql_Table_Account::insert($data);
        if ($status[0] > 0) {
            $data['id'] = $status[0];
            return Api::request('success', $data, '注册成功');
        }
        return Api::request('error', '', '注册失败');
    }

}

