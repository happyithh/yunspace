<?php

/**
 * Created by PhpStorm.
 * User: yl
 * Date: 15/09/06
 * Time: 10：03
 * 新拓展数据，为子空间
 */
class Data_Mysql_Table_Item_Expand_New extends Data_Mysql_Table
{
    public $cols = array(
        'item_id' => 'int',
        'admin_id' => 'int',
        'admin_name' => '100',
        'create_time'=>'int',
        'update_time'=>'int',
    );
    public $index = array(
        'item_id' => 'i',
        'admin_id' => 'i',
        'admin_name' => 'i',
    );
    public $title = array(
        "" => "子空间拓展日志",                                                     //空键,表名
        'item_id' => '子空间ID',
        'admin_id' => '拓展人',
        'admin_name' => '拓展名',
        'create_time'=>'拓展时间',
        'update_time'=>'更新时间',
    );
}