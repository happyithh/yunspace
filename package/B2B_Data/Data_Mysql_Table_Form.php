<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2015/6/23
 * Time: 16:01
 */
class Data_Mysql_Table_Form extends Data_Mysql_Table{
    public $cols = array(
        'form'=>'100',
        'field'=>'array',
        'email'=>'100',
        'backemail'=>'100',
        'start_time'=>'int',
        'end_time' =>'int',
        'create_time'=>'int',
        'update_time' =>'int',
        'status'=>'int',
    );
    public $index = array(
        'form'=>'title',
        'backemail'=>'i',
    );

}