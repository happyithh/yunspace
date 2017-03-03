<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 15/8/11
 * Time: 11:41
 */
//需求进度记录表
class Data_Mysql_Table_Demand_Step_Record extends Data_Mysql_Table
{
    public $cols = array(
        'demand_id' => 'int',     //需求ID
        'admin_id' => 'int',
        'step' => 'int',            //进度
        'reason' => 'string',   //理由
        'create_time' => 'int',
    );
    public $index = array(
        'step' => 'i',
        'demand_id' => 'i',
        'create_time'=>'i',
    );
}

