<?php

/**
 * 接口读取 *
 */
class Api_Account_GetWechatInfo extends Api
{

    /**
     * @param $args
     * @return bool
     * 获取销售的基本信息
     */
    static function  getSaleBaseInfoByPhone($args)
    {
        $request = Func_Input::filter(array(
            'phone' => 'phone',
        ), $args);

        $rs = Data_Mysql_Table_Account::select('t1.id, t1.username, t1.fullname, t1.phone, t1.email, t1.avatar, t2.openid, t2.user_info',
            array('t1.phone=?' => $request['phone']), '', 1,
            '{table} as t1 LEFT JOIN {prefix}account_wechat_sale as t2 ON t1.id = t2.account_id');
        if (!empty($rs[0]['id'])) {
            return $rs[0];

        }
    }


}

