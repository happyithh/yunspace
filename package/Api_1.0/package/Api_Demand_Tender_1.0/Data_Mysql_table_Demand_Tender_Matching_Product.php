<?php
/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2015/8/27
 * Time: 14:39
 */

/***
 * Class Data_Mysql_table_Demand_Matching_Product
 * 需求匹配产品表
 * 主要保存需求匹配的对应的产品id及供应商id
 */
class Data_Mysql_Table_Demand_Tender_Matching_Product extends Data_Mysql_Table
{
    public $cols = array(
        'tender_id' => 'int',
        'vendor_ids' => 'array',   //匹配的供应商id集合
        'product_ids' => 'array',    //匹配的产品id
        'product_name' => 'array',    //匹配的产品
        'phones' => 'array',    //供应商手机号
        'create_time' => 'int',
        'update_time' => 'int',
        'status' => 'tinyint',   // 0  未发送消息  1 已发送部分  2.全部发送 -1 停止发送
        'send_total_num' => 'int',  //当前发送总条数
    );

    public $index = array(
        'tender_id' => 'u',
        'product_name' => 'u',
        'vendor_ids' => 'attr',
        'product_ids' => 'attr',
        'phones' => 'attr',
    );
}