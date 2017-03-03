<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/3/17
 * Time: 9:58
 * 订单统计
 */
class Api_Order_Statistics extends Api
{
    static function orderStatistics($args)
    {
        if (!empty($args['search'])) {
            $request = Func_Input::filter(array(
                'notice_city' => 'string',
                'start_time' => 'string',
                'end_time' => 'string',
                'demand_type' => 'string'
            ), $args['search']);
            if (!empty($request['demand_type'])) {
                if ($request['demand_type'] == '线上') {
                    $conditions[] = '(t2.demand_type != "销售创建" AND t2.demand_type != "个人订单")';
                }
                if ($request['demand_type'] == '线下') {
                    $conditions[] = '(t2.demand_type = "销售创建" OR t2.demand_type = "个人订单")';
                }
            }
            if (!empty($request['notice_city'])) {
                if ($request['demand_type'] == '线下') {
                    $conditions['t2.city = ?'] = $request['notice_city'];
                } else {
                    $conditions['t2.notice_city = ?'] = $request['notice_city'];
                }
            }
        }
//        if(isset($request['create_time'])&&!empty($request['create_time'])){
//                $start_time = strtotime($request['create_time'].'-01');
//                $end_time = strtotime($request['create_time'].'-01 +1 month -1 day'.'23:59:59');
//        }else{
//            $start_time= strtotime(date("Y-m-01"));
//            $end_time =strtotime(date("Y-m-01")." +1 month -1 day".'23:59:59');
//        }
        if (!empty($request['start_time']) && !empty($request['end_time'])) {
            if (strtotime($request['start_time']) > strtotime($request['end_time'])) {
                Func_Header::back('请选择正确的起止时间！');
            } else {
                $start_time = strtotime($request['start_time'] . '-01 00:00:00');
                $end_time = strtotime($request['end_time'] . '-01 +1 month -1 day' . '23:59:59');
            }
        } elseif (!empty($request['start_time']) && empty($request['end_time'])) {
            $start_time = strtotime($request['start_time'] . '-01 00:00:00');
            $end_time = strtotime(date('Y-m-01') . ' +1 month -1 day' . '23:59:59');
        } elseif (empty($request['start_time']) && !empty($request['end_time'])) {
//            q(date('2016-02-01 00:00:00',strtotime('-2 month')),$request['end_time'].'-01 00:00:00');
            $start_time = strtotime($request['end_time'] . '-01 00:00:00');
            $end_time = strtotime($request['end_time'] . '-01 +1 month -1 day' . '23:59:59');
        } else {
            $start_time = strtotime(date('Y-m-01 00:00:00', strtotime('-2 month')));
            $end_time = strtotime(date("Y-m-01") . " +1 month -1 day" . '23:59:59');
        }
        if (date('Y', $end_time) - date('Y', $start_time) > 1) {
            Func_Header::back('仅供查询近两年的数据！');
        }
        $conditions['t2.create_time between ? and ?'] = array($start_time, $end_time);
        $conditions['t2.demand_status = ?'] = 1;
        $conditions[] = 't1.sale_phone != 9 ';
        $conditions['t2.demand_type != ?'] = '文创项目合作';
        $cols = 'count(*) as c,t1.step,FROM_UNIXTIME(t2.create_time,"%Y%m") days';
        $table = '{table} as t1 LEFT JOIN {prefix}demand as t2 ON t1.id = t2.id';
        $data = Data_Mysql_Table_Grab_Order::select($cols, $conditions, 'GROUP BY days,step ORDER BY t2.create_time DESC', 9999, $table);
        $newData = array();
        for ($i = date('Ym', $start_time); $i <= date('Ym', $end_time); $i++) {
            if (date('Y', $start_time) != date('Y', $end_time) && substr($i, -2) == 13) {
                $i = date('Y', $end_time) . '01';
            }
            $newData[$i] = array(
                0 => '',
                10 => '',
                20 => '',
                30 => '',
                40 => '',
                60 => '',
                100 => '',
                -1 => '',
                -2 => ''
            );
        }
        $newData['进度总计'] = array(
            0 => '',
            10 => '',
            20 => '',
            30 => '',
            40 => '',
            60 => '',
            100 => '',
            -1 => '',
            -2 => ''
        );
        if(!empty($data)){
            foreach($data as $k=>$v){
                if(!in_array($v['step'],array_keys($newData[$v['days']]))){
                    unset($v['step']);
                }else{
                    $newData[$v['days']][$v['step']] =$v['c'];
                    $newData['进度总计'][$v['step']] += $v['c'];
                }

            }
        }
        return $newData;
    }
}