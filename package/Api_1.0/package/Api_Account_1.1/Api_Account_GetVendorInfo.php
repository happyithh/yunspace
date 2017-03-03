<?php

/**
 * 接口读取供应商de基础信息
 *
 */
class Api_Account_GetVendorInfo extends Api
{


    static $tempCache = array();

    static function getVendorBaseInfo($args)
    {
        $request = Func_Input::filter(array(
            'vendor_id' => 'int',
        ), $args);
        if (!empty(self::$tempCache[$request['vendor_id']])) {
            return self::$tempCache[$request['vendor_id']];
        }
        $rs = Data_Mysql_Table_Vendor_Info::select('t1.id,t1.vendor_name,t1.vendor_account_id,t2.username, t2.fullname, t2.phone, t2.email, t2.avatar, t3.openid, t3.user_info',
            array('t1.id=?' => $request['vendor_id']), '', 1,
            '{table} as t1 LEFT JOIN {prefix}account as t2 ON t1.vendor_account_id = t2.id LEFT JOIN {prefix}account_wechat as t3 ON t2.id = t3.account_id');
        if (empty($rs[0]['id'])) {
            return false;
        }
        return self::$tempCache[$request['vendor_id']] = self::convertDataToInfo($rs[0]);
    }

    static function convertDataToInfo($data)
    {
        if (!empty($data['user_info'])) {
            $data['user_info'] = json_decode($data['user_info'], 1);
            if (empty($data['avatar']) && !empty($data['user_info']['headimgurl'])) {
                $data['avatar'] = $data['user_info']['headimgurl'];
            }
            if ($data['fullname'] == $data['phone']) {
                $data['fullname'] = $data['user_info']['nickname'];
            }
        }
        return $data;
    }

}

