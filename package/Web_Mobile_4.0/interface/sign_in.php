<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/1/25
 * Time: 15:24
 * 外出签到
 */
$sign = Web_Moblie_Sign_In_Management::getInstance();
$act=empty(Core::$urls['action'])?'list/status_all':Core::$urls['action'];
if(strstr($act,'/')){
    $action = explode('/',$act);
}else{
    $action[0] = $act;
}
switch($action[0]){
    case  "list":
//        q($sign->signStatus);
//        q($sign->signInList);
        Web_Moblie_Sign_In_Management::display('Web_Mobile_Static::sign_in/sign_in_list_1.tpl');
        break;
    case  "sign":
        Web_Moblie_Sign_In_Management::display('Web_Mobile_Static::sign_in/sign_in_time_1.tpl');
        break;
    case  "detail":
        $signPackage = Api_Sign_In_GetLocation::getLocation();
        Tpl_Smarty::assign('signPackage',$signPackage);
        Web_Moblie_Sign_In_Management::display('Web_Mobile_Static::sign_in/sign_in_mark_refuse_1.tpl');
        break;
}