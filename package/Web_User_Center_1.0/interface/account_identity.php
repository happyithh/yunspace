<?php
/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2015/7/14
 * Time: 18:01
 */
@session_start();
//if(!isset($_SESSION['user']) ){
//    Func_Header::to("请先登录，或注册账号","http://".Core::$urls['host']."/user_center/login");
//}
Web_Account::handleIsLogin("请先登录，或注册账号");

$type = isset($_REQUEST['type']) ? $_REQUEST['type'] : "personal";
switch($type){
    //判断是个人认证还是企业认证
    case 'personal':
        accountIdentity::personalIdentity();
        break;
    case 'company':
        accountIdentity::companyIdentity();
        break;
    case 'personalsubmit':
        accountIdentity::personalSubmit();
        break;
    case 'companysubmit':
        accountIdentity::companySubmit();
        break;
    case 'personalcomplete':
        accountIdentity::personalComplete();
        break;
    case 'companycomplete':
        accountIdentity::companyComplete();
        break;
    case 'auth_code':
        accountIdentity::sendAuthCode();
        break;
        default:
        Func_Header::back("参数错误");
        break;
}

class accountIdentity {
    //个人认证页面 第一步
    static   function personalIdentity(){
        //判断是否已经提交信息，如果已提交未审核，返回，如果已提交已通过 返回，如果审核未通过显示未通过理由，重新填写
        if(!empty($_SESSION['user']['id'])){
            $identityInfo = Api_Account_Identity_Authentication_Personal_Info::getInfo();
            if(!empty($identityInfo['data']) ){
                switch($identityInfo['data']['status']){
                    case 0:
                        $Identitystatus = "<span style='color: #fcb322;font-size: 16px;'>正在审核中！</span>";
                        break;
                    case 1:
                        $Identitystatus = "<span style='color: #3cc051;font-size: 16px;'>恭喜您信息认证审核通过！</span>";
                        break;
                    case -1:
                        $Identitystatus = "<span style='color: #ed4e2a;font-size: 16px;'>很遗憾,信息认证审核未通过！</span>";
                        break;
                    default:
                        break;
                }
                if($Identitystatus){
                    Tpl_Smarty::assign("identity_status",$Identitystatus);
                }
                Tpl_Smarty::assign("identity_info",$identityInfo['data']);
            }
            if(!empty($identityInfo['data']) && $identityInfo['data']['status']==1 ){
                //已提交，审核通过 返回
                Func_Header::to("已审核通过");
            }
            if((!empty($identityInfo['data']) && $identityInfo['data']['status']==-1) || (isset($_REQUEST['action']) &&  $_REQUEST['action']=="update")){
                //已提交，审核为通过
                Tpl_Smarty::assign("identity_info",$identityInfo['data']);
//                Func_Header::to("已审核通过");
            }
        }
        if(!empty($_SESSION['url_back'])){
            $url_back = $_SESSION['url_back'];
        }else{
            $url_back = "http://".Core::$urls['host']."/user_center/";
        }
        Tpl_Smarty::assign("url_back",$url_back);
        Tpl_Smarty::display('Web_Static', 'id_validate/validate_step1.tpl');
    }

    //发送验证码
    static function sendAuthCode(){
        $request = Func_Input::filter(array(
            'phone' => 'phone',
        ));
        if (!$request['phone']) {
            die('参数错误!');
        }
        if (!empty($_SESSION['auth_code']) && $_SESSION['auth_code'][2] > time()) {
            die('请求太过频繁,请稍候再试!');
        }
        $_SESSION['auth_code'] = array(
            $request['phone'],
            rand(10000, 99999),
            time() + 30
        );
        Web_Message::registerAuthCode($request['phone'], $_SESSION['auth_code'][1]);
        die();
    }

        //企业认证页面
    static function companyIdentity(){
        //判断是否已经提交信息，如果已提交未审核，返回，如果已提交已通过 返回，如果审核未通过显示未通过理由，重新填写
        if(!empty($_SESSION['user']['id'])){
            $identityInfo = Api_Account_Identity_Authentication_Company_Info::getInfo();
            if(!empty($identityInfo['data']) ){
                switch($identityInfo['data']['status']){
                    case 0:
                        $Identitystatus = "<span style='color: #fcb322;font-size: 16px;'>正在审核中！</span>";
                        break;
                    case 1:
                        $Identitystatus = "<span style='color: #3cc051;font-size: 16px;'>恭喜您信息认证审核通过！</span>";
                        break;
                    case -1:
                        $Identitystatus = "<span style='color: #ed4e2a;font-size: 16px;'>很遗憾,信息认证审核未通过！</span>";
                        break;
                    default:
                        break;
                }
                if($Identitystatus){
                    Tpl_Smarty::assign("identity_status",$Identitystatus);
                }
                Tpl_Smarty::assign("identity_info",$identityInfo['data']);
            }

        }
        if(!empty($_SESSION['url_back'])){
            $url_back = $_SESSION['url_back'];
        }else{
            $url_back = "http://".Core::$urls['host']."/user_center/";
        }
        Tpl_Smarty::assign("url_back",$url_back);
        Tpl_Smarty::display('Web_Static', 'id_validate/validate_compy.tpl');
    }

        //个人信息提交
    static function personalSubmit(){
        $result = Api_Account_Identity_Authentication_Personal_Step_One::stepOne();
        if($result['status']==1){
            Func_Header::to($result['msg'],"?type=personalcomplete");
        }else{
            Func_Header::back($result['msg']);
        }
    }

        //企业信息提交
    static function companySubmit(){
        $result = Api_Account_Identity_Authentication_Company::companyInfoInsert();
        if($result['status']==1){
            Func_Header::to($result['msg'],"http://".Core::$urls['host']."/user_center/");
        }else{
            Func_Header::back($result['msg']);
        }
    }

        //个人信息提交成功页面
    static function personalComplete(){
        if(!isset($_SESSION['user']) ){
            Func_Header::to("请先登录，或注册账号","http://".Core::$urls['host']."/user_center/login");
        }
        if(!empty($_SESSION['url_back'])){
            $url_back = $_SESSION['url_back'];
        }else{
            $url_back = "http://".Core::$urls['host']."/user_center/";
        }
        Tpl_Smarty::assign("url_back",$url_back);
        Tpl_Smarty::display('Web_Static', 'id_validate/validate_step2.tpl');
    }

    //企业信息提交成功页面
    static function companyComplete(){
    }
}
