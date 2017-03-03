<?php

/**
 * Created by PhpStorm.
 * User: yl
 * Date: 15-4-20
 * Time: 下午4:44
 * 供应商修改页面
 */
class OA_My_Customer_Handle_Vendor
{
    static function handle(){
        if (!empty($_REQUEST['is_submit_vendor'])) {
            self::handleEdit();
        } elseif (!empty($_REQUEST['reset_vendor'])) {
            self::handleResetVendor();
        } else {
            self::handleShow();
        }
        Tpl_Smarty::assign('_vendor_attr', Data_Config_Vendor_Attr::all());
        Tpl_Smarty::assign('_categories', Data_Mysql_Table_Product_Category::getTreeCache());
    }
    /*
     *展示供应商信息
     */
    static function handleShow()
    {
        if (!empty($_REQUEST['vendor_id'])) {
            //获取供应商下已完成的订单信息
            $complete_order = 0;
            $orderInfo = Data_Mysql_Table_Order_Info::page(0, 0, '{prefix}account.username,{table}.order_no,{table}.order_complete,{table}.product_id,{table}.vendor_id', array('vendor_id' => $_REQUEST['vendor_id']), 'ORDER BY {table}.update_time desc', '{table} LEFT JOIN {prefix}account ON {table}.buyer_account_id = {prefix}account.id');
            if (!empty($orderInfo['rows'])) {
                foreach ($orderInfo['rows'] as $key => $value) {
                    $orderInfo['rows'][$key]['order_complete'] = json_decode($value['order_complete'], 1);
                }
                $total_order = $orderInfo['page']['dt'];//总订单量
                Tpl_Smarty::assign('total_order', $total_order);
                $complete = Data_Mysql_Table_Order_Info::select('count(*) as c', array('vendor_id' => $_REQUEST['vendor_id'], 'order_status' => 90));
                $complete_order = 0;
                if (!empty($complete)) {
                    $complete_order = $complete[0]['c'];//已完成订单量
                }
            }
            Tpl_Smarty::assign('complete_order', $complete_order);
            Tpl_Smarty::assign('orderInfo', $orderInfo);
        }
    }

    /*
     *添加或修改供应商信息
     */
    static function handleEdit()
    {
        $request = Func_Input::filter(array(
            'vendor_id' => 'int',
            'data' => 'array',
        ));
        $vendor_rs_submit=Api_Vendor_Info::handleVendorSubmit($request['data'],$request['vendor_id']);
        if (empty($vendor_rs_submit["status"])) {
            Func_Header::back($vendor_rs_submit['msg']);
        }else{
            Func_Header::to(' '.$vendor_rs_submit['msg'], Core::$urls['path'] . '?action=detail&tab=' . $_REQUEST['tab'] . '&vendor_id=' . $request['vendor_id']);
        }
    }
    /*
     *重置供应商信息
     */
    static function handleResetVendor(){
        $request = Func_Input::filter(array(
            'vendor_id' => 'int',
            'action' => 'string',
            'tab' => 'string',
            'reset_vendor' => 'int',
        ));
        if (empty($request['vendor_id'])) {
            Func_Header::back('参数错误！！');
        }

        $vendor = Data_Mysql_Table_Vendor_Info::select('id, vendor_name, categories_id,addr,attr,attr_index,vendor_remarks,logo,media,base_info,vendor_account_id,status,des',$request['vendor_id']);
        if (empty($vendor[0])) {
            Func_Header::back('供应商不存在！！');
        }
        $vendorInfo = $vendor[0];
        if (!empty($vendorInfo['vendor_remarks'])) {
            $vendorInfo['vendor_remarks'] = json_decode($vendorInfo['vendor_remarks'], 1);
        }
        if (!empty($vendorInfo['base_info'])) {
            $vendorInfo['base_info'] = json_decode($vendorInfo['base_info'], 1);
        }
        if (!empty($vendorInfo['attr'])) {
            $vendorInfo['attr'] = json_decode($vendorInfo['attr'], 1);
        }
        if (!empty($vendorInfo['media'])) {
            $vendorInfo['media'] = json_decode($vendorInfo['media'], 1);
        }
        $rs=Data_Mysql_Table_Vendor_Info::subTable("_update")->update($vendorInfo);
        if(!empty($rs[0])){
            Func_Header::to(" 重置成功！！",Core::$urls['path'] . '?action=detail&tab=' . $request['tab'] .  '&vendor_id=' . $request['vendor_id']);
        }else{
            Func_Header::back('操作失败,请重试！！');
        }
    }
}