<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/5/7
 * Time: 13:43
 * IP数据表
 */
class Data_Mysql_Table_Winchance_New extends Data_Mysql_Table
{
    public $cols = array(
        // 储备信息
        'ip_name' => '300',  // ip项目名称
        'figure' => '300', // 人物形象名称
        'company' => '300',    // 公司名称
        'country' => '100', //来源国家
        // 审核上线信息
        'active_name' => '300',  // 上线活动名称
        'ip_des'=>'100',        //一句话简介
        'conform_crowd' => '500', // 符合人群  例：儿童,老人,20-30岁
        'age' => 'array', // 年龄段
        'category' => '1000',  // 分类
        'feature_tag'=>'500',//特色标签
        'cover_picture'=>'array',//封面图
        'ip_brief_introduction'=>'1000',//ip简介
        'budget'=>'string',//预算
        'storey'=>'string',//层高
        'supporting'=>'string',//配套
        'indoor_outdoor'=>'string',//室内室外
        'online_status'=>'int', //上线状态

        // 拜访或电话
        'agent' => 'array',  // 授权代理详情信息 （联系人、电话、授权公司名称、授权期限等）
        'city' => '3000',//运营范围 例如：上海,北京
        'ip_age' => 'int', // ip年龄
        'manifestation' => '500', //表现形式
        'mandate_expire' => 'int',  // 授权期限
        'min_area' => 'int',  //最小面积
        'max_area' => 'int',  //最大面积

        //完善IP信息
//        'cooperating_state'=>'100',//合作状态
        'cooperating_mode' => '3000',//合作模式
        'grant_country' => '100', //运营团队授权国家
        'curator' => '100',  // 策展人  无策展人时为空，有策展人时必填
        'grant_fee' => 'array', //授权费用信息
        'schedule' => '1000', //档期  开始时间/结束时间
        'materiel_source' => '100',  // 物料来源

        // 签订协议
        'agreement' => 'array',  // 协议详情
        'accessory' => 'array',  //  合同附件

        // 整体同步存在的字段
        'admin_id' => 'int',  // 负责人ID
        'operator_id' => 'int',  // 操作者ID
        'note' => 'text', // 备注
        'create_time' => 'int',
        'update_time' => 'int',
        'step' => '50', // 进度 （当前处在哪个状态）
        'status' => 'int', // 区分已入驻/未入驻 1 已入住 0 未入驻 -1已删除

        'space_id'=>'int'//关联百科里space_id

    );
    public $index = array(
        'ip_name' => 'title',
        'figure' => 'title',
        'company' => 'title',
        'active_name' => 'title',
        'country' => 'i',
        'category' => 'attr',  // 分类
        'step' => 'i',
        'city' => 'attr',
        'manifestation' => 'i', //表现形式
        'min_area' => 'i',  //最小面积
        'max_area' => 'i',  //最大面积
        'cooperating_mode' => 'attr',//合作模式
        'create_time' => 'i',
        'update_time' => 'i'

    );

    static $step = array(
        '1' => '储备',
        '2' => '审核上线',
        '3' => '拜访或电话',
        '4' => '完善IP信息',
        '5' => '签订协议',
    );
}