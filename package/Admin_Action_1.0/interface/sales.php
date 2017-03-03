<?php
/**
 * Created by PhpStorm.
 * User: liushengchun
 * Date: 15/2/4
 * Time: 11:59
 */
switch (Core::$urls['action']) {
    //创建需求和联系人
    case 'demand_contact':
        OA_Demand_Create::handle('销售部');
        break;
    // 联系人详情,和添加联系人
    case 'contact_detail':
        unset($_REQUEST['is_urgent']);
        OA_Contact_Detail::handleGlobal(1);
        break;
    case 'contact_iska_urgent_list':
        //KA紧急联系人，24小时内
        OA_Contact_List::handle(1, 0, 1, 1);
        break;
    case 'contact_notka_urgent_list':
        //标准紧急联系人，24小时内
        OA_Contact_List::handle(1, 0, 1, 2);
        break;
    case 'contact_urgent_list':
        //紧急联系人，24小时内
        OA_Contact_List::handle(1, 0, 1);
        break;
    // 联系人库
    case 'contact_list':
        OA_Contact_List::handle(1, 0);
        break;
    // 我的联系人
    case 'my_contact_list':
        OA_Contact_List::handle(1, 1);
        break;
    // 部门联系人
    case 'department_contact_list':
        OA_Contact_List::handle(1, 2);
        break;
    //我的需求列表
    case 'my_demand_list':
        OA_Demand_Lists::handle('销售部', '', '', 1);
        break;
    case 'team_demand_list':
        //组需求管理
        OA_Demand_List::handle('销售部', 1);
        break;
    case 'department_demand_list':
        //销售部门需求管理
        Core::log('demand_list_log_by_adu', '部门需求管理', $_SESSION['administrator']['fullname'], Func_Input::ip(), $_COOKIE['un_a']);
        OA_Demand_List::handle('销售部', 0);
        break;
    // 组联系人
    case 'team_contact_list':
        OA_Contact_List::handle(1, 3);
        break;
    // 我的客户
    case 'list':
        OA_My_Customer_Account::handle(1, 1);
        break;
    //部门管理
    case 'department_manage':
        OA_Department_Manage::handle('销售部');
        break;
    //部门统计
    case 'department_sum':
        OA_Department_Count::handle(1);
//        Tpl_Smarty::display('OA', 'department_salesum.tpl');
        break;
    case 'team_demand_list_new':
//        OA_Demand_Lists::handle('销售部', 1, 0);
        Core::log('demand_list_log_by_adu', '组需求管理', $_SESSION['administrator']['fullname'], Func_Input::ip(), $_COOKIE['un_a']);
        OA_Demand_Lists_All::handle('销售部', 1, 0);
        break;
    case 'department_demand_list_new':
        Core::log('demand_list_log_by_adu', '城市需求管理', $_SESSION['administrator']['fullname'], Func_Input::ip(), $_COOKIE['un_a']);
        OA_Demand_Lists_All::handle('销售部', 0, 0);
        break;
//    case 'department_demand_list_all':
//        Core::log('demand_list_log_by_adu','所有需求管理',$_SESSION['administrator']['fullname'],Func_Input::ip(),$_COOKIE['un_a']);
//        OA_Demand_Lists::handle('销售部', 0, 1);
//        break;
    case 'department_demand_lists_all':
        Core::log('demand_list_log_by_adu', '所有需求管理', $_SESSION['administrator']['fullname'], Func_Input::ip(), $_COOKIE['un_a']);
        OA_Demand_Lists_All::handle('销售部', 0, 1);
        break;
    case 'department_demand_all':
        // $_REQUEST['action'] ='demand_all';
        OA_Demand_Lists::handle('销售部', 0, 1, '', 1);
        break;
    case 'department_demand_city_partner':
        // $_REQUEST['action'] ='demand_all';
        OA_Demand_Lists_All::handle('销售部', 0, 1, '', 1, 1);
        break;
    case 'demand_statistics':
        OA_Demand_Statistics::demandStatistics();
        break;
    case 'demand_record':
        OA_Demand_Record::handle(0, 1);
        break;
    case 'contact_record':
        OA_Contact_Record::handle();
        break;
    case 'order_statistics':
        OA_Order_Statistics::handle();
        break;
    case 'demand_export':
        OA_Demand_Export::handle();
        break;
    default:
        Func_Header::notFound();
        break;
}