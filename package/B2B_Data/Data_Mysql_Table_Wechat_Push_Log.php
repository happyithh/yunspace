<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/7/14
 * Time: 13:56
 * 微信推送日志
 */
class Data_Mysql_Table_Wechat_Push_Log extends Data_Mysql_Table
{

    public $cols = array(
        'to_openid' => '200',              //接收件的openid
        'data' => 'array',              //发送的内容
        'request' => 'array',           //返回的内容
        'create_time' => 'int',
        'status' => 'int',              //状态

    );

    public $index = array(
        'status' => 'i'
    );

    static function createLog($data, $request)
    {
        self::subTable('_' . date('Ym'))->insert(array(
            'to_openid' => $data['touser'],
            'data' => $data,
            'request' => $request,
            'status' => 0));
    }
}