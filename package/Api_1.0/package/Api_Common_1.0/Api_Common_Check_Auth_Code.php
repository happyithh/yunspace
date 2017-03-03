<?php

/**
 * Created by PhpStorm.
 * User: adu
 * Date: 15/7/9
 * Time: 15:09
 */
@session_start();
class Api_Common_Check_Auth_Code extends Api
{
    //检测验证码是否正确
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
         * 验证码 auth_code
         *
         *
         *
         */

        //返回结果：提交结果，
        //插入成功 1  失败0 失败原因
        $result = self::checkAuthCode();
        return $result;
    }
    //返回参数
    static function checkAuthCode()
    {
        $request = Func_Input::filter(array(
            'phone'=>'11',
            'auth_code'=>'6',
            'from'=>'int',
            'token'=>'string'
        ),$_REQUEST);
        if(empty($request['phone']) ){
            $result =self::request('error','',"手机号不能为空！");
            return $result;
        }
        if (empty($request['auth_code'])) {
            $result = self::request('error', '', "验证码不能为空！");
            return $result;
        }
        if(isset($request['from']) && ($request['from']==-2 || $request['from']==-3)){
            if(empty($request['token'])){
                $result =self::request('error','',"token未传递!");
                return $result;
            }
            $token = md5($request['auth_code'] . $request['phone']);
            if ($token == $request['token']) {
                $result =self::request('success','',"验证码正确!");
                return $result;
            } else {
                $result =self::request('error','',"验证码错误！");
                return $result;
            }
        }else{
           /* if (empty($_SESSION['auth_code'][0]) || empty($request['phone']) || $request['phone'] != $_SESSION['auth_code'][0]) {
                $result =self::request('error','',"验证手机不一致！");
                return $result;
            }*/
            if($request['phone']!=$_SESSION['auth_code'][0]){

                return Api::request('error','',"该手机号没有发送过验证码！");
            }
            if (empty($_SESSION['auth_code'][1]) || empty($request['auth_code']) || $request['auth_code'] != $_SESSION['auth_code'][1]) {
                $result =self::request('error','',"验证码错误!");
                return $result;
            }
            $result =self::request('success','',"  验证码正确!");
            return $result;
        }

    }

}

