<?php

/**
 * Created by PhpStorm.
 * User: yl
 * Date: 15/09/01
 * Time: 14:32
 * 拓展的供应商账户
 */
class Data_Mysql_Table_Vendor_Expand extends Data_Mysql_Table
{
    public $cols = array(
        'vendor_id' => 'int',
        'account_id' => 'int',
        'email'=>'30',
        'username' => '100',
        'phone' => '15',
        'status' => 'tinyint',
        'create_time'=>'int',
        'update_time'=>'int',
    );
    public $index = array(
        'vendor_id' => 'u',                                                    //p:主键, u:唯一索引, i:索引
        'account_id' => 'u',
        'email'=>'i',
        'username' => 'i',
        'phone' => 'i',
        'status' => 'i',
    );
    public $title = array(
        "" => "供应商拓展信息",                                                     //空键,表名
        'vendor_id' => '供应商ID',
        'account_id' => '供应商绑定的账户ID',
        'username' => '账户名称',
        'email'=>'账户邮箱',
        'phone' => '供应商绑定的账户的手机号',
        'status' => '状态',   //0未激活  1已激活
        'create_time'=>'int',
        'update_time'=>'int',
    );
}