<?php
/*
 * Created by PhpStorm
 * User: Yangchenglin
 * Date: 2015/9/7
 * Time: 16:44
 */
Class  Data_Mysql_Table_Raiders_Candidate extends Data_Mysql_Table
{
    public $cols = array(
        'title' =>'200',
        'des' => 'html',
        'cont' => 'html',
        'create_time' => 'int',     //入库时间
        'update_time' => 'int',     //操作时间
        'username' => '30',         //操作人
        'status' => 'int',          //状态 1为已接受，2为重复，3为待处理，4为无效，5为数据不完整
        'from_where' => 'string',   //采集的网址来源
    );
//    public $index = array(
//        'title' => 'title',
//    );
}