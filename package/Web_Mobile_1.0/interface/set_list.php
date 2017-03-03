<?php
/**
 * Created by PhpStorm.
 * User: Alex Shen
 * Date: 2015/6/15
 * Time: 16:16
 */
if(!empty(Core::$urls['action']) && Core::$urls['action']=="get_list_for_mobile" ){
    Web_Set_list::handleGetListForMobile();
    die();
}
Web_Set_list::display('Web_Mobile_Static::set_list.v1.0/set_list.php.tpl');
//Tpl_Smarty::display('Web_Mobile_Static::set_list.v1.0/set_list.tpl');