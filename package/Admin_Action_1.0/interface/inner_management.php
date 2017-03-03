<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 15-4-14
 * Time: 下午6:33
 * yl
 * 全局标签
 */
switch (Core::$urls['action']) {
//    case 'market_member':
//        OA_Inner_Member_Management::handle('市场部');
//        break;
//    case 'sales_member':
//        OA_Inner_Member_Management::handle('销售部');
//        break;
    case 'admin_management':
        OA_Admin_Management::handle();
        break;
    case 'personal':
        Account_Administrator::handle();
        break;
    case 'sign_in':
        OA_Sign_In_Management::handle();
        break;
    case 'sign_in_check':
        OA_Sign_In_Check_List::handle();
        break;
    default:
        Func_Header::notFound();
        break;
}
