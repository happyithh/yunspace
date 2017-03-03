<?php

/**
 * Created by PhpStorm.
 * User: adu
 * Date: 15/6/11
 * Time: 11:41
 */
class Data_Mysql_Table_Weixin_Event_Info extends Data_Mysql_Table
{
    public $cols = array(
        'title' => '200',   //活动名称
        'content' => 'html',  //活动详情
        'checkticketids' => 'array',  //检票ids
        'checkticketphone' => '500',  //检票手机号
//        'vendor_account_id' => 'int',
        'addr' => '200',
        'ticket_type' => 'int',
        'is_mail' => 'int',
        'event_logo' => '200',
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
        'activity_time'=>'int',  //活动开始时间
        'activity_end_time'=>'int',  //活动开始时间
        'create_time' => 'int',  //创建时间
        'update_time' => 'int',  //修改时间
        'start_time'=>'int',     //开始时间
        'end_time' =>'int',      //结束时间
        'status' => 'tinyint',  //-2 彻底删除   -1 回收站  0 下线    1 上线
        'is_showtime'=>'int',    // 是否显示门票时间 0 显示  1 不显示
        //'vendor_remarks' => 'array',  //其他备注信息     //签约信息   签约状态 0：未签约   2：已签约   1：合作备忘录
        //'count_product' => 'int',  //产品总数
        //'create_by_quick' => 'int', //1快速创建，0普通创建
        'admin_id' => 'int',      //创建者
    );
    public $index = array(
        'title' => 'i',                                                    //p:主键, u:唯一索引, i:索引
//        'content' => 'title',
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
        "" => "微信门票活动信息",                                                     //空键,表名
        'title' => ' 活动名称',
        'content' => '活动详情',
//        'categories_id' => '服务范围ID',
//        'contacts' => '联系人',
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
        'admin_id' => '活动创建者',
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