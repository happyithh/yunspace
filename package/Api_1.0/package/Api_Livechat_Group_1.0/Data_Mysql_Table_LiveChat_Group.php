<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 15/7/8
 * Time: 13:41
 * @聊天群组表
 */
class Data_Mysql_Table_LiveChat_Group extends Data_Mysql_Table
{
    public $cols = array(
        'name' => 'string',         //群组名称
        'members' => 'array',       //成员
        'members_total' => 'int',
        'demand_id' => 'int',     //关联的活动需求单id
        'create_time' => 'int',     //创建时间
        'update_time' => 'int',     //更新时间
    );
    public $index = array(
        'name' => 'title',
        'members' => 'attr',
        'demand_id' => 'i',
    );

    //转成负数
    static function convertToAccountId($id)
    {
        return $id > 0 ? (-1 * $id - 10000) : $id;
    }
    //转成正整数
    static function convertFromAccountId($id)
    {
        return $id < 0 ? (-1 * $id - 10000) : $id;
    }

    static function isGroupId($id)
    {
        return $id < -10000;
    }
    static function  makeGroupId($id)
    {
        return $id < -10000 ? $id : -1 * $id + (-10000);
    }
}