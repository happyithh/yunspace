<?php

/**
 * Created by PhpStorm.
 * account: yl
 * Date: 15/7/16
 * Time: 12:00
 * 新订单合同表
 */
class Data_Mysql_Table_Order_Conform extends Data_Mysql_Table
{
    public $cols = array(
        'order_id' => 'int',
        'order_no' => '50',
        'conform_title' => '100',
        'conform_amount' => '11',
        'conform_path' => 'array',
        'create_time' => 'int',
        'update_time' => 'int',
        'status' => 'tinyint',  //0 待签约  1 已签约  -1 已拒绝
        'refuse_reason' => 'text',
    );
    public $index = array(
        'conform_title'=>'title',
        'order_no'=>'i',
        'order_id'=>'i',
    );
    public $title = array(
        "" => "订单合同",                            //空键,表名
        'order_id' => '订单ID',
        'order_no' => '订单编号',
        'conform_title' => '合同标题',
        'conform_amount' => '合同金额',
        'conform_path' => '合同文件地址',
        'create_time' => '创建时间',
        'update_time' => '修改时间',
        'status' => '合同状态',  //0 待签约  1 已签约  -1 已拒绝
        'refuse_reason'=>'拒绝原因',
    );

}