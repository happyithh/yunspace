<?php

/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 15-5-8
 * Time: 上午9:46
 */
class OA_Element_Vendor_List
{
    static function handle()
    {
        if (!empty($_REQUEST['action']) && $_REQUEST['action'] == 'detail') {
            self::vendorDetail();
        } elseif (!empty($_REQUEST['action']) && $_REQUEST['action'] == 'del_vendor') {
            $status = -2;
            self::handleVendorStatus($status);
        } elseif (!empty($_REQUEST['action']) && $_REQUEST['action'] == 'recover_vendor') {
            $status = 1;
            self::handleVendorStatus($status);
        } else {
            self::vendorList();
        }

    }
    /*
     * 供应商列表页
     */
    static function vendorList()
    {
        $conditions = array();
        $vendor = array();
        //筛选条件
        if (!empty($_REQUEST['search'])) {
            $search = Func_Input::filter(array(
                'title' => 'string',
                'search_city' => 'string',
                'end_time' => 'string',
                'start_time' => 'string',
                'search_status'=>'int'
            ), $_REQUEST['search']);
            //名称或ID筛选
            if (!empty($search['title'])) {
                if (is_numeric($_REQUEST['search']['title'])) {
                    $conditions['id'] = $search['title'];
                } else {
                    $conditions['vendor_name'] = $search['title'];
                }
            }
            //城市
            if (!empty($search['search_city'])) {
                $conditions['attr_index']['城市'] = '+' . $search['search_city'];
            }
            //更新时间筛选
            if (!empty($search['start_time']) && !empty($search['end_time'])) {
                if (strtotime($search['start_time']) > strtotime($search['end_time'])) {
                    Func_Header::back('请正确选择时间范围！！');
                } else {
                    $conditions['{table}.create_time between ? and ?'] = array(strtotime($search['start_time']), strtotime($search['end_time']));
                }
            } elseif (!empty($search['start_time']) && empty($search['end_time'])) {
                $conditions['{table}.create_time > ?'] = strtotime($search['start_time']);
            } elseif (empty($search['start_time']) && !empty($search['end_time'])) {
                $conditions['{table}.create_time < ?'] = strtotime($search['end_time']);
            }
            //签约状态
            if(!empty($search['search_status'])){
                $conditions['attr_index']['签约状态']=$search['search_status'];
            }
        }
        $handle_type = empty($_REQUEST['handle_type']) ? 'online' : $_REQUEST['handle_type'];
        switch ($handle_type) {
            case "reject":
                $conditions['{table}_update.status = ? '] = 3;
                break;
            case "waiting":
                $conditions['{table}_update.status = ? '] = 2;
                break;
            case "online":
                $conditions['{table}.status = ? '] = 1;
                break;
            case "offline":
                $conditions['{table}.status = ? '] = 0;
                break;
            case "recycle":
                $conditions['{table}_update.status = ? '] = -2;
                break;
            case "all":
                break;
        }
//        //-----------------------查询出所有供应商，在attr_index里增加【签约状态】更新开始-----------------------------//
//        //查询出所有供应商，在attr_index，attr里增加【签约状态】，为查询时 查询签约条件使用
//        //1.vendor_info表
//        $vendor_status = Data_Mysql_Table_Vendor_Info::select('id,attr,attr_index,vendor_remarks','', '',999999);
//        if(!empty($vendor_status)){
//            foreach($vendor_status as $k=>$v){
//                //vendor_info 表
//                $vendor_status[$k]['attr_index'] = json_decode($vendor_status[$k]['attr_index'], 1);
//                $vendor_status[$k]['attr'] = json_decode($vendor_status[$k]['attr'], 1);
//                $vendor_status[$k]['vendor_remarks'] = json_decode($vendor_status[$k]['vendor_remarks'],1);
//                if ($vendor_status[$k]['vendor_remarks']['签约状态'] == 1) {
//                    $vendor_status[$k]['attr_index']['签约状态'] = 1;
//                    $vendor_status[$k]['attr']['签约状态'] = 1;
//                } elseif($vendor_status[$k]['vendor_remarks']['签约状态'] == 2) {
//                    $vendor_status[$k]['attr_index']['签约状态'] = 2;
//                    $vendor_status[$k]['attr']['签约状态'] = 2;
//                }else{
//
//                    $vendor_status[$k]['attr_index']['签约状态'] = 3;
//                    $vendor_status[$k]['attr']['签约状态'] = 3;
//                }
//                $data['attr_index'] = $vendor_status[$k]['attr_index'];
//                $data['attr'] = $vendor_status[$k]['attr'];
//                Data_Mysql_Table_Vendor_Info::update(array('id' => $vendor_status[$k]['id']), $data);
//            }
//        }
//
//        //2.vendor_info_update表
//        $vendor_update_status = Data_Mysql_Table_Vendor_Info::subTable('_update')->select('id,attr,attr_index,vendor_remarks','', '',999999);
//        if(!empty($vendor_update_status)){
//            foreach($vendor_update_status as $k=>$v){
//                //vendor_info 表
//                $vendor_update_status[$k]['attr_index'] = json_decode($vendor_update_status[$k]['attr_index'], 1);
//                $vendor_update_status[$k]['attr'] = json_decode($vendor_update_status[$k]['attr'], 1);
//                $vendor_update_status[$k]['vendor_remarks'] = json_decode($vendor_update_status[$k]['vendor_remarks'],1);
//                if ($vendor_update_status[$k]['vendor_remarks']['签约状态'] == 1) {
//                    $vendor_update_status[$k]['attr_index']['签约状态'] = 1;
//                    $vendor_update_status[$k]['attr']['签约状态'] = 1;
//                } elseif($vendor_update_status[$k]['vendor_remarks']['签约状态'] == 2) {
//                    $vendor_update_status[$k]['attr_index']['签约状态'] = 2;
//                    $vendor_update_status[$k]['attr']['签约状态'] = 2;
//                }else{
//
//                    $vendor_update_status[$k]['attr_index']['签约状态'] = 3;
//                    $vendor_update_status[$k]['attr']['签约状态'] = 3;
//                }
//                $data_update['attr_index'] = $vendor_update_status[$k]['attr_index'];
//                $data_update['attr'] = $vendor_update_status[$k]['attr'];
//                Data_Mysql_Table_Vendor_Info::update(array('id' => $vendor_update_status[$k]['id']), $data_update);
//            }
//        }
//        //-----------------------更新结束----------------------------//
        $vendor = Data_Mysql_Table_Vendor_Info::page(0, 20, '{table}.id,{table}.vendor_name,{table}.addr,{table}.categories_id,{table}.attr,{table}.count_product,{table}.create_time,{table}.update_time,{table}.status,{table}_update.status as update_status,{table}_update.create_by_quick,{table}_update.admin_id', $conditions, 'ORDER BY {table}.vendor_name ASC', '{table} LEFT JOIN {table}_update ON {table}.id={table}_update.id');
        if (!empty($vendor['rows'])) {
            foreach ($vendor['rows'] as $key => $value) {
                $vendor['rows'][$key]['attr'] = json_decode($value['attr'], 1);
            }
        }
        if (!empty($_REQUEST['search'])) {
            $sea_url = '&search[title]='.$search['title'].'&search[search_city]='.$search['search_city'].'&search[end_time]='.$search['end_time'].'&search[start_time]='.$search['start_time'].'&search[search_status]='.$search['search_status'];
            Tpl_Smarty::assign('urls', $sea_url);
        }
        //获取管理员列表
        $admin_condition['{table}.status > ?']=0;
        $admin_list=Api_Administrator_List::getAdminList($admin_condition,1);
        Tpl_Smarty::assign('_category', Data_Mysql_Table_Product_Category::getInfoCache());
        Tpl_Smarty::assign('_data', $vendor);
        Tpl_Smarty::assign('_adminInfo', $admin_list);
        Tpl_Smarty::assign('handle_type', $handle_type);
        Tpl_Smarty::assign('is_admin', Admin_Authority::checkUrl('marketing/contact_urgent_list', 0));
        Tpl_Smarty::display('OA_Static', 'elements/element_vendor_list.tpl');
    }

    /*
     * 供应商详情页
     */
    static function vendorDetail()
    {
        if (empty($_REQUEST['id'])) {
            Func_Header::back('参数错误！！');
        }
        $vendor_rs=Api_Vendor_Info::getVendorInfo('update',$_REQUEST['id']);
        if(empty($vendor_rs['status'])){
            Func_Header::back($vendor_rs['msg']);
        }
        $vendorInfo=$vendor_rs['data'];
        //获取该供应商下已完成的订单信息
        $order = Api_Order_Normal_Api::getOrder('vendor',$_REQUEST['id']);
        Tpl_Smarty::assign('order', $order);
        Tpl_Smarty::assign('data', $vendorInfo);
        Tpl_Smarty::assign('_category', Data_Mysql_Table_Product_Category::getInfoCache());
        Tpl_Smarty::assign('is_admin', Admin_Authority::checkUrl('marketing/contact_urgent_list', 0));
        Tpl_Smarty::assign('is_sales', Admin_Authority::checkUrl('sales/contact_list', 0));
        Tpl_Smarty::display('OA_Static', 'elements/element_vendor_detail.tpl');
    }

    /*
     *删除供应商
     */
    static function handleVendorStatus($status = 1)
    {
        if (empty($_REQUEST['id'])) {
            Func_Header::back('参数错误！！');
        }
        if (!Admin_Authority::checkUrl('marketing/contact_urgent_list', 0)) {
            Func_Header::back('没有权限！！');
        }
        $request = Func_Input::filter(array(
            'id' => 'int',
        ));
        $_REQUEST['vendor_id']=$request['id'];
        $_REQUEST['status']=$status;
        $rs=Api_Vendor_Handle::handleChangeStatus();
        if(empty($rs['status'])){
            Func_Header::back($rs['msg']);
        }else{
            Func_Header::to(' '.$rs['msg'], Core::$urls['path'] . '?handle_type=' . $_REQUEST['handle_type']);
        }
    }
}