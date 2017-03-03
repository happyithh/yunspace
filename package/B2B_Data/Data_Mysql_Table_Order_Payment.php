<?php

/**
 * Created by PhpStorm.
 * User: yl
 * Date: 15/5/20
 * 订单支付信息表
 */
class Data_Mysql_Table_Order_Payment extends Data_Mysql_Table
{
    public $cols = array(
        'order_id' => 'int',
        'order_no' => '50',
        'buyer_account_id' => 'int',
        'vendor_id' => 'int',
        'payment_id' => '100',
        'payment_no' => '100',
        'payment_amount' => '11',
        'payment_status' => 'tinyint',// -1 待审核  1 通过审核  2未通过审核
        'payment_method' => '20',  //账户支付，在线支付，银行转账
        'payment_info' => 'array',
        'payment_img' => '100',
        'refuse_reason'=>'300',
        'create_time' => 'int',
    );
    public $index = array(
        'order_id' => 'i',
        'order_no' => 'i',
        'payment_id' => 'i',
        'payment_status' => 'i',
        'payment_method' => 'i',
    );
    public $title = array(
        "" => "支付信息",                                                     //空键,表名
        'order_id' => '订单ID',
        'order_no' => '订单编号',
        'payment_id' => '对账单ID',
        'payment_no' => '支付流水号',
        'buyer_account_id' => '买家ID',
        'vendor_id' => '供应商ID',
        'payment_amount' => '金额',
        'payment_status' => '支付状态',//
        'payment_method' => '支付方式',  //账户支付，在线支付，银行转账
        'payment_info' => '支付信息',
        'payment_img' => '转账截图',
        'create_time' => '支付时间',
        'refuse_reason'=>'拒绝原因',
        'update_time' => '更新时间',
    );
}