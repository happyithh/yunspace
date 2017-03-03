<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/8/27
 * Time: 11:47
 *  需求招标表
 */
class  Data_Mysql_Table_Demand_Tender extends Data_Mysql_Table
{
    public $cols = array(
        'demand_id' => 'int',       //需求ID
        'product_sum' => 'int',     //产品总数
        'scheme_sum' => 'int',         //反馈数量
        'create_time' => 'int',
        'scheme_id' => 'int',        //中标ID
        'update_time' => 'int',
        'status' => 'tinyint',   // 0  新的   1 竞标成功      -n 竞标失败
        'agent_info' => 'array',   //代理人的信息，包括手机号和邮箱及用户id
        'agent_status'=>'tinyint',   // 0 默认是正常流程   1 是代理人模式
    );

    public $index = array(
        'demand_id' => 'u',
        'scheme_sum' => 'i',
        'product_sum' => 'i',
        'status' => 'i',
    );
    public static $status= array(
        0 => '待确认',
        1 => '已确认',

    );
}