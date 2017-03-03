<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 15/1/28
 * Time: 11:41
 */
class Data_Mysql_Table_Account_Broker extends Data_Mysql_Table
{
    public $cols = array(
        'account_id' => 'int',         //账户id
        'phone' => '15',            //手机号
        'city' => '50',             //城市
        'broker_info' => 'array',             //经纪人信息
        'update_time' => 'int',   //更新时间
        'create_time' => 'int',   //创建时间
        'marks' => 'text',        //备注
        'status' => 'tinyint',      //  0:新创建 ，带审核   ， 2:已审核    -1:拒绝
    );
    public $index = array(
        'username' => 'u',                                                    //p:主键, u:唯一索引, i:索引
        'phone' => 'i',
        'status' => 'i',

    );




}