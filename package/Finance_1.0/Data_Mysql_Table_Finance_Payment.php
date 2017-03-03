<?php

/**
 * Created by PhpStorm.
 * User: liushengchun
 * Date: 15/3/19
 * Time: 10:37
 */
class Data_Mysql_Table_Finance_Payment extends Data_Mysql_Table
{
    public $cols = array(
        'account_id' => 'int',
        'target_account_id' => 'int',
        'order_id' => 'int',
        'payment_title' => '100',
        'amount' => '14', // 金额
        'payment_time' => 'int',
        'payment_detail' => 'array',
        'confirm_time' => 'int',
        'confirm_detail' => 'array',
        'admin_id' => 'int',
        'sign' => '32',
        'sign_long' => 'text',
        'create_time' => 'int',
        'update_time'=>'int',
    );
    public $index = array(
        'account_id' => 'i',
        'target_account_id' => 'i',
        'order_id,payment_title' => 'u',
        'payment_time' => 'i',
        'confirm_time' => 'i',
    );
    public $title = array(
        "" => "支付明细",                                                     //空键,表名
        'account_id' => '账号ID',
    );
}