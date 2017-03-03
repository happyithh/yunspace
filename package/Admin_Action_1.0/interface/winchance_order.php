<?php
/*
 * Created by PhpStorm
 * User: Yangchenglin
 * Date: 2016/5/10
 * Time: 14:50
 */
$action = empty(Core::$urls['action'])?'winchance_list':Core::$urls['action'];
switch($action)
{
    case 'order_list':
        OA_Winchance_Order::handle();
        break;
    case 'order_statistical':
        OA_Winchance_Order_Statistical::handle();
        break;
}