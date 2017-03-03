<?php
/**
 * Created by PhpStorm.
 * User: liushengchun
 * Date: 15/3/2
 * Time: 14:17
 */
switch (Core::$urls['action']) {
    case 'forget_step1':
        /**
         * 忘记密码 步骤1  提交手机号
         */
        forgetLogin::identityTel();
        break;
    case 'forget_step2':
        /**
         * 忘记密码 步骤2    提交验证码
         */
        switch ($_REQUEST['action']) {
            case 'sendSMS':
                forgetLogin::sendSMS();
                break;
            case 'code':
                forgetLogin::identityPhone();
                break;
            case 'next':
                forgetLogin::clickNext();
                break;
            default:
                Func_Header::notFound();
                break;
        }
        break;
    case 'forget_step3':
        /**
         * 忘记密码 步骤3    提交新密码
         */
        forgetLogin::updatePassword();
        break;
}

class forgetLogin
{
//验证手机号码
    static function identityTel()
    {
        session_start();
        $data = Data_Mysql_Table_Account::select("*", array('phone'=>$_REQUEST['tel'])  );
        $json = array();
        if ($data) {
            $json['code'] = 'success';
        } else {
            $json['code'] = 'error';
        }
        echo json_encode($json);
        die();
    }

    //发送验证码
    static function sendSMS()
    {
        session_start();
        $_SESSION['auth_code'] = array();
        $phone = $_REQUEST['phone'];
        $code = mt_rand(100000, 999999);
        $_SESSION['auth_code']['phone'] = $phone;
        $_SESSION['auth_code']['code'] = $code;
        $match = '/^((1[3|5|7|8]{1})+\d{9})$/';
        if (preg_match($match, $phone)) {
            Web_Message::registerAuthCode($phone, $code);
        } else {
            Func_Header::back('请输入正确的手机号码！！');
        }
        die();
    }

    //验证验证码
    static function identityPhone()
    {
        session_start();
        $json = array();
        if ($_REQUEST['code'] == $_SESSION['auth_code']['code']) {
            $json = array(
                'code' => 'success'
            );
        } else {
            $json = array(
                'code' => 'error'
            );
        }
        echo json_encode($json);
        die();
    }

    static function clickNext()
    {
        $request = Func_Input::filter(array(
            'phone' => 'phone',
        ));
        $conditions = array(
            'phone' => $request['phone']
        );
        $data = Data_Mysql_Table_Account::select('*', $conditions, '');
        session_start();
        if (empty($_SESSION['auth_code']['phone']) || $_REQUEST['phone'] != $_SESSION['auth_code']['phone']) {
            Func_Header::back('验证手机不一致！');
        }
        if (empty($_SESSION['auth_code']['code']) || empty($_REQUEST['code']) || $_REQUEST['code'] != $_SESSION['auth_code']['code']) {
            Func_Header::back('验证码错误！');
        }
        if (!$data) {
            Func_Header::back('该手机号码没有绑定！！');
        }
        $json = array('code' => 'success');
        echo json_encode($json);
        die();
    }

    //验证提交数据，并更新
    static function updatePassword()
    {
        session_start();
        $data = array();
        $data['password'] = Data_Mysql_Table_Account::makePassword($_REQUEST['password']);
        $update = Data_Mysql_Table_Account::update(array('phone=?' => $_SESSION['auth_code']['phone']), $data);
        if ($update) {
            //创建操作日志
            $rs = Data_Mysql_Table_Account::select('id', array('phone=?' => $_SESSION['auth_code']['phone']), '');
            Data_Mysql_Table_Account_Log::insertAccountLog($rs[0]['id'], 0, '修改密码', '更新--修改密码');
            Func_Header::back('密码修改成功！！');
        }
    }

}