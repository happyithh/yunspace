<?php

/**
 * Created by PhpStorm.
 * User: yaoli
 * Date: 2015/9/17
 * Time: 11:00
 *  供应商下的产品和套餐列表
 */
class  Api_Vendor_Get_All_List extends Api
{
    /*
     *获取某个供应商下所有产品列表
     * $param   $id     供应商id
     */
    static function getProductListByVendorId($vendorId,$conditions=array()){
        $categories = Data_Mysql_Table_Product_Category::getInfoCache();
        $conditions['{table}.vendor_id = ?'] = $vendorId;
        $conditions['{table}.status >= ? '] = 0;
        $order = 'ORDER BY {table}.update_time DESC';
        $data = Data_Mysql_Table_Product_Info::subTable('_update')->page(0, 0,
            "{table}.id , {table}.category_id,{table}.create_time,  {table}.product_name ,{table}.refuse_reason, {table}.status as update_status, {table}.counter_view, {table}.update_time, {prefix}product_info.status, {prefix}vendor_info.vendor_name",
            $conditions, $order,
            '{table} LEFT JOIN {prefix}product_info ON {table}.id = {prefix}product_info.id LEFT JOIN {prefix}vendor_info ON {table}.vendor_id = {prefix}vendor_info.id');
        if (!empty($data['rows'])) {
            foreach ($data['rows'] as $k => $v) {
                if (!empty($categories[$v['category_id']][0])) {
                    $data['rows'][$k]['category_name'] = $categories[$v['category_id']][0];
                    $data['rows'][$k]['product_name'] = preg_replace('/\|.*/', '', $v['product_name']);
                }
            }
        }
        return $data;

    }

    /*
     *获取某个供应商下所有套餐列表
     * $param   $id     供应商id
     */
    static function getSetListByVendorId($vendorId,$conditions=array()){
        $data=array();
        $categories=Data_Mysql_Table_Product_Set::$category_name;
        $conditions['{table}.vendor_id = ?'] = $vendorId;
        $conditions['{table}.status >= ? '] = 0;
        $table = "{table} LEFT JOIN {prefix}product_info ON {table}.id = {prefix}product_info.id LEFT JOIN {prefix}vendor_info ON {prefix}vendor_info.id = {table}.vendor_id LEFT JOIN {prefix}product_set AS t3 ON {table}.id = t3.id";
        $cols = "{table}.id,{table}.set_name,{table}.category_id,t3.status,{table}.status as update_status,{table}.update_time,{table}.refuse_reason";
        $data = Data_Mysql_Table_Product_Set::subTable('_update')->page(0, 0, $cols, $conditions, "ORDER BY {table}.update_time  DESC", $table);

        if (!empty($data['rows'])) {
            foreach ($data['rows'] as $k => $v) {
                if (!empty($categories[$v['category_id']][0])) {
                    $data['rows'][$k]['category_name'] = $categories[$v['category_id']];
                    $data['rows'][$k]['set_name'] = preg_replace('/\|.*/', '', $v['set_name']);
                }
            }
        }
        return $data;
    }


}