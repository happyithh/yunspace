<?php

/**
 * Created by PhpStorm.
 * User: adu
 * Date: 15/7/9
 * Time: 15:09
 */
@session_start();
class Api_Account_Identity_Authentication_Personal_Step_One extends Api
{
    //个人身份认证第一步
    static function handle()
    {
        //判断是否登录 //判断权限
        if(empty($_SESSION['user']['id'])){
            $result = self::request('error','',"没有登录");
            return $result;
        }
        //接受参数
        /**
         * 姓名
         * 身份证号
         *手机号
         * 短信验证码
         */

        //返回结果：提交结果，
        //插入成功 1  失败0 失败原因
        $result = self::stepOne();
        return $result;
    }
    //返回参数
    static function stepOne()
    {
        $request = Func_Input::filter(array(
            'identity_id'=>'int',
            'fullname'=>'string',
            'id_card_number'=>'18',
            'hold_identity_card_img'=>'string',
//            'phone'=>'11',
//            'auth_code'=>'6'
        ),$_REQUEST);
        if(empty($request['fullname']) ){
            $result =self::request('error','',"姓名不能为空！");
            return $result;
        }
        if(empty($request['id_card_number']) || strlen($request['id_card_number'])!=18){
            $result =self::request('error','',"身份证号不能为空并且长度是18位！");
            return $result;
        }
        if(empty($request['hold_identity_card_img']) ){
            $result =self::request('error','',"手持身份证照片必须上传！");
            return $result;
        }
//        if(empty($request['phone']) ){
//            $result =self::request('error','',"手机号不能为空！");
//            return $result;
//        }
//        if(empty($request['auth_code']) ){
//            $result =self::request('error','',"手机验证码不能为空！");
//            return $result;
//        }
//        if (!Func_Input::isLocal()) {
//            if (empty($_SESSION['auth_code'][0]) || empty($request['phone']) || $request['phone'] != $_SESSION['auth_code'][0]) {
//                $result =self::request('error','',"验证手机不一致！");
//                return $result;
//            }
//            if (empty($_SESSION['auth_code'][1]) || empty($request['auth_code']) || $request['auth_code'] != $_SESSION['auth_code'][1]) {
//                $result =self::request('error','',"验证码错误！");
//                return $result;
//            }
//        }
        $data = array(
//            "account_id"=>$_SESSION['user']['id'],
            'fullname'=>$request['fullname'],
            'id_card_number'=>$request['id_card_number'],
//            'phone'=>$request['phone'],
            'hold_identity_card_img'=>$request['hold_identity_card_img'],
            'create_time'=>time(),
            'update_time'=>time(),
            'status'=>0,
        );
        if(!empty($request['identity_id'])){
            unset($data['create_time']);
            $data['refuse_reason'] = '';
            $rs = Data_Mysql_Table_Account_Identity_Personal_Info::update(array("id=?"=>$request['identity_id'],"account_id=?"=>$_SESSION['user']['id']),$data);
        }else{
            $rs = Data_Mysql_Table_Account_Identity_Personal_Info::insert($data);
        }
        if($rs){
            $result =self::request('success',$request,"提交成功");
            return $result;
        }else{
            $result =self::request('error','',"提交失败");
            return $result;
        }

    }

}

