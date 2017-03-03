<?php

/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/3/24
 * Time: 17:01
 * 产品营销信息表
 */
class Data_Mysql_Table_Product_Marketing extends Data_Mysql_Table
{
    public $cols = array(
        'platform_charges' => 'int',
        'recommend_charges' => 'int',
        'counter_marketing' => 'int',
        'counter_order' => 'int',
        'update_time' => 'int',
        'status' => 'tinyint',
    );
    public $index = array(
        'status' => 'i',
    );
    public $title = array(
        "" => "产品营销信息",
        'id' => '产品ID',
        'platform_charges' => '平台成交佣金',
        'recommend_charges' => '推广成交佣金',
        'recommend_count' => '推广次数',
    );
}