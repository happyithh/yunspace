<?php

/**
 * Created by PhpStorm.
 * User: liushengchun
 * Date: 15/5/27
 * Time: 21:52
 */
class Data_Mysql_View_Vendor extends Data_Mysql_View
{
    /**
     * 定义视图中的字段,,名称=>类型。
     */
    public $cols = array(
        'id' => 'vendor_info.id',
        'vendor_name' => 'vendor_info._update.vendor_name',
        'username' => 'account.username',
    );
    public $tables = array(
        'vendor_info' => array(
            'account.id' => 'vendor_info.vendor_account_id'
        ),
    );
}