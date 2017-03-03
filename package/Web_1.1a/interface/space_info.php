<?php
/**
 * Created by PhpStorm.
 * User: pzl
 * Date: 2015/6/16
 * Time: 9:58
 */
switch(Core::$urls['action']){
    case  "space":
        Tpl_Smarty::display('Web_Static::space_info/space_info.tpl');
        break;
    case  "inquiry":
        Tpl_Smarty::display('Web_Static::space_info/space_inquiry.tpl');
        break;
}

