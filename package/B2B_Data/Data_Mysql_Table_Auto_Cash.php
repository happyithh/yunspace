<?php

/**
 * Created by PhpStorm.
 * User: yl
 * Date: 15/1/28
 * Time: 11:41
 * 自动提现请求
 */
class Data_Mysql_Table_Auto_Cash extends Data_Mysql_Table
{
    public $cols = array(
        'account_id' => 'int',
        'account_name' => '50',
        'pup_no' => '50',   //银联在线商户号
        'bank_id' => '20',
        'bank_account' => '100',
        'bank_account_no' => '50',
        'bank_city' => '50',
        'bank_name' => '50',
        'status' => 'tinyint',  //-1 关闭自动提现 0 未生成银联商户号  1已开启自动提现
        'update_time'=>'int',
        'create_time'=> 'int',
    );
    public $index = array(
        'account_id'=>'i',
        'account_name'=>'title',
    );
    public $title = array(
        "" => "自动提现信息",                                                     //空键,表名
        'account_id' => '账户ID',
        'account_name' => '账户名称',
        'pup_no' => '银联在线标识号',
        'bank_id' => '',
        'bank_account' => '银行卡账户',
        'bank_account_no' => '银行卡号',
        'bank_name' => '银行名称',
    );

}