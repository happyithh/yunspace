<?php
switch (Core::$urls['action']) {
    case  "mp":
        Tpl_Smarty::display('Web_Static::map.v1.0/html_map.tpl');
        break;
    case  "mp1":
        Tpl_Smarty::display('Web_Static::map.v1.0/html_map_search.tpl');
        break;
}