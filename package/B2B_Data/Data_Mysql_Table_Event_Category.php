<?php

/**
 * Created by PhpStorm.
 * User: liushengchun
 * Date: 15/1/28
 * Time: 11:41
 */
class Data_Mysql_Table_Event_Category extends Data_Mysql_Table
{
    public $cols = array(
        'parent_id' => 'int',
        'category_name' => '50',
        'attr_info' => 'array',
        'sort_weight' => 'tinyint',
        'status' => 'tinyint',
    );
    public $index = array(
        'parent_id,category_name' => 'u',                                                    //p:主键, u:唯一索引, i:索引
        'sort_weight' => 'i',
        'status' => 'i',
    );
    public $title = array(
        "" => "活动分类",                                                     //空键,表名
        'parent_id' => '父级ID',
        'category_name' => '分类名',
        'sort_weight' => '排序优先级',
        'attr_info' => '属性预定义',
    );
    public $titleHidden = array( //    list / form / both
        'attr_info' => 'list',
    );
    public $filter = array(
        'status' => array(
            99 => '回收站',
            98 => '停用',
            1 => '正常',
        ),
    );

}