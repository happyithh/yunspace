<?php
/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2016/8/30
 * Time: 18:02
 */
//seo信息
switch (Core::$urls['action']) {
    case  "about":
        Tpl_Smarty::assign('seo', array(
            '网页标题' => '关于我们-微官网-【云SPACE】',
            '网页关键词' => '云space 微官网',
            '网页简介' => '云space 微官网'
        ));
        Tpl_Smarty::display('Web_Mobile_Static::wechat_web/wechat_intro.tpl');
        break;
    case  "contact":
        Tpl_Smarty::assign('seo', array(
            '网页标题' => '联系我们-微官网-【云SPACE】',
            '网页关键词' => '云space 微官网',
            '网页简介' => '云space 微官网'
        ));
        Tpl_Smarty::display('Web_Mobile_Static::wechat_web/wechat_contact.tpl');
        break;
    default:
        Func_Header::notFound();
        break;
}