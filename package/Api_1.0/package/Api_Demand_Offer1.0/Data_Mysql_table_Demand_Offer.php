<?php

/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2015/10/16
 * Time: 9:47
 *  报价系统主表
 */
class  Data_Mysql_Table_Demand_Offer extends Data_Mysql_Table
{
    public $cols = array(
        'demand_id' => 'int',       //需求ID
        'demand_filter' => 'array',     //需求筛选条件
        'admin_id' => 'int',         //操作人id（报价系统操作员） 领取人（呼出团队）
//        'customer_phone'=>'string', //客户手机号
        'create_time' => 'int',         //创建时间
        'update_time' => 'int',         //修改时间
        'notice_time' => 'int',             //通知时间
        'status' => 'int',         //本次报价状态。-1 关闭  0 正常  //4报价完成
        'receive_time' => 'int',             //领取时间
        'view_count_c' => 'int',     //客户浏览数量
        'view_count_v' => 'int',     //商家浏览数量
        'match_result' => 'int',     //匹配结果       //12/28  这个字段的结果是进入报价30分统计的
        'result_notice_time' => 'int', //匹配结果通知时间
        'reason' => 'string',
        'order_quality' =>'int',
    );

    public $index = array(
        'demand_id' => 'u',
        'demand_filter' => 'attr',
        'admin_id' => 'i',
        'view_count_c' => 'i',
        'view_count_v' => 'i',
    );

    static $_status = array(
        0 => '进行中',
        1 => '进行中',
        2 => '进行中',
        3 => '进行中',
        4 => '完成',
        -1 => '客户关闭',
    );

//报价单位
    static $_offer_price_unit = array(
        '总价',
        '天',
        '半天',
        '小时',
        '人'
    );
}