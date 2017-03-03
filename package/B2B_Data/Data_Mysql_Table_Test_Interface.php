<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2015/7/22
 * Time: 11:43
 */
class Data_Mysql_Table_Test_Interface extends Data_Mysql_Table
{
    public $cols = array(
        'interface_name' => 'string',      // 接口名称
        'category' => 'string',            //接口类型
        'des' => 'string',                 //接口说明
        'type' => 'string',                //接口传递类型
        'data' => 'string',                 //接口传递的参数
        'status' => 'int',                   // 0: 正常  -1 删除
        'create_time' => 'int',
        'update_time' => 'int',
    );
    public $index = array(
        'interface_name' => 'i',
        'category' => 'i',
        'type' => 'i',
        'status' => 'i'
    );
    static $category = array(
        '1' => '消息',
        '2'=>'需求',
        '3'=>'供应商',
        '4'=>'采购者',
        '5'=>'信息统计',
        '6'=>'产品',
        '7'=>'账户'
    );
}