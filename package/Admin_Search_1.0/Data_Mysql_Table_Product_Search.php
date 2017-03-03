<?php
/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/4/14
 * Time: 15:38
 */
//产品搜索表
Class Data_Mysql_Table_Product_Search extends Data_Mysql_Table
{

    public $cols = array(
        'vendor_id' => 'int',
        'category_id' => 'int',
        'vendor_name' => '200',
        'product_name' => '200',
        'addr' => '200',
        'logo' => '100',
        'geo_lat' => 'int',
        'geo_lng' => 'int',
        'price' => 'int',           //价格   除以100显示
        'attr_index' => 'array',
        'des' => 'html',
        'update_time' => 'int',
        'counter_follow' => 'int',
        'counter_order' => 'int',
        'counter_order_complete' => 'int',
        'order_product_size' => 'int',
        'order_score' => '10',
        'order_counter_view' => 'int',
        'order_index' => 'int',
        'order_people_number' => 'int',              //人数
        'status' => 'tinyint',
        'vendor_signing' => 'int',        // 供应商是否签约   0 : 未签约  2：已签约
        'vendor_account_id' => 'int'            //  供应商是否认领  0: 未认领
    );

    public $index = array(
        'category_id' => 'i',
        'order_people_number' => 'i',
        'vendor_name,product_name,addr' => 'title',
        'geo_lat' => 'i',
        'geo_lng' => 'i',
        'attr_index' => 'attr',
        'order_product_size' => 'i',
        'order_score' => 'i',
        'counter_follow' => 'i',
        'price' => 'i',
        'order_counter_view' => 'i',
        'order_index' => 'i',
        'status' => 'i',
        'vendor_singing' => 'i',
        'vendor_account_id' => 'i'
    );
    public $title = array(
        'category_id' => '产品类型',
        'vendor_id' => '供应商id',
        'vendor_name' => '供应商名称',
        'product_id' => '产品id',
        'product_name' => '产品名称',
        'addr' => '产品地址',
        'logo' => 'logo',
        'geo_lat' => '地理GEO-LAT',           //x
        'geo_lng' => '地理GEO-LNG',           //y
        'attr_index' => '属性索引-扁平',
        'counter_follow' => 'i',
        'counter_order' => 'i',
        'des' => '介绍',
        'update_time' => '更新时间',

        'counter_follow' => '收藏量',
        'counter_order' => '订单数',
        'counter_order_complete' => '完成订单数',

        'order_product_size' => '面积',
        'order_score' => '评分',
        'order_counter_view' => '浏览量',
        'order_index' => '自定义排序',
        'order_set_top' => '设置置顶',
        'vendor_signing' => '签约状态',
        'vendor_account_id' => '是否被认领'
    );
    static $product_size = array(
        1 => '小于200㎡',
        200 => '200-500㎡',
        500 => '500-800㎡',
        800 => '800-1000㎡',
        1000 => '1000-2000㎡',
        2000 => '2000㎡以上',
    );
}