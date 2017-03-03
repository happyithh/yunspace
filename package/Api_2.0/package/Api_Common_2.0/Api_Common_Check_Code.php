<?php
/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2016/11/2
 * Time: 10:26
 */

class Api_Common_Check_Code extends Api{
        static function handle(){
            return self::CheckCode();
        }

        static function CheckCode(){
            $request = Func_Input::filter(array(
                'phone'=>'11',
                'auth_code'=>'6',
                'code_token'=>'string'
            ),$_REQUEST);
            if(empty($request['phone']) ){
                $result =self::request('-1','',"手机号不能为空！");
                return $result;
            }
            if (empty($request['auth_code'])) {
                $result = self::request('-1', '', "验证码不能为空！");
                return $result;
            }
            if(empty($request['code_token'])){
                $result =self::request('-1','',"请先获取验证码!");
                return $result;
            }
            $token = md5($request['auth_code'] . $request['phone'].'yunspace');
            if ($token == $request['code_token']) {
                $result =self::request('success','',"验证码正确!");
                return $result;
            } else {
                $result =self::request('-1','',"验证码错误！");
                return $result;
            }

        }
} 