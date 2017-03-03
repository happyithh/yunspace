<?php
/**
 * Created by PhpStorm.
 * User: pzl
 * Date: 2015/6/16
 * Time: 9:58
 */
Api_Session::user_info();
//判断是否登录。没有登录就跳转到登录哪里
//Web_Account::handleIsLogin('');
//q($_SESSION);
if(empty($_SESSION['user'])){
    Web_Account::handleIsLogin('');
}
$data['id']=$_SESSION['user']['id'];
$data['username']=$_SESSION['user']['username'];
$data['email']=$_SESSION['user']['email'];
$data['fullname']=$_SESSION['user']['fullname'];


//q($data);
Tpl_Smarty::assign("data", $data);
Tpl_Smarty::display("Web_Mobile_Static::opinion_feedback.v1.0/opinion_feedback.tpl");
