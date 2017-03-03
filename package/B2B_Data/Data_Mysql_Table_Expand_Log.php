<?php

/**
 * Created by PhpStorm.
 * User: yl
 * Date: 15/09/06
 * Time: 10：03
 * 拓展日志，方便统计拓展人
 */
class Data_Mysql_Table_Expand_Log extends Data_Mysql_Table
{
    public $cols = array(
        'vendor_id' => 'int',
        'account_id' => 'int',
        'admin_id' => 'int',
        'email' => '30',
        'admin_name' => '100',
        'status' => 'int', //-1已丢弃  0正常
        'create_time'=>'int',
        'update_time'=>'int',
    );
    public $index = array(
        'vendor_id' => 'u',                                                    //p:主键, u:唯一索引, i:索引
        'account_id' => 'u',
        'admin_id' => 'i',
        'vendor_name' => 'i',
        'email' => 'i',
    );
    public $title = array(
        "" => "供应商拓展日志",                                                     //空键,表名
        'vendor_id' => '供应商ID',
        'account_id' => '账户ID',
        'admin_id' => '操作者ID',
        'admin_name' => '操作者名称',
        'email' => '邮件地址',
        'create_time'=>'创建时间',
        'update_time'=>'更新时间',
    );
}