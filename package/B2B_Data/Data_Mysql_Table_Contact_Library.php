<?php

class Data_Mysql_Table_Contact_Library extends Data_Mysql_Table
{
    public $cols = array(
        'username' => '30',
        'phone' => '15',
        'tel' => '15',
        'business' => '100',
        'sub_business' => '100',
        'city' => '200',
        'company' => '100',
        'product_name' => '200',
        'position' => '50',
        'attr' => 'array',
        'state' => 'int',
        'status' => 'int',
        'admin_id' => 'int',
        'account_id' => 'int',
        'vendor_id' => 'int',
        'new_demand_time' => 'int',  // 新需求的时间
        'type' => 'tinyint',        //1客户 ，21 供应商
        'customer_type' => 'tinyint',        //客户类型  1: KA客户   2,：标准产品客户   客户专属字段
        'create_time' => 'int'
    );
    public $index = array(
        'phone' => 'u',
        'business' => 'i',
        'sub_business' => 'i',
        'city' => 'attr',
        'company,position,username, product_name' => 'title',
        'state' => 'i',
        'account_id' => 'i',
        'vendor_id' => 'i',
        'type' => 'i',
        'new_demand_time' => 'i',
        'customer_type'=>'i',
    );
    public $title = array(
        'username' => '用户名',
        'phone' => '手机号',
        'business' => '业务类型ID',
        'sub_business' => '业务子类ID',
        'company' => '公司',
        'position' => '职务',
        'supplier_id' => '供应商ID',
        'attr' => '其他',
        'state' => '是否转为供应商',//-9999已转为供应商
        'account_id' => '已转化为供应商的账户ID',
        'type' => '联系人类型'
    );
   public  static  $state = array(
        '5' => 'A',
        '4' => 'B',
        '3' => 'C',
        '2' => 'D',

    );
}