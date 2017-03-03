<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/3/20 12:00
 * 供应商介绍页
 */
Tpl_Smarty::assign('nav_index',3);
if (!strpos(Core::$urls['action'], '.html') || substr(Core::$urls['action'], -5) !== '.html') {
    Func_Header::notFound();
}
$vendorInfo = Web_Vendor_Info::getInstance();
Data_Config_Site::seo('vendor_info', $vendorInfo->vendorInfo);
Web_Vendor_Info::display('vendor-info.v2.tpl');
