<?php
/**
 * Created by PhpStorm.
 * User: bll
 * Date: 16/6/27
 * Time: 下午1:49
 */
$action = Core::$urls['action'];

switch($action){
    default:
        Tpl_Smarty::display('Web_Static::home_1.2/index_2.tpl');
        break;
}