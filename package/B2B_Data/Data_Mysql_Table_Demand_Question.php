<?php

/**
 * Created by PhpStorm.
 * User: liushengchun
 * Date: 15/1/28
 * Time: 11:41
 */
class Data_Mysql_Table_Demand_Question extends Data_Mysql_Table
{
    public $cols = array(
        'demand_id' => 'int',
        'demand_question' => 'array',
        'create_time' => 'int',
        'update_time' => 'int',
    );
    public $index = array(
        'demand_id' => 'u',
        'demand_question' => 'attr',
    );


}

