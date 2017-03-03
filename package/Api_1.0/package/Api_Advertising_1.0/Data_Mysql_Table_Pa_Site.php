<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 15/10/21
 * Time: 17:41
 */
class Data_Mysql_Table_Pa_Site extends Data_Mysql_Table
{
    public $cols = array(
        'site' => '50',  // 广告位置
        'description' => '300', // 广告描述
        'size' => 'array',  // 版位尺寸
        'adver_city' => 'int',  // 投放城市   0 无 1 有
        'update_time'=>'int',
        'create_time'=>'int',
        'status'=>'int',  // 0 正常 -1删除

    );
    public $index = array(
        'site' => 'u',
        'title' => 'i',
    );
    public $title = array(
        'site' => '广告位置',
        'description' => '广告描述',
        'size' => '版位尺寸',
    );
}