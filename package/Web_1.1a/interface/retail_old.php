<?php
Tpl_Smarty::assign('seo', array(
    '网页标题' => '【云SPACE】城市合伙人,共享商业地产万亿元市场,全国300个城市合伙人虚位以待!',
    '网页关键词' => '【云SPACE】城市合伙人,共享商业地产万亿元市场,全国300个城市合伙人虚位以待!',
    '网页简介' => '【云SPACE】城市合伙人,共享商业地产万亿元市场,全国300个城市合伙人虚位以待!'
));
switch (Core::$urls['action']) {
    case  "information":
        Tpl_Smarty::display('Web_Static::retail/retail_information.tpl');
        break;
    case  "painter":
        Tpl_Smarty::display('Web_Static::retail/retail_painter.tpl');
        break;
    default:
        Tpl_Smarty::display('Web_Static::retail/retail_two.tpl');
}
