<?php

/**
 * Created by PhpStorm.
 * User: liushengchun
 * Date: 15/3/19
 * Time: 10:36
 */
class Data_Mysql_Table_Finance_Account extends Data_Mysql_Table
{
    public $cols = array(
        'account_id' => 'int',
        'account_name' => '300',
        'balance' => '100',
        'bank_account' => 'array', //绑定银行卡
        'salt' => '32',
        'sign' => '32',
        'bank_account_no'=>'50',//银联在线的银行卡号
        'pup_no'=>'50',//银联在线的商户号
        'is_lock' => 'tinyint',
        'lock_time' => 'int',
        'update_time' => 'int',
        'create_time' => 'int',
    );
    public $index = array(
        'account_id' => 'u',                                                    //p:主键, u:唯一索引, i:索引
        'account_name' => 'i',
        'update_time' => 'i',
        'is_lock' => 'i',
    );
    public $title = array(
        "" => "金融账号",                                                     //空键,表名
        'account_id' => '账号ID',
        'account_name' => '账户名称',
        'salt' => '盐',
        'sign' => '签名',
    );
}