<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2015/11/4
 * Time: 9:53
 * 广告点击量、展现量统计信息
 */
class Api_Pa_Statistics extends Api
{
    static function statistics($args)
    {
        $request = Func_Input::filter(
            array(
                'search'=>'array',
                'type' => 'string',
            ), $args);
        $condition=array();
        if(!empty($args['search']['pa']) && strstr($request['search']['pa'],',')){
            $pa = explode(',',$args['search']['pa']);
            $condition['{table}.site_id = ?'] = $pa[0];
            $condition['{table}.adv_id = ?'] = $pa[1];
        }
//        q($condition);
        $request['type'] = empty($request['type']) ? 'day' : $request['type'];
        switch ($request['type']) {
            case 'day':
                $res = self::dayStatistic($condition);
                break;
            case 'week':
                $res = self::weektatistic($condition);
                break;
            case 'month':
                $res = self::monthStatistic($condition);
                break;
            default:
                $res = self::dayStatistic($condition);
        }
        return $res;
    }

    // 按天统计
    static function dayStatistic($condition)
    {

//        q($condition);
        $condition['date_time >= ?'] = date('ymd', strtotime('-14 day')).'00';
//        Data_Mysql_Table_Pa_Static::subTable(date('_Ym'))->debug(1);
        $res = Data_Mysql_Table_Pa_Static::subTable(date('_Ym'))->select('SUM(display) as display,SUM(click) as click, FLOOR(date_time / 100) as days', $condition, 'GROUP BY days', 15);
        if (date('m', strtotime('-14 day')) != date('m')) {
            $date = date('Ym', strtotime('-16 day'));
            $res1 = Data_Mysql_Table_Pa_Static::subTable('_' . $date)->select('SUM(display) as display,SUM(click) as click, FLOOR(date_time / 100) as days', $condition, 'GROUP BY days', 15);
            $res = array_merge($res, $res1);
        }
//        q($res);
        $newRes = array();
        for ($i = strtotime('-14 day'); $i <= time(); $i += 86400) {
            $newRes[date('Y-m-d', $i)]['展示量'] = '';
            $newRes[date('Y-m-d', $i)]['点击量'] = '';
            $newRes[date('Y-m-d', $i)]['点击率'] = '';
        }
        if (!empty($res)) {
            foreach ($res as $k => $v) {
                $key = date('Y-m-d', strtotime(substr(date('Y'), 0, 2) . $v['days']));
                $newRes[$key]['展示量'] += $v['display'];
                $newRes[$key]['点击量'] += $v['click'];
                $newRes[$key]['点击率'] = sprintf('%.4f', $v['click'] / $v['display']);


            }
            krsort($newRes);
            $type = array(
                0 => '展示量',
                1 => '点击量',
                2 => '点击率',
            );
            $newRes['type'] = $type;
//            q($newRes);
            return $newRes;
        }
    }

    // 按周统计
    static function weektatistic($condition)
    {
//        if(!empty($args['search']['pa'])){
//            $pa = explode(',',$args['search']['pa']);
//            $condition['{table}.site_id = ?'] = $pa[0];
//            $condition['{table}.adv_id = ?'] = $pa[1];
//        }
        $condition['date_time >= ?'] = date('ymd', strtotime('-5 week')) . '00';
        $res = Data_Mysql_Table_Pa_Static::subTable(date('_Ym'))->select('SUM(display) as display,SUM(click) as click, FLOOR(date_time / 100) as days', $condition, 'GROUP BY days', 49);
        if (date('m', strtotime('-5 week')) != date('m')) {
            if (date('m', strtotime('-5 week')) != date('m')) {
                $date = date('Ym', strtotime('-5 week'));
                $res1 = Data_Mysql_Table_Pa_Static::subTable('_' . $date)->select('SUM(display) as display,SUM(click) as click, FLOOR(date_time / 100) as days', $condition, 'GROUP BY days', 49);
                $res = array_merge($res, $res1);
            }
        }
//        q($res);
        $newRes = array();
        // 判断是否是周一，获取每周时间
        $is_monday = date("Y-m-d", (strtotime('-' . 0 . ' Monday'))) == date('Y-m-d', time()) ? 0 : 1;
        for ($i = 0; $i <= 5; $i++) {
            $j = $is_monday + $i;
//            $key[]= date('Y-W',strtotime('-' . $i . ' Sunday'));
            $day[date('Y-W', strtotime('-' . $i . ' Sunday'))] = date("Y-m-d", strtotime('-' . $j . ' Monday')) . ' ~ ' . date("Y-m-d", strtotime('-' . $i . ' Sunday'));
            $newRes[date('Y-W', strtotime('-' . $i . ' Sunday'))]['展示量'] = '';
            $newRes[date('Y-W', strtotime('-' . $i . ' Sunday'))]['点击量'] = '';
            $newRes[date('Y-W', strtotime('-' . $i . ' Sunday'))]['点击率'] = '';
        }

        if (!empty($res)) {
            foreach ($res as $k => $v) {
                $newRes[date('Y-W', strtotime(date('Y') . substr($v['days'], 2)))]['展示量'] += $v['display'];
                $newRes[date('Y-W', strtotime(date('Y') . substr($v['days'], 2)))]['点击量'] += $v['click'];
                $newRes[date('Y-W', strtotime(date('Y') . substr($v['days'], 2)))]['点击率'] = sprintf('%.4f', $v['click'] / $v['display']);
//
            }
            $newRes1 = array();
            foreach ($day as $k => $v) {
                $newRes1[$v] = $newRes[$k];
            }
            $type = array(
                0 => '展示量',
                1 => '点击量',
                2 => '点击率',
            );

            $newRes1['type'] = $type;
            return $newRes1;
        }
    }

    // 按月统计
    static function monthStatistic($condition)
    {

//        if(!empty($args['search']['pa'])){
//            $pa = explode(',',$args['search']['pa']);
//            $condition['{table}.site_id = ?'] = $pa[0];
//            $condition['{table}.adv_id = ?'] = $pa[1];
//        }
        $newRes = array();
        for ($i = 0; $i <= 5; $i++) {
            $date = date('Ym', strtotime('-' . $i . ' month'));
            $newRes[date('Y-m', strtotime('-' . $i . ' month'))]['展示量'] = '';
            $newRes[date('Y-m', strtotime('-' . $i . ' month'))]['点击量'] = '';
            $newRes[date('Y-m', strtotime('-' . $i . ' month'))]['点击率'] = '';

            $res[$i] = Data_Mysql_Table_Pa_Static::subTable('_' . $date)->select('SUM(display) as display,SUM(click) as click, FLOOR(date_time / 10000) as days', $condition, 'GROUP BY days', 6);
//            q($res);
            if (empty($res[$i][0]['days'])) {
                unset($res[$i]);
            }
        }
//        q($res);
        if (!empty($res)) {
            foreach ($res as $k => $v) {
                $y = substr(date('Y'), 0, 2) . substr($v[0]['days'], 0, 2) . '-' . substr($v[0]['days'], 2, 4);
//                q($y);
                $newRes[$y]['展示量'] = $v[0]['display'];
                $newRes[$y]['点击量'] = $v[0]['click'];
                $newRes[$y]['点击率'] = sprintf('%.4f', $v[0]['click'] / $v[0]['display']);
            }
            $type = array(
                0 => '展示量',
                1 => '点击量',
                2 => '点击率',
            );
            $newRes['type'] = $type;
            return $newRes;
        }

    }

}