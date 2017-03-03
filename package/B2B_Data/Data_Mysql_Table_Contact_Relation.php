<?php

class Data_Mysql_Table_Contact_Relation extends Data_Mysql_Table
{
    public $cols = array(
        'contact_id' => 'int',
        'admin_id' => 'int',
        'allocate_time' => 'int',
        'status' => 'int',
        'operator_id' => 'int',
    );
    public $index = array(
        // 'contact_id'=>'i',
        'admin_id' => 'i',
        'allocate_time' => 'i',
    );
    public $title = array(
        'contact_id' => '联系人ID',
        'admin_id' => '后台人员ID',
        'allocate_time' => '关联时间',
        'status' => '状态',
        'operator_id' => '操作员ID',
    );
}