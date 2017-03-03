<?php

/**
 * Created by PhpStorm.
 * User: zhaozhichao
 * Date: 2015/9/5
 * Time: 14:40
 *  供应商是否是第一次审核
 */
class  Api_Vendor_isFirstCheck extends Api
{

    static $template = array();

    static function isFirstCheck($args)
    {
        $request = Func_Input::filter(array(
            'vendor_id' => 'int',
            'vendor_account_id' => 'int',
        ), $args);
        if (empty($request['vendor_id']) && empty($request['vendor_account_id'])) {
            return '';
        }
        if (!empty($request['vendor_id'])) {
            $conditions['id =?'] = $request['vendor_id'];
        }
        if (!empty($request['vendor_account_id'])) {
            $conditions['vendor_account_id =?'] = $request['vendor_account_id'];
        }

        if (isset(self::$template[$request['vendor_id']])) {
            return self::$template[$request['vendor_id']];
        }

        $data = Data_Mysql_Table_Vendor_Info::select('id,vendor_name', $conditions, '', 1);
        if (!empty($data[0]['vendor_name'])) {
            return self::$template[$request['vendor_id']] = false;
        }
        return self::$template[$request['vendor_id']] = 1;
    }

    static $vendor_static = array();

    static function  vendorStatic($args)
    {
        $request = Func_Input::filter(array(
            'vendor_id' => 'int',
        ), $args);
        if (empty($request['vendor_id'])) {
            return false;
        }

        if (isset(self::$vendor_static[$request['vendor_id']])) {
            return self::$vendor_static[$request['vendor_id']];
        }

        $conditions['t2.id =?'] = $request['vendor_id'];
        $table = "{table} as t1 RIGHT JOIN {prefix}vendor_info_update as t2 ON t1.id =t2.id";
        $data = Data_Mysql_Table_Vendor_Info::select('t1.vendor_name,t2.id,t2.status', $conditions, '', 1, $table);
        if (empty($data[0]['vendor_name'])) {
            return self::$vendor_static[$request['vendor_id']] = array(
                'is_first_check' => 1,
                'status' => $data[0]['status']
            );
        }
        return self::$vendor_static[$request['vendor_id']] = array(
            'is_first_check' => '',
            'status' => $data[0]['status']
        );

    }


}