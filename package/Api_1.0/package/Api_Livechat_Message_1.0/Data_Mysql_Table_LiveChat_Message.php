<?php

/**
 * Created by PhpStorm.
 * User: lsc
 * Date: 15/6/30
 * Time: 13:41
 */
class Data_Mysql_Table_LiveChat_Message extends Data_Mysql_Table
{
    //最近消息列表，最后一条信息保存在这个表里
    public $cols = array(
        'to_account_id' => 'int',  //接收人id > 0 是用户,  < -10000 是群组 ,  -10000 < id< 0 特殊账号, 如系统通知等
        'from_account_id' => 'int',  //来源id
        'create_time' => 'int',  //消息更新时间
        'message' => 'html',
    );
    public $index = array(
        'to_account_id' => 'i',
        'from_account_id' => 'i',
        'create_time' => 'i',
    );
}