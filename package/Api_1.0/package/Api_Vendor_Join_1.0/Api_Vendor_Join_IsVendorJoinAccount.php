<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/8/13
 * Time: 16:13
 */
class Api_Vendor_Join_IsVendorJoinAccount extends Api
{

    /**
     * @args = array(
     *
     *  account_id=>''
     * )
     *
     */

    static function  check($args)
    {

        $request = Func_Input::filter(array(
            'account_id' => 'int',
        ), $args);
        if (empty($request['account_id'])) {
            return false;
        }
        $data = Data_Mysql_Table_Vendor_Join::select('id,category_id as categories_id,vendor_name,update_time,status',
            array('account_id =?' => $request['account_id'], 'status =?' => 0));
        if (!empty($data[0])) {
            return $data[0];
        }
        return false;
    }


}