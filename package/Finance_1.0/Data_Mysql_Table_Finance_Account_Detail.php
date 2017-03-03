<?php

/**
 * Created by PhpStorm.
 * User: liushengchun
 * Date: 15/3/19
 * Time: 10:37
 */
class Data_Mysql_Table_Finance_Account_Detail extends Data_Mysql_Table
{
    public $cols = array(
        'account_id' => 'int',
        'target_account_id' => 'int',
        'order_no' => '32',
        'category' => '50', // 类目
        'amount' => '14', // 金额
        'sign' => '32',
        'sign_long' => 'text',
        'confirm_time' => 'int',
        'admin_id' => 'int',
        'create_time' => 'int',
    );
    public $index = array(
        'account_id,target_account_id,order_no' => 'u',
        'order_no' => 'i',
        'category' => 'i',
        'confirm_time' => 'i',
        'create_time' => 'i',
    );
    public $title = array(
        "" => "账目明细",                                                     //空键,表名
        'account_id' => '账号ID',
    );
}