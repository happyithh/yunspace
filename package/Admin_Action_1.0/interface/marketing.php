<?php
/**
 * Created by PhpStorm.
 * User: liushengchun
 * Date: 15/4/2
 * Time: 19:54
 */
switch (Core::$urls['action']) {
    //佣金订单
    case 'commission_order':
        OA_Commission_Order::handle();
        break;
    // 联系人详情,和添加联系人
    case 'contact_detail':
        OA_Contact_Detail::handleGlobal(21, 1);
        break;
    case 'contact_urgent_list':
        //紧急联系人，24小时内
        OA_Contact_List::handle(21, 0, 1);
        break;
    // 联系人库
    case 'contact_list':
        //联系人，非24小时内
        OA_Contact_List::handle(21, 0);
        break;
    // 我的联系人
    case 'my_contact_list':
        OA_Contact_List::handle(21, 1);
        break;
    // 部门联系人
    case 'department_contact_list':
        OA_Contact_List::handle(21, 2);
        break;
    // 组供应商
    case 'team_vendor':
        OA_Department_Vendor::handle(1, 1);
        break;
    // 组供应商审核
    case 'team_vendor_check':
        OA_Department_Vendor_List::handle(1, 1, 1);
        break;
    // 我的供应商
    case 'my_vendor_list':
        OA_Department_Vendor::handle(2, 0);
        break;
    // 部门供应商
    case 'department_vendor':
        OA_Department_Vendor::handle(1, 0);
        break;
    // 所有供应商
    case 'all_vendor_list':
        OA_Department_Vendor::handle(0, 0);
        break;
    // 所有供应商审核
    case 'all_vendor':
        OA_Department_Vendor_List::handle(0, 0, 1);
        break;
    // 部门供应商审核
    case 'department_vendor_check':
        OA_Department_Vendor_List::handle(1, 0, 1);
        break;
    //组联系人
    case 'team_contact_list':
        OA_Contact_List::handle(21, 3);
        break;
    case 'department_manage':
        //部门管理
        OA_Department_Manage::handle('市场部');
        break;
    case 'account_check':
        //账户信息更改审核
        OA_Account_Check::handle();
        break;
    case 'vendor_change_account':
        //供应商更改绑定账户
        OA_Vendor_Change_Account_Check::handle();
        break;
    case 'vendor_account_identity':
        //供应商实名认证
        OA_Account_Identity::handle(21);
        break;
    case 'broker_account_identity':
        //经纪人实名认证
        OA_Account_Broker_Identity::handle();
        break;
    case 'audit/vendor_info':
        //供应商信息审核
        OA_Audit_Vendor_Info::handle();
        break;
    case 'audit/product_info':
        //服务信息审核
        OA_Audit_Product_Info::handle();
        break;
    case 'audit/case_info':
        //案例信息审核
        OA_Audit_Case_Info::handle();
        break;
    //我的供应商账户
    case 'list':
        OA_My_Customer_Account::handle(21, 1);
//        if (!empty($_REQUEST['category_attr'])) {
//            Core::output('');
//            $request = Func_Input::filter(array('category_id' => 'int', 'jsoncallback' => 'string'));
//            $json = json_encode(Data_Mysql_Table_Product_Category::getCategoryAttr($request['category_id']));
//            echo "{$request['jsoncallback']}({$json})";
//        } else if (!empty($_REQUEST['vendor_auto_complete'])) {
//            Admin_Data_Table_Product_Info::handleVendorAutoComplete();
//        } else {
//            OA_My_Customer_Account::handle(21, 1);
//        }
        break;
    //快速创建产品
    case 'quick_create_product':
        OA_Quick_Create_Product::handle(21);
        break;
    //我的需求列表
    case 'my_demand_list':
        OA_My_Demand_List::handle(21);
        break;
    case 'department_sum':
        OA_Department_Count::handle(21);
        break;
    case 'audit/my_vendor':
        Tpl_Smarty::display("Admin_Action", 'mkt_my_vendor.tpl');
        break;
    case 'audit/my_vendor_edit':
        Tpl_Smarty::display("Admin_Action", 'mkt_my_vendor_edit.tpl');
        break;
    case 'help-center':
        OA_Help_Center::handle();
        break;
    //供应商数据批量导入处理
    case 'vendor_candidate':
        OA_Vendor_Candidate::handle();
        break;

}