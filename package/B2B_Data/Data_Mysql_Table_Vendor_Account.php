<?php

/**
 * Created by PhpStorm.
 * User: yl
 * Date: 15/06/30
 * Time: 18:00
 * 账户更改绑定供应商表
 */
class Data_Mysql_Table_Vendor_Account extends Data_Mysql_Table
{
    public $cols = array(
        'account_id' => 'int',
        'vendor_name' => '100',
        'old_vendor_id' => 'int',
        'base_info' => 'array',
        'attr' => 'array',
        'logo'=>'100',
        'des' => 'html',
        'demo'=>'text',
        'create_time' => 'int',
        'update_time' => 'int',
        'status' => 'int',
    );
    public $index = array(
        'account_id' => 'u',                                                    //p:主键, u:唯一索引, i:索引
    );
    public $title = array(
        ""=>'账户更改绑定的供应商表',
        'account_id' => '账户ID',
        'vendor_name' => '新供应商名称',
        'old_vendor_id' => '旧的供应商ID',
        'base_info' => '基本信息',
        'attr' => '属性',
        'logo'=>'LOGO',
        'des' => '描述',
        'demo'=>'备注',
        'create_time' => '创建时间',
        'update_time' => '更新时间',
        'status' =>'状态',    // 0 初始状态   1 绑定原有供应商   2   创建新的供应商     -1  请求拒绝
    );
    public $titleHidden = array(
    );

}