<?php

/**
 * Created by PhpStorm.
 * User: yl
 * Date: 16/2/17
 * Time: 16:38
 * 来源页数据整理
 */
class Data_Mysql_Table_Track_Referer_Url extends Data_Mysql_Table
{
    public $cols = array(
        'referer_url' => '200',         //url
        'datetime' => '10',
        'count' => 'int',
        'create_time' => 'int',
    );
    public $index = array(
        'referer_url,datetime' => 'u',
    );
    public $title = array(
        '' => '来源页数据',
        'referer_url' => '来源页url',         //url
        'datetime' => '日期',
        'count' => '作为来源页的总数',
        'create_time' => '创建时间',
    );
}