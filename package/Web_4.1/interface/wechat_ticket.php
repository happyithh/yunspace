<?php
/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2016/3/30
 * Time: 13:38
 */
$is_login = Web_Wechat_Login::isLogin();
if(!$is_login){
    Func_Header::to('你还没有登录，请先登录','/');
}
$action = isset($_REQUEST['action']) ? $_REQUEST['action']:'event';
switch($action){
    case 'event':
        Web_Wechat_Ticket::eventList();
        break;
    case 'order':
        Web_Wechat_Ticket::orderList();
        break;
    case 'detail':
        Web_Wechat_Ticket::orderDetail();
        break;
    case 'check':

        break;
    default:
        Func_Header::back('非法操作');
        break;
}