<?php

/**
 * Created by PhpStorm.
 * User: yl
 * Date: 16/2/17
 * Time: 16:38
 * 落地页数据整理
 */
class Data_Mysql_Table_Track_Land_Url extends Data_Mysql_Table
{
    public $cols = array(
        'land_url' => '200',         //url
        'datetime' => '10',
        'layer_1' => 'int',
        'layer_2' => 'int',
        'layer_3' => 'int',
        'layer_4' => 'int',
        'layer_5' => 'int',
        'land_1' => 'int',
        'land_2' => 'int',
        'land_3' => 'int',
        'land_4' => 'int',
        'land_5' => 'int',
        'create_time' => 'int',
    );
    public $index = array(
        'land_url,datetime' => 'u',
    );
    public $title = array(
        ''=>'落地页数据整理',
        'land_url' => '落地页url',         //url
        'datetime' => '日期',
        'layer_1' => '作为第一级页面次数',
        'layer_2' => '作为第二级页面次数',
        'layer_3' => '作为第三级页面次数',
        'layer_4' => '作为第四级页面次数',
        'layer_5' => '作为大于第四级页面次数',
        'land_1' => '此url作为一级跳出页面的次数',
        'land_2' => '此url作为二级跳出页面的次数',
        'land_3' => '此url作为三级跳出页面的次数',
        'land_4' => '此url作为四级跳出页面的次数',
        'land_5' => '此url作为大于四级跳出页面的次数',
        'create_time' => '创建时间',
    );
}