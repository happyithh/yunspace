<?php
Tpl_Smarty::assign('seo', array(
    '网页标题' => '【云SPACE】城市合伙人,共享商业地产万亿元市场,全国300个城市合伙人虚位以待!',
    '网页关键词' => '【云SPACE】城市合伙人,共享商业地产万亿元市场,全国300个城市合伙人虚位以待!',
    '网页简介' => '【云SPACE】城市合伙人,共享商业地产万亿元市场,全国300个城市合伙人虚位以待!'
));
Tpl_Smarty::assign("nav","join");
switch (Core::$urls['action']) {
    case  "join":
        Tpl_Smarty::display('Web_Static::city_collaborate/city_collaborate_join.tpl');
        break;
    default :
        Tpl_Smarty::display('Web_Static::city_collaborate/city_collaborate.tpl');
        break;
}
