<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/4/8
 * Time: 17:47
 */
class Api_Winchance_Site_Statistical extends Api
{
    static function siteStatistical($args)
    {
        if (!empty($args['search'])) {
            $request = Func_Input::filter(array(
                'city' => 'string',
                'step' => 'string',
                'start_time' => 'string',
                'end_time' => 'string',
            ), $args['search']);
            if (!empty($request['city'])) {
                $conditions['city'] = $request['city'];
            }
            if (!empty($request['step'])) {
                $conditions['step'] = $request['step'];
            }
            if (!empty($request['start_time']) && !empty($request['end_time'])) {
                if (strtotime($request['start_time'] . "00:00:00") > strtotime($request['end_time'] . "23:59:59")) {
                    Func_Header::back('请选择正确的起止时间！');
                } else {
                    $conditions['create_time between ? and ?'] = array(strtotime($request['start_time'] . "00:00:00"),strtotime($request['end_time'] . "23:59:59"));
                }
            } elseif (!empty($request['start_time']) && empty($request['end_time'])) {
                $conditions['create_time >= ?'] = strtotime($request['start_time'] . "00:00:00");
            }elseif(empty($request['start_time']) && !empty($request['end_time'])){
                $conditions['create_time <= ?'] = strtotime($request['end_time'] . "23:59:59");
            }
        }
        $conditions[] = 'status !=-1';
        if(!isset($request) || (empty($request['start_time']) && empty($request['end_time']))){
            $start_time = strtotime(date('Y-m-01 00:00:00'));
            $end_time = strtotime(date("Y-m-d").'23:59:59');
            $conditions['create_time between ? and ?'] = array($start_time, $end_time);
        }
        $data = Data_Mysql_Table_Winchance_Site::select('count(*) as total ,step,city', $conditions, 'GROUP BY step,city ORDER BY create_time DESC', 999);
        // 提取城市信息
        if(!empty($data)){
            $citys = self::getCitys($data);
            $keys = array_fill(0, count($citys), '');
        }

        $newData = array(
            'A' => '',
            'B' => '',
            'C' => '',
            'D' => '',
            'E' => '',
            'F' => '',
            '' => ''
        );
        if (!empty($data)) {
            foreach ($newData as $k => $v) {
                $newData[$k] = array_combine(array_values($citys), array_values($keys));
            }
            foreach ($data as $k => $v) {
                $newData[$v['step']][$v['city']] += $v['total'];
            }
            $newData['city'] = $citys;
        }
//        q($newData);
        return $newData;

    }

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
        return array_filter(array_unique($citys));
    }
}