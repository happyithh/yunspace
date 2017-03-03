<?php
/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2016/11/2
 * Time: 10:26
 */

class Api_Common_Send_Code extends Api{
        static function handle(){
            return self::sendCode();
        }
        static $test_phone =array(
            '13812345678',
            '13812345679',
            '13812345688',
            '13812345689',
            '13812345698',
            '13812345699'
        );
        static function sendCode(){
            $request = Func_Input::filter(array(
                'phone' => 'phone',
                "verify" => "string",  //
            ), $_REQUEST);

            if(empty($request['phone'])){
                return self::request('-1','','手机号不能为空');
            }
            //verify 是md5（'yunspace'） 前六位
            if(empty($request['verify'])||$request['verify']!='31eff6'){
                return self::request('-1','','非法请求');
            }
            $smsTpl = 14467;
            if (Func_Input::isLocal()||in_array($request['phone'],self::$test_phone)) {
                $code = '888888';
            } else {
                $code = rand(100000, 999999);
//                /**
//                 * 如果验证码还没有过期，就使用原来的验证码
//                 */
//                if (isset($_SESSION['auth_code'][1])&& $_SESSION['auth_code'][1]==$request['phone']&& $_SESSION['auth_code'][2] < time()) {
//                    $code = $_SESSION['auth_code'][1];
//                } else {
//                    $code = rand(100000, 999999);
//                }
            }
            $_SESSION['auth_code'] = array(
                $request['phone'],          //0         key
                $code,                      //1         key
                time() + 30                 //2         key
            );

            if (!Func_Input::isLocal()||!in_array($request['phone'],self::$test_phone)) {
                Func_Message::sendSMS($request['phone'], array(
                    $_SESSION['auth_code'][1],
                    5
                ), $smsTpl);
            }

            $token = md5($code . $request['phone'].'yunspace');
            $data = array(
                'code_token' => $token,
                //'auth_code' => $code
            );
            return Api::request('success', $data, "验证码发送成功！");
        }
} 