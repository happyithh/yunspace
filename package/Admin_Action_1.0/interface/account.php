<?php
/**
 * Created by PhpStorm.
 * User: liushengchun
 * Date: 15/2/4
 * Time: 11:59
 */
switch (Core::$urls['action']) {
    case 'user':
        Admin_Data_Table::quick(Data_Mysql_Table_Account::subTable(), array('account_type' => 1));
        break;
    case 'user_corp':
        Admin_Data_Table::quick(Data_Mysql_Table_Account::subTable(), array('account_type' => 1));
        break;
    case 'vendor':
        Admin_Data_Table::quick(Data_Mysql_Table_Account::subTable(), array('account_type' => 21));
        break;
    case 'reset_password':
       // Admin_Data_Table::quick(Data_Mysql_Table_Account::subTable());
        OA_Account_Manage::resetPassword();
        break;
    case 'account_info':
        OA_Account_List::handle();
        break;
    case 'change_vendor':
        //账户变更供应商
        OA_Account_Change_Vendor::handle();
        break;
    default:
        Func_Header::notFound();
        break;
}