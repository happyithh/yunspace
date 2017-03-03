<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/5/12
 * Time: 13:57
 * 文创IP进度统计
 */
class Api_Winchance_New_Ip_Step_Statistical extends Api
{
    static function stepList()
    {
        $request = Func_Input::filter(array(
            'tab_time' => 'string',
        ), $_REQUEST);
//        q($request);
        $conditions=array();
        if(!empty($_REQUEST['search'])){
            $search = Func_Input::filter(array(
                'admin_id'=>'int',
                'city'=>'string',
                'start_time'=>'string',
                'end_time'=>'string',
            ),$_REQUEST['search']);
//            q($_REQUEST);
            if(!empty($search['admin_id'])){
                $conditions['admin_id =?'] = $search['admin_id'];

            }
            if(!empty($search['city'])){
                $conditions[] = "t3.city LIKE '%".$search['city']."%'";
            }
            /**
             *
             * 统计时间处理  -----开始------
             **/
            $search_time = Api_Winchance_Ip_Statistical_Time_Deal::searchTime($request['tab_time'],$search);
            if (empty($search['start_time']) && empty($search['end_time'])) {
                $conditions['check_time >=?'] = $search_time['start_time'];

            } elseif (empty($search['start_time']) && !empty($search['end_time'])) {

                $conditions['check_time between ? and ?'] = array($search_time['start_time'],$search_time['end_time']);

            } elseif (!empty($search['start_time']) && empty($search['end_time'])) {

                $conditions['check_time >=?'] = $search_time['start_time'];
            } elseif (!empty($search['start_time']) && !empty($search['end_time'])) {
                if($search['start_time'] > $search['end_time']){
                    Func_Header::back('请选择正确的起止时间！');
                }
                $conditions['check_time between ? and ?'] =array($search_time['start_time'],$search_time['end_time']);
            }
            /**
             *
             * 统计时间处理  -----结束------
             **/
//            q($conditions);
        }
        $tab_time = empty($request['tab_time']) ? 'week' : $request['tab_time'];
        switch ($tab_time) {
            case 'day':
                $cols = "count(*) as c ,ip_step,FROM_UNIXTIME(t3.check_time,'%Y年%m月%d日') as days";
              if(empty($search['start_time']) && empty($search['end_time'])){
                  $conditions['check_time >=?'] = strtotime('-1 month');
              }
                break;
            case 'week':
                $cols = "count(*) as c ,ip_step,FROM_UNIXTIME(t3.check_time,'%Y年第%u周') as days";
                if(empty($search['start_time']) && empty($search['end_time'])){
                    $conditions['check_time >=?'] = strtotime('-16 week');
                }
                break;
            case 'month':
                $cols = "count(*) as c ,ip_step,FROM_UNIXTIME(t3.check_time,'%Y年%m月') as days";
                if(empty($search['start_time']) && empty($search['end_time'])){
                    $conditions['check_time >=?'] = strtotime('-6 month');
                }
                break;
        }
        $table = "(SELECT * FROM(SELECT * FROM {prefix}winchance_check ORDER BY check_time ASC) as t2  WHERE t2.status=1 GROUP BY ip_id,ip_step) as t3";
//        Data_Mysql_Table_Winchance_Check::debug(1);
        $data = Data_Mysql_Table_Winchance_Check::select($cols,$conditions,"GROUP BY days,ip_step",99999,$table);
        // 显示时间处理
        if (empty($search['start_time']) && empty($search['end_time'])){
            $search_time['start_time'] = strtotime('-16 week');
            $search_time['end_time'] = time();
        }
        $time_interval = Api_Winchance_Ip_Statistical_Time_Deal::timeInterval($search_time['start_time'], $search_time['end_time'], $tab_time,'step');
        $newResult = array();
        $newResult['合计'] = array(
            '1' => '',
            '2' => '',
            '3' => '',
            '4' => '',
            '5' => '',
        );
        foreach ($time_interval as $k => $v) {
            $newResult[$v] = array(
                '1' => '',
                '2' => '',
                '3' => '',
                '4' => '',
                '5' => '',
            );
        }
        foreach ($data as $v) {
            $newResult[$v['days']][$v['ip_step']] = $v['c'];
            $newResult['合计'][$v['ip_step']] += $v['c'];
        }
        return array_reverse($newResult, 1);
    }

}