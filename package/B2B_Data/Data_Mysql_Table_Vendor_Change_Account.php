<?php

/**
 * Created by PhpStorm.
 * User: liushengchun
 * Date: 15/1/28
 * Time: 11:41
 */
class Data_Mysql_Table_Vendor_Change_Account extends Data_Mysql_Table
{
    public $cols = array(
        'vendor_id' => 'int',
        'old_account_id' => 'int',
        'old_account_name' => '100',
        'new_account_id' => 'int',
        'create_time' => 'int',
        'update_time' => 'int',
        'status' => 'int',  //0 待审核 1审核成功   -1审核未通过
        'demo' => 'text',
        'admin_id' => 'int',
    );
    public $index = array(
        'vendor_id' => 'u',
        'old_account_name'=>'title',
    );
    public $title = array(
        "" => "供应商变更绑定的账户",
        'vendor_id' => '供应商ID',
        'old_account_id' => '旧的账户ID',
        'old_account_name' => '旧的账户名称',
        'new_account_id' => '新的账户ID',
        'create_time' => '创建时间',
        'update_time' => '更新时间',
        'status' => '状态',  //0 待审核 1审核成功   -1审核未通过
        'demo' => '备注',
        'admin_id' => '操作者',
    );
    public $titleHidden = array( //    list / form / both
    );

}