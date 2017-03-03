<?php

/**
 * Created by PhpStorm.
 * User: yl
 * Date: 15/10/16
 * Time: 10:11
 * 场地百科子空间数据表
 */
class Data_Mysql_Table_Space_Item extends Data_Mysql_Table
{
    public $cols = array(
        'space_id' => 'int',
        'item_name' => '200',
        'city' => '50',
        'logo' => '100',
        'size' => 'int',
        'activity_type' => 'array',
        'tags' => 'array',  //以后可能没有的标签
        'tags_new'=>'200',
        'price_unit' => '50',
        'min_price' => '100',   //以后可能不用，使用了第三个价格表
        'max_price' => '100',   //以后可能不用，使用了第三个价格表
        'min_people' => 'int',
        'max_people' => 'int',
        'inner_price' => 'int', //内部底价  //以后可能不用，使用了第三个价格表
        'layer_height' => 'int', //层高
        'item_weight' => 'int', //空间承重
        'desk_num' => 'int', //桌数
        'seat_num' => 'int', //座位数
        'stage_size' => 'int', //舞台面积
        'visit_num' => 'int', //人流量
        'person_spend' => 'int', //人均消费
        'is_outside' => 'int', //是否户外      1 室内  2 开放  3 半开放
        'past_case' => 'html', //过往案例/适合活动
        'agreement' => 'html', //协议
        'demo' => 'html', //备注
        'media' => 'array',
        'des' => 'html',
        'contacts' => '100',
        'phone' => '11',
        'email' => '100',
        'office_phone' => '100',
        'admin_name' => '100',  //负责人
        'location_area' => '100',    //落位区域
        'lifetime' => '100',   //产品周期
        'status' => 'tinyint',
        'refuse_reason' => '200',
        'expand_status' => 'int',
        'expand_demand_id' => 'int',
        'expand_refuse_reason'=>'200',
        'product_id' => 'int',
        'create_time' => 'int',
        'update_time' => 'int',
        'is_thc'=>'int',
    );
    public $index = array(
        'item_name,addr' => 'title',
        'past_case' => 'title',
        'activity_type' => 'attr',
        'tags' => 'attr',
        'location_area'=>'attr',
        'tags_new'=>'attr',
        'lifetime'=>'attr',
        'city' => 'i',
        'phone' => 'i',
        'space_id'=>'i',
        'min_price,max_price' => 'i',
        'min_people,max_people' => 'i',
        'status,expand_status' => 'i',
    );
    public $title = array(
        'space_id' => '场地百科ID',
        'item_name' => '子空间名称',
        'activity_type' => '活动类型',
        'tags' => '标签',
        'city' => '城市',
        'logo' => 'LOGO',
        'size' => '场地面积',
        'price_unit' => '价格单位',
        'min_price' => '最低价格',
        'max_price' => '最高价格',
        'min_people' => '最少人数',
        'max_people' => '最大人数',
        'media' => '子空间图片',
        'des' => '子空间描述',
        'contacts' => '子空间负责人名称',
        'phone' => '子空间负责人电话',
        'email' => '子空间负责人邮箱',
        'status' => '子空间状态',    //-1 删除     0 下线     1 上线       2 审核中     3 审核拒绝
        'refuse_reason' => '拒绝原因',
        'expand_status' => '拓展状态', //  -3 都无兴趣  0   未拓展     1   对本次需求有兴趣，对报价感兴趣     2  对本次需求无兴趣，对报价系统有兴趣 -1一直找不到联系方式的 下移
        'expand_demand_id' => '拓展所属需求id',
        'expand_refuse_reason' => '没有兴趣的原因',
        'product_id' => '转换过来的旧商品ID',
        'create_time' => '创建时间',
        'update_time' => '更改时间',
    );

    static $status=array(
        -1=>'删除',
        0=>'下线',
        1=>'上线',
        2=>'审核中',
        3=>'审核拒绝'
    );

    //子空间落位区域
    static $location_area=array(
        "商铺",
        '廊道',
        '中庭/平台',
        '外广场',
        '出入口',
        '电梯口',
        '地铁口',
        '端头'
    );

    //子空间产品周期
    static $lifetime=array(
        1=>'1个月以下',
        2=>'1-3个月',
        3=>'3-6个月',
        4=>'6个月以上',
        5=>'长期租赁',
    );

    static $outside=array(
        1 =>'室内' , 
        2 =>'开放' , 
        3 =>'半开放'
    );

}