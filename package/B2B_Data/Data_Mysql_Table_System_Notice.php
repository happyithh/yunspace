<?php

/**
 * Class Data_Mysql_Table_System_Notice
 *
 *
 * 系统公告
 */
class Data_Mysql_Table_System_Notice extends Data_Mysql_Table
{
    public $cols = array(
        'title' => '200',
        'admin_id' => 'int',
        'category_id' => 'int',     //1 公告   5 抢单公告
        'content' => 'html',
        'create_time' => 'int',
        'status' => 'int', //-1删除  0正常
    );
    public $index = array(
        'category_id,title' => 'i',
        'content' => 'i',
    );


}