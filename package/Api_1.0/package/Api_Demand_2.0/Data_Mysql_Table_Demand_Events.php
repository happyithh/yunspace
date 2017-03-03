<?php

/**
 * Created by PhpStorm.
 * User: yl
 * Date: 2016/1/15
 * Time: 13:50
 * 存储同一个手机号的价格咨询，合作咨询等数据
 */
class Data_Mysql_Table_Demand_Events extends Data_Mysql_Table
{
    public $cols = array(
        'demand_id' => 'int',
        'object_id' => 'int',
        'object_name' => '200',
        'object_type' => '50',
        'demand' => 'array',
        'demand' => 'array',
        'create_time' => 'int',
    );
    public $index = array(
        'demand_id,object_id' => 'u',
        'demand' => 'i',

    );
} 