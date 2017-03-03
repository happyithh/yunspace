<?php
/**
 * Created by PhpStorm.
 * User: Alex Shen
 * Date: 2015/6/4
 * Time: 14:38
 */


if (!strpos(Core::$urls['action'], '.html') || substr(Core::$urls['action'], -5) !== '.html') {
	Func_Header::notFound();
}
$detail = Web_Search_Vendor::getInstance();
//输出模板
Data_Config_Site::seo('vendor_info', $detail->vendorInfo);
Web_Search_Vendor::display('Web_Mobile_Static::vendor.v1.0/vendor-info.tpl');

