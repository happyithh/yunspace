<?php

/**
 * Created by PhpStorm.
 * User: yl
 * Date: 16/05/19
 * Time: 09:20
 * 专题数据表
 */
class Data_Mysql_Table_Topic extends Data_Mysql_Table
{
    public $cols = array(
        'topic_name' => '200',
        'topic_url' => '200',
        'topic_title' => '200',
        'topic_des' => 'html',
        'seo_title' => '200',
        'seo_keywords' => '300',
        'small_logo' => '200',
        'big_logo' => '200',
        'home_title' => '200',
        'home_summary' => '200',
        'is_home' => 'int', //是否在首页展示   1 展示
        'topic_type'=>'tinyint',    //专题分类  1为场地专题  该字段备用
        'status' => 'tinyint',  // 0下线  1上线
        'count_view' => 'int',  // 浏览量
        'create_time' => 'int',
        'update_time' => 'int',
    );
    public $index = array(
        'topic_url'=>'u',
        'topic_name'=>'title',
    );
    public $title = array(
        'topic_name' => '专题名称',
        'topic_url' => '专题地址',
        'status' => '状态',  // 0下线  1上线
        'create_time' => '创建时间',
        'update_time' => '更新时间',
    );

    static public $status=array(
        '1'=>'上线',
        '0'=>'下线',
    );
    static public $theme_type=array(
        '1'=>'场地专题',
    );
}