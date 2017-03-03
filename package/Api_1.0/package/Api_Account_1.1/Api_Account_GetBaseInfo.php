<?php

/**
 * 接口读取用户基础信息
 *
 */
class Api_Account_GetBaseInfo extends Api
{


    static $tempCache = array();

    static function getBaseInfoById($args)
    {
        $request = Func_Input::filter(array(
            'account_id' => 'int'
        ), $args);
        if (!empty(self::$tempCache[$request['account_id']])) {
            return self::$tempCache[$request['account_id']];
        }
        if ($request['account_id'] < -10000) {
            return self::$tempCache[$request['account_id']] = Api_Livechat_Group_GetInfo::getGroupInfoById($request['account_id']);
        } else if ($request['account_id'] < 0) {
            return array('id' => $request['account_id'], 'fullname' => self::getSystemNameById($request['account_id']), 'vendor_name' => '');
        }
        $rs = Data_Mysql_Table_Account::select('t1.id, t1.username, t1.fullname, t1.phone, t1.email, t1.avatar, t2.openid, t2.user_info, t3.vendor_name, t3.id as vendor_id', array('t1.id=?' => $request['account_id']), '', 1,
            '{table} as t1 LEFT JOIN {prefix}account_wechat as t2 ON t1.id = t2.account_id LEFT JOIN {prefix}vendor_info as t3 ON t1.id = t3.vendor_account_id');
        if (empty($rs[0]['id'])) {
            return false;
        }
        return self::$tempCache[$request['account_id']] = self::convertDataToInfo($rs[0]);
    }

    static function getBaseInfoByIds($args)
    {
        $request = Func_Input::filter(array(
            'account_ids' => 'ids',
        ), $args);
        //TODO:
    }

    /**
     * @根据手机号查询是否 存在这个账户
     */
    static function  getBaseInfoByPhone($args)
    {
        $request = Func_Input::filter(array(
            'phone' => 'phone',
        ), $args);
        if (!empty(self::$tempCache[$request['phone']])) {
            return self::$tempCache[$request['phone']];
        }
        $rs = Data_Mysql_Table_Account::select('t1.id, t1.username, t1.fullname, t1.phone, t1.email, t1.avatar, t2.openid, t2.user_info',
            array('t1.phone=?' => $request['phone']), '', 1,
            '{table} as t1 LEFT JOIN {prefix}account_wechat as t2 ON t1.id = t2.account_id');
        if (empty($rs[0]['id'])) {
            return false;
        }
        return self::$tempCache[$request['phone']] = self::convertDataToInfo($rs[0]);
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
        if (!empty($data['attr'])) {
            $data['attr'] = json_decode($data['attr'], 1);
        }
        return $data;
    }

    static $fromNames = array(
        '-1' => '系统消息',
    );

    static function getSystemNameById($id)
    {
        return empty(self::$fromNames[$id]) ? '' : self::$fromNames[$id];
    }

}

