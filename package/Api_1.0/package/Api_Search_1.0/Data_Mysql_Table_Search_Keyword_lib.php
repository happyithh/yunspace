<?php
/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2016/1/4
 * Time: 11:35
 */
class Data_Mysql_Table_Search_Keyword_Lib extends Data_Mysql_Table{
    public $cols = array(
        's_key' => '200',
        'frequency' => 'int',
    );
    public $index = array(
        's_key' => 'u',
        's_key' => 'i',
        'frequency' => 'i',
    );
    public $title = array(
        's_key' => '关键词',
        'frequency' => '次数',
    );
}