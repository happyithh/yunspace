<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/12/17
 * Time: 13:50
 * 需求轨迹
 */
class Data_Mysql_Table_Demand_Track extends Data_Mysql_Table
{
    public $cols = array(
        'demand_id' => 'int',
        'intro' => '100',
        'create_time' => 'int',
    );

    /**
     * @param $demand_id
     * @param $intro
     * 创建需求轨迹
     */
    static function  create($demand_id, $intro)
    {
        if (!$demand_id || !$intro) {
            return false;
        }
        Data_Mysql_Table_Demand_Track::insert(array('demand_id' => $demand_id, 'intro' => $intro, 'create_time' => time()));
    }
} 