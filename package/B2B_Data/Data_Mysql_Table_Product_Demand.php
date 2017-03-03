<?php
/*
 * Created by PhpStorm
 * User: Yangchenglin
 * Date: 2015/11/26
 * Time: 16:13
 */
class Data_Mysql_Table_Product_Demand extends Data_Mysql_Table
{
    public $cols = array(
        'account_phone' => 'string',        //登录者的电话账户
        'demand_time' => 'int',           //订单时间
        'status' => 'tinyint',            //订单状态 1有意向 2已经预定 3签约流程中 4已签协议
        'activity_start_time' => 'int',   //活动开始日期
        'activity_end_time' => 'int',     //活动结束日期
        'item_id' => 'int',              //场地名称ID
        'item_name' => 'string',           //场地名称
        'detail' => 'array',               //场地租金其他费用
        'from_where' => 'string',           //来源  1云SPACE  2朋友介绍
        'demand' => 'array',                //包含如下注释字段
        'match_result_id'=>'int',            //match_result匹配表中的id
        'demand_id' => 'int',               //需求表的id


//        'activity_name' => 'string',        //活动名称
//        'activity_people_num' => 'array',   //人数
//        'activity_type' => 'string',        //类型
//        'remark' => 'string',               //备注
//        'demand_people' => 'string',        //联系人
//        'demand_phone' => 'string',         //电话
//        'demand_email' => 'string',         //邮箱
//        'company' => 'array'                //所属公司等
    );

    public $index = array(
        'status' => 'i',
        'from_where' => 'i',
        'detail' => 'attr',
        'demand' => 'attr',
    );

    static $from_where = array(
        '1'=>'云SPACE',
        '2'=>'朋友介绍',
        '3'=>'老客户',
        '4'=>'媒体广告',
        '5'=>'其他渠道',
    );

    static $status = array(
        '1'=>'有意向',
        '2'=>'已预订',
        '3'=>'签约流程中',
        '4'=>'已签协议',
        '5'=>'已取消',
        '6'=>'已结束',
    );

    static $company_type = array(
        '1'=>'广告公司',
        '2'=>'公关公司',
        '3'=>'其他公司',
        '4'=>'个人',
    );

    static $activity_type = array(
        '1'=>'派对/典礼/沙龙',
        '2'=>'年会/晚会/演出',
        '3'=>'路演/展览/发布会',
        '4'=>'会议/讲座',
        '5'=>'团建/拓展',
        '6'=>'其他',
    );

    static $per_price = array(
        '1'=>'1天',
        '2'=>'半天',
        '3'=>'1小时',
        '4'=>'全包'
    );

    static $per_other_price = array(
        '1'=>'全包',
        '2'=>'1天',
        '3'=>'半天',
        '4'=>'1小时',
    );
}