<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 15/10/21
 * Time: 17:41
 */
class Data_Mysql_Table_Pa_Static extends Data_Mysql_Table
{
    public $cols = array(
        'site_id' => 'int',
        'adv_id' => 'int',
        'date_time' => 'int',
        'display' => 'int',
        'click' => 'int',
    );
    public $index = array(
        'site_id' => 'i',
        'adv_id,date_time,site_id' => 'u',
    );
    public $title = array(
        'site_id' => '广告位置',
    );
}