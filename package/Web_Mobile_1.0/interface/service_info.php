<?php
/**
 * Created by PhpStorm.
 * User: Alex Shen
 * Date: 2015/6/4
 * Time: 14:38
 */
session_start();
if(!empty($_SESSION['user'])){
    Tpl_Smarty::assign('__user', $_SESSION['user']);
}
if (!strpos(Core::$urls['action'], '.html') || substr(Core::$urls['action'], -5) !== '.html') {
	Func_Header::notFound();
}
$serviceInfo = Web_Product_Info::getInstance();

//访问记录跟踪
Web_Account::footPrint($serviceInfo->productInfo);

//输出模板
Data_Config_Site::seo('service_info', $serviceInfo->productInfo);
Web_Product_Info::display('Web_Mobile_Static::service_info.v2.0/service-info.tpl');

