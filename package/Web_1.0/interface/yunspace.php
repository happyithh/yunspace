<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/3/6
 * Time: 10:38
 */
header("content-type:text/html;charset=utf-8");
switch (Core::$urls['action']) {
    case '':
        Func_Header::to('', Core::$urls['root']);
        break;
    case 'about_us':
        Data_Config_Site::seo('关于云·SPACE');
        Tpl_Smarty::display('Web', 'yunspace/about-us.tpl');
        break;
    case 'aboutus':
        Data_Config_Site::seo('关于云·SPACE');
        Tpl_Smarty::display('Web_Feature_Static','contact/contact.tpl');
        break;
    case 'business':
        Data_Config_Site::seo('云·SPACE - 业务合作');
        Tpl_Smarty::display('Web', 'yunspace/business-cooperation.tpl');
        break;
    case 'recruitment':
        Data_Config_Site::seo('云·SPACE - 职位招聘');
        Tpl_Smarty::display('Web', 'yunspace/post-recruitment.tpl');
        break;
    case 'contact_us':
        Data_Config_Site::seo('云·SPACE - 联系我们');
        Tpl_Smarty::display('Web', 'yunspace/contact-us.tpl');
        break;
    case 'agreement':
        Data_Config_Site::seo('云·SPACE - 协议');
        Tpl_Smarty::display('Web', 'yunspace/agreement.tpl');
        break;
    case 'drawback':
        Data_Config_Site::seo('云·SPACE - 协议');
        Tpl_Smarty::display('Web', 'yunspace/drawback.tpl');
        break;
    case 'broker':
        Data_Config_Site::seo('云·SPACE - 经纪人规则');
        Tpl_Smarty::display('Web', 'yunspace/broker.tpl');
        break;
    case 'broker-vendor':
        Data_Config_Site::seo('云·SPACE - 经纪人规则-商户版');
        Tpl_Smarty::display('Web', 'yunspace/broker-vendor.tpl');
        break;
    default:
        Func_Header::notFound();
        break;
}