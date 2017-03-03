<?php

/**
 * Created by PhpStorm.
 * User: liushengchun
 * Date: 15/1/28
 * Time: 11:41
 */
class Data_Mysql_Table_Demand extends Data_Mysql_Table
{
    public $cols = array(
        'account_id' => 'int',
        'demand_type' => '20',  //  办活动 / 整体方案 / 供应商加盟 / 实地看场 / 客户人工服务 / 供应商人工客服 / 订单转发
        'demand_name' => '100',// 活动的名字       默认为空
        'phone' => '15',
        'ip' => '15',
        'city' => '50',
        'notice_city' => '20',  //通知城市
        'demand' => 'array',    //
        'create_time' => 'int',
//        'step' => 'int',            //客户进度情况     //分两种情况   1.AE客户项目进展    2.漏斗石销售客户跟进        //-n  为关闭         //12/18  zzc
        'resolve_time' => 'int',    //  受理时间
        'demand_status' => 'tinyint',  //  0未处理  -1 已放弃   5转为测试 其他代表已处理           -3 系统自动关闭
        'response_account_id' => 'int',   //响应人的id
        'admin_id' => 'int',
//        'group_id' => 'int',        //群组ID
        'submit_person' => '15',   //提交人(手机号)
        'submit_person_account_id' => 'int', //提交人账户id
        'demand_reason' => 'array',//拒绝理由
        'update_time' => 'int',
        'refuse_time' => 'int',  //放弃时间
        'price_up' => 'int',          //最低价
        'price_down' => 'int',            //最高价
        'win_id' => 'int',   //其他ID        文创ID
        'backup_demand' => 'array',         //备份需求
        'mark_tags' => '50',   //标记  存放ID        //12/30
        'mark' => '100',  //标记
        'delay_time' => 'int',     //延迟时间，  客服处理        //12/18
        'integral' => 'int',      //积分         //抢单系统所用的积分 ，  12/14
        'enter_url' => '100',  //入口页
        'referer' => '100',  //来源
        'demand_level' => 'int',  //需求级别 默认0级，补充第一步 1，补充第二步 2
        'is_phone'=>'int'   //是否显示手机号   1显示  2不显示
    );
    //zzc 12/14 注释  理由：不需要这么多索引
    public $index = array(
        'account_id,phone' => 'i',
        'integral' => 'i',
        'mark_tags' => 'i',
        'demand' => 'attr',
        'demand_type' => 'i',
        'demand_name' => 'i',
        'demand_status,mark' => 'i',
        'city,notice_city' => 'i',
    );

    public static $_demandType = array(
        0 => '400订单',
        2 => '一键租场地',
        3 => '咨询价格和档期',
        15 => '查看参考价',
        1 => '办活动',
        12 => '办活动M',
        7 => '预约咨询',
//        2 => '整体方案',
//        3 => '实地看场',
        4 => '联系供应商',
//        8 => '订单转发',
//        9 => '产品咨询档期',
//        10 => '套餐咨询档期',
//        11 => '活动爆料',
        13 => '文创项目合作',
//        14 => '年会咨询',
//        16 => '查看参考价M',
        6 => '个人订单',
        17 => '销售创建',

    );

    //AE客户项目进展
    static $step_AE = array(
        0 => '准备约谈的客户',
        10 => '沟通中的客户',
        20 => '正在提案中',
        30 => '项目执行中',
        40 => '市场执行中',
        100 => '已完成',
        -1 => '关闭',
    );
    //漏斗石销售客户跟进
    static $step_funnel = array(
        0 => '未沟通-0%',
        10 => '已电话的客户-20%',
        20 => '初步意向的客户-30%',
        30 => '上门拜访客户-50%',
        40 => '强意向客户-75%',
        60 => '商务洽谈客户-80%',
        100 => '成交-100%',
        -1 => '关闭',
//        -2 =>'转至报价系统自动处理'
    );

    static $grab_order_step = array(
        0 => '未沟通',
        10 => '已电话的客户',
        20 => '初步意向的客户',
        30 => '上门拜访客户',
        40 => '强意向客户',
        60 => '商务洽谈客户',
        100 => '成交',
        -1 => '关闭',
        -2 => '关闭（重复单）'
    );

    //进度的积分支付
    static $step_integral = array(
        10 => 2,
        20 => 4,
        30 => 6,
        40 => 8,
        60 => 10,
        100 => 7,
    );

    //标记
    static $mark_tags = array(
        //需求表
        0 => '',
        1 => '自动',
//        2 => '销售',
        //抢单表
        20 => '重复',
        21 => '代理',
    );

    /**
     * @param $args
     * @return bool
     *添加标标记
     */
    static function handleAddMarkTags($args)
    {
        $request = Func_Input::filter(array(
            'demand_id' => 'int',
            'mark_id' => 'int',
        ), $args);
        $tags_array = self::$mark_tags;
        if (empty($tags_array[$request['mark_id']])) {
            return false;
        }
        $data = Data_Mysql_Table_Demand::select('id,mark_tags', array('id=?' => array($request['demand_id'])));
        if (empty($data[0]['id'])) {
            return false;
        }
        $mark_id = $request['mark_id'];

        if (!empty($data[0]['mark_tags'])) {

            $dataMark_tags = $data[0]['mark_tags'];
            if (is_bool(strpos("$dataMark_tags", "$mark_id"))) {
                $marks = $dataMark_tags . $mark_id . '|';
            } else {
                return true;
            }

        } else {
            $marks = $mark_id . '|';
        }
        $update = array(
            'mark_tags' => $marks
        );
        $rs = Data_Mysql_Table_Demand::update(array('id=?' => array($request['demand_id'])), $update);
        if ($rs[0] > 0) {
            return true;
        }
        return false;
    }

    static function   handleConvertMarkTags($args)
    {
        $request = Func_Input::filter(array(
            'mark_tags' => 'string',
        ), $args);
        if (empty($request['mark_tags'])) {
            return false;
        }
        $mark_array = self::$mark_tags;

        $values = explode('|', $request['mark_tags']);
        $newArray = array();
        if (is_array($values)) {
            foreach ($values as $key => $val) {
                if (!empty($mark_array[$val])) {
                    $newArray[$val] = $mark_array[$val];
                }
            }
        } elseif (!empty($mark_array[$request['mark_tags']])) {
            $newArray[$request['mark_tags']] = $mark_array[$request['mark_tags']];
        }

        return $newArray;

    }

    /**
     * @param $referer
     * @return string
     * 处理来源
     */
    static function  handleSource($referer)
    {
        $request = Func_Input::filter(array(
            'referer_url' => 'string',
        ), $referer);

        if (strpos($request['referer_url'], 'baidu')) {
            //如果是百度
            if (strpos($request['referer_url'], 'link')) {
                return '百度搜索';
            } else {
                return '百度推广';
            }
        } elseif (strpos($request['referer_url'], 'sougou')) {
            return '搜狗';
        } elseif (strpos($request['referer_url'], 'haosou')) {
            return '好搜';
        } elseif (strpos($request['referer_url'], 'baixing')) {
            return '百姓';
        } else {
            $url = parse_url($request['referer_url']);
            if (!empty($url['host'])) {
                return $url['host'];
            } else {
                return substr($request['referer_url'], 0, 10);
            }
        }
    }


}

