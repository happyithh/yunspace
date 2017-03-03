<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 15/7/9
 * Time: 15:09
 * @获取后台人员的account表中的信息
 */
class Api_Administrator_GetBaseAccountInfo extends Api
{
    static $tempCache = array();

    static function  getBastAccountInfo($args)
    {
        $request = Func_Input::filter(array(
            'admin_id' => 'int',
        ), $args);
        if (empty($request['admin_id'])) {
            return false;
        }
        if (!empty(self::$tempCache[$request['admin_id']])) {
            return self::$tempCache[$request['admin_id']];
        }
        $table = "{table} as t1 RIGHT JOIN {prefix}administrator as t2 ON t2.phone=t1.phone";
        $conditions = array('t2.id =?' => $request['admin_id']);
        $status = Data_Mysql_Table_Account::select('t1.id ,t1.id as account_id,t1.username,t2.email,t2.username,t2.phone,t2.fullname,t2.id as admin_id', $conditions, '', 1, $table);
        if (empty($status[0]['id'])) {
            if (empty($status[0]['phone'])) {
                return false;
            }
            $account = Api_Account_Register::quickRegister(array(
                'phone' => $status[0]['phone'],
                'username' => $status[0]['username'],
                'fullname' => $status[0]['fullname'],
                'password' => rand(10000000, 9999999),
            ));
//            Data_Mysql_Table_Administrator::select()
            $account['data']['account_id'] = $account['data']['id'];
            $account['data']['admin_id'] = $request['admin_id'];
            return self::$tempCache[$request['admin_id']] = $account['data'];
        }
        return self::$tempCache[$request['admin_id']] = $status[0];
    }

    static function  getBastAccountInfoByPhone($args)
    {
        $request = Func_Input::filter(array(
            'phone' => 'int',
        ), $args);
        if (empty($request['phone'])) {
            return false;
        }
        if (!empty(self::$tempCache[$request['phone']])) {
            return self::$tempCache[$request['phone']];
        }
        $table = "{table} as t1 RIGHT JOIN {prefix}administrator as t2 ON t2.phone=t1.phone";
        $conditions = array('t2.phone =?' => $request['phone']);
        $status = Data_Mysql_Table_Account::select('t1.id ,t1.id as account_id,t1.username,t2.email,t2.username,t2.integral,t2.phone,t1.fullname,t2.id as admin_id', $conditions, '', 1, $table);
        if (empty($status[0]['id'])) {
            if (empty($status[0]['phone'])) {
                return false;
            }
            $account = Api_Account_Register::quickRegister(array(
                'phone' => $status[0]['phone'],
                'username' => $status[0]['username'],
                'password' => rand(10000000, 9999999),
            ));
            $account['data']['account_id'] = $account['data']['id'];
            $account['data']['admin_id'] = $request['admin_id'];
            return self::$tempCache[$request['phone']] = $account['data'];
        }
        return self::$tempCache[$request['phone']] = $status[0];
    }

}

