<?php

/*
 * Created by PhpStorm
 * User: Yangchenglin
 * Date: 2015/8/4
 * Time: 13:55
 */

Class Data_Mysql_Table_Vendor_Candidate extends Data_Mysql_Table
{

    public $cols = array(

        //联系人字段->account账户表和contact_library联系人表
        'username' => '30',
        'phone' => '100',            //采集数据中可能包含多个电话
        //'business' => '100',
//        'sub_business' => '100',
        'city' => '200',
//        'company' => '100',

        //供应商字段->vendor_info_update表
//        'vendor_name' => '200',
//        'vendor_categories_id' => 'int',
//        'vendor_addr' => '200',
//        'vendor_logo' => '100',
//        'vendor_des' => 'html',
//        'vendor_attr' => 'array',
//        'vendor_base_info' => 'array',

        //产品字段->product_info_update表
        'product_name' => '200',
//        'product_category_id' => 'int',
        'product_addr' => '200',
        'product_price' => 'int',
        'product_size' => 'int',
        'product_attr_new' => 'array',
        'product_des' => 'html',
        'product_media' => 'array',

        'create_time' => 'int',     //入库时间
        'update_time' => 'int',
        'status' => 'int',          //状态 1为已接受，2为重复，3为待处理，4为无效，5为数据不完整
//        'from_where' => 'int',      //数据来源 1为采集，2为表格导入
        'from_where' => 'string',     //采集于哪个网站
//        'manager_id' => 'int',        //负责人id
        'is_deal_water' => 'int'      //0为未处理水印，1是已经处理水印
    );


    public $index = array(                                                //p:主键, u:唯一索引, i:索引
        'city,product_name,product_addr' => 'title',

    );
}
