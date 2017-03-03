<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/5/28
 * Time: 11:06
 */
Tpl_Smarty::assign('nav_index', 2);
if(!empty(Core::$urls['action']) && Core::$urls['action']=="get_list_for_mobile" ){

    Web_Search_Space::handleGetListForMobile();
    die();
}
Web_Search_Space::display('Web_Mobile_Static::service.v1.0/service.tpl');
//Tpl_Smarty::display('service.tpl');