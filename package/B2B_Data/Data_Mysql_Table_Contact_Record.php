<?php

/**
 * Class Data_Mysql_Table_Contact_Record
 * zzc 、12/15
 */
class Data_Mysql_Table_Contact_Record extends Data_Mysql_Table
{
    public $cols = array(
//        'contact_id' => 'int',
        'admin_id' => 'int',
        'admin_name' => '20',
        'time' => 'int',
        'step'=>'int',
        'phone' => '15',
        'demand_id' => 'int',
        'content' => 'text',
    );
    public $index = array(
//        'contact_id' => 'i',
        'admin_id' => 'i',
        'admin_name' => 'i',
        'content' => 'i',
        'phone,demand_id' => 'i',
    );
    public $title = array(
        'contact_id' => '联系人ID',
        'admin_id' => '后台人员ID',
        'admin_name' => '后台人员姓名',
        'time' => '联系时间',
        'content' => '联系内容',
    );
}