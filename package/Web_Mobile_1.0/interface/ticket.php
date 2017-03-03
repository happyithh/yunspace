<?php
/**
 * Created by PhpStorm.
 * User: pzl
 * Date: 2015/6/16
 * Time: 9:58
 */
switch(Core::$urls['action']){
    case  "createorder":
        Web_Weixin_Ticket::createOrder();
        break;
    case  "payorder":
        Web_Weixin_Ticket::payOrder();
        break;
    case  "orderlist":
        Web_Weixin_Ticket::orderList();
        break;
    case  "payorderlist":
        Web_Weixin_Ticket::payOrderList();
        break;
    case  "ticketlist":
        Web_Weixin_Ticket::ticketList();
        break;
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
        Web_Weixin_Ticket::handle();
        break;
}

