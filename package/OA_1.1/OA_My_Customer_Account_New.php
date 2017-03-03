<?php

/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 15-3-31
 * Time: 下午2:07
 */
class OA_My_Customer_Account_New
{
    static function handle()
    {
        //判断权限
        self::checkAdminAuth();

        //获取供应商信息
        if(empty($_REQUEST['vendor_id'])){
            Func_Header::back('参数缺失！');
        }
        $vendor_rs=Api_Vendor_Info::getVendorInfo("update",$_REQUEST['vendor_id']);
        if(empty($vendor_rs['status'])){
            Func_Header::back($vendor_rs['msg']);
        }
        Tpl_Smarty::assign('vendorInfo',$vendor_rs["data"]);
        $tab = empty($_REQUEST['tab']) ? 'vendor' : $_REQUEST['tab'];
        switch ($tab) {
            case "vendor":
                OA_My_Customer_Handle_Vendor::handle();
                Tpl_Smarty::assign('_data',$vendor_rs["data"]);
                break;
            case "info":
                $_REQUEST['account_id']=$vendor_rs["data"]['vendor_account_id'];
                if(!empty($_REQUEST['account_id'])){
                    OA_My_Customer_Handle_Identity::handle();
                }
                break;
            case "product":
                OA_My_Customer_Handle_Product::handle();
                break;
            case "schedule":
                OA_My_Customer_Handle_Product_Schedule::handle();
                break;
            case "set":
                OA_My_Customer_Handle_Product_Set::handle();
                break;
            case "change_bind_account":
                OA_My_Customer_Handle_Account::handleChangeAccount();
                break;
            case "update_account_info":
                OA_My_Customer_Handle_Account::handleUpdateVendorAccount();
                break;
            case "unbind_account":
                OA_My_Customer_Handle_Account::handleUnbindAccount();
                break;

        }
        Tpl_Smarty::assign('tab',$tab);
        Tpl_Smarty::display('OA_Static', 'customer_account_new/detail.tpl');
    }

    //判断权限
    static function checkAdminAuth(){
        $r=Data_Mysql_Table_Vendor_Info::subTable('_update')->select("id,vendor_name",array('id'=>$_REQUEST['vendor_id'],'admin_id'=>$_SESSION['administrator']['id']));
        $is_admin=Admin_Authority::checkUrl('operation_new/all_vendor_new', 0);
        if(empty($r[0]) && !$is_admin){
            Func_Header::back("No Permission!");
        }
    }

}