<?php

/**
 * Created by PhpStorm.
 * User: adu
 * Date: 15/6/11
 * Time: 11:41
 */
class Data_Mysql_Table_Weixin_Ticket_Num_Info extends Data_Mysql_Table
{
    public $cols = array(
        'ticket_num' => '50',  //票号
        'order_no' => '50',  //订单号
        'ticket_price' => '11',     //票价价格
        'ticket_detail' => 'string', //票种
        'ticket_id' => 'int', //票种id
//        'buyer_account_id' => 'int',  //购买用户id
//        'buyer_account_name' => 'string',  //购买用户名
//        'buyer_account_phone' => '14',  //购买者手机号
        'event_id' => 'int',   //活动id
        'create_time' => 'int',   //购票时间
        'use_time' => 'int', //使用时间
        'update_time' => 'int',  //更新时间
        'status' => 'tinyint',  //0 未使用  1 已使用
    );
    public $index = array(
        'ticket_num' => 'u',
        'order_no' => 'i',
        'buyer_account_id' => 'i',
        'event_id' => 'i',
        'create_time' => 'i',
        'use_time' => 'i',
        'update_time' => 'i',
        'status' => 'i',
    );
    public $title = array(
        "" => "微信门票订单信息",
        'ticket_num' => '票号',//空键,表名
        'order_no' => '订单号',
        'ticket_price' => '票价价格',
        'ticket_detail' => '票种',
        'buyer_account_name' => '购买用户名',
//        'geo_lat' => '地理GEO-LAT',
//        'geo_lng' => ' 地理GEO-LNG',
//        'attr' => '属性数据',
//        'attr_index' => '属性索引-扁平',
//        'media' => '媒体材料',
//        'media_num' => '媒体材料',
//        'des' => '介绍',
//        'counter_view_index' => '浏览量',
//        'counter_view' => '浏览量',
//        'counter_follow_index' => '订阅量',
//        'counter_follow' => '订阅量',
//        'counter_follow_cancel' => '取消订阅量',
//        'counter_order' => '订单数',
//        'counter_order_update' => '订单数',
//        'counter_order_complete' => '完成订单数',
        'create_time' => '购票时间',
        'use_time' => '使用时间',
        'update_time' => '更新时间',
//        'admin_id' => '活动创建者',
//        'count_product' => '产品总数',
    );
    public $titleHidden = array( //    list / form / both
//        'geo_lat' => 'both',
//        'geo_lng' => 'both',
//        'categories_id' => 'both',
//        'attr_index' => 'both',
//        'media' => 'list',
//        'media_num' => 'form',
//        'contacts' => 'both',
//        'des' => 'list',
//        'attr' => 'list',
//        'addr' => 'list',
//        'counter_view_index' => 'both',
//        'counter_follow_index' => 'both',
//        'counter_order' => 'both',
//        'create_time' => 'list',
//        'update_time' => 'list',
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