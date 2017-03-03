<?php

class Data_Mysql_Table_Demand_Take_Look extends Data_Mysql_Table{
    public $cols = array(
        'demand_id'=>'int',
        'admin_id'=>'int',
        'product_id'=>'int',
        'demo'=>'text',
        'look_time'=>'int',
        'create_time'=>'int',
    );
    public $index = array(
        'demand_id'=>'i',
        'admin_id'=>'i',
        'product_id'=>'i',
        'look_time'=>'i',
    );
    public $title = array(
        ''=>'带看场地',
        'demand_id'=>'需求ID',
        'admin_id'=>'操作者',
        'product_id'=>'产品ID',
        'demo'=>'备注',
        'look_time'=>'场地查看时间',
        'create_time'=>'创建时间',
    );

}