<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/5/4
 * Time: 14:36
 * 零售短租
 */
Web_Global::openCache(0.5);
Tpl_Smarty::assign('seo', array(
    '网页标题' => '快闪店_市集_商铺短租_零售卖场_零售场地-【云SPACE】',
    '网页关键词' => '商铺短租,零售卖场,零售场地,快闪店,体验店,showroom,集合店,店中店',
    '网页简介' => '云SPACE是全球商业零售短租平台，连接全球强体验的创新消费场景。聚合品牌及内容、空间、设计、执行、运营等多方资源，引入创新或联合、独立打造多元多品类的强体验场景，将众多消费场景进行线上线下多维运营分发，运用大数据支持，将消费场景落地到匹配的商业空间，共享商业经济创新消费场景，推动商业繁荣'
));
$action = empty(Core::$urls['action'])?'list':Core::$urls['action'];
if(strstr($action,'/')){
    $act = explode('/',$action);
}else{
    $act[0] = $action;
}
switch($act[0]){
    case 'list':
        $retail=Web_Retail_List::getInstance();
        Tpl_Smarty::assign('nav','retail');
        Tpl_Smarty::assign('is_work_time', Web_Global::isWorkTime());
        Web_Retail_List::display("Web_Static::retail/retail_two_2.tpl");
        break;
    case 'brand':
        $brand = Web_Retail_Cooperation_Brand_Detail::getInstance();
        $brand->updateClick;
        Web_Retail_Cooperation_Brand_Detail::display("Web_Static::retail/cooperation_brand.tpl");
        break;
//    case 'information':
//        $information = Web_Retail_Information_Detail::getInstance();
//        $information->updateClick;
//        Web_Retail_Information_Detail::display("Web_Static::retail/information.tpl");
//        break;
}
