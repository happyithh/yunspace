<?php

/**
 * Created by PhpStorm.
 * User: liushengchun
 * Date: 15/1/28
 * Time: 11:41
 */
class Data_Mysql_Table_Product_Schedule extends Data_Mysql_Table
{
    public $cols = array(
        'product_id' => 'int',
        'vendor_account_id' => 'int',
        'order_id' => 'int',
        'start_time' => 'int',
        'end_time' => 'int',
        'des' => '200',
        'create_time' => '11',
        'status' => 'tinyint',            //   -n 关闭     0 :未预定   2：已预订， 1 ：意向预定
		'color'=>'string',
    );
    public $index = array(
        'product_id' => 'i',
        'order_id' => 'i',
        'start_time' => 'i',
        'end_time' => 'i',
        'status' => 'i',
    );
    public $title = array(
        "" => "产品档期",                                                     //空键,表名
        'product_id' => '产品ID',
        'vendor_account_id' => '供应商账户ID',
        'set_id' => '套餐ID',
        'start_time' => '开始时间',
        'end_time' => '结束时间',
        'des' => '描述',
		'color'=>'状态颜色'
    );
    static $status = array(
        2 => '已预订',
        1 => '意向预定',

    );


}