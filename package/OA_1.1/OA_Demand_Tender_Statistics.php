<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2015/9/8
 * Time: 11:06
 */
class OA_Demand_Tender_Statistics
{
    static function demandTenderStatistics()
    {
        $request = Func_Input::filter(array(
            'type' => 'string',
            'search' => 'array'
        ));
        if (empty($request['type'])) {
            $request['type'] = 'weeks';
        }
        // 对需求统计类型 进行处理
        $statistics = empty($request['search']['statisticsType']) ? 'step' : $request['search']['statisticsType'];
        $type = empty($request['type']) ? 'weeks' : $request['type'];
        switch ($statistics) {

            // 需求跟进
            case 'step':
                self::stepData($type);
                break;
           /* // 需求来源
            case 'demand_type':
                self::demandType($type);
                break;
            // 需求时间点
            case 'hours':
                self::demandHours();
                break;*/
            // 需求城市
            case 'citys':
                self::demandCity();
                break;
           /* case 'admin':
                self::demandAdmin();
                break;*/
            default:
                self::stepData($type);
        }

        if (empty($request['type']) && $statistics != 'hours') {
            $request['type'] = 'days';
        }
        if ($statistics == 'hours') {
            $request['type'] = 'months';
        }

       // Tpl_Smarty::assign('admin', self::getAdmin());
        Tpl_Smarty::assign('type', $request['type']);

        Tpl_Smarty::display('OA_Static::demands_tender/demand_tender_statistics/demand_tender_statistics.tpl');
    }

       /* // 获取所有负责人
        static function getAdmin()
        {
            $conditions['t1.department_name =?'] = '销售部';
            $conditions[] = 't2.status = 1';
            $table = '{table} as t1 LEFT JOIN {prefix}administrator as t2 ON t1.admin_id = t2.id LEFT JOIN {prefix}account as t3 ON t2.phone = t3.phone';
            $re = Data_Mysql_Table_Department_Member::select(' t2.fullname,t3.id as response_account_id', $conditions, 'GROUP BY t2.id', 9999, $table);
            if (!empty($re)) {
                foreach ($re as $k => $v) {
                    if (!empty($v['response_account_id']) && !empty($v['fullname'])) {
                        $getAdmin[$v['response_account_id']] = $v['fullname'];
                    }
                }
            }
            return $getAdmin;
        }*/

    // 需求跟进
    static function stepData($timeType)
    {
        // 获取数据
        $res = Api_Demand_Tender_getStepStatisticsList::stepStatistics($_REQUEST);
        // 获取进度类型
       // $step = Data_Mysql_Table_Demand::$step_funnel;

        // 处理进度数据
       /* $plan = array();
        if (!empty($step)) {
            foreach ($step as $k => $v) {
                $steps[$k] = explode("-", $v);
                $plan[$k] = $steps[$k][0];
            }
        }
        Tpl_Smarty::assign('step_funnel', $plan);*/

        // 处理统计图显示数据
        if (!empty($res['data'])) {
            $step1 = array();
            $step2 = array();
          foreach ($res['data'] as $k => $v) {
                if ($timeType == 'weeks') {
                    $arr1 = substr($k, 5, 5);
                    $arr2 = substr($k, 18, 5);
                    $date[] = $arr1 . '~' . $arr2;
                } elseif ($timeType == 'days') {
                    $arr = explode('-', $k);
                    $date[] = $arr[1] . '-' . $arr[2];
                } else {
                    $date[] = $k;
                }

                $step1[] = empty($v[4]) ? 0 : $v[4];
                $step2[] = empty($v[-1]) ? 0 : $v[-1];
                $sum[] = array_sum($v);
            }
            // 视图显示数据 输出
            krsort($date);
            krsort($sum);
            krsort($step1);
            krsort($step2);
            Tpl_Smarty::assign('sum', json_encode(array_values($sum), 1));
            Tpl_Smarty::assign('daysTime', json_encode(array_values($date), 1));
            Tpl_Smarty::assign('step1', json_encode(array_values($step1), 1));
            Tpl_Smarty::assign('step2', json_encode(array_values($step2), 1));
         //   Tpl_Smarty::assign('stepType', $plan);
        }
        // table 数据输出
        if (!empty($res['data'])) {
            Tpl_Smarty::assign('data', $res['data']);
        }
    }

    // 需求来源
    static function demandType($timeType)
    {
        // 获取来源类型
//        $demandType = Data_Mysql_Table_Demand::$_demandType;
//        Q($demandType);

        // 获取数据
        $res = Api_Demand_Admin_getDemandTypeStatisticsList::demandTypeStatistics($_REQUEST);
        // 处理图表显示数据
        $dataVaule = array();
        $month = array();
        if (!empty($res['data'])) {
            foreach ($res['data'] as $k => $v) {
                $date = array_keys($v);     // 过滤后的数据类型
                $dataVaule[$k] = $v;        // 过滤后的数据
                // 处理时间显示长度
                if ($timeType == 'weeks') {
                    $arr1 = substr($k, 5, 5);
                    $arr2 = substr($k, 18, 5);
                    $month[] = $arr1 . '~' . $arr2;
                } elseif ($timeType == 'days') {
                    $arr = explode('-', $k);
                    $month[] = $arr[1] . '-' . $arr[2];
                } else {
                    $month[] = $k;
                }
            }
            // 不同类型下的 六个月的总计
            $dataSum = array();
            for ($i = 0; $i <= 7; $i++) {
                $sum1[$i] = 0;
                foreach ($dataVaule as $k => $v) {
                    $sum1[$date[$i]][] = $sum1[$i] + $v[$date[$i]];
                }
                unset($sum1[$i]);
                $dataSum[] = array_sum($sum1[$date[$i]]);
            }

            //  输出视图显示数据
            $i = 0;
            foreach ($dataVaule as $k => $v) {
                // 给为空的键赋值 0
                foreach ($v as $kk => $vv) {
                    $v[$kk] = empty($vv) ? 0 : $vv;
                }
                $i = $i + 1;
                Tpl_Smarty::assign('demand' . $i, json_encode(array_values($v), 1));
            }
            if (!empty($date)) {
                Tpl_Smarty::assign('demandType', $date);
            }
            // table 数据输出
            Tpl_Smarty::assign('data', $dataVaule);
            Tpl_Smarty::assign('dataSum', json_encode(array_values($dataSum), 1));
            Tpl_Smarty::assign('month', $month);
            Tpl_Smarty::assign('dataType', json_encode(array_values($date), 1));
        }

    }
/*    //需求时间点
    static function demandHours()
    {
        if (!empty($hours)) {
            Tpl_Smarty::assign('hours', $hours);
        }

        // 获取数据
        $res = Api_Demand_Admin_getDemandHoursStatistics::demandHoursStatistics($_REQUEST);
        if(!empty($res['data'])){
//            q($res['data']);
            Tpl_Smarty::assign('data', $res['data']);
        }

        // 过滤处理视图显示信息
        $date = array(); // 时间点
        if (!empty($res)) {
            foreach ($res['data'] as $k => $v) {
                for ($i = 0; $i < 7; $i++) {
//                    if($k==$i){
                    unset($res['data'][$i]);
//                    }
                }
                unset($res['data'][22]);
                unset($res['data'][23]);
                $months = array_keys($v);
            }
            $data=array();
            foreach ($res['data'] as $k=>$v) {
                $sum[] = array_sum(array_values($v));
                $data[$months[0]][] = empty($v[$months[0]])?0:$v[$months[0]];
                $data[$months[1]][] = empty($v[$months[1]])?0:$v[$months[1]];
                $data[$months[2]][] = empty($v[$months[2]])?0:$v[$months[2]];
                $data[$months[3]][] = empty($v[$months[3]])?0:$v[$months[3]];
                $data[$months[4]][] = empty($v[$months[4]])?0:$v[$months[4]];
                $data[$months[5]][] = empty($v[$months[5]])?0:$v[$months[5]];
                $date[] = $k.':00';
            }

            Tpl_Smarty::assign('dataSum', json_encode(array_values($sum), 1));
            Tpl_Smarty::assign('month', $months);

//            q(json_encode(array_values($res['data']),1));
            Tpl_Smarty::assign('getHours', json_encode(array_values($date)));


            //  输出视图显示数据
            for ($i = 0; $i <= 5; $i++) {
                Tpl_Smarty::assign('hours' . $i, json_encode(array_values($data[$months[$i]])), 1);
            }
        }
    }
*/
    //需求城市
    static function demandCity(){

        //获取数据
        $res = Api_Demand_Tender_getStepStatisticsList::stepStatistics($_REQUEST);
        if(!empty($res['data'])){
            $citys = $res['data']['city'];
            Tpl_Smarty::assign('citys',$citys);
            unset($res['data']['city']);
            Tpl_Smarty::assign('data',$res['data']);
        }
    }

    //需求负责人
  /*  static function demandAdmin(){
        //获取数据
        $res=Api_Demand_Admin_getAdminStatisticsList::adminStatistics($_REQUEST);
        if(!empty($res['data'])){
            $weeks = array();
            foreach($res['data']['weeks'] as $k=>$v){
                $weeks[] = explode('-',$v);
            }
//            q($weeks);
            Tpl_Smarty::assign('weeksTime',$weeks);
            Tpl_Smarty::assign('adminsData',$res['data']['admins']);
//            q($res['data']);
            unset($res['data']['weeks']);
            unset($res['data']['admins']);
            Tpl_Smarty::assign('data',$res['data']);
        }

    }*/
}