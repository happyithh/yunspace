<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/5/28
 * Time: 11:06
 */
if(!empty(Core::$urls['action']) && Core::$urls['action']=="get_list_for_mobile" ){
    Web_Search_Vendor::handleGetListForMobile();
    die();
}
$detail = Web_Search_Vendor::getInstance();
//q($detail->getVendorList);
//q($detail->conditions);
Web_Search_Vendor::display('Web_Mobile_Static::vendor.v1.0/vendor.tpl');