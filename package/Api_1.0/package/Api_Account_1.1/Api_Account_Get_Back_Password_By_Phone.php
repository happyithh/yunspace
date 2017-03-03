<?php

/**
 * 用户注册
 *
 */
@session_start();
class Api_Account_Get_Back_Password_By_Phone extends Api
{


    // 用户注册
    static function handle($args)
    {
        //接受参数

        //返回结果：提交结果，
        //插入成功 1  失败0 失败原因
        $result = self::getBackPassword($_REQUEST);
        return $result;
    }

    static function getBackPassword($args='')
    {
        $request = Func_Input::filter(array(
            'password' => 'string',
            'rpassword' => 'string',
            'auth_code'=>'6',
            'phone'=>'phone',
            'from'=>'int',
            'token'=>'string'
        ), $args);
        if(!isset($request['from'])||(isset($request['from']) && $request['from']!=-2 && $request['from']!=-3)){
           $rs =  self::normalChangePassword($request);
//            if(empty($_SESSION['auth_code']) || empty($_SESSION['auth_code'][0])){
//                $result =self::request('error','',"手机号验证异常");
//                return $result;
//            }
        }else{
            $rs =  self::appChangePassword($request);
        }
        return $rs;
//        if (strlen(trim($request['password'])) < 6) {
//            $result =self::request('error','',"密码不能小于6个字符");
//            return $result;
//        }
//        if (empty($request['password']) || empty($request['rpassword']) || $request['password'] != $request['rpassword']) {
//            $result =self::request('error','',"密码必须填写，且两次输入必须一致！");
//            return $result;
//        }
//        $data = array();
//        if(isset($request['from']) && ($request['from']==-2||$request['from']==-3)){
//            if(!empty($request['phone'])){
//                $phone = $request['phone'];
//            }else{
//                $result =self::request('error','',"手机号不能为空");
//                return $result;
//            }
//        }else{
//            $phone = $_SESSION['auth_code'][0];
//        }
//        $data['password'] = Data_Mysql_Table_Account::makePassword($request['password']);
//        $update = Data_Mysql_Table_Account::update(array('phone' => $phone), $data);
//        if ($update) {
//            //创建操作日志
//            $rs = Data_Mysql_Table_Account::select('id', array('phone' => $phone), '');
//            Data_Mysql_Table_Account_Log::insertAccountLog($rs[0]['id'], 0, '修改密码', '更新--修改密码');
//            $result =self::request('success',$request,"密码修改成功！！");
//            return $result;
//        }else{
//            $result =self::request('error','',"修改密码失败！");
//            return $result;
//        }

    }

    static function  normalChangePassword($request){
        if (strlen(trim($request['password'])) < 6) {
            $result =self::request('error','',"密码不能小于6个字符");
            return $result;
        }
        if (empty($request['password']) || empty($request['rpassword']) || $request['password'] != $request['rpassword']) {
            $result =self::request('error','',"密码必须填写，且两次输入必须一致！");
            return $result;
        }
        $data = array();
        $data['password'] = Data_Mysql_Table_Account::makePassword($request['password']);
        $update = Data_Mysql_Table_Account::update(array('phone' =>  $_SESSION['auth_code'][0]), $data);
        if (isset($update[0])&&!empty($update[0])) {
            //创建操作日志
            $rs = Data_Mysql_Table_Account::select('id', array('phone' =>  $_SESSION['auth_code'][0]), '');
            Data_Mysql_Table_Account_Log::insertAccountLog($rs[0]['id'], 0, '修改密码', '更新--修改密码');
            $result =self::request('success',$request,"密码修改成功！！");
            return $result;
        }else{
            $result =self::request('error','',"修改密码失败！");
            return $result;
        }
    }
    static function appChangePassword($request){
        if(empty($request['phone'])){
            $result =self::request('error','',"手机号不能为空");
            return $result;
        }
        if(empty($request['token'])){
            $result =self::request('error','',"手机号不能为空");
            return $result;
        }
        if(empty($request['auth_code']) ){
            $result =self::request('error','',"验证码不能为空！");
            return $result;
        }
        $token = md5($request['auth_code'] . $request['phone']);
        if ($token != $request['token']) {
            $result =self::request('error','',"验证码错误！");
            return $result;
        }
        if (strlen(trim($request['password'])) < 6) {
            $result =self::request('error','',"密码不能小于6个字符");
            return $result;
        }
        if (empty($request['password']) || empty($request['rpassword']) || $request['password'] != $request['rpassword']) {
            $result =self::request('error','',"密码必须填写，且两次输入必须一致！");
            return $result;
        }
        $data = array();
        $data['password'] = Data_Mysql_Table_Account::makePassword($request['password']);
        $update = Data_Mysql_Table_Account::update(array('phone' => $request['phone']), $data);
        if (isset($update[0])&&!empty($update[0])) {
            //创建操作日志
            $rs = Data_Mysql_Table_Account::select('id', array('phone' => $request['phone']), '');
            Data_Mysql_Table_Account_Log::insertAccountLog($rs[0]['id'], 0, '修改密码', '更新--修改密码');
            $result =self::request('success',$request,"密码修改成功！！");
            return $result;
        }else{
            $result =self::request('error','',"修改密码失败！");
            return $result;
        }
    }

}

