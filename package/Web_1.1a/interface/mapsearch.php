<?php
/**
 * Created by PhpStorm.
 * User: pzl
 * Date: 2015/6/16
 * Time: 9:58
 */
//q(Core::$urls['action']);
switch(Core::$urls['action']){
    case  "map":
        Tpl_Smarty::display('Web_Static::map_search.v1.0/mapsearch.tpl');
        break;
}

