<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2015/8/13
 * Time: 18:41
 */
session_start();
class Web_Mobile_Broke_News
{
    static function broke_the_news_form(){
        if(!isset($_COOKIE['is_one'])){
            $_COOKIE['is_one']=1;
        }
        Tpl_Smarty::assign('user_phone',@$_SESSION['user']['phone']);
        Tpl_Smarty::assign('userId',@$_SESSION['user']['id']);
        Tpl_Smarty::display('Web_Mobile_Static::broke_the_news.v1.0/broke_the_news_form.tpl');
        die();
    }
    static function broke_the_news_mine(){
        //判断是否登录。没有登录就跳转到登录哪里
        Web_Account::handleIsLogin('');
        $data = Api_Broke_ListPreview::brokeListPreview($_REQUEST);
        if (!empty($data['data']) && $data['status']==1) {
            Tpl_Smarty::assign('data', $data['data']);
            Tpl_Smarty::display('Web_Mobile_Static::broke_the_news.v1.0/broke_the_news_mine.tpl');
        }else{
            Tpl_Smarty::display('Web_Mobile_Static::broke_the_news.v1.0/broke_the_news_enter.tpl');
        }
        die();
    }
    static function broke_validate(){
        //判断是否登录。没有登录就跳转到登录哪里
        Web_Account::handleIsLogin('');
        $data = Api_Broke_List::listDetail($_REQUEST);
        if(!empty($data['data']) && $data['status']==1){
            Tpl_Smarty::assign('data',$data['data']);
            Tpl_Smarty::display('Web_Mobile_Static::broke_the_news.v1.0/broke_validate.tpl');
        }else{

            Tpl_Smarty::display('Web_Mobile_Static::broke_the_news.v1.0/broke_the_news_enter.tpl');
        }

        die();
    }

}