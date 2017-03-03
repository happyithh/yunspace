<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/9/1
 * Time: 14:03
 * 获取供应商的商品
 */
class Api_Product_Search_GetListByVendor extends Api
{
    /**
     *
     */
    static function  getAll($args)
    {
        $request = Func_Input::filter(array(
            'account_id' => 'int',
        ), $args);
        if (empty($request['account_id'])) {
            return false;
        }
        $conditions ['t1.status=?'] = 1;
        $conditions['t2.vendor_account_id=?'] = $request['account_id'];

        $children = Data_Mysql_Table_Product_Category::getChildren(Data_Config_Site::$staticConfig['space_id']);

        $table = "{table} as t1 LEFT JOIN {prefix}vendor_info as t2 ON t1.vendor_id = t2.id";

        $product = Data_Mysql_Table_Product_Search::select('t1.id,t1.product_name,t1.category_id', $conditions, 'ORDER BY t1.order_index DESC', 100, $table);
        $table_s = "{table} as t1 LEFT JOIN {prefix}vendor_info as t2 ON t1.vendor_id =t2.id";
        $set = Data_Mysql_Table_Product_Set::select('t1.id,t1.set_name as product_name,t1.category_id', $conditions, '', 100, $table_s);

        foreach ($product as $k => $v) {
            if (in_array($v['category_id'], $children)) {
                $product[$k]['product_name'] = '[ 场地空间 ] - ' . $v['product_name'];
            }
            if (!in_array($v['category_id'], $children)) {
                $product[$k]['product_name'] = '[ 配套服务 ] - ' . $v['product_name'];
            }
            $product[$k]['type'] = 1;
        }
        foreach ($set as $k => $v) {
            $set[$k]['product_name'] = '[ 套餐 ] - ' . $v['product_name'];
            $set[$k]['type'] = 2;
        }
        $all = array();
        $all = array_merge($set, $product);
        return $all;
    }


    static function  getSpace($args)
    {
        $request = Func_Input::filter(array(
            'account_id' => 'int',
        ), $args);
        if (empty($request['account_id'])) {
            return false;
        }
        $conditions ['t1.status=?'] = 1;
        $conditions['t2.vendor_account_id=?'] = $request['account_id'];

        $children = Data_Mysql_Table_Product_Category::getChildren(Data_Config_Site::$staticConfig['space_id']);

        $table = "{table} as t1 LEFT JOIN {prefix}vendor_info as t2 ON t1.vendor_id = t2.id";

        $product = Data_Mysql_Table_Product_Search::select('t1.id,t1.product_name,t1.category_id', $conditions, 'ORDER BY t1.order_index DESC', 100, $table);

        foreach ($product as $k => $v) {
            if (in_array($v['category_id'], $children)) {
                $product[$k]['product_name'] = '[ 场地空间 ] - ' . $v['product_name'];
            }
            $product[$k]['type'] = 1;
        }
        return $product;
    }
}