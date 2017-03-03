<?php

class Data_Mysql_Table_Vendor_Join extends Data_Mysql_Table
{
    public $cols = array(
        'account_id' => 'int',
        'ip' => '20',
        'city' => '15',
        'product_name' => '300',  //产品名称
        'card' => 'array',   //名片
        'category_id' => 'int',   //商品类型
        'product_des' => '300',        //产品介绍
        'vendor_name' => '200',             //供应商名称
        'phone' => '15',               //联系方式
        'contact_people' => '100',      //联系人
        'media' => 'array',    //图片
        'other' => 'html',        //其他信息
        'create_time' => 'int',
        'update_time' => 'int',
        'remark' => '300',
        'refuse_reason' => '300',   //拒绝原因
        'status' => 'tinyint'   //0 新创建   1通过审核    -1  未通过
    );
    public $index = array(
        'account_id' => 'i',
        'category_id' => 'i',
        'vendor_name' => 'i',
        'product_name' => 'i',
        'contact_people' => 'i',
        'status' => 'i',
        'phone' => 'i',
    );

    public static $status = array(
        '0' => '未审核',
        '1' => '已通过',
        '-1' => '已拒绝',
    );
}