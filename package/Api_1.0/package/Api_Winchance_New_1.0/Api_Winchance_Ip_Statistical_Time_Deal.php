<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/5/19
 * Time: 16:32
 * 统计的时间处理
 */
class Api_Winchance_Ip_Statistical_Time_Deal extends Api{

    static function searchTime($tab_time,$time_data){
        if (empty($time_data['start_time']) && empty($time_data['end_time'])) {
            if ($tab_time == 'day') {
                $time_data['start_time'] = strtotime('-1 month');
            } elseif ($tab_time == 'month') {
                $time_data['start_time'] = strtotime('-6 month'."00:00:00");
            } else {
                $time_data['start_time'] = strtotime('-16 week');
            }
            $time_data['end_time'] = time();

        } elseif (empty($time_data['start_time']) && !empty($time_data['end_time'])) {
            if ($tab_time == 'day') {
                $time_data['start_time'] =strtotime("-1 month", strtotime($time_data['end_time']));
                $time_data['end_time'] = strtotime($time_data['end_time'].'23:59:59');
            }elseif($tab_time == 'month'){
                $time_data['start_time'] = strtotime("-6 month", strtotime(substr($time_data['end_time'],0,7).'-01 +1 month -1 day'));
                $time_data['end_time'] = strtotime(substr($time_data['end_time'],0,7).'-01 +1 month -1 day');
            }else{
                $time_data['start_time'] = strtotime("-16 week", self::this_monday(strtotime($time_data['start_time'])));
                $time_data['end_time'] =self::this_sunday(strtotime($time_data['start_time']));
            }

        } elseif (!empty($time_data['start_time']) && empty($time_data['end_time'])) {
            if($tab_time=='day'){
                $time_data['start_time'] = strtotime($time_data['start_time']."00:00:00");
            }elseif($tab_time=='month'){
                $time_data['start_time'] = strtotime(substr($time_data['start_time'],0,7));
            }else{
                $time_data['start_time'] = self::this_monday(strtotime($time_data['start_time']));
            }
            $time_data['end_time'] = time();
        } elseif (!empty($time_data['start_time']) && !empty($time_data['end_time'])) {
            if($tab_time=='day'){
                $time_data['start_time'] = strtotime($time_data['start_time']."00:00:00");
                $time_data['end_time'] = strtotime($time_data['end_time']."23:59:59");
            }elseif($tab_time=='month'){
                $time_data['start_time'] = strtotime(substr($time_data['start_time'],0,7));
                $time_data['end_time'] = strtotime(substr($time_data['end_time'],0,7).'-01 +1 month -1 day');
            }else{
                $time_data['start_time'] = self::this_monday(strtotime($time_data['start_time'])) ;
                $time_data['end_time'] = self::this_sunday(strtotime($time_data['end_time']));
            }
        }
        return $time_data;
    }

    //时间处理
    static function timeInterval($start_time = '', $end_time = '', $type,$sta_type = 'step')
    {
        $time_arr = array();
        switch ($type) {
            case 'week':
                $time_arr = self::getWeek($start_time, $end_time,$sta_type);
                break;
            case 'day':
                $time_arr = self::getDay($start_time, $end_time,$sta_type);
                break;
            case 'month':
                $time_arr = self::getMonth($start_time, $end_time,$sta_type);
                break;
            default:
                $time_arr = self::getWeek($start_time, $end_time,$sta_type);
        }
        return $time_arr;
    }

    //获取一段时间内的天
    static function getDay($start_date, $end_date,$sta_type)
    {
        $arr = array();
        //参数不能为空
        if (!empty($start_date) && !empty($end_date)) {
            //开始日期不能大于结束日期
            if ($start_date <= $end_date) {
                if($sta_type=='step'){
                    for ($i = $start_date; $i <= $end_date; $i += (24 * 3600)) {
                        $arr[] = date('Y年m月d日', $i);
                    }
                }else{
                    for ($i = $start_date; $i <= $end_date; $i += (24 * 3600)) {
                        $arr[] = date('Ymd', $i);
                    }
                }

            }
        }
        return $arr;
    }

    //获得一段时间内的月
    static function getMonth($start_date, $end_date,$sta_type)
    {
//        q(date('Y-m', $start_date), date('Y-m', $end_date));
        $arr = array();
        //参数不能为空
        if (!empty($start_date) && !empty($end_date)) {
            //先把两个日期转为时间戳
//            $start_date = strtotime($start_date);
//            $end_date = strtotime($end_date);
            //开始日期不能大于结束日期
            if ($start_date <= $end_date) {
                //结束时间的年份、月份
                $end_year = date('Y', $end_date);
                $end_month = date('m', $end_date);
                //开始时间的年份、月份
                $start_year = date('Y', $start_date);
                $start_month = date('m', $start_date);
                //相隔月数
                $month = abs($end_year - $start_year) * 12 + $end_month - $start_month;
                if($sta_type=='step'){
                    for ($i = 0; $i <= $month; $i++) {
                        $start_time_last = date('Y-m-01', strtotime("+" . $i . " month", $start_date));
                        $arr[] = date('Y年m月', strtotime($start_time_last));;
                    }
                }else{
                    for ($i = 0; $i <= $month; $i++) {
                        $start_time_last = date('Y-m-01', strtotime("+" . $i . " month", $start_date));
                        $arr[] = date('Ym', strtotime($start_time_last));;
                    }
                }

            }
        }
        return $arr;
    }

    //获得一段时间内的周
    static function getWeek($start_date, $end_date,$sta_type)
    {
        $arr = array();
        //参数不能为空
        if (!empty($start_date) && !empty($end_date)) {
            //先把两个日期转为时间戳
//            $start_date = strtotime($start_date);
//            $end_date = strtotime($end_date);
            //开始日期不能大于结束日期
            if ($start_date <= $end_date) {
                $end_date_new = strtotime("next monday", $end_date);
                if (date("w", $start_date) == 1) {
                    $start_date_new = $start_date;
                } else {
                    $start_date_new = strtotime("last monday", $start_date);
                }
                //计算时间差多少周
                $count_week = ($end_date_new - $start_date_new) / (7 * 24 * 3600);
                if($sta_type=='step') {
                    for ($i = 0; $i < $count_week; $i++) {
                        $sd = date("Y-m-d", $start_date_new);
                        $ed = strtotime("+ 6 days", $start_date_new);
                        $eed = date("Y-m-d", $ed);
                        if(date('W', $ed)=='53'){
                            $arr[] = intval(date('Y', $ed)-1).'年'.date('第W周', $ed);
                        }else{
                            $arr[] = date('Y年第W周', $ed);
                        }
                        $start_date_new = strtotime("+ 1 day", $ed);
                    }
                }else{
                    for ($i = 0; $i < $count_week; $i++) {
                        $sd = date("Y-m-d", $start_date_new);
                        $ed = strtotime("+ 6 days", $start_date_new);
                        $eed = date("Y-m-d", $ed);
                        if(date('W', $ed)=='53'){
                            $arr[] = intval(date('Y', $ed)-1).date('W', $ed);
                        }else{
                            $arr[] = date('YW', $ed);
                        }
                        $start_date_new = strtotime("+ 1 day", $ed);
                    }
                }
            }
        }
        return $arr;
    }

    //这个星期的星期一
// @$timestamp ，某个星期的某一个时间戳，默认为当前时间
// @is_return_timestamp ,是否返回时间戳，否则返回时间格式
    static  function this_monday($timestamp=0,$is_return_timestamp=true){
        static $cache ;
        $id = $timestamp.$is_return_timestamp;
        if(!isset($cache[$id])){
            if(!$timestamp) $timestamp = time();
//            q($timestamp,date('y-m-d',$timestamp));
            $monday_date = date('Y-m-d', $timestamp-86400*date('w',$timestamp)+(date('w',$timestamp)>0?86400:-/*6*86400*/518400));
            $cache[$id] = strtotime($monday_date);
//            if($is_return_timestamp){
//                $cache[$id] = strtotime($monday_date);
//            }else{
//                $cache[$id] = $monday_date;
//            }
        }
        return $cache[$id];

    }

//这个星期的星期天
// @$timestamp ，某个星期的某一个时间戳，默认为当前时间
// @is_return_timestamp ,是否返回时间戳，否则返回时间格式
    static  function this_sunday($timestamp=0,$is_return_timestamp=true){
        static $cache ;
        $id = $timestamp.$is_return_timestamp;
        if(!isset($cache[$id])){
            if(!$timestamp) $timestamp = time();
            $sunday = self::this_monday($timestamp) + /*6*86400*/518400;
            $cache[$id] = $sunday;
        }
        return $cache[$id];
    }
}