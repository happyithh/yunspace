<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2015/9/8
 * Time: 13:34
 * 需求统计 ：  需求跟进的统计
 */
class Api_Demand_Tender_getStepStatisticsList extends Api
{

    static function stepStatistics($args)
    {
        $request = Func_Input::filter(array(
            'type' => 'string',
            'search' => 'array'
        ), $args);
        $conditions = array();
        if (!empty($request['search']['response_account_id'])) {
            $conditions['response_account_id =?'] = $request['search']['response_account_id'];
        }
        if (!empty($request['search']['city'])) {
            $conditions['city =?'] = $request['search']['city'];
        }
        $request['type'] = empty($request['type']) ? 'weeks' : $request['type'];
        switch ($request['type']) {
            case 'weeks':
                $newResult = self::getWeekData($conditions);

                break;
            case 'months':
                $newResult = self::getMonthData($conditions);
                break;
            case 'days':
                $newResult = self::getDayData($conditions);
                break;
            default:
                $newResult = self::getDayData($conditions);

        }
        return self::request('success', $newResult, '');
    }

    //获取前30天的数据
    static function getDayData($args)
    {
        $args['t1.create_time >= ?'] = strtotime('-1 month');
       // $args['demand_status'] = 1;
        $table = '{table} as t1 LEFT JOIN {prefix}demand as t2 ON t1.demand_id =t2.id';
        $res = Data_Mysql_Table_Demand_Offer::select('count(*) as c,t1.status,FROM_UNIXTIME(t1.create_time,"%Y-%m-%d") days ,t1.create_time', $args, 'GROUP BY days,t1.status', 300,$table);
        $newResult = array();
        for ($i = $args['t1.create_time >= ?']; $i <= time(); $i += 86400) {
            $newResult[date('Y-m-d', $i)] = array(
                '0' => '',
                '4' => '',
                '-1' => '',
            );
        }
        foreach ($res as $v) {
            $newResult[$v['days']][$v['status']] = $v['c'];
        }
        return array_reverse($newResult, 1);
    }

    // 获取前10周的数据
    static function getWeekData($args)
    {
        $args['t1.create_time >= ?'] = strtotime('-10 week');
       // $args['demand_status'] = 1;
       // $args['t1.create_time >= ?'] = strtotime('-1 month');
        $table = '{table} as t1 LEFT JOIN {prefix}demand as t2 ON t1.demand_id =t2.id';
        $res = Data_Mysql_Table_Demand_Offer::select('count(*) as c,t1.status,FROM_UNIXTIME(t1.create_time,"%Y-%u") days ,t1.create_time', $args, 'GROUP BY days,t1.status', 300,$table);
        $newResult = array();
        // 判断是否是周一，获取每周时间
        $is_monday = date("Y-m-d", (strtotime('-' . 0  . ' Monday')))==date('Y-m-d',time()) ? 0 :1;
        for ($i = 0; $i <= 10; $i++) {
            $j = $is_monday+$i;
            $day = date("Y-m-d", strtotime('-' . $j . ' Monday')) . ' ~ ' . date("Y-m-d", strtotime('-' . $i. ' Sunday'));
            $newResult[date('Y-W', strtotime('-' . $i . ' Sunday'))] = array(
                '0' => '',
                '4' => '',
                '-1' => '',
                'd' => $day
            );
        }
        foreach ($res as $v) {
            $newResult[$v['days']][$v['status']] = $v['c'];
        }
        foreach ($newResult as $k => $v) {
            unset($newResult[$k]);
            $k = $v['d'];
            unset($v['d']);
            $newResult[$k] = $v;
        }
        return $newResult;

    }

//  获取前六个月的数据
    static function getMonthData($args)
    {
        $args['t1.create_time >= ?'] = strtotime('-5 month');
        $table = '{table} as t1 LEFT JOIN {prefix}demand as t2 ON t1.demand_id =t2.id';
        $res = Data_Mysql_Table_Demand_Offer::select('count(*) as c,t1.status,FROM_UNIXTIME(t1.create_time,"%Y-%m") days ,t1.create_time', $args, 'GROUP BY days,t1.status', 300,$table);
        $newResult = array();
        for ($i = $args['t1.create_time >= ?']; $i <= time() + 86400; $i += 86400) {
            $newResult[date('Y-m', $i)] = array(
                '0' => '',
                '4' => '',
                '-1' => '',
            );
        }
        foreach ($res as $v) {
            $newResult[$v['days']][$v['status']] = $v['c'];
        }
//        q($newResult);
        return array_reverse($newResult, 1);
    }

}