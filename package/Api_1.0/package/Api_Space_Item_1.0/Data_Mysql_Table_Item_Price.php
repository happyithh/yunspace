<?php

/**
 * Created by PhpStorm.
 * User: yl
 * Date: 15/10/16
 * Time: 10:11
 * 场地子空间价格相关数据表
 */
class Data_Mysql_Table_Item_Price extends Data_Mysql_Table
{
    public $cols = array(
        'space_id' => 'int',
        'item_id' => 'int',
        'is_public' => 'int',   //是否公开  1 公开
        'standard' => '100',    //规格
        'start_lifetime' => 'int',  //有效期开始时间
        'end_lifetime' => 'int',    //有效期结束时间
        'price_unit' => '50',   //价格单位
        'day_or_people' => 'int',   //是以时间为单位还是以人为单位  1 以时间为单位  2 以人为单位，方便检索用
        'market_price' => 'int',    //市场价
        'discount_price' => 'int',    //优惠价
        'discount_price_B' => 'int',    //优惠价B 如果单位不是元/天,转换为元/天的价格
        'inner_price' => 'int',     //内部价
        'inner_price_B' => 'int',     //内部价B 如果单位不是元/天,转换为元/天的价格
        'consult_price' => '100',     //协商价
        'price_status' => 'tinyint',     //价格状态
        'update_time' => 'int',
    );
    public $index = array(
        'space_id,item_id,standard' => 'u',
        'discount_price_B'=>'i',
        'item_id'=>'i',
        'space_id'=>'i',
        'discount_price'=>'i',
    );
    public $title = array(
        'space_id' => '场地ID',
        'item_id' => '空间ID',
        'is_public' => '是否公开',
        'standard' => '规格',
        'start_lifetime' => '有效期开始时间',
        'end_lifetime' => '有效期结束时间',
        'price_unit' => '价格单位',
        'market_price' => '市场价',
        'discount_price' => '优惠价',
        'inner_price' => '内部价',
        'consult_price' => '协商价',

    );

    static $price_unit = array(
        "天"=>'元/天',
        "周"=>'元/周',
        "半天"=>'元/半天',
        "小时"=>'元/小时',
        "㎡/天"=>'元/㎡/天',
        "场"=>'元/场',
        "人"=>'元/人'
    );
    static $price_status=array(
        1=>'上线',
        0=>'下线',
        -1=>'删除',
    );

}