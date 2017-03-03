<?php
/**
 * Created by PhpStorm.
 * User: liushengchun
 * Date: 15/2/4
 * Time: 11:59
 */
switch (Core::$urls['action']) {
    case 'manage':
        OA_Weixin_Ticket_Manage::handle();
        break;
    case 'orderManage':
        OA_Weixin_Ticket_Order_Manage::handle();
        break;
    default:
        Func_Header::notFound();
        break;
}