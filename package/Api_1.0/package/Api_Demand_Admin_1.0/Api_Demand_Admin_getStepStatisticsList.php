<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2015/9/8
 * Time: 13:34
 * 需求统计 ：  需求跟进的统计
 */
class Api_Demand_Admin_getStepStatisticsList extends Api
{

    static function stepStatistics($args)
    {
        $request = Func_Input::filter(array(
            'type' => 'string',
            'search' => 'array'
        ), $args);
        $conditions = array();
        if (!empty($request['search']['phone'])) {
            $conditions['t2.sale_phone =?'] = $request['search']['phone'];
        }
        $search_time = array();
        if (!empty($request['search']['start_time']) || !empty($request['search']['end_time'])) {
            $search_time = self::timeDeal($request);
            $conditions['t1.create_time between ? and ?'] = array($search_time['start_time'], $search_time['end_time']);
        }
        $conditions['t1.demand_status =?'] = 1;
        $request['type'] = empty($request['type']) ? 'day' : $request['type'];
        switch ($request['type']) {
            case 'week':
                $newResult = self::getWeekData($conditions, $search_time);
                break;
            case 'month':
                $newResult = self::getMonthData($conditions, $search_time);
                break;
            case 'day':
                $newResult = self::getDayData($conditions, $search_time);
                break;
            default:
                $newResult = self::getDayData($conditions, $search_time);

        }
        return self::request('success', $newResult, '');
    }

    //获取前30天的数据
    static function getDayData($args, $search = array())
    {
        // 时间处理
        if (empty($search)) {
            $args['t1.create_time >= ?'] = strtotime('-1 month');
            $time = Api_Winchance_Ip_Statistical_Time_Deal::getDay($args['t1.create_time >= ?'], time(), 'step');
        } else {
            $time = Api_Winchance_Ip_Statistical_Time_Deal::getDay($search['start_time'], $search['end_time'], 'step');
        }
//        $res = Data_Mysql_Table_Grab_Order::select('count(*) as c,t1.step,FROM_UNIXTIME(t2.create_time,"%Y-%m-%d") days ,t2.create_time', $args, 'GROUP BY days,t1.step', 300,'{table} as t1 LEFT JOIN {prefix}demand as t2 ON t1.id=t2.id');
        $res = Data_Mysql_Table_Demand::select('count(*) as c,IFNULL(t2.step,0) as step,FROM_UNIXTIME(t1.create_time,"%Y年%m月%d日") days ', $args, 'GROUP BY days,t2.step', 9999, "{table} as t1 LEFT JOIN {prefix}grab_order as t2 ON t1.id=t2.id");
        $newResult = self::dataDeal($time,$res);
        if(!empty($newResult)){
            return array_reverse($newResult, 1);
        }
    }

    // 获取前10周的数据
    static function getWeekData($args, $search = array())
    {
        // 时间处理
        if (empty($search)) {
            $args['t1.create_time >= ?'] = strtotime('-10 week');
            $time = Api_Winchance_Ip_Statistical_Time_Deal::getWeek($args['t1.create_time >= ?'], time(), 'step');
        } else {
            $time = Api_Winchance_Ip_Statistical_Time_Deal::getWeek($search['start_time'], $search['end_time'], 'step');
        }
        $res = Data_Mysql_Table_Demand::select('count(*) as c,IFNULL(t2.step,0) as step,FROM_UNIXTIME(t1.create_time,"%Y年第%u周") days', $args, 'GROUP BY days,t2.step', 9999, "{table} as t1 LEFT JOIN {prefix}grab_order as t2 ON t1.id=t2.id");
        $newResult = self::dataDeal($time,$res);
        if(!empty($newResult)){
            return array_reverse($newResult, 1);
        }

    }

//  获取前六个月的数据
    static function getMonthData($args,$search)
    {
        // 时间处理
        if (empty($search)) {
            $args['t1.create_time >= ?'] = strtotime('-6 month');
            $time = Api_Winchance_Ip_Statistical_Time_Deal::getMonth($args['t1.create_time >= ?'], time(), 'step');
        } else {
            $time = Api_Winchance_Ip_Statistical_Time_Deal::getMonth($search['start_time'], $search['end_time'], 'step');
        }
        $res = Data_Mysql_Table_Demand::select('count(*) as c,IFNULL(t2.step,0) as step,FROM_UNIXTIME(t1.create_time,"%Y年%m月") days', $args, 'GROUP BY days,t2.step', 9999, "{table} as t1 LEFT JOIN {prefix}grab_order as t2 ON t1.id=t2.id");

        $newResult = self::dataDeal($time,$res);
        if(!empty($newResult)){
            return array_reverse($newResult, 1);
        }

    }

    // 时间处理

    static function timeDeal($search)
    {
        if (!empty($search['search']['start_time']) && !empty($search['search']['end_time']) && (strtotime($search['search']['start_time']) > strtotime($search['search']['end_time']))) {
            Func_Header::back('请选择正确的起止时间！');
        } else {
            $search_time = Api_Winchance_Ip_Statistical_Time_Deal::searchTime($search['type'], $search['search']);
            return $search_time;
        }
    }

    static function dataDeal($time,$res){
        if (!empty($time)) {
            foreach ($time as $k => $v) {
                $newResult[$v] = array(
                    '0' => '',
                    '10' => '',
                    '20' => '',
                    '30' => '',
                    '40' => '',
                    '60' => '',
                    '100' => '',
                    '-1' => '',
                    '-2' => '',
                    '总计' =>'',
                );
            }
            if(!empty($res)){
                foreach($res as $k=>$v){
                    if(strstr($v['days'],'周')){
                        $wee = mb_substr($v['days'],6,2,'utf8');
                        if($wee=='00'){
                            $v['days']=mb_substr($v['days'],0,5,'utf8').'第01周';
                        }
                    }
                    if(array_key_exists($v['step'],$newResult[$v['days']])){
                        $newResult[$v['days']][$v['step']] += $v['c'];
                    }
                }
                // 合计
                $sum = $newResult;
                foreach($newResult as $k=>$v){
                    unset($sum[$k]['-2']);
                   $newResult[$k]['总计'] = array_sum($sum[$k]);
                }
            }
            return $newResult;
        }
    }

}