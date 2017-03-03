<?php

/**
 * Created by PhpStorm.
 * User: adu
 * Date: 15/6/11
 * Time: 11:41
 */
class Data_Mysql_Table_Weixin_Ticket_Info extends Data_Mysql_Table
{
    public $cols = array(
        'name' => '200',   //票名
        'price' => '500',  //票价
        'stock' => 'int',  //库存
        'event_time'=>'string',  //所属活动id
        'envent_id'=>'int',  //所属活动id
        'envent_title'=>'200',  //所属活动名称
        'price_is_score' => 'int',     //此标识用来判断价格是否为积分，1为积分（积分），空则为价格（元）
//        'addr' => '200',
//        'geo_lat' => 'int',
//        'geo_lng' => 'int',
//        'logo' => '100',
//        'base_info' => 'array',
//        'attr' => 'array',
//        'attr_index' => 'array',
//        'media_num' => 'int',
//        'media' => 'array',
//        'des' => 'html',
//        'counter_view_index' => 'int',
//        'counter_view' => 'int',
//        'counter_follow_index' => 'int',
//        'counter_follow' => 'int',
//        'counter_follow_cancel' => 'int',
//        'counter_order' => 'int',
//        'counter_order_update' => 'int',
//        'counter_order_complete' => 'int',
        'create_time' => 'int',  //创建时间
        'update_time' => 'int',  //修改时间
        'status' => 'tinyint',  //-2 彻底删除     1 上线
        //'vendor_remarks' => 'array',  //其他备注信息     //签约信息   签约状态 0：未签约   2：已签约   1：合作备忘录
        //'count_product' => 'int',  //产品总数
        //'create_by_quick' => 'int', //1快速创建，0普通创建
    );
    public $index = array(
//        'name' => 'i',                                                    //p:主键, u:唯一索引, i:索引
        'name' => 'title',
//        'attr_index' => 'attr',
//        'categories_id' => 'attr',
//        'vendor_account_id' => 'i',
//        'geo_lat' => 'i',
//        'geo_lng' => 'i',
//        'counter_view_index' => 'i',
//        'counter_follow_index' => 'i',
//        'counter_order' => 'i',
        'status' => 'i',
//        'admin_id' => 'i',
    );
    public $title = array(
        "" => "微信门票信息",                                                     //空键,表名
        'name' => ' 票名',
        'price' => '票价',
        'stock' => '库存',
        'envent_title' => '所属活动名称',
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
        'create_time' => '添加时间',
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