<?php

/**
 * Created by PhpStorm.
 * account: yl
 * Date: 15/7/16
 * Time: 12:00
 * 订单评价表
 */
class Data_Mysql_Table_Order_Evaluate extends Data_Mysql_Table
{
    public $cols = array(
        'order_id' => '50',
        'order_no' => '50',
        'product_id'=>'int',
        'set_id'=>'int',
        'quality' => 'int',
        'service' => 'int',
        'speed' => 'int',
        'demo' => 'text',
        'create_time' => 'int',
    );
    public $index = array(
        'demo'=>'title',
        'order_id'=>'i',
        'order_no'=>'i',
    );
    public $title = array(
        "" => "订单评价",                            //空键,表名
        'order_id' => '订单ID',
        'order_no' => '订单编号',
        'product_id'=>'int',//服务ID
        'set_id'=>'int',   //套餐ID
        'quality' => '质量效果',
        'service' => '服务态度',
        'speed' => '响应速度',
        'demo' => '评价备注',
        'create_time' => '评价时间',
    );

}