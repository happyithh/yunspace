<?php

/**
 * Created by PhpStorm.
 * User: lsc
 * Date: 15/6/30
 * Time: 13:41
 */
class Data_Mysql_Table_LiveChat_Contacts extends Data_Mysql_Table
{
    //最近消息列表，最后一条信息保存在这个表里
    public $cols = array(
        'account_id' => 'int',  //用户ID
        'contact_account_id' => 'int',  //目标联系人
        'contact_name' => '50', //备注名称
        'config' => 'array',     //配置
        'update_time' => 'int',  //消息更新时间
        'status' => 'tinyint',    //状态  0 陌生, 1 普通, 2 关注, -1 删除, -2 黑名单
        'initials' => '2',  //联系人首字母
    );
    public $index = array(
        'account_id,contact_account_id' => 'u',
        'update_time' => 'i',
    );
}