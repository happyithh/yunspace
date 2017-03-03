<?php
/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2016/10/26
 * Time: 16:46
 */
@session_start();
//$agent = strtolower($_SERVER['HTTP_USER_AGENT']);
//if(strpos($agent, 'micromessenger') == false){
//    Func_Header::to('请使用微信打开！','http://www.yunspace.com.cn/');
//}
$seo['网页标题']="云SPACE玩转快闪店";
$seo['网页关键词']="云SPACE玩转快闪店";
$seo['网页简介']="云SPACE玩转快闪店";
Tpl_Smarty::assign("seo",$seo);

$agent = strtolower($_SERVER['HTTP_USER_AGENT']);
if(strpos($agent, 'micromessenger')!=false){
    if(isset($_SESSION['openid'])){
        Tpl_Smarty::display('Web_Mobile_Static::retail_special/retail_special.tpl');
        die();
    }else{
        $_SESSION['url_back'] = 'http://www.yunspace.com.cn/m/adm';
        Wechat_Oauth_New::handle();
    }
}else{

    Tpl_Smarty::display('Web_Mobile_Static::retail_special/retail_special.tpl');
    die();
}
