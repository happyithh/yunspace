<?php

/**
 * Created by PhpStorm.
 * User: adu
 * Date: 15/6/11
 * Time: 11:41
 */
class Data_Mysql_Table_Weixin_Ticket_Order_Info extends Data_Mysql_Table
{
    public $cols = array(
        'order_no' => '50',  //订单号
        'buyer_account_id' => 'int',  //购买用户id
        'buyer_account_name' => 'string',  //购买用户名
        'buyer_account_phone' => '15',  //购买用户手机号
        'event_id' => 'int',   //活动id
        'event_title' => 'string',   //活动名称
        'order_price' => '11',     //订单价格
        'order_ticket_num' => '11',     //门票总张数
        'order_price_pay' => '11',   //订单支付金额
        'order_detail' => 'array', //票种，张数及票号
        'order_status' => 'tinyint', //  0:已下订单;  1： 已付款   -1:关闭（不买了）  -2 订单删除（不显示）
        'create_time' => 'int',   //1下单时间
        'create_time2' => 'int', //2支付完成时间
        'update_time' => 'int',  //更新时间
        'status' => 'tinyint',  //1 正常  3 超时订单已处理  -9 订单已删除,
        'addressInfo'=>'array', // 邮寄实体票地址
        'logisticsInfo'=>'array',//物流信息
        'price_is_score'=> 'int',   //价格是否为积分的标识，1价格是积分
    );
    public $index = array(
        'order_no' => 'u',
        'buyer_account_id' => 'i',
        'event_id' => 'i',
        'order_status' => 'i',
        'create_time' => 'i',
        'update_time' => 'i',
        'status' => 'i',
    );
    public $title = array(
        "" => "微信门票订单信息",                                                     //空键,表名
        'order_no' => '订单号',
        'buyer_account_name' => '购买用户名',
        'buyer_account_phone' => '购买用户手机号',
        'event_title' => '活动名称',
        'order_price' => '订单价格',
        'order_ticket_num' => '门票总张数',
        'order_price_pay' => '订单支付金额',
        'order_price' => '订单价格',
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
        'create_time' => '下单时间',
        'create_time2' => '支付完成时间',
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