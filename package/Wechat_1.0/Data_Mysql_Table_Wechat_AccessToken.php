<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2016/2/1
 * Time: 11:48
 */
class Data_Mysql_Table_Wechat_AccessToken extends Data_Mysql_Table
{
    public $cols = array(
        'wechat_type' => '50',          //商家服务号manager ，抢单服务号sale ， 客户customer服务号
        'access_token' => '300',
        'update_time' => 'int',
    );
    public $index = array(
        'wechat_type' => 'u',
        'update_time,access_token' => 'i',
    );
}