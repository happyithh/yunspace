<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2015/6/23
 * Time: 17:39
 */
Class Data_Mysql_Table_Form_Data extends Data_Mysql_Table
{
    public $cols = array(
        'form_id' => 'int',
        'username' => '50',
        'data' => 'array',
        'must_info'=>'string',
        'ip' => '15',
        'status'=>'int',
        'create_time' => 'int',
        'check_time' => 'int',
    );
    public $index = array(
        'form_id' => 'i',
        'username' => 'title',
        'must_info'=>'i',
    );

}