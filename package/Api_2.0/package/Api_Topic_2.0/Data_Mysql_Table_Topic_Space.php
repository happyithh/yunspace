<?php

/**
 * Created by PhpStorm.
 * User: yl
 * Date: 16/05/19
 * Time: 09:20
 * 场地专题数据表
 */
class Data_Mysql_Table_Topic_Space extends Data_Mysql_Table
{
    public $cols = array(
        'topic_id' => 'int',
        'space_id' => 'int',
        'space_name' => '200',
        'logo' => '200',    //场地图片
        'activity_type' => '200',//活动类型
        'framework' => '200',//场地面积和描述
        // 'size' => 'int',//场地面积
        'visit_people' => '200',//人流量
        'price' => '200',//价格和价格单位
        'discount' => '100',//折扣描述
        'max_people' => 'int',//可容纳人数
        'addr' => '200',//地址
        'des' => 'html',//场地描述
        'click_num' => 'int',//点击量（专题页过去的点击量）
        'status' => 'tinyint',  // 0下线  1上线
        'create_time' => 'int',
        'update_time' => 'int',
    );
    public $index = array(
        'topic_id,space_id'=>'u',
    );
    public $title = array(
        'topic_id' => '专题ID',
        'space_id' => '场地ID',
        'space_name' => '场地名称',
        'logo' => '场地图片',
        'activity_type' => '活动类型',
        'framework' => '场地结构',
        'size' => '场地面积',
        'visit_people' => '人流量',
        'price' => '价格和价格单位',
        'discount' => '折扣描述',
        'max_people' => '可容纳人数',
        'addr' => '地址',
        'click_num' => '点击量',
        'status' => '状态', 
        'create_time' => '创建时间',
        'update_time' => '修改时间',
    );

    static public $status=array(
        '1'=>'上架',
        '0'=>'下架',
    );
}