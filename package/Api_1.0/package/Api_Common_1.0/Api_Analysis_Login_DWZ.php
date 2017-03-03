<?php

/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/7/6
 * Time: 16:44
 * @解析登录短网址
 */
class  Api_Analysis_Login_DWZ extends Api
{
    /**
     * 接收参数
     * $urlCode  短网址的代码
     *
     *
     *
     *
     * *
     * 返回结果：
     * 返回状态status （0，返回未成功，1返回成功），
     * 状态消息 msg：返回成功 或返回失败原因
     * 直接跳转
     *
     */

    static function  handle($args = '')
    {
        if($_REQUEST['action_login'] && $_REQUEST['action_login'] =='quick_login'){
            self::authCodeLogin();
        }
        $result = self::analysisLoginLink($args);
        return $result;
    }

    static function  analysisLoginLink($urlCode)
    {
        if (empty($urlCode)) {
            Func_Header::notFound();
        }
        $rs = Data_Mysql_Table_Login_Dwz::select("*", array("url_code" => $urlCode));
        if (empty($rs[0]['id'])) {
            Func_Header::notFound();
        }
        $_url = parse_url($rs[0]['access_url']);
        if(isset($_url['host']) &&  $_url['host']!=Core::$urls['host'] ){
            Func_Header::location('http://'.$_url['host'].'/l'.$urlCode);
        }
        if ($rs[0]['overdue_time'] >= time()) {
            //登录
            $_REQUEST['from'] = -5;
            $_REQUEST['access_url'] = $rs[0]['access_url'];
            $_REQUEST['account_id'] = $rs[0]['account_id'];
            //跳转
            $result = Api_Account_Login::doLogin($_REQUEST);
            if ($result['status'] == 1) {
                //已登录
                Func_Header::location($rs[0]['access_url']);
            } else {
                //未登录
                Func_Header::to('登录失败，请重试');
            }

        }else{
            if(empty($rs[0]['auth_code'])){
                //登录
                $_REQUEST['from'] = -5;
                $_REQUEST['access_url'] = $rs[0]['access_url'];
                $_REQUEST['account_id'] = $rs[0]['account_id'];
                //跳转
                $result = Api_Account_Login::doLogin($_REQUEST);
                if ($result['status'] == 1) {
                    //已登录
                    Func_Header::location($rs[0]['access_url']);
                } else {
                    //未登录
                    Func_Header::to('登录失败，请重试');
                }
            }else{
                Tpl_Smarty::assign("account_id",$rs[0]['account_id']);
                Tpl_Smarty::display('Web_Mobile_Static::user_center.v1.0/quick_login.tpl');
                die();
            }
//            Tpl_Smarty::assign("url_back",$rs[0]['access_url']);
            //过期跳转登录输入验证码登录
//            Func_Header::location($rs[0]['access_url']);
//            Func_Header::to('非常抱歉，访问链接失效！',Core::$urls['root']);
        }


    }

    static function authCodeLogin(){
        $request =  Func_Input::filter(array(
            'account_id' => 'int',
            'auth_code' => 'int',
        ), $_REQUEST);
        if(empty($request['auth_code'])){
            Func_Header::to('验证码不能为空');
        }
        if(empty($request['account_id'])){
            Func_Header::to('参数错误！');
        }
        $rs = Data_Mysql_Table_Login_Dwz::select("*", array("account_id" => $request['account_id'],"auth_code"=>$request['auth_code']));
        if (empty($rs[0]['id'])) {
            Func_Header::to('验证码错误！');
        }else{
            if ($rs[0]['overdue_time']+30*24*60*60 < time()) {
                Func_Header::to('验证码超时！');
            }else{
                //登录
                $_REQUEST['from'] = -5;
                $_REQUEST['access_url'] = $rs[0]['access_url'];
                $_REQUEST['account_id'] = $rs[0]['account_id'];
                //跳转
                $result = Api_Account_Login::doLogin($_REQUEST);
                if ($result['status'] == 1) {
                    //已登录
                    Func_Header::location($rs[0]['access_url']);
                } else {
                    Tpl_Smarty::assign("account_id",$rs[0]['account_id']);
                    Tpl_Smarty::display('Web_Mobile_Static::user_center.v1.0/quick_login.tpl');
                    die();
                }
            }
        }

    }



}