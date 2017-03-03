<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/10/16
 * Time: 13:40
 * 商品表匹配表（报价）
 *
 * 存放场地的匹配记录等等
 */
class Data_Mysql_Table_Demand_Match_Space_Archives extends Data_Mysql_Table
{
    public $cols = array(
        'item_id' => 'int',         //商品的ID
        'vendor_id' => 'int',         //供应商的ID
        'price_up' => 'int',            //价格上限
        'price_down' => 'int',          //价格下限
        'people_up' => 'int',             //人数上限
        'people_down' => 'int',             //人数下限
        'tags' => 'array',                    //标签
        'city' => '50',                    //城市
        'effective_time' => 'int',        //有效时间      1 2 3
        'grade' => 'int',              //优先级  1 2  3
        'notice_sum' => 'int',            //  总通知数
        'response_sum' => 'int',             //总响应数
        'notice_last_time' => 'int',     //最后一次通知的时间
        'scheme_last_time' => 'int',     //最后一次 提交方案的时间
        'update_time' => 'int',

    );

    public $index = array(
        'item_id' => 'u',
        'price_up,price_down' => 'i',
        'people_up,people_down' => 'i',
        'effective_time' => 'i',
        'grade' => 'i',
        'city' => 'i',
        'notice_sum' => 'i',
        'response_sum' => 'i',
        'notice_last_time,scheme_last_time' => 'i',
        'tags' => 'attr',
    );

}