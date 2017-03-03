<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/8/27
 * Time: 11:47
 * 供应商竞标方案表
 * */
class  Data_Mysql_Table_Demand_Tender_Scheme extends Data_Mysql_Table
{
    public $cols = array(
        'tender_id' => 'int',
        'product_id' => 'int',
        'set_id' => 'int',
        'vendor_account_id' => 'int',
        'quote' => 'int',               //价格
        'scheme' => 'array',             //方案        array(联系人,联系人手机号，备注)
        'create_time' => 'int',
        'update_time' => 'int',
        'status' => 'tinyint',   // 0  新的   1 竞标成功
        'agent_status' => 'tinyint',   // 代理人审核状态。默认 0  不显示   审核通过 为 1 给客户发消息
    );

    public $index = array(
        'tender_id' => 'i',
        'set_id' => 'i',
        'product_id' => 'i',
        'quote' => 'i',
        'scheme' => 'i',
        'status' => 'i',
    );
}