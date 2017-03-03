<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2016/8/18
 * Time: 10:13
 */
class Api_Spacepedia_Get_Info extends Api
{
    static function  getBaikeInfo($conditions)
    {

        if (empty($conditions)) {
            return false;
        }
        $cols = "{table}.*,{prefix}space_item.* ";
        $table = "{table} LEFT JOIN {prefix}space_item ON {table}.id = {prefix}space_item.space_id";
//        Data_Mysql_Table_Space_Item::debug(1);
        $data = Data_Mysql_Table_Spacepedia::select($cols, $conditions, '', 1, $table);
        if (empty($data[0])) {
            return array();
        }
        if (!empty($data[0]['attr'])) {
            $data[0]['attr'] = json_decode($data[0]['attr'], 1);
        }
        if (!empty($data[0]['min_price'])) {
            $data[0]['min_price'] = $data[0]['min_price'] / 100;
        }
        if (!empty($data[0]['max_price'])) {
            $data[0]['max_price'] = $data[0]['max_price'] / 100;
        }
        return $data[0];

    }
}