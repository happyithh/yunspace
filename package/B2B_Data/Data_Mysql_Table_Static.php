<?php

/**
 * Created by PhpStorm.
 * User: liushengchun
 * Date: 15/1/28
 * Time: 11:41
 */
class Data_Mysql_Table_Static extends Data_Mysql_Table
{
    public $cols = array(
        'static_id' => 'int',
        'time_in_hour' => 'int',
        'counter_1' => 'int',
        'counter_2' => 'int',
        'counter_3' => 'int',
        'counter_4' => 'int',
        'counter_5' => 'int',
        'counter_6' => 'int',
        'counter_7' => 'int',
    );
    public $index = array(
        'static_id,time_in_hour' => 'u',
    );
    public $title = array(
        '' => '统计信息',
        'static_id' => 'ID',
        'time_in_hour' => '时间段',
        'counter_1' => '计数1',
        'counter_2' => '计数2',
        'counter_3' => '计数3',
        'counter_4' => '计数4',
        'counter_5' => '计数5',
        'counter_6' => '计数6',
        'counter_7' => '计数7',
    );
    public $titleHidden = array( //    list / form / both
        'time_in_hour' => 'form',
    );
    public $filter = array();

}