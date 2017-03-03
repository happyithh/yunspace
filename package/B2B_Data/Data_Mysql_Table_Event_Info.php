<?php

/**
 * Created by PhpStorm.
 * User: liushengchun
 * Date: 15/1/28
 * Time: 11:41
 */
class Data_Mysql_Table_Event_Info extends Data_Mysql_Table
{
    public $cols = array(
        'category_id' => 'int',
        'event_name' => '200',
        'event_time' => 'int',
        'addr' => '200',
        'geo_lat' => 'int',
        'geo_lng' => 'int',
        'logo' => '100',
        'attr' => 'array',
        'attr_index' => 'array',
        'media_num' => 'int',
        'media' => 'array',
        'des' => 'html',
        'counter_view_index' => 'int',
        'counter_view' => 'int',
        'counter_follow_index' => 'int',
        'counter_follow' => 'int',
        'counter_follow_cancel' => 'int',
        'create_time' => 'int',
        'update_time' => 'int',
        'status' => 'tinyint',
    );
    public $index = array(
        'category_id,event_name,event_time' => 'u',                                                    //p:主键, u:唯一索引, i:索引
        'event_name' => 'title',
        'addr' => 'des',
        'attr_index' => 'attr',
        'geo_lat' => 'i',
        'geo_lng' => 'i',
        'event_time' => 'i',
        'counter_view_index' => 'i',
        'counter_follow_index' => 'i',
        'status' => 'i',
    );
    public $title = array(
        "" => "活动信息",                                                     //空键,表名
        'category_id' => '分类ID',
        'event_name' => '活动名称',
        'event_time' => '活动时间',
        'addr' => '地址',
        'geo_lat' => '地理GEO-LAT',
        'geo_lng' => ' 地理GEO-LNG',
        'attr' => '属性数据',
        'attr_index' => '属性索引-扁平',
        'media_num' => '媒体材料',
        'media' => '媒体材料',
        'des' => '介绍',
        'counter_view_index' => '浏览量索引',
        'counter_view' => '浏览量',
        'counter_follow_index' => '订阅量索引',
        'counter_follow' => '订阅量',
        'counter_follow_cancel' => '取消订阅量',
        'create_time' => '添加时间',
        'update_time' => '更新时间',
    );
    public $titleHidden = array( //    list / form / both
        'geo_lat' => 'list',
        'geo_lng' => 'list',
        'attr_index' => 'both',
        'media' => 'list',
        'media_num' => 'form',
        'des' => 'list',
        'attr' => 'list',
        'counter_view_index' => 'both',
        'counter_follow_index' => 'both',
        'create_time' => 'list',
        'update_time' => 'list',
    );
    public $filter = array(
        'status' => array(
            99 => '回收站',
            98 => '停用',
            1 => '正常',
            0 => '待审核',
        ),
    );

}