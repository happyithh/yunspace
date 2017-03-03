<?php

/**
 * Created by PhpStorm.
 * User: lsc
 * Date: 15/6/30
 * Time: 13:41
 */
class Data_Mysql_Table_LiveChat_Message_Recent extends Data_Mysql_Table
{
    //最近消息列表，最后一条信息保存在这个表里
    public $cols = array(
        'to_account_id' => 'int',  //接收人id
        'from_account_id' => 'int',  //来源id   >0 是用户,  <0 是群组
        'from_name' => '50',
        'update_time' => 'int',  //消息更新时间
        'message' => 'text',
        'total' => 'tinyint',        //未读消息数
        'is_notice' => 'tinyint',        //是否已发送通知
    );
    public $index = array(
        'to_account_id,from_account_id' => 'u',
        'from_account_id' => 'i',
        'update_time' => 'i',
        'is_notice' => 'i',
    );
}