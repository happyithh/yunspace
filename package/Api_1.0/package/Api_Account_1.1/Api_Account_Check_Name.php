<?php

/**
 * Created by PhpStorm.
 * User: adu
 * Date: 15/7/9
 * Time: 15:09
 */
@session_start();
class Api_Account_Check_Name extends Api
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
        /**
         *企业证件信息
         * 法人代表信息
         *
         *
         *
         */

        //返回结果：提交结果，
        //插入成功 1  失败0 失败原因
        $result = self::checkNameIsUse();
        return $result;
    }
    //返回参数
    static function checkNameIsUse()
    {
        $request = Func_Input::filter(array(
            'username'=>'string',
        ),$_REQUEST);
        if(empty($request['username']) ){
            $result =self::request('error','',"用户名不能为空！");
            return $result;
        }
        $rs = Data_Mysql_Table_Account::select('id',$request);
        if($rs){
            $result =self::request('success','',"用户名已被注册");
            return $result;
        }else{
            $result =self::request('error','',"用户名已未被注册，可以使用");
            return $result;
        }
    }

}

