<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/5/12
 * Time: 19:43
 * 主表IP统计（已入驻/未入驻）
 */
class Api_Winchance_New_Ip_Total_Statistical extends Api
{
    static function totalList()
    {

        $request = Func_Input::filter(array(
            'tab_time' => 'string',
        ), $_REQUEST);
        $tab_time = empty($request['tab_time']) ? 'week' : $request['tab_time'];
        $conditions = array();
        if (!empty($_REQUEST['search'])) {
            $search = Func_Input::filter(array(
                'admin_id' => 'string',
                'city' => 'string',
                'start_time' => 'string',
                'end_time' => 'string',
            ), $_REQUEST['search']);
            if (!empty($search['admin_name'])) {
                $conditions['admin_id =?'] = $search['admin_id'];
            }
            if (!empty($search['city'])) {
                $conditions[] = "city LIKE '%" . $search['city'] . "%'";
            }
            /**
             *
             * 统计时间处理  -----开始------
            **/
            $search_time = Api_Winchance_Ip_Statistical_Time_Deal::searchTime($request['tab_time'],$search);
            if (empty($search['start_time']) && empty($search['end_time'])) {
                $conditions['update_time >=?'] = $search_time['start_time'];
            } elseif (empty($search['start_time']) && !empty($search['end_time'])) {
                $conditions['update_time between ? and ?'] = array($search_time['start_time'],$search_time['end_time']);
            } elseif (!empty($search['start_time']) && empty($search['end_time'])) {
                $conditions['update_time >=?'] = $search_time['start_time'];
            } elseif (!empty($search['start_time']) && !empty($search['end_time'])) {
                if(strtotime($search['start_time']) > strtotime($search['end_time'])){
                    Func_Header::back('请选择正确的起止时间！');
                }
                $conditions['update_time between ? and ?'] =array($search_time['start_time'],$search_time['end_time']);
            }
            /**
             *
             * 统计时间处理  -----结束------
             **/
        }
        switch ($tab_time) {
            case 'day':
                $cols = "count(*) as c,status,FROM_UNIXTIME(update_time,'%Y%m%d') as days";
                if (empty($search['start_time']) && empty($search['end_time'])) {
                    $conditions['update_time >=?'] = strtotime('-1 month');
                }
                break;
            case 'week':
                $cols = "count(*) as c,status,FROM_UNIXTIME(update_time,'%Y%u') as days";
                if (empty($search['start_time']) && empty($search['end_time'])) {
                    $conditions['update_time >= ?'] = strtotime('-16 week');
                }
                break;
            case 'month':
                $cols = "count(*) as c,status,FROM_UNIXTIME(update_time,'%Y%m') as days";
                if (empty($search['start_time']) && empty($search['end_time'])) {
                    $conditions['update_time >= ?'] = strtotime('-6 month');
                }
                break;
            default:
                $cols = "count(*) as c,status,FROM_UNIXTIME(update_time,'%Y%u') as days";
        }
        $conditions['status !=?'] = -1;
        $data = Data_Mysql_Table_Winchance_New::select($cols, $conditions, "GROUP BY days,status ORDER BY update_time DESC", 99999);
        // 显示时间处理
        if (empty($search['start_time']) && empty($search['end_time'])){
            $search_time['start_time'] = strtotime('-16 week');
            $search_time['end_time'] = time();
        }
        $time_interval = Api_Winchance_Ip_Statistical_Time_Deal::timeInterval($search_time['start_time'], $search_time['end_time'], $tab_time,'total');
        $newResult = array();
        $newResultTemp = array();
        foreach ($time_interval as $k => $v) {
            $newResult[$v] = array(
                '0' => '',
                '1' => '',

            );
        }
//        q($newResult);
        foreach($data as $k=>$v){
            $newResult[$v['days']][$v['status']] = $v['c'];
        }
        // 数据累加
        foreach($newResult as $k=>$v){
            if(isset($newResult[$k-1])){
                $newResult[$k][0] =(int)$newResult[$k][0]+(int)$newResult[$k-1][0];
                $newResult[$k][1] =(int)$newResult[$k][1]+(int)$newResult[$k-1][1];
            }
        }

        // 数据日期显示处理
        if(!empty($data)){
            $newResultTemp = array();
            if($tab_time=='day'){
                foreach($newResult as $k=>$v){
                    $newResultTemp[substr($k,0,4).'年'.substr($k,4,2).'月'.substr($k,6,2).'日'] = $v;
                }
            }elseif($tab_time=='month'){
                foreach($newResult as $k=>$v){
                    $newResultTemp[substr($k,0,4).'年'.substr($k,4,2).'月'] = $v;
                }
            }else{
                foreach($newResult as $k=>$v){
                    $newResultTemp[substr($k,0,4).'年 第'.substr($k,4,2).'周'] = $v;
                }
            }
        }
        return $newResultTemp;
    }
}
