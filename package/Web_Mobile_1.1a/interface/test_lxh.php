<?php
switch (Core::$urls['action']) {
    case  "schedule":
        Tpl_Smarty::display('Web_Mobile_Static::search_about/schedule_prices.tpl');
        break;
    case  "location":
        Tpl_Smarty::display('Web_Mobile_Static::search_about/search_location.tpl');
        break;
    case  "inquiry":
        Tpl_Smarty::display('Web_Mobile_Static::search_about/mass_inquiry.tpl');
        break;
    case  "pic":
        Tpl_Smarty::display('Web_Mobile_Static::search_about/mass_inquiry_pic.tpl');
        break;
    case  "sub":
        Tpl_Smarty::display('Web_Mobile_Static::site/subspace.tpl');
        break;
    case  "space":
        Tpl_Smarty::display('Web_Mobile_Static::search_about/schedule_space.tpl');

    case  "wchuang":
        Tpl_Smarty::display('Web_Mobile_Static::wchuang/wchuang.tpl');
        break;
    case  "inq":
        Tpl_Smarty::display('Web_Mobile_Static::wchuang/enquiry.tpl');
        break;
    case  "wchinq":
        Tpl_Smarty::display('Web_Mobile_Static::wchuang/wch_enquiry.tpl');
        break;
    case  "wchbk":
        Tpl_Smarty::display('Web_Mobile_Static::wchuang/baike_wch.tpl');
        break;
    case  "wchmore":
        Tpl_Smarty::display('Web_Mobile_Static::wchuang/wch_more.tpl');
        break;

    case  "weweb":
        Tpl_Smarty::display('Web_Mobile_Static::wechat_web/wechat_index.tpl');
        break;
    case  "welist":
        Tpl_Smarty::display('Web_Mobile_Static::wechat_web/wechat_article_list.tpl');
        break;
    case  "article":
        Tpl_Smarty::display('Web_Mobile_Static::wechat_web/wechat_article_detail.tpl');
        break;
    case  "intro":
        Tpl_Smarty::display('Web_Mobile_Static::wechat_web/wechat_intro.tpl');
        break;
    case  "contact":
        Tpl_Smarty::display('Web_Mobile_Static::wechat_web/wechat_contact.tpl');
        break;
    case  "madm":
        Tpl_Smarty::display('Web_Mobile_Static::retail_special/retail_special.tpl');
        break;


    default:
        echo "路径写错了";
        break;
}