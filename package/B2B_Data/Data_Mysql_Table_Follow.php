<?php

/**
 * Created by PhpStorm.
 * User: liushengchun
 * Date: 15/1/28
 * Time: 11:41
 */
class Data_Mysql_Table_Follow extends Data_Mysql_Table
{
    public $cols = array(
        'follow_id' => 'int',
        'user_id' => 'int',
        'is_cancel' => 'tinyint',
        'create_time' => 'int',
    );
    public $index = array(
        'follow_id,user_id' => 'u',
        'user_id' => 'i',
        'is_cancel' => 'i',
    );
    public $title = array(
        '' => '订阅',
        'follow_id' => '订阅ID',
        'user_id' => '用户ID',
        'is_cancel' => '是否取消',
        'create_time' => '添加时间',
    );
    public $titleHidden = array( //    list / form / both
    );
    public $filter = array();

}