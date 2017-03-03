<?php
/**
 * Created by PhpStorm.
 * User: liushengchun
 * Date: 15/4/2
 * Time: 19:54
 */
switch (Core::$urls['action']) {
    // 超时订单
    case 'overtime_order':
        OA_Overtime_Order::handle();
        break;
    // 需求管理
    case 'demand_operate':
        OA_Demand_Operate::handle();
        break;
    // 需求竞标---管理
    case 'demand_tender':
        OA_Demand_Tender::handle();
        break;
    //报价统计
    case 'demand_tender_statistics':
        OA_Demand_Tender_Statistics::demandTenderStatistics();
        break;
    //创建需求400电话
    case 'demand_contact':
        OA_Demand_Create::handle('运营部');
        break;
    // 创建联系人
    case 'contact_detail':
        OA_Contact_Detail::handle(1);
        break;
    case 'vendor_join':
        OA_Vendor_Join::handle();
        break;
//    case 'contact_urgent_list':
//        //紧急联系人，24小时内
//        OA_Contact_List::handle(0,0,1);
//        break;
    // 联系人库
    case 'contact_list':
        //联系人，非24小时内
        OA_Contact_List::handle(0, 0, 2);
        break;
//    case 'department_manage':
//        //部门管理
//        OA_Department_Manage::handle('市场部');
        break;
    case 'buyer_account_identity':
        //用户实名认证
        OA_Account_Identity::handle(1);
        break;
    case 'personal_account_identity':
        //个人实名认证
        OA_Account_Personal_Identity_Manage::handle();
        break;
    case 'company_account_identity':
        //公司实名认证
        OA_Account_Company_Identity_Manage::handle();
        break;
    case 'sms_notice_config':
        OA_Sms_Notice_Config::handle();
        break;
    case 'sms_notice_set':
        OA_Sms_Notice_Set::handle();
        break;
    case 'year_vote';
        OA_Weixin_Year_Vote::handle();
        break;
    case 'raiders_list':
        OA_Raiders_Info::handle();
        break;
    case 'raiders_check_list':
        OA_Raiders_Check_List::handle();
        break;
    //资讯数据采集
    case 'raiders_candidate':
        OA_Raiders_Candidate::handle();
        break;
    case 'comment_list':
        OA_Comment_Info::handle();
        break;
    case 'form_manage':
        OA_Form_Management::handle();
        break;
    //文创项目
    case 'winchance':
        OA_WinChance::handle();
        break;
    case 'broke_reward':
        OA_Broke_Reward::handle();
        break;
    case 'pa_management':
        OA_Pa_Management::handle();
        break;
    case 'demand_offer_count':
        OA_Demand_Offer_Count::handle();
        break;
    case 'cooperation_brand':
        OA_Cooperation_Brand_Management::handle();
        break;
    case 'form_retail':
        //零售短租单独管理入口
        OA_Retail_Manage::handle(16);
        break;
    case 'city_partner':
        //城市合伙人单独管理入口
        OA_Retail_Manage::handle(14);
        break;
    case 'adm_manage':
        //零售短租ADM参展申请
        OA_Cooperation_Brand_Management::handle(2);
        break;
    default:
        Func_Header::notFound();
        break;

}