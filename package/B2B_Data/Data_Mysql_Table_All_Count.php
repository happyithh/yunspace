<?php
/*
 *统计表
 */
class Data_Mysql_Table_All_Count extends Data_Mysql_Table
{
    public $cols = array(
        'object_id' => 'int',
        'count_order' => 'int',
    );
    public $index = array(
        'object_id' => 'u',
        'count_order' => 'i',
    );
    public $title = array(
        'object_id' => '对象ID',
        'count_order' => '订单总数',
    );
}