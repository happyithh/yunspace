<?php

/**
 * Created by PhpStorm.
 * User: 空间场地筛选日志
 * Date: 2015/9/24
 * Time: 10:08
 */
class  Data_Mysql_Table_Space_Screening_Log extends Data_Mysql_Table
{
    public $cols = array(
        'php_class ' => '50',
        'php_func ' => '50',
        'behavior ' => '100',         //行为
        'account_id' => 'int',      //
        'city'=>'30',
        'screening' => 'array',     //筛选条件
        'loginInfo' => 'array',
        'create_time' => 'int',
    );
    public $index = array();

}