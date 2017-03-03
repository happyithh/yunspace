<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/4/7
 * Time: 17:25
 * 文创需求/项目管理
 *
 */

switch(Core::$urls['action'])
{
    case 'site_list':
        OA_Winchance_Site_list::handle();
        break;
    case 'site_add':
        OA_Winchance_Site_Add::handle();
        break;
    case 'site_statistical':
        OA_Winchance_Site_Statistical::handle();
        break;
}