<?php

/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2015/10/16
 * Time: 10:33
 * 匹配结果表（会分表）
 */
class Data_Mysql_Table_Demand_Match_Result extends Data_Mysql_Table
{
    public $cols = array(
        'demand_id' => 'int',       //需求ID
        'item_id' => 'int',     //产品id
        'vendor_id' => 'int', //供应商ID
        'offer_id' => 'int',     //报价搜索条件id（暂时名字定义有问题）
        'match_level' => 'int',     //匹配情况(匹配等级) 1~10  （按照搜索条件及权重）
        'notice_level' => 'int',         //通知发送情况（反馈）  0,1,2,3
        'notice_time' => 'int',     //通知商家（供应商）时间
        'offer_info' => 'array',     //报价相关信息
        'offer_price' => 'int',     //商家报价价格
        'offer_unit' => '50',
        'offer_time' => 'int',     //商家提交报价时间
        'change_phone_time' => 'int',     //交换联系方式时间
        'change_phone' => 'int',     //是否交换联系方式
        'hits' => 'int',       //点击浏览次数（..）
        'is_call_center' => 'int',       //是否拨打400电话（客户）
        'call_center_time' => 'int',       //拨打400电话（客户）时间
        'demand_tag_complete' => 'array',       //需求标签完善记录
        'vendor_close_time' => 'int',        //商家接不了
        'vendor_close_mark' => '200',   // 关闭的原因
        'call_vendor_time' => 'int',        //拨打商家电话时间      客户拨打商家
        'call_customer_time' => 'int',        //拨打客户电话时间    商家拨打客户
        'match_time' => 'int',         //匹配时间
        'last_view_time' => 'int',        //商家报价报价后,客户在一定时间内没有预览视为 无意向
        'update_time' => 'int',
        'intention_time' => 'int',     //发送意向短信的时间
        'is_update' => 'tinyint'
    );

    public $index = array(
        'demand_id,item_id' => 'u',
        'demand_id' => 'i',
        'offer_id' => 'i',
        'vendor_close,vendor_close_mark' => 'i',
        'offer_unit,offer_price' => 'i',
        'match_level' => 'i',
        ',notice_time,offer_time' => 'i',
        'notice_level' => 'i',
        'offer_info' => 'attr',
        'demand_tag_complete' => 'attr',
    );

    //组装分表查询SQL
    /**
     * @param $tableString   子表名字
     * @param $cols   子表名字
     * @return array
     */
    static function  HandleSubSql($tableString, $cols)
    {
        if (!is_string($tableString) || !is_string($cols)) {
            return false;
        }

        $tableNameArray = explode(',', $tableString);

        if (empty($tableNameArray[0])) {
            return false;
        }
        $Sql = "( SELECT " . $cols . " FROM  {prefix}" . $tableNameArray[0] . ") ";

        for ($i = 1; $i < count($tableNameArray); $i++) {
            if ($tableNameArray[$i]) {
                $Sql .= " union (SELECT " . $cols . " FROM  {prefix}" . $tableNameArray[$i] . ")";
            }
        }
        return $Sql;

//        ((SELECT * FROM  yun_demand_match_result_201510 ) union
//    (SELECT * FROM  yun_demand_match_result_201511 ))


    }
}