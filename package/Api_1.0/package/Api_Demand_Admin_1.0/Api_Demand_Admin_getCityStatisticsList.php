<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2015/10/9
 * Time: 13:32
 *
 *   不同城市的需求统计
 */
class Api_Demand_Admin_getCityStatisticsList extends Api
{
    static function demandCityStatistics($args)
    {
        $request = Func_Input::filter(array(
            'type' => 'string',
            'search' => 'array',
        ), $args);
        $conditions = array();
        $search_time = array();
        if (!empty($request['search']['start_time']) || !empty($request['search']['end_time'])) {
            $search_time = Api_Demand_Admin_getStepStatisticsList::timeDeal($request);
            $conditions['t1.create_time between ? and ?'] = array($search_time['start_time'], $search_time['end_time']);
        }
        $conditions['t1.demand_status = ?'] = 1;
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

    // 前30天的数据
    static function getDayData($args, $search)
    {
        // 时间处理
        if (empty($search)) {
            $args['t1.create_time >= ?'] = strtotime('-1 month');
            $time = Api_Winchance_Ip_Statistical_Time_Deal::getDay($args['t1.create_time >= ?'], time(), 'step');
        } else {
            $time = Api_Winchance_Ip_Statistical_Time_Deal::getDay($search['start_time'], $search['end_time'], 'step');
        }
        $res = Data_Mysql_Table_Demand::select('count(*) as c,t1.city,FROM_UNIXTIME(t1.create_time,"%Y年%m月%d日") days ', $args, 'GROUP BY days,t1.city ORDER BY t1.create_time DESC', 300, '{table} as t1 LEFT JOIN {prefix}grab_order as t2 ON t1.id = t2.id');
        $newResult = self::dataDeal($time, $res);
        $newResult['pie'] = self::pieChart($newResult[date('Y年m月d日', time())]);
        if(!empty($newResult)){
            return array_reverse($newResult, 1);
        }

    }

    //前10周的数据
    static function getWeekData($args, $search)
    {
        // 时间处理
        if (empty($search)) {
            $args['t1.create_time >= ?'] = strtotime('-10 week');
            $time = Api_Winchance_Ip_Statistical_Time_Deal::getWeek($args['t1.create_time >= ?'], time(), 'step');
        } else {
            $time = Api_Winchance_Ip_Statistical_Time_Deal::getWeek($search['start_time'], $search['end_time'], 'step');
        }
        $res = Data_Mysql_Table_Demand::select('count(*) as c,t1.city,FROM_UNIXTIME(t1.create_time,"%Y年第%u周") days', $args, 'GROUP BY days,t1.city', 300, '{table} as t1 LEFT JOIN {prefix}grab_order as t2 ON t1.id = t2.id');
        $newResult = self::dataDeal($time, $res);
        $arr = self::pieChart($newResult[date('Y年第W周', time())]);
        $newResult['pie'] = $arr;
        return $newResult;


    }

    //前六个月的数据
    static function getMonthData($args, $search)
    {
        // 时间处理
        if (empty($search)) {
            $args['t1.create_time >= ?'] = strtotime('-6 month');
            $time = Api_Winchance_Ip_Statistical_Time_Deal::getMonth($args['t1.create_time >= ?'], time(), 'step');
        } else {
            $time = Api_Winchance_Ip_Statistical_Time_Deal::getMonth($search['start_time'], $search['end_time'], 'step');
        }
        $res = Data_Mysql_Table_Demand::select('count(*) as c,t1.city,FROM_UNIXTIME(t1.create_time,"%Y年%m月") days ,t1.create_time', $args, 'GROUP BY days,t1.city', 300, '{table} as t1 LEFT JOIN {prefix}grab_order as t2 ON t1.id = t2.id');

        $newResult = self::dataDeal($time, $res);
        $newResult['pie'] = self::pieChart($newResult[date('Y年m月', time())]);
        if(!empty($newResult)){
            return array_reverse($newResult, 1);
        }
    }

    static function  pieChart($data)
    {
        $nes = array();
        foreach ($data as $k => $v) {
            if (!empty($v)) {
                $nes[] = '{value:' . $v . ',name:"' . $k . '"}';
                $nes['name'][] = $k;
            }

        }
        return $nes;
    }

    // 提取城市信息
    static function getCitys($res)
    {
        $city_arr = array();
        foreach ($res as $v) {
            $city_arr[] = $v['city'];
        }
        $citys = array();
        if (!empty($city_arr)) {
            $citys = explode(',', implode(',', $city_arr));
        }
//        q(array_filter($citys));
        return array_filter(array_unique($citys));
    }

    //多城市处理
    static function dealCity($data, $new_data)
    {
        $citys = explode(',', $data['city']);
        foreach ($citys as $k => $v) {
            if (!empty($v)) {

                $new_data[$data['days']][$v] += $data['c'];
            }
        }
        return $new_data;
    }

    static function dataDeal($time, $res)
    {
        if (!empty($res)) {
            $newResult = array();
            $citys = self::getCitys($res);
            $keys = array_fill(0, count($citys), '');
            if (!empty($time)) {
                foreach ($time as $k => $v) {
                    $newResult[$v] = array_combine(array_values($citys), array_values($keys));
                }
            }
            foreach ($res as $k => $v) {
                if(strstr($v['days'],'周')){
                    $wee = mb_substr($v['days'],6,2,'utf8');
                    if($wee=='00'){
                        $v['days']=mb_substr($v['days'],0,5,'utf8').'第01周';
                    }
                }
                if (empty($v['city'])) {
                    unset($v['city']);
                } elseif (strstr($v['city'], ',')) {
                    $newResult = self::dealCity($v, $newResult);
                } else {
                    $newResult[$v['days']][$v['city']] = $v['c'];
                }
            }
            $newResult['city'] = $citys;
            return $newResult;
        }

    }
}
