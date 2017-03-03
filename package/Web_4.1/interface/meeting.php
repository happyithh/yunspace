<?php
/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2016/10/25
 * Time: 15:47
 */
switch (Core::$urls['action']) {
    case "creative":
        Tpl_Smarty::display('Web_Static::meeting/creative.tpl');
        break;
    case "largesize":
        Tpl_Smarty::display('Web_Static::meeting/largesize.tpl');
        break;
    case "midsize":
        Tpl_Smarty::display('Web_Static::meeting/mid_size.tpl');
        break;
    case "nationsize":
        Tpl_Smarty::display('Web_Static::meeting/nationsize.tpl');
        break;
    case "hot_list":
//        Web_Global::openCache(4);
//        $detail = Web_Meeting_Hot::getInstance();
        Web_Meeting_Hot::display('Web_Static::meeting_hot/hot_list.tpl');
//        Tpl_Smarty::display('Web_Static::meeting-hot/hot_list.tpl');
        break;
//    case "hot_details":
//        Web_Global::openCache(4);
//        Web_Meeting_Hot::display('Web_Static::meeting_hot/hot_dtl.tpl');
//        break;
    case "wanda":
        Web_Meeting_Hot::display('Web_Static::subject_wanda/wanda.tpl');
        break;
    default:
        Tpl_Smarty::display('Web_Static::meeting/home.tpl');
        break;
}