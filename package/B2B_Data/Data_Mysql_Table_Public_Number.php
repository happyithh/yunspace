<?php

/**
 * Created by PhpStorm.
 * User: yl
 * Date: 15/11/30
 * Time: 09:40
 * 公众号
 */
class Data_Mysql_Table_Public_Number extends Data_Mysql_Table
{
    public $cols = array(
        'public_number' => '200',
        'show_name' => '200',
        'public_type' => 'array',
        'create_time'=> 'int',
        'update_time'=>'int',
    );
    public $index = array(
        'public_number'=>'u',
        'public_number,show_name'=>'title',
        'public_type'=>'attr',
    );
    public $title = array(
        "" => "微信号管理",                                                     //空键,表名
        'public_number' => '微信号',
        'show_name' => '微信号的名称',
        'public_type' => '公众号类型',
        'create_time'=> '创建时间',
        'update_time'=>'更新时间',
    );

}