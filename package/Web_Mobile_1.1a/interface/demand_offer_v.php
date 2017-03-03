<?php
switch (Core::$urls['action']) {
    case  "cust":
        Tpl_Smarty::display('Web_Mobile_Static::demand_offer.v3.0/demand_offer_customer.tpl');
        break;
    case  "cust1":
        Tpl_Smarty::display('Web_Mobile_Static::demand_offer.v3.0/demand_offer_customer1.tpl');
        break;
    case  "cust2":
        Tpl_Smarty::display('Web_Mobile_Static::demand_offer.v3.0/demand_offer_customer2.tpl');
        break;
    case  "cust3":
        Tpl_Smarty::display('Web_Mobile_Static::demand_offer.v3.0/demand_offer_customer3.tpl');
        break;
    case  "cust4":
        Tpl_Smarty::display('Web_Mobile_Static::demand_offer.v3.0/demand_offer_customer4.tpl');
        break;
    case  "custphp":
        Tpl_Smarty::display('Web_Mobile_Static::demand_offer.v3.0/demand_offer_customer.php.tpl');
        break;
    case  "vendor":
        Tpl_Smarty::display('Web_Mobile_Static::demand_offer.v3.0/demand_offer_vendor.tpl');
        break;
    case  "vendorhv":
        Tpl_Smarty::display('Web_Mobile_Static::demand_offer.v3.0/demand_offer_vendorhv.tpl');
        break;
    case  "bid":
        Tpl_Smarty::display('Web_Mobile_Static::demand_offer.v3.0/demand_offer_vendorBid.php.tpl');
        break;
    case  "bid1":
        Tpl_Smarty::display('Web_Mobile_Static::demand_offer.v3.0/demand_offer_bid.tpl');
        break;
    case  "my":
        Tpl_Smarty::display('Web_Mobile_Static::demand_offer.v3.0/demand_offer_my.tpl');
        break;
    case  "edit":
        Tpl_Smarty::display('Web_Mobile_Static::demand_offer.v3.0/demand_offer_removeMk.tpl');
        break;
    case  "inq":
        Tpl_Smarty::display('Web_Mobile_Static::demand_offer_wechat.v3.0/wechat_inquiry.tpl');
        break;
    case  "unable":
        Tpl_Smarty::display('Web_Mobile_Static::demand_offer_wechat.v3.0/wechat_inquiry_unable.tpl');
        break;
    case  "inqbns":
        Tpl_Smarty::display('Web_Mobile_Static::demand_offer_wechat.v3.0/wechat_inquiry_business.tpl');
        break;
    case  "inqhv":
        Tpl_Smarty::display('Web_Mobile_Static::demand_offer_wechat.v3.0/wechat_inquiry_business_hv.tpl');
        break;
    case  "inqhvlist":
        Tpl_Smarty::display('Web_Mobile_Static::demand_offer_wechat.v3.0/wechat_inquiry_business_hv_list.tpl');
        break;
    case  "wait":
        Tpl_Smarty::display('Web_Mobile_Static::demand_offer_wechat.v3.0/wechat_inquiry_wait.tpl');
        break;
}