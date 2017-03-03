<?php

/**
 * Created by PhpStorm.
 * User: adu
 * Date: 15/7/9
 * Time: 15:09
 */
@session_start();
class Api_Account_Identity_Authentication_Company extends Api
{
    //个人身份认证第一步
    static function handle()
    {
        //判断是否登录 //判断权限
        if(empty($_SESSION['administrator']['id'])){
            $result = self::request('error','',"没有登录");
            return $result;
        }
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
        $result = self::companyInfoInsert();
        return $result;
    }
    //返回参数
    static function companyInfoInsert()
    {
        $request = Func_Input::filter(array(
            'identity_id'=>'int',
            'fullname'=>'string',
            'id_card_number'=>'18',
//            'phone'=>'11',
//            'auth_code'=>'6',
            'company_name'=>'string',
            'company_license_number'=>'string',
            'organization_code'=>'string',
            'business_licence_img'=>'string',
            'organization_code_img'=>'string',
            'tax_registration_img'=>'string',
        ),$_REQUEST);
        if(empty($request['fullname']) ){
            $result =self::request('error','',"姓名不能为空！");
            return $result;
        }
        if(empty($request['id_card_number']) || strlen($request['id_card_number'])!=18){
            $result =self::request('error','',"身份证号不能为空并且长度是18位！");
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
        if(empty($request['company_name']) ){
            $result =self::request('error','',"公司名称不能为空！");
            return $result;
        }
        if(empty($request['company_license_number']) ){
            $result =self::request('error','',"营业执照注册号不能为空！");
            return $result;
        }
        if(empty($request['organization_code']) ){
            $result =self::request('error','',"组织机构代码不能为空！");
            return $result;
        }
//        if (!Func_Input::isLocal()) {
//            if (empty($_SESSION['auth_code'][0]) || empty($request['phone']) || $request['phone'] != $_SESSION['auth_code'][0]) {
//                $result = self::request('error', '', "验证手机不一致！");
//                return $result;
//            }
//            if (empty($_SESSION['auth_code'][1]) || empty($request['auth_code']) || $request['auth_code'] != $_SESSION['auth_code'][1]) {
//                $result = self::request('error', '', "验证码错误！");
//                return $result;
//            }
//        }
        $data = array(
//            "account_id"=>$_SESSION['user']['id'],
            'fullname'=>$request['fullname'],
            'id_card_number'=>$request['id_card_number'],
//            'phone'=>$request['phone'],
            'company_name'=>$request['company_name'],
            'company_license_number'=>$request['company_license_number'],
            'organization_code'=>$request['organization_code'],
            'business_licence_img'=>$request['business_licence_img'],
            'organization_code_img'=>$request['organization_code_img'],
            'tax_registration_img'=>$request['tax_registration_img'],
            'create_time'=>time(),
            'update_time'=>time(),
            'status'=>0,
        );
        if(!empty($request['identity_id'])){
            unset($data['uid']);
            unset($data['create_time']);
            $data['refuse_reason'] = '';
            $rs = Data_Mysql_Table_Account_Identity_Company_Info::update(array("id=?"=>$request['identity_id'],"account_id=?"=>$_SESSION['user']['id']),$data);
        }else{
            $rs = Data_Mysql_Table_Account_Identity_Company_Info::insert($data);
        }
        if($rs){
            $request['id'] = isset($request['identity_id']) ? $request['identity_id'] : $rs[0];
            $result =self::request('success',$request,"提交成功");
            return $result;
        }else{
            $result =self::request('error','',"提交失败");
            return $result;
        }
    }

}

