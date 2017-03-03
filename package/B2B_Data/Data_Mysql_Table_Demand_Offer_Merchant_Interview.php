<?php

class Data_Mysql_Table_Demand_Offer_Merchant_Interview extends Data_Mysql_Table
{
    public $cols = array(
        'demand_id'=>'int',
        'space_id' => 'int',
        'item_id'=>'int',
        'reason' => 'text',
        'admin_id' => 'int',
        'create_time' => 'int',
        'addr' => '100',
        'step'=>'int',//1成交  0没成交
    );
    public $index = array(
        'demand_id' => 'i',
        'admin_id' => 'i',
        'item_id' => 'i',
        'space_id' => 'i',
    );
    public $title = array(
        'demand_id'=>'需求id',
        'item_id' => '报价ID',
        'space_id'=>'子空间id',
        'admin_id' => '操作者',
        'addr' => '订单来源',
        'reason' => '回访记录',
        'create_time' => '创建时间',
        'step'=>'是否成交',
    );

}