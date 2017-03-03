<?php

switch (Core::$urls['action']) {
    case  "ready":
        Tpl_Smarty::display('Web_Mobile_Static::grab_order.v2.0/grablist_readyGrab.tpl');
        break;
    case  "hv":
        Tpl_Smarty::display('Web_Mobile_Static::grab_order.v2.0/grablist_hvReceived.tpl');
        break;
    case  "credit":
        Tpl_Smarty::display('Web_Mobile_Static::grab_order.v2.0/grab_credit.tpl');
        break;
    case  "rule":
        Tpl_Smarty::display('Web_Mobile_Static::grab_order.v2.0/grab_credit_rule.tpl');
        break;
    case  "notice":
        Tpl_Smarty::display('Web_Mobile_Static::grab_order.v2.0/notice.tpl');
        break;
    case  "noticeno":
        Tpl_Smarty::display('Web_Mobile_Static::grab_order.v2.0/notice_no.tpl');
        break;
    case  "readydtl":
        Tpl_Smarty::display('Web_Mobile_Static::grab_order.v2.0/grablist_readyGrab_details.tpl');
        break;
    case  "hvdtl1":
        Tpl_Smarty::display('Web_Mobile_Static::grab_order.v2.0/grablist_hvReceived_details1.tpl');
        break;
    case  "hvdtl2":
        Tpl_Smarty::display('Web_Mobile_Static::grab_order.v2.0/grablist_hvReceived_details2.tpl');
        break;
    case  "norecords":
        Tpl_Smarty::display('Web_Mobile_Static::grab_order.v2.0/grablist_hvReceived_norecords.tpl');
        break;
    case  "needs":
        Tpl_Smarty::display('Web_Mobile_Static::grab_order.v2.0/activity-needs.tpl');
        break;
    case  "creat":
        Tpl_Smarty::display('Web_Mobile_Static::grab_order.v2.0/grab_creat.tpl');
        break;
    case  "perfect":
        Tpl_Smarty::display('Web_Mobile_Static::grab_order.v2.0/perfect_info.tpl');
        break;

}