<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/5/7
 * Time: 17:36
 */
$action = empty(Core::$urls['action'])?'winchance_list':Core::$urls['action'];
switch($action)
{
    case 'winchance_list':
        OA_Winchance_list::handle();
        break;
    case 'winchance_statistical':
        OA_Winchance_Ip_Statistical::handle();
        break;
    case 'brand_manage':
        OA_Winchance_Brand_Manage::handle();
        break;
    case 'fields_manage':
        OA_Winchance_Fields_Manage::handle();
        break;
    case 'winchance_check':
        OA_Winchance_Check::handle();
        break;
}