<?php

/**
 * Created by PhpStorm.
 * User: yl
 * Date: 15/9/28
 * Time: 15:01
 * 批量处理数据临时表
 */
class Data_Mysql_Table_Import_Log extends Data_Mysql_Table
{
    public $cols = array(
        'product_id' => 'int',
        'product_name' => '200',
        'category_id' => 'int',
        'price' => 'int',
        'is_lowest' => 'tinyint',     //起价  1 起价
        'unit' => '50',        //价格单位
        'max' => '100',        //价格上线
        'min' => '100',        //价格下线
        'size'=>'int',
        'username'=>'100',
        'phone_old'=>'11',
        'phone_new'=>'11',
        'status'=>'tinyint',    //1已更新， 0未更新
        'create_time'=>'int',
        'update_time'=>'int',
    );
    public $index = array(
        'product_id'=>'u',
        'product_name' => 'i',
        'status' => 'i',
    );
    public $title = array(
        "" => "批量处理临时表",                                                     //空键,表名
        'product_id' => '产品ID',
        'product_name' => '产品名称',
        'category_id' => '产品分类',
        'price' => '产品价格',
        'is_lowest' => '是否是起价',     //起价  1 起价
        'unit' => '价格单位',        //价格单位
        'max' => '价格上限',        //价格上线
        'min' => '价格下限',        //价格下线
        'size'=>'面积',
        'username'=>'联系人',
        'phone_old'=>'旧联系方式',
        'phone_new'=>'新联系方式',
        'status'=>'状态',    //1已更新， 0未更新
        'create_time'=>'创建时间',
        'update_time'=>'更新时间',
    );
}