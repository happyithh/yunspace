<?php

/**
 * Class App_Api_Vendor_User_Center
 * @供应商
 * @zzc
 */
class App_Api_Vendor_Account extends Base
{
    //找回密码第一步
    static function retrieve_password_one()
    {
        $request = Func_Input::filter(array(
            'phone' => 'phone',
        ));
        if (!empty($request['phone'])) {
            $rs = Data_Mysql_Table_Account::select('id,username', array('phone=?' => $request['phone']));
            if (!empty($rs[0])) {
                App_Api_Vendor_Account::send_sms($request['phone']);
                @session_start();
                Func_Output::json('success', md5($_SESSION['code'][1] . '_yunspace'), '验证码发送成功！');

            } else {
                Func_Output::json('error', '', '不存在这个手机号！');
            }
        } else {
            Func_Output::json('error', '', '请填写正确的手机号！');
        }
    }


    //找回密码第三步  验证成功后修改密码
    static function retrieve_password_three()
    {
        $request = Func_Input::filter(array(
            'phone' => 'phone',
            'pwd' => 'string',
            'code' => 'int',
            'md5code' => 'string',
            'pwd2' => 'string',
        ));
        if (empty($request['phone'])) {
            Func_Output::json('error', '', '手机号不正确！');
        }
        if (!empty($request['code'])) {

            if (md5($request['code'] . '_yunspace') != $request['md5code']) {
                Func_Output::json('error', '', '验证码不正确！');
            }
        } else {
            Func_Output::json('error', '', '请填写验证码！');
        }

        if (empty($request['pwd'])) {
            Func_Output::json('error', '', '请输入密码！');
        }
        if (strlen($request['pwd']) < 8) {
            Func_Output::json('error', '', '密码不能小于8位！');
        }
        if ($request['pwd'] != $request['pwd2']) {
            Func_Output::json('error', '', '两次密码不一致！');
        }
        $rs = Data_Mysql_Table_Account::select('id', array('phone =?' => $request['phone']));
        if (empty($rs[0])) {
            Func_Output::json('error', '', '不存在账户信息！');
        }
        $md5Pwd = Data_Mysql_Table_Account::makePassword($request['pwd']);
        $rows = Data_Mysql_Table_Account::update(array('id =?' => $rs[0]['id']), array('password =?' => $md5Pwd));
        if ($rows > 0) {
            Func_Output::json('success', '', '密码修改成功，返回登录');
        }
        Func_Output::json('error', '', '操作失败');

    }

    static function  send_sms($phone)
    {
        @session_start();
        if (empty($phone)) {
            Func_Output::json('error', '', '请输入手机号');
        }
        if (!empty($_SESSION['code']) && $_SESSION['code'][2] > time()) {
            Func_Output::json('error', '', '验证码请求太过频繁,请稍候再试!');
        }
        $code = rand(100000, 999999);
        $_SESSION['code'] = array(
            $phone,
            $code,
            time() + 30
        );

        //手机发送码验证',
        $sta = Func_Message::sendSMS($phone, array(
            $code,
            6
        ), 13838);
        return true;
    }

    static function  modification_password()
    {
        $request = Func_Input::filter(array(
            'phone' => 'phone',
            'user_id' => 'int',
            'pwd' => 'string',
            'pwd1' => 'string',
            'pwd2' => 'string',
        ));
        if (empty($request['phone'])) {
            Func_Output::json('error', '', '手机号不正确！');
        }
        if (empty($request['pwd'])) {
            Func_Output::json('error', '', '请输入旧密码！');
        }

        if (strlen($request['pwd1']) < 8 || strlen($request['pwd']) < 8) {
            Func_Output::json('error', '', '密码不能小于8位！');
        }
        if ($request['pwd1'] != $request['pwd2']) {
            Func_Output::json('error', '', '两次密码不一致！');
        }
        $md5Pwd = Data_Mysql_Table_Account::makePassword($request['pwd']);
        $rs = Data_Mysql_Table_Account::select('id', array('phone =?' => $request['phone'], 'password =?' => $md5Pwd, 'id =?' => $request['user_id']));
        if (empty($rs[0])) {
            Func_Output::json('error', '', '原密码输入错误！');
        }
        $md5Pwd = Data_Mysql_Table_Account::makePassword($request['pwd1']);
        $rows = Data_Mysql_Table_Account::update(array('id =?' => $rs[0]['id']), array('password =?' => $md5Pwd));
        if ($rows > 0) {
            Func_Output::json('success', '', '操作成功！');
        }
        Func_Output::json('error', '', '操作失败');

    }
}