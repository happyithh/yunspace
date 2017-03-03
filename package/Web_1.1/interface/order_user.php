<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/5/15
 * Time: 10:19
 */

Tpl_Smarty::assign('nav_index', 5);
switch (Core::$urls['action']) {
    case 'booking':
        Tpl_Smarty::display('Web_Static','order_user/order_booking.tpl');
        break;

    //微信售票
    case 'boki':
        Tpl_Smarty::display('Web_Mobile_Static','wechat.v2.0/booking_index.tpl');
        break;
    case 'check':
        Tpl_Smarty::display('Web_Mobile_Static','wechat.v2.0/booking_check.tpl');
        break;
    case 'boki_dtl':
        Tpl_Smarty::display('Web_Mobile_Static','wechat.v2.0/booking_details.tpl');
        break;
    case 'choice':
        Tpl_Smarty::display('Web_Mobile_Static','wechat.v2.0/booking_choice.tpl');
        break;
    case 'tobepay':
        Tpl_Smarty::display('Web_Mobile_Static','wechat.v2.0/booking_tobepay.tpl');
        break;
    case 'hvcancel':
        Tpl_Smarty::display('Web_Mobile_Static','wechat.v2.0/booking_hvcancel.tpl');
        break;
    case 'hvnotused':
        Tpl_Smarty::display('Web_Mobile_Static','wechat.v2.0/booking_hvnotused.tpl');
        break;
    case 'hvused':
        Tpl_Smarty::display('Web_Mobile_Static','wechat.v2.0/booking_hvused.tpl');
        break;
    case 'hvcancel':
        Tpl_Smarty::display('Web_Mobile_Static','wechat.v2.0/booking_hvcancel.tpl');
        break;
}
