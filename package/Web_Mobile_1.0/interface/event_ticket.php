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
    default:
        Web_Mobile_WeChat_Ticket::handle();
        break;
}

