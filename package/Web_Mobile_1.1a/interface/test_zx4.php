<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2016/6/23
 * Time: 10:25
 */

$action = Core::$urls['action'];

switch($action){
    case 'search_list':
        Tpl_Smarty::display('Web_Mobile_Static::search.v2.0/search_list.tpl');
        die();
        break;
    case '11':
        Tpl_Smarty::display('');
        die();
        break;
    case '22':
        Tpl_Smarty::display('');
        die();
        break;
    case '33':
        Tpl_Smarty::display('');
        die();
        break;
    default:
        echo "路径写错了";
        break;
}