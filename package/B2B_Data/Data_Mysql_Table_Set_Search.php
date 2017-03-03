<?php
/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/7/1
 * Time: 15:38
 */
//套餐搜索表
Class Data_Mysql_Table_Set_Search extends Data_Mysql_Table
{

    public $cols = array(
        'set_name' => '200',               //  套餐名称
        'version' => '20',                       //  版本
        'addr' => '200',                       //  地址
        'category_id' => 'int',                  //分类id
        'vendor_id' => 'int',                  //供应商id
        'vendor_name' => '100',               //  供应商名称
        'hours' => 'int',                    //  小时数
        'people' => 'int',                    //  人数
        'schedule_product_id' => 'int',              //关联档期产品ID
        'attr_index' => 'array',                   //标签
        'logo' => '100',                     //logo
        'detail' => 'array',                //套餐价格清单
        'detail_des' => 'html',            //套餐版本细节
        'counter_order' => 'int',              //订单总数
        'create_time' => 'int',             //创建时间
        'update_time' => 'int',          //修改时间
        'order_score' => 'int',                //评分
        'order_counter_view' => 'int',          //浏览量
        'set_price' => 'int',                //价格
        'order_index' => 'int',     //自定义排序

        'geo_lat' => 'int',
        'geo_lng' => 'int',
        'attr_new' => 'array',              //产品的标签
        'status' => 'tinyint',               //0下线，1上线，2待审核，3审核未通过  -n  关闭
    );

    public $index = array(
        'vendor_name,set_name,addr,version' => 'title',
        'category_id' => 'i',
        'geo_lat' => 'i',
        'geo_lng' => 'i',
        'attr_index' => 'attr',
        'attr_new' => 'attr',
        'order_counter_view' => 'i',
        'order_score' => 'i',
        'order_index' => 'i',
        'set_price' => 'i',
        'status' => 'i',
    );
}