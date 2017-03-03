<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2015/9/10
 * Time: 11:53
 * 需求统计  ： 根据时间段的统计
 */
class Api_Demand_Admin_getDemandHoursStatistics extends Api
{
    static function demandHoursStatistics($args)
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
        $request['type']='month';
        if (!empty($request['search']['start_time']) || !empty($request['search']['end_time'])) {
            $search_time = Api_Demand_Admin_getStepStatisticsList::timeDeal($request);
            $conditions['t1.create_time between ? and ?'] = array($search_time['start_time'], $search_time['end_time']);
        }
        $conditions['t1.demand_status = ?']=1;

        $newResult = self::getMonthData($conditions,$search_time);
        return self::request('success', $newResult, '');
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
        $res = Data_Mysql_Table_Demand::select('count(*) as c,FROM_UNIXTIME(t1.create_time,"%Y年%m月 %k") days ', $args, 'GROUP BY days', 300,'{table} as t1 LEFT JOIN {prefix}grab_order as t2 ON t1.id = t2.id');
        $newResult = self::dataDeal($time,$res);
        return $newResult;

//        return array_reverse($newResult, 1);
    }
    static function dataDeal($time,$res){
        if(!empty($time)){
            $keys = array_fill(0, count($time), '');
            for ($i = 0; $i <= 23 ; $i++) {
                $newResult[$i] = array_combine($time,array_values($keys));
            }
            $newResult['总计'] = array_combine($time,array_values($keys));
            foreach ($res as $k => $v) {
                $day = explode(' ', $v['days']);
                $newResult[$day[1]][$day[0]] = $v['c'];
                $newResult['总计'][$day[0]]+=$v['c'];
            }
            $newResult['month'] = $time;
            return $newResult;
        }
    }
}