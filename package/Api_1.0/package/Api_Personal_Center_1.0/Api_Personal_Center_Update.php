<?php

/**
 * Created by PhpStorm.
 * User: yl
 * Date: 15-8-17
 * Time: 下午3:05
 * 管家app订单接口
 */
class Api_Personal_Center_Update extends Api
{
    static function  handle()
    {
        Api_Session::user_id();
        $request = Func_Input::filter(array(
            'action' => 'string',
        ), $_REQUEST);
        switch ($request['action']) {
            //头像
            case 'head_portrait':
                $data = self::getHeadPortrait();
                break;
            //用户名
            case 'user_name':
                $data = self::getUserName();
                break;
            //手机号
            case 'getcode':
                $data = self::register_send_sms();
                break;
            case 'phone':
                $data = self::getMyPhone();
                break;

            //邮箱
            case 'my_email':
                $data = self::getMyEmail();
                break;
            case 'update_email':
                $data = self::getMyEmailUpdate();
                break;
            //积分
            case 'my_integral':
                $data = self::getMyIntegral();
                break;
        }
        return $data;
    }

    //更换头像
    static function getHeadPortrait()
    {
        $request = Func_Input::filter(array(
            'avatar' => 'array'
        ), $_FILES);
        if (empty($request['avatar'])) {
            return self::request('error', '', '请选择上传图片!');
        }
        $headImg = Func_Upload::image('avatar');
        $img_path = Func_Upload::getInstance()->___uploadPath . substr($headImg, strlen(Func_Upload::getInstance()->___uploadUrl));
        Func_Image::thumCenterImage($img_path, $img_path, 180, 180);
        if (!$headImg) {
            return self::request('error', '', '上传失败！,请稍候再试');
        }
        //写入数据库
        $res = Data_Mysql_Table_Account::update($_SESSION['user']['id'], array(
            'avatar' => $headImg
        ));
        unset(Api_Account_GetBaseInfo::$tempCache[$_SESSION['user']['id']]);
        if (empty($res[0])) {
            return self::request('error', '', '操作异常,请稍候再试!');
        }

        return self::request('success', '', '更换头像成功!');
    }
    //发送验证码
    static function register_send_sms()
    {
        $request = Func_Input::filter(array(
            'phone' => 'phone',
        ));
        if (!$request['phone']) {
            Func_Return::jsonReturn('', '请输入正确的手机号！！', -1002);
        }
        $rs = Data_Mysql_Table_Account::select('id', array('phone =?' => $request['phone']));
        if (!empty($rs[0])) {
            Func_Return::jsonReturn('', '该手机号已被注册', -2001);
        }
        $code = rand(100000, 999999);
        //$code = '888888';
        $token = md5($code . $request['phone']);
        //'手机号码验证',
        $sta = Func_Message::sendSMS($request['phone'], array(
            $code,
            6
        ), 13838);
        $backData = array(
            'token' => $token,
            'code' => $code
        );
        Func_Return::jsonReturn($backData, '发送成功！', 1);

    }


    //更改绑定手机号
    static function getMyPhone()
    {
        Core::output('');
        $request = Func_Input::filter(array(
            'phone' => 'phone',
            'token' => 'string',
            'code' => 'int'
        ));

        $token = md5($request['code'] . $request['phone']);
        if ($token != $request['token']) {
            return self::request('error', 'code', '验证码错误!');
        }
        $data = Data_Mysql_Table_Account::select('id', 'phone=' . $request['phone']);
        if (!empty($data[0])) {
            return self::request('error', 'phone', '该手机号已被注册!');
        }
        $update = Data_Mysql_Table_Account::update($_SESSION['user']['id'], array('phone' => $request['phone']));
        if (!empty($update[0])) {
            //创建操作日志
            Data_Mysql_Table_Account_Log::insertAccountLog($_SESSION['user']['id'], 0, '绑定手机号', '更新--绑定手机号');
            $_SESSION['user']['phone'] = $request['phone'];
            return self::request('success', '', '更换绑定手机号成功!');
        }
        return self::request('error', 'code', '操作失败!');
    }

    //修改昵称
    static function  getUserName()
    {
        $request = Func_Input::filter(array(
            'username' => 'string',
        ), $_REQUEST);
       // q($_SESSION);
        if (empty($_SESSION['user']['id'])) {
            return self::request('error', '', '参数错误!');
        }
        if (empty($request['username'])) {
            return self::request('error', '', '用户名不能为空');
        }
        $data = Data_Mysql_Table_Account::select("id,fullname", 'id="' . $_SESSION['user']['id'] . '"');
     //q($data);
        if (empty($data)) {
            return self::request('error', '', '用户不存在！！');
        }
        $rs = Data_Mysql_Table_Account::update($_SESSION['user']['id'], array('fullname' => $request['username']));
        if ($rs) {
            return self::request('success', '', '用户名修改成功');
        } else {
            return self::request('error', '', '用户名修改失败');
        }
    }

    //发送邮箱
    static function getMyEmail()
    {
        $request = Func_Input::filter(array(
            'email' => 'email',
        ), $_REQUEST);
        $data = Data_Mysql_Table_Account::select("id", 'email="' . $request['email'] . '"');
        $username = Data_Mysql_Table_Account::select('username',array('id =?'=>$_SESSION['user']['id']));
        if(empty($username)){
            return self::request('error', '', '参数错误！！');
        }
        if (empty($request['email'])) {
            return self::request('error', '', '邮箱格式不正确！！');
        }
        if ($data) {
            return self::request('error', '', '邮箱已被绑定！！');
        } else {
                   $code = mt_rand(100000, 999999);
                     $enId = mt_rand(288, 9999);
                     $checkCode = Func_String::encrypt(($_SESSION['user']['id'] + 106672) . ' ' . $request['email'] . ' ' . uniqid(), 'ieio2ok');
                   $send = Web_Message::emailConform(
                         $request['email'],
                         $username[0]['username'],
                         'http://' . Core::$urls['host'] . Core::$urls['path'] . '?action=update_email&code=' . $checkCode);
                     if (!$send) {
                         return self::request('success', '', '验证邮件发送成功，请注意查收，如长时间未收到邮件，建议查看垃圾箱或点击重新发送！！');

                     } else {
                         return self::request('error', '', '验证邮件发送失败！！');
                     }

                 }

             }

         //修改绑定邮箱
             static function getMyEmailUpdate()
             {
                 if (empty($_REQUEST['code'])) {
                     return false;
                 }

                 $checkCode = Func_String::decrypt(str_replace(' ', '%2B', $_REQUEST['code']), 'ieio2ok');
                 $checkCode = explode(' ', $checkCode . '   ');
                 $checkCode['id'] = $checkCode[0] - 106672;
                 $checkCode['email'] = $checkCode[1];
                 $checkCode = Func_Input::filter(array('id' => 'int', 'email' => 'email'), $checkCode);
                // q($checkCode);
                // q($_SESSION);
                /* if ($checkCode['id'] != $_SESSION['user']['id']) {
                     return self::request('error', '', '您当前登录的账号与验证邮箱不匹配！！');
                 }*/
                 $data = array(
                     'email' => $checkCode['email']
                 );
            $update = Data_Mysql_Table_Account::update(array(
                'id' => $checkCode['id']
            ), $data);
            if ($update) {
                $_SESSION['user']['email'] = $checkCode['email'];
                //创建操作日志
                Data_Mysql_Table_Account_Log::insertAccountLog($checkCode['id'], 0, '绑定邮箱', '更新--绑定邮箱');
                return self::request('success', '', '绑定邮件成功！！');
            } else {
                return self::request('error', '', '绑定邮件失败！！');
            }

    }

    //我的积分
    static function getMyIntegral()
    {
        $request = Func_Input::filter(array(
            'integral' => 'int',
        ), $_REQUEST);

        $rs = Data_Mysql_Table_Account::select('sign_num,sign_time', array('id' => $_SESSION['user']['id']));
        if (empty($rs)) {
            return self::request('error', '', '用户不存在！！');
        }

        if (empty($rs[0]['sign_num'])) {
            //没有记录，第一次签到
            $vs = Data_Mysql_Table_Account::update(array('id' => $_SESSION['user']['id']), array('sign_time' => time(), 'sign_num' => 1, 'integral' => $request['integral'] + 1));
            if($vs){
                return self::request('success', '', '签到成功，恭喜你获得1积分');
            }else{
                return self::request('error', '', '签到失败！！');
            }
        } else {
            $date = date('z', time()) - date('z', $rs[0]['sign_time']);
            if ($date < 1) {
                return self::request('error', '', '您今天已经签过到！！');
            } elseif ($date == 1) {
                //昨天签过到
                if (!empty($rs[0]['sign_num']) && $rs[0]['sign_num'] < 5) {
                    $vs = Data_Mysql_Table_Account::update(array('id' => $_SESSION['user']['id']), array('sign_time' => time(), 'sign_num' => $rs[0]['sign_num'] + 1, 'integral' => $request['integral'] + $rs[0]['sign_num']+1));
                   $num =intval($rs[0]['sign_num']+1);
                    if($vs[0]){
                        return self::request('success', '', "签到成功，恭喜你获得'".$num."'积分");
                    }else{
                        return self::request('error', '', '签到失败！！');
                    }
                } elseif (!empty($rs[0]['sign_num']) && $rs[0]['sign_num'] >= 5) {
                    $vs = Data_Mysql_Table_Account::update(array('id' => $_SESSION['user']['id']), array('sign_time' => time(), 'sign_num' => $rs[0]['sign_num'] + 1, 'integral' => $request['integral'] + 5));
                    if($vs){
                        return self::request('success', '', "签到成功，恭喜你获得5积分");
                    }else{
                        return self::request('error', '', '签到失败！！');
                    }
                }

            } elseif ($date > 1) {
                $vs = Data_Mysql_Table_Raiders_Info::update(array('id' => $_SESSION['user']['id']), array('sign_time' => time(), 'sign_num' => 1, 'integral' => $request['integral'] + 1));
                if($vs){
                    return self::request('success', '', '签到成功，恭喜你获得1积分');
                }else{
                    return self::request('error', '', '签到失败！！');
                }
            }
        }
    }

}