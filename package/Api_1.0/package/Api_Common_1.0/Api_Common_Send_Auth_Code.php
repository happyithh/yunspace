<?php

/**
 * Created by PhpStorm.
 * User: adu
 * Date: 15/7/9
 * Time: 15:09
 */
@session_start();

class Api_Common_Send_Auth_Code extends Api
{
    //发送验证码
    static function handle()
    {
        //判断是否登录 //判断权限
//        if(empty($_SESSION['administrator']['id'])){
//            $result = self::request('error','',"没有登录");
//            return $result;
//        }
        //接受参数
        /**
         *手机号 phone
         * 验证码类型  短信注册。默认验证码。找回密码等
         *
         *
         *
         */

        //返回结果：提交结果，
        //插入成功 1  失败0 失败原因
        $result = self::sendAuthCode($_REQUEST);
        return $result;
    }

    //返回参数
    static function sendAuthCode($args)
    {
        $request = Func_Input::filter(array(
            'phone' => 'phone',
            "type" => "int",  //不同地方的验证码  注册。登录。找回密码等
            "from" => 'int'
        ), $args);
        $cs_status = Func_Start_Cs::checkCs();
        if(!$cs_status){
            $result = self::request('error', '', "非法请求！");
            return $result;
        }
        if (!$request['phone']) {
            $result = self::request('error', '', "手机号不能为空！");
            return $result;
        }
        if (!empty($_SESSION['phone'])) {
            $_SESSION['phone'] = $_SESSION['phone'] + 1;
        } else {
            $_SESSION['phone'] = 1;
        }
        //大于8次 就打客服
        if (!Func_Input::isLocal() && $_SESSION['phone'] > 8) {
            return Api::request('error', '', '请致电客服400-056-0599获取帮助~');
        }
        if (!Func_Input::isLocal() && !empty($_SESSION['auth_code']) && $_SESSION['auth_code'][2] > time()) {

            $result = self::request('error', $_SESSION['auth_code'][1], "请求太过频繁,");
            return $result;
        }
        $smsType = empty($request['type']) ? 0 : $request['type'];
        switch ($smsType) {
            case 0 :
                $smsTpl = 14467;  //通用
                break;
            case 1 :
                $smsTpl = 13838;  //注册
                break;
            default :
                $smsTpl = 14467;  //通用
                break;
        }
        if (Func_Input::isLocal()) {
            $code = '888888';
        } else {
            /**
             * 如果验证码还没有过期，就使用原来的验证码
             */
            if (isset($_SESSION['auth_code'][1])&& $_SESSION['auth_code'][1]==$request['phone']&& $_SESSION['auth_code'][2] < time()) {
                $code = $_SESSION['auth_code'][1];
            } else {
                $code = rand(100000, 999999);
            }
        }
        $_SESSION['auth_code'] = array(
            $request['phone'],          //0         key
            $code,                      //1         key
            time() + 30                 //2         key
        );

        if (!Func_Input::isLocal()) {
            Func_Message::sendSMS($request['phone'], array(
                $_SESSION['auth_code'][1],
                5
            ), $smsTpl);
        }
        if (isset($request['from']) && ($request['from'] == -2 || $request['from'] == -3)) {

            $token = md5($code . $request['phone']);
            $data = array(
                'token' => $token,
                //'auth_code' => $code
            );
            return Api::request('success', $data, "验证码发送成功！");
        } else {
            return Api::request('success', '', "验证码发送成功！");
        }

    }
}

