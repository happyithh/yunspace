<?php

/**
 * Created by PhpStorm.
 * User: adu
 * Date: 15/7/9
 * Time: 15:09
 */
@session_start();
class Api_Account_Identity_Authentication_Personal_Info extends Api
{
    //个人身份认证信息
    static function handle()
    {
        //判断是否登录 //判断权限
        if(empty($_SESSION['user']['id'])){
            $result = self::request('error','',"没有登录");
            return $result;
        }
        //接受参数
        /**
         * 登录用户id
         */

        //返回结果：提交结果，
        //插入成功 1  失败0 失败原因
        $result = self::getInfo();
        return $result;
    }
    //返回参数
    static function getInfo()
    {
        if(empty($_SESSION['user']['id'])){
            $result = self::request('error','',"没有登录非法请求");
            return $result;
        }
        $uid = $_SESSION['user']['id'];
        $rs = Data_Mysql_Table_Account_Identity_Personal_Info::select("*",array('account_id'=>$uid),'',1);
        if($rs && isset($rs[0])){
            $result['id'] = $rs[0];
            $result =self::request('success',$rs[0],"认证信息");
            return $result;
        }else{
            $result =self::request('error','',"未找到认证信息");
            return $result;
        }

    }

}

