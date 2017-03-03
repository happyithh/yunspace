<?php

class Data_Mysql_Table_Demand_Recommend extends Data_Mysql_Table
{
    public $cols = array(
        'demand_id' => 'int',
        'admin_id' => 'int',
        'recommend_account_id' => 'int',
        'product_id' => 'int',
        'set_id' => 'int',
        'demo' => 'text',
        'create_time' => 'int',
        'order_no' => '50',
        'look_time' => '20',
        'remark' => 'text',             //备注
        'customer_feedback' => 'tinyint',   // 客户反馈    -1 :关闭   0 ：推荐    1：咨询   3有意向   5：想去看场地
        'market_remark' => 'array',//销售备注
        'clientele_remark' => 'array',//客户备注
    );
    public $index = array(
        'demand_id' => 'i',
        'admin_id' => 'i',
        'product_id,set_id' => 'i',
    );
    public $title = array(
        'demand_id' => '需求ID',
        'admin_id' => '操作者',
        'product_id' => '产品ID',
        'set_id' => '套餐ID',
        'demo' => '推荐理由',
        'create_time' => '创建时间',
        'order_no' => '订单号',
        'look_reason' => '场地查看理由',
        'look_time' => '场地查看时间',
    );
    public static $customer_feedback = array(
        0 => '推荐',
        1 => '咨询',
        3 => '有意向',
        5 => '看场地',
    );

    //地址匹配
    static function checkUrl($str)
    {
        $preg = '/service_info\/([\d]+)\.html$/i';
        return preg_match($preg, $str);
    }
}