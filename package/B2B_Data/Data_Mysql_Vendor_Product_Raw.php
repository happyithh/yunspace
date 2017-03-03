<?php

/**
 * Created by PhpStorm.
 * User: liushengchun
 * Date: 15/1/28
 * Time: 11:41
 */
class Data_Mysql_Vendor_Product_Raw extends Data_Mysql_Table
{
    public $cols = array(
        'account_id' => 'int',
        'vendor_id' => 'int',
        'vendor_name' => '200',
        'raw_data' => 'array',
        'create_time' => 'int',
        'status' => 'tinyint',
    );
    public $index = array(
        'account_id' => 'i',
        'vendor_id' => 'i',
        'status' => 'i',
    );
    public $title = array(
        "" => "需求",                                                     //空键,表名
        'account_id' => '账号ID',
        'vendor_id' => '供应商ID',
        'vendor_name' => '供应商名称',
        'create_time' => '提交时间',
    );
    public $titleHidden = array( //    list / form / both
    );
    public $filter = array();

}