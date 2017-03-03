<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/8/26
 * Time: 13:15
 * 自动登录
 * 1.如果已经登录，清除旧的session，重新自动登录
 * 2.未登录，自动登录
 */
class  Api_Account_Login_AutoLoginSession extends Api
{
    /**
     * @param $args =>array()
     *
     *
     */
    static function  auto($args)
    {
        $request = Func_Input::filter(array(
            'account_id' => 'int',
            'phone' => 'string',
        ), $args);
        $conditions = array();
        if (!empty($request['account_id'])) {
            $conditions['id=?'] = $request['account_id'];
        } elseif (!empty($request['phone'])) {
            $conditions['phone =?'] = $request['phone'];
        } else {
            return false;
        }
        $rs = Data_Mysql_Table_Account::select("{table}.*,{prefix}vendor_info_update.id as vendor_id,{prefix}vendor_info_update.vendor_name", array("id" => $request['account_id']), '', 1, '{table} LEFT JOIN {prefix}vendor_info_update ON {table}.id= {prefix}vendor_info_update.vendor_account_id');
        if (empty($rs[0]['id'])) {
            return false;
        }
        Api_Account_Login::mkSession($rs[0]);
        Data_Mysql_Table_Account::update($rs[0]['id'], array("login_times = login_times + 1"));
        Data_Mysql_Table_StaticLog::log('login', 0, $_SESSION['user']['id'], '供应商加盟快速登录');
        return true;
    }

}