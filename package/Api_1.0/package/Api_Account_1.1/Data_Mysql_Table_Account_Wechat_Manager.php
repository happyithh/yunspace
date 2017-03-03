<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 15/1/28
 * Time: 11:41
 */
Class Data_Mysql_Table_Account_Wechat_Manager extends Data_Mysql_Table
{
    public $cols = array(
        'account_id' => 'int',        //账户id    account_id<0为假数据
        'openid' => '200',            //微信 openid
        'create_time' => 'int',       //创建时间
        'update_time' => 'int',       //创建时间
        'user_info' => 'array',       //用户的微信信息
        'status' => 'tinyint',      //状态
        'point' => 'int'               //积分
    );

    public $index = array(
        'openid' => 'u',
        'status' => 'i',
        'account_id'=>'i'
    );

    static function handleGetOpenid($account_id)
    {
        $data = self::handleGetAccountInfo($account_id);
        if (!empty($data)) {
            return $data['openid'];
        }
        return false;
    }

    static function  handleGetAccountInfo($account_id)
    {
        if (!$account_id) {
            return false;
        }
        $table = "{table} as t1 LEFT JOIN {prefix}account as t2 ON t1.account_id = t2.id";
        $rs = self::select('t1.openid,t2.id,t2.username,t2.phone,t2.fullname,t2.avatar,t1.user_info', array('t2.id =?' => $account_id), '', 1, $table);
        if (!empty($rs[0])) {
            $rs[0]['user_info'] = json_decode($rs[0]['user_info'], 1);
            return $rs[0];
        }
        return false;

    }

}