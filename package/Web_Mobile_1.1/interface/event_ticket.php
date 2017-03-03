<?php
/**
 * Created by PhpStorm.
 * User: pzl
 * Date: 2015/6/16
 * Time: 9:58
 */
switch(Core::$urls['action']){
    case "event_list":
        Web_Mobile_WeChat_Ticket::handle();
        break;
    case "event_info":
        Web_Mobile_WeChat_Ticket::eventInfo();
        break;
    case "ticket_list":
        Web_Mobile_WeChat_Ticket::eventTicketList();
        break;
    case "create_order":
        Web_Mobile_WeChat_Ticket::createOrder();
        break;
    case "order_list":
//        Tpl_Smarty::display("Web_Mobile_Static::wechat.v3.1/booking_check1.0.tpl");
        Web_Mobile_WeChat_Ticket::orderList();
        break;
    case "cancel_order":
        Web_Mobile_WeChat_Ticket::cancelOrder();
        break;
    case "pay_order_list":
        Web_Mobile_WeChat_Ticket::payOrderList();
        break;
    case "order_info":
        Web_Mobile_WeChat_Ticket::orderInfo();
        break;
//    case  "createorder":
//        Web_Weixin_Ticket::createOrder();
//        break;
    case  "payorder":
        Web_Mobile_WeChat_Ticket::payOrder();
        break;
//    case  "orderlist":
//        Web_Weixin_Ticket::orderList();
//        break;
//    case  "payorderlist":
//        Web_Weixin_Ticket::payOrderList();
//        break;
//    case  "ticketlist":
//        Web_Weixin_Ticket::ticketList();
//        break;
    case  "ticketcode":
        Web_Weixin_Ticket::ticketQrCode();
        break;
    case  "ticketinfo":
        Web_Weixin_Ticket::ticketInfo();
        break;
    case  "checkticket":
        Web_Weixin_Check_Ticket::handle();
        break;
    case  "sendmessage":
        Web_Weixin_Ticket::sendOrderMessage();
        break;
    case "create_address":
        Web_Mobile_WeChat_Ticket::createTicketAddress();
        break;
    case "submit_address":
        Web_Mobile_WeChat_Ticket::submitTicketAddress();
        break;
    case 'manage_address':
        Web_Mobile_WeChat_Ticket::manageTicketAddress();
        break;
    case 'select_address':
        Web_Mobile_WeChat_Ticket::selectTicketAddress();
        break;
    case 'edit_address':
        Web_Mobile_WeChat_Ticket::editTicketAddress();
        break;
    case 'update_address':
        Web_Mobile_WeChat_Ticket::updateAddress();
        break;
    //路跑活动临时
    case 'show_lupao_form':
        Web_Mobile_WeChat_Ticket::showEventForm();
        break;
    case 'submit_lupao_form':
        Web_Mobile_WeChat_Ticket::submitEventForm();
        break;
    default:
        Web_Mobile_WeChat_Ticket::handle();
        break;
}

