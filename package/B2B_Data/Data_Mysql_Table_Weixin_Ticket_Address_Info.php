<?php
/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2015/9/14
 * Time: 16:59
 */

class Data_Mysql_Table_Weixin_Ticket_Address_Info extends  Data_Mysql_Table
{

    public $cols = array(
        'account_id' => 'int',   //账户id
        'name'=>'string',  //收件人姓名
        'phone' => '15',  //收件人电话
        'address_content' => 'string',  //收件人地址
        'is_default'=>'int',  //是否为默认
        'create_time' => 'int',  //创建时间
        'update_time' => 'int',  //修改时间
        'status' => 'tinyint',  //-2 彻底删除     0 普通 1为默认
    );
    public $index = array(
        'account_id' => 'i',                                                    //p:主键, u:唯一索引, i:索引
        'name' => 'title',
        'status' => 'i',
    );
    public $title = array(
        "" => "微信售票收票地址",                                                     //空键,表名
        'name' => '收件人姓名',
        'phone' => '收件人电话',
        'address_content' => '收件人地址',
        'default' => '是否为默认',
        'create_time' => '添加时间',
        'update_time' => '更新时间',
    );



}