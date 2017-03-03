<?php

/**
 * Created by PhpStorm.
 * User: yl
 * Date: 15/10/16
 * Time: 10:11
 * 场地百科指向，场地更改名称之后，储存旧的场地名称，指向新的链接
 */
class Data_Mysql_Table_Space_Redirect extends Data_Mysql_Table
{
    public $cols = array(
        'space_id'=>'int',
        'space_name' => '200',
//        'redirect_url'=>'300',
        'create_time' => 'int',
        'update_time' => 'int',

    );
    public $index = array(
        'space_name' => 'u',
    );
    public $title = array(
        'space_id' => '场地ID',
        'space_name' => '场地名称',
//        'redirect_url'=>'指向的url',
        'create_time' => '创建时间',
        'update_time' => '更新时间',
    );

}