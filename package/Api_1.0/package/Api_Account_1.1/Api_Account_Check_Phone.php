<?php

/**
 * Created by PhpStorm.
 * User: adu
 * Date: 15/7/9
 * Time: 15:09
 */
@session_start();
class Api_Account_Check_Phone extends Api
{
    //手机号是否已注册
    static function handle()
    {
        //判断是否登录 //判断权限
//        if(empty($_SESSION['administrator']['id'])){
//            $result = self::request('error','',"没有登录");
//            return $result;
//        }
        //接受参数

        //返回结果：提交结果，
        //插入成功 1  失败0 失败原因
        $result = self::checkPhoneIsUse();
        return $result;
    }
    //返回参数
    static function checkPhoneIsUse()
    {
        $request = Func_Input::filter(array(
            'phone'=>'11',
        ),$_REQUEST);
        if(empty($request['phone']) ){
            $result =self::request('error','',"手机号不能为空！");
            return $result;
        }
        $pattern = "/^((1[3|5|7|8]{1})+\d{9})$/";
        if (empty($request['phone']) && !preg_match($pattern, $request['phone'])) {
            $result =self::request('error','',"*手机号码格式错误！");
            return $result;
        }
        $rs = Data_Mysql_Table_Account::select('id',$request);
        if($rs){
                $result =self::request('success','',"手机号已被注册");
                return $result;
        }else{
            $result =self::request('error','',"手机号已未被注册，可以使用");
            return $result;
        }
    }

}

