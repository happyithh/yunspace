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
$a = Web_Product_Set_Info::getInstance();
Data_Config_Site::seo('set_info', $a->info);

Web_Product_Set_Info::display('Web_Mobile_Static::set_info.v1.0/set_info_v3.tpl');
