<?php
Tpl_Smarty::assign('seo', array(
    '网页标题' => '【云SPACE】场地加盟，助您解决场地烦恼!',
    '网页关键词' => '【云SPACE】场地加盟，助您解决场地烦恼!',
    '网页简介' => '【云SPACE】场地加盟，助您解决场地烦恼!'
));
//switch (Core::$urls['action']) {
//    case  "site_join":
//        Tpl_Smarty::display('Web_Static::site_join/site_join.tpl');
//        break;
////    default :
////        Tpl_Smarty::display('Web_Static::city_collaborate/city_collaborate.tpl');
////        break;
//}
Tpl_Smarty::display('Web_Static::site_join/site_join.tpl');
