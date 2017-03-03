<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2015/9/8
 * Time: 11:06
 */
class OA_Demand_Statistics
{
    static function demandStatistics()
    {
        $request = Func_Input::filter(array(
            'type' => 'string',
            'search' => 'array'
        ));
        if (empty($request['type'])) {
            $request['type'] = 'day';
        }
        // 对需求统计类型 进行处理
        $statistics = empty($request['search']['statisticsType']) ? 'step' : $request['search']['statisticsType'];
        $type = empty($request['type']) ? 'day' : $request['type'];
        switch ($statistics) {

            // 需求跟进
            case 'step':
                self::stepData($type);
                break;
            // 需求来源
            case 'demand_type':
                self::demandType($type);
                break;
            // 需求时间点
            case 'hours':
                self::demandHours();
                break;
            // 需求城市
            case 'citys':
                self::demandCity();
                break;
            case 'admin':
                self::demandAdmin();
                break;
            default:
                self::stepData($type);
        }

        if (empty($request['type']) && $statistics != 'hours') {
            $request['type'] = 'day';
        }
        if ($statistics == 'hours') {
            $request['type'] = 'month';
        }

        Tpl_Smarty::assign('admin', self::getAdmin());
        Tpl_Smarty::assign('type', $request['type']);

        Tpl_Smarty::display('OA_Static::demands/demand_statistics/demand_statistics.tpl');
    }

    // 获取所有负责人
    static function getAdmin()
    {
        $conditions['t1.department_name =?'] = '销售部';
        $conditions[] = 't2.status = 1';
        $table = '{table} as t1 LEFT JOIN {prefix}administrator as t2 ON t1.admin_id = t2.id LEFT JOIN {prefix}account as t3 ON t2.phone = t3.phone';
        $re = Data_Mysql_Table_Department_Member::select(' t1.*,t2.id as admin_id,t2.phone, t2.fullname,t3.id as response_account_id', $conditions, 'GROUP BY t2.id', 9999, $table);
        if (!empty($re)) {
            foreach ($re as $k => $v) {
                if (!empty($v['admin_id']) && !empty($v['phone'])) {
                    $getAdmin[$k] = $v;
                }
            }
        }
        return $getAdmin;
    }

    // 需求跟进
    static function stepData($timeType)
    {
        // 获取数据
        $res = Api_Demand_Admin_getStepStatisticsList::stepStatistics($_REQUEST);
        // 获取进度类型
        $step = Data_Mysql_Table_Demand::$grab_order_step;

        // 处理进度数据
        $plan = array();
        if (!empty($step)) {
            foreach ($step as $k => $v) {
                $steps[$k] = explode("-", $v);
                $plan[$k] = $steps[$k][0];
            }
        }
        Tpl_Smarty::assign('step_funnel', $plan);

        // 处理统计图显示数据
        if (!empty($res['data'])) {
            $step1 = array();
            $step2 = array();
            foreach ($res['data'] as $k => $v) {
                $sum[] = $v['总计'];
                $date[] = $k;
                $step1[] = empty($v[100]) ? 0 : $v[100];
                $v[-1] = empty($v[-1]) ? 0 : $v[-1];
                $v[-2] = empty($v[-2]) ? 0 : $v[-2];
                $step2[] = empty($v[-1]) && empty($v[-2]) ? 0 : intval($v[-1] + $v[-2]);
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
            Tpl_Smarty::assign('stepType', $plan);
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
                $month[] = $k;
            }
            $dataSum = array(
                '400订单'=>'',
                '办活动'=>'',
                '联系供应商'=>'',
                '个人订单'=>'',
                '预约咨询'=>'',
                '文创'=>'',
                '办活动M'=>'',
                '年会咨询'=>'',
                '其他'=>'',
            );
            //  输出视图显示数据
            foreach ($dataVaule as $k => $v) {
                // 给为空的键赋值 0
                foreach ($v as $kk => $vv) {
                    $v[$kk] = empty($vv) ? 0 : $vv;
                    $dataSum[$kk] += $vv;
                }
                $demand_type[] = json_encode(array_values($v), 1);
            }
            Tpl_Smarty::assign('demand', $demand_type);

            if (!empty($date)) {
                Tpl_Smarty::assign('demandType', $date);
            }
//            q($dataSum);
            // table 数据输出
            Tpl_Smarty::assign('data', $dataVaule);
            Tpl_Smarty::assign('dataSum', json_encode(array_values($dataSum), 1));
            Tpl_Smarty::assign('month', $month);
            Tpl_Smarty::assign('dataType', json_encode(array_values($date), 1));
        }

    }

    //需求时间点
    static function demandHours()
    {
        if (!empty($hours)) {
            Tpl_Smarty::assign('hours', $hours);
        }

        // 获取数据
        $res = Api_Demand_Admin_getDemandHoursStatistics::demandHoursStatistics($_REQUEST);

        if (!empty($res['data'])) {
            $months = $res['data']['month'];
            unset($res['data']['month']);
            Tpl_Smarty::assign('data', $res['data']);
        }
        // 过滤处理视图显示信息
        $date = array(); // 时间点
        if (!empty($res['data'])) {
            foreach ($res['data'] as $k => $v) {
                for ($i = 0; $i < 7; $i++) {
//                    if($k==$i){
                    unset($res['data'][$i]);
//                    }
                }
                unset($res['data'][22]);
                unset($res['data'][23]);
                unset($res['data']['总计']);
            }

            $data = array();
            foreach ($res['data'] as $k => $v) {
                $sum[] = array_sum(array_values($v));
//                $data[$k][] = empty($v[$months[0]])?0:$v[$months[0]];
                foreach ($months as $kk => $vv) {
                    $data[$vv][] = empty($v[$vv]) ? 0 : $v[$vv];
                }
                $date[] = $k . ':00';
            }
            Tpl_Smarty::assign('dataSum', json_encode(array_values($sum), 1));
            Tpl_Smarty::assign('month', $months);

//            q(json_encode(array_values($res['data']),1));
            Tpl_Smarty::assign('getHours', json_encode(array_values($date)));


            //  输出视图显示数据
            if (!empty($months)) {
                foreach ($months as $k => $v) {
//                    q(json_encode(array_values($data[$v]),1));
                    $hours[] = json_encode(array_values($data[$v]), 1);
                }
                Tpl_Smarty::assign('hours', $hours);
            }
        }
    }

    //需求城市
    static function demandCity()
    {

        //获取数据
        $res = Api_Demand_Admin_getCityStatisticsList::demandCityStatistics($_REQUEST);
        if (!empty($res['data'])) {
            $citys = array_values($res['data']['city']);
            Tpl_Smarty::assign('citys', $citys);
            if (!empty($res['data']['pie'])) {
                Tpl_Smarty::assign('city_s', $res['data']['pie']['name']);
                unset($res['data']['pie']['name']);
                Tpl_Smarty::assign('pieChart', $res['data']['pie']);
            }
            unset($res['data']['city']);
            unset($res['data']['pie']);
            Tpl_Smarty::assign('data', $res['data']);
        }

    }

    //需求负责人
    static function demandAdmin()
    {
        //获取数据
        $res = Api_Demand_Admin_getAdminStatisticsList::adminStatistics($_REQUEST);
        if (!empty($res['data'])) {

            Tpl_Smarty::assign('weeksTime', $res['data']['weeks']);
//            q($res['data']['admins']);
            Tpl_Smarty::assign('adminsData', $res['data']['admins']);
            if (!empty($res['data']['pie'])) {
                Tpl_Smarty::assign('admins', $res['data']['pie']['name']);
                unset($res['data']['pie']['name']);
                Tpl_Smarty::assign('pieChart', $res['data']['pie']);

            }
            unset($res['data']['pie']);
            unset($res['data']['weeks']);
            unset($res['data']['admins']);
            Tpl_Smarty::assign('data', $res['data']);
        }

    }
}