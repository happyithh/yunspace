<?php
/*
 * Created by PhpStorm
 * User: Yangchenglin
 * Date: 2015/11/27
 * Time: 13:31
 */
//场地方登录
@session_start();
class Api_Demand_Product_Login extends Api
{
    static function handle($args='')
    {
        $result = self::handleLogin($args);
        return $result;
    }

    static $access_code = 'yunspace123';

    static function handleLogin($args)
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

}