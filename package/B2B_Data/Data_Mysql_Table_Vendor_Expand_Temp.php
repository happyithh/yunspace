<?php

/**
 * Created by PhpStorm.
 * User: yl
 * Date: 15/09/01
 * Time: 14:32
 * 拓展的供应商账户
 */
class Data_Mysql_Table_Vendor_Expand_Temp extends Data_Mysql_Table
{
    public $cols = array(
        'vendor_id' => 'int',
        'vendor_name' => '100',
        'account_id' => 'int',
        'username' => '20',
        'phone' => '15',
        'email' => '15',
        'city'=>'50',
        'status'=>'int',
        'create_time'=>'int',
        'update_time'=>'int',
    );
    public $index = array(
        'vendor_id' => 'u',                                                    //p:主键, u:唯一索引, i:索引
       'vendor_name'=>'title',
        'account_id' => 'i',
        'username' => 'i',
        'email' => 'i',
        'phone' => 'i',
        'status' => 'i',
    );
    public $title = array(
        "" => "供应商待拓展数据",                                                     //空键,表名
        'vendor_id' => '供应商ID',
        'vendor_name' => '供应商名称',
        'account_id' => '供应商绑定的账户ID',
        'username' => '账户名称',
        'phone' => '供应商绑定的账户的手机号',
        'email' => '供应商绑定的账户的邮箱',
        'status'=>'是否已拓展',      //1已拓展     0未拓展
        'create_time'=>'int',
        'update_time'=>'int',
    );
}