<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2015/9/10
 * Time: 10:36
 *
 * 需求统计  ： 需求来源统计
 */
class Api_Demand_Admin_getDemandTypeStatisticsList extends Api
{
    static function demandTypeStatistics($args)
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
            $search_time = Api_Demand_Admin_getStepStatisticsList::timeDeal($request);
            $conditions['t1.create_time between ? and ?'] = array($search_time['start_time'], $search_time['end_time']);
        }
        $conditions['t1.demand_status = ?']=1;
        $request['type'] = empty($request['type']) ? 'day' : $request['type'];
        switch ($request['type']) {
            case 'week':
                $newResult = self::getWeekData($conditions,$search_time);
                break;
            case 'month':
                $newResult = self::getMonthData($conditions,$search_time);
                break;
            case 'day':
                $newResult = self::getDayData($conditions,$search_time);
                break;
            default:
                $newResult = self::getDayData($conditions,$search_time);

        }
        return self::request('success', $newResult, '');
    }
    //获取前30天的数据
    static function getDayData($args,$search)
    {
        // 时间处理
        if (empty($search)) {
            $args['t1.create_time >= ?'] = strtotime('-1 month');
            $time = Api_Winchance_Ip_Statistical_Time_Deal::getDay($args['t1.create_time >= ?'], time(), 'step');
        } else {
            $time = Api_Winchance_Ip_Statistical_Time_Deal::getDay($search['start_time'], $search['end_time'], 'step');
        }
//        Data_Mysql_Table_Demand::debug(1);
        $res = Data_Mysql_Table_Demand::select('count(*) as c,t1.demand_type,FROM_UNIXTIME(t1.create_time,"%Y年%m月%d日") days ', $args, 'GROUP BY days,t1.demand_type ORDER BY t1.create_time DESC', 300,'{table} as t1 LEFT JOIN {prefix}grab_order as t2 ON t1.id = t2.id');
        $newResult = self::dataDeal($time,$res);
        if(!empty($newResult)){
            return array_reverse($newResult, 1);
        }

    }

    // 获取前10周的数据
    static function getWeekData($args,$search)
    {
        // 时间处理
        if (empty($search)) {
            $args['t1.create_time >= ?'] = strtotime('-10 week');
            $time = Api_Winchance_Ip_Statistical_Time_Deal::getWeek($args['t1.create_time >= ?'], time(), 'step');
        } else {
            $time = Api_Winchance_Ip_Statistical_Time_Deal::getWeek($search['start_time'], $search['end_time'], 'step');
        }
        $res = Data_Mysql_Table_Demand::select('count(*) as c,t1.demand_type,FROM_UNIXTIME(t1.create_time,"%Y年第%u周") days ', $args, 'GROUP BY days,t1.demand_type', 300,'{table} as t1 LEFT JOIN {prefix}grab_order as t2 ON t1.id = t2.id');
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
        $res = Data_Mysql_Table_Demand::select('count(*) as c,t1.demand_type,FROM_UNIXTIME(t1.create_time,"%Y年%m月") days ', $args, 'GROUP BY days,t1.demand_type', 300,'{table} as t1 LEFT JOIN {prefix}grab_order as t2 ON t1.id = t2.id');
        $newResult = self::dataDeal($time,$res);
        if(!empty($newResult)){
            return array_reverse($newResult, 1);
        }
    }
    static function dataDeal($time,$res){
        if (!empty($time)) {
            foreach ($time as $k => $v) {
                $newResult[$v] = array(
                    '400订单'=>'',
                    '办活动'=>'',
                    '联系供应商'=>'',
                    '个人订单'=>'',
                    '预约咨询'=>'',
                    '文创'=>'',
                    '办活动M'=>'',
                    '年会咨询'=>'',
                    '其他'=>'',
                );
            }
            if(!empty($res)){
                foreach($res as $k=>$v){
                    if(!empty($newResult[$v['days']])) {
                        if ($v['demand_type'] == '文创项目合作') {
                            $newResult[$v['days']]['文创'] = $v['c'];
                        } elseif (array_key_exists($v['demand_type'], $newResult[$v['days']])) {
                            $newResult[$v['days']][$v['demand_type']] = $v['c'];
                        } else {
                            $newResult[$v['days']]['其他'] += $v['c'];
                        }
                    }
                }
            }
            return $newResult;
        }
    }
}