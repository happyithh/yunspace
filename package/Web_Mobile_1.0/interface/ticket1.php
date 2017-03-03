<?php
/**
 * Created by PhpStorm.
 * User: pzl
 * Date: 2015/6/16
 * Time: 9:58
 */

switch(Core::$urls['action']){
    case  "check":
        Tpl_Smarty::display('Web_Mobile_Static::wechat.v3.0/booking_check.tpl');
        break;
    case  "choice":
        Tpl_Smarty::display('Web_Mobile_Static::wechat.v3.0/booking_choice.tpl');
        break;
    case  "details":
        Tpl_Smarty::display('Web_Mobile_Static::wechat.v3.0/booking_details.tpl');
        break;
    case  "hvcancel":
        Tpl_Smarty::display('Web_Mobile_Static::wechat.v3.0/booking_hvcancel.tpl');
        break;
    case  "hvnotused":
        Tpl_Smarty::display('Web_Mobile_Static::wechat.v3.0/booking_hvnotused.tpl');
        break;
    case  "hvused":
        Tpl_Smarty::display('Web_Mobile_Static::wechat.v3.0/booking_hvused.tpl');
        break;
    case  "index":
        Tpl_Smarty::display('Web_Mobile_Static::wechat.v3.0/booking_index.tpl');
        break;
    case  "tobepay":
        Tpl_Smarty::display('Web_Mobile_Static::wechat.v3.0/booking_tobepay.tpl');
        break;
    case  "adress01":
        Tpl_Smarty::display('Web_Mobile_Static::wechat.v3.0/booking_adress01.tpl');
        break;
    case  "adress1":
        Tpl_Smarty::display('Web_Mobile_Static::wechat.v3.0/booking_adress1.tpl');
        break;
    case  "adress2":
        Tpl_Smarty::display('Web_Mobile_Static::wechat.v3.0/booking_adress2.tpl');
        break;
    case  "adress3":
        Tpl_Smarty::display('Web_Mobile_Static::wechat.v3.0/booking_adress3.tpl');
        break;
    case  "adress4":
        Tpl_Smarty::display('Web_Mobile_Static::wechat.v3.0/booking_adress4.tpl');
        break;


    case  "bj":
        Tpl_Smarty::display('Web_Mobile_Static::demand_tender.v1.0/demand_tender_vendorBid.php.tpl');
        break;
    case  "dtc":
        Tpl_Smarty::display('Web_Mobile_Static::demand_tender.v1.0/demand_tender_customer.php.tpl');
        break;
    case  "dtv":
        Tpl_Smarty::display('Web_Mobile_Static::demand_tender.v1.0/demand_tender_vendor.php.tpl');
        break;
}

