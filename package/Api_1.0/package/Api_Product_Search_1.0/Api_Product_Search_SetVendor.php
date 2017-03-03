<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/7/2
 * Time: 9:44
 * @搜索套餐和供应商
 */
class  Api_Product_Search_SetVendor extends Api
{

    static function  getSetVendor($args)
    {
        $request = Func_Input::filter(array(
            'id' => 'int',
        ), $args);
        if (!empty($request['id'])) {
            $table = "{table} as t1 LEFT JOIN {prefix}vendor_info as t2 ON t1.vendor_id = t2.id";
            $conditions['t1.id=?'] = $request['id'];
            $conditions['t1.status=?'] = 1;
            $data = Data_Mysql_Table_Product_Set::select('t1.id,t1.vendor_id,t1.set_name,t1.des,t1.logo,t2.vendor_account_id,t2.vendor_name',
                $conditions, '', 1, $table);
            if (!empty($data[0])) {
                return $data[0];
            }
        }
        return false;

    }
}