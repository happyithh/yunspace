<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/4/8
 * Time: 9:48
 * 文创场地专用
 */
class Data_Mysql_Table_Winchance_Site extends Data_Mysql_Table
{
    public $cols = array(
        'site_name' => '300',          //场地名称
        'city' => '50',                // 城市
        'site_type' => '100',          // 场地类型
        'step' => '50',                // 场地进度
        'des' => 'array',               //场地基本资料以及需求
        'plan' => 'array',             //工作计划 （本周、下周）
        'admin_id' => 'int',           // 操作者ID
        'operator' => '300',           // 负责人
        'note' => 'array',              // 备注
        'create_time' => 'int',        //创建时间
        'update_time' => 'int',        //更新时间
        'entry_type'=>'int',           //1 线上  2 线下
        'status'=>'int',               //场地状态
        'demand_id'=>'int',            // 线上需求转换成场地 demand_id唯一
    );
    public $index = array(
        'site_name' => 'title',
        'city' => 'i',
        'site_type' => 'i',
        'step' => 'i',
        'admin_id' => 'i',
        'operator' => 'i',
        'entry_type'=>'i',
        'demand_id'=>'u',
    );
    public $title = array(
        'site_name' => '场地名称',
        'city' => '城市',
        'site_type' => '场地类型',
        'step' => '场地进度',
        'des' => '场地基本资料以及需求',
        'plan' => '工作计划',
        'admin_id' => '负责人',
        'note' => '备注',
        'create_time' => '创建时间',
        'update_time' => '更新时间',
        'demand_id'=>'需求ID'
    );

    static $step = array(
        'A' => '双方已签署合同',
        'B' => '方案谈判阶段',
        'C' => '客户确认方案',
        'D' => '方案提交',
        'E' => '需求信息不明确',
        'F' => '储备场地'
    );
    static $site_type = array(
        1 => '办公楼',
        2 => '创意园区',
        3 => '会展中心',
        4 => '商业中心',
        5 => '艺术空间',
    );
}