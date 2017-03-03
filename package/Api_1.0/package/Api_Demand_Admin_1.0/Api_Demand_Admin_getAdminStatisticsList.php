<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2015/9/8
 * Time: 13:34
 * 需求统计 ：  负责人的统计
 */
class Api_Demand_Admin_getAdminStatisticsList extends Api
{

    static function adminStatistics($args)
    {
        $request = Func_Input::filter(array(
            'search' => 'array'
        ), $args);
        $conditions = array();
        if (!empty($request['search']['phone'])) {
            $conditions['t2.sale_phone =?'] = $request['search']['phone'];
        }
        $search_time = array();
        if (!empty($request['search']['start_time']) || !empty($request['search']['end_time'])) {
            $request['type']='week';
            $search_time = Api_Demand_Admin_getStepStatisticsList::timeDeal($request);
            $conditions['t1.create_time between ? and ?'] = array($search_time['start_time'], $search_time['end_time']);
        }
        $conditions['t1.demand_status =?'] = 1;
        $newResult = self::getWeekData($conditions,$search_time);

        return self::request('success', $newResult, '');
    }

    // 获取前6周的数据
    static function getWeekData($args,$search)
    {

        // 时间处理
        if (empty($search)) {
            $args['t1.create_time >= ?'] = strtotime('-6 week');
            $time = Api_Winchance_Ip_Statistical_Time_Deal::getWeek($args['t1.create_time >= ?'], time(), 'step');
        } else {
            $time = Api_Winchance_Ip_Statistical_Time_Deal::getWeek($search['start_time'], $search['end_time'], 'step');
        }
        $args['t2.sale_phone !=?']=0;
//        Data_Mysql_Table_Grab_Order::debug(1);
        $res = Data_Mysql_Table_Demand::select('count(*) as c,t2.sale_phone,FROM_UNIXTIME(t1.create_time,"%Y年第%u周") days', $args, 'GROUP BY days,t2.sale_phone', 300,'{table} as t1 LEFT JOIN {prefix}grab_order as t2 ON t1.id=t2.id');
        //获取所有负责人
        $admins= self::getAdmin();
        $newResult = array();


        $keys = array_fill(0, count($time), '');

        //组合数据
//        q(!empty($args['response_account_id =?']));
        if(!empty($args['phone =?'])){
            $newResult[$args['phone =?']]=array_combine(array_values($time), array_values($keys));
        }else{
            foreach($admins as $k=>$v){
                $newResult[$v]=array_combine(array_values($time), array_values($keys));
            }
            $newResult['9'] = array_combine(array_values($time), array_values($keys));
        }
        //匹配数据
        foreach ($res as $v) {
            if(!empty($admins)){
//                q($v['sale_phone'],$admins);
                if(array_search($v['sale_phone'],$admins)){
                    $newResult[$v['sale_phone']][$v['days']] = $v['c'];
                }
            }
        }
//        q($newResult);
        $num = array();
        foreach($newResult as $k=>$v){
            $newResult[$k]['num']=array_sum($v);
            $num[$k]=$newResult[$k]['num'];
        }
        arsort($num);
//        q(array_flip($admins));
        $endResult=array();  
        foreach($num as $k=>$v){
            $endResult[$k]=$newResult[$k];
            unset($endResult[$k]['num']);
        }
        $endResult['weeks'] = $time;
        $endResult['admins']=array_flip($admins);
        $endResult['pie']=self::pieChart($admins,$res);
//        q($endResult);
        return $endResult;

    }
    static function getAdmin()
    {
        $conditions['t1.department_name =?'] = '销售部';
        $conditions[] = 't2.status = 1';
        $table = '{table} as t1 LEFT JOIN {prefix}administrator as t2 ON t1.admin_id = t2.id LEFT JOIN {prefix}account as t3 ON t2.phone = t3.phone';
        $re = Data_Mysql_Table_Department_Member::select(' t1.*,t2.id as admin_id,t2.phone, t2.fullname,t3.id as response_account_id', $conditions, 'GROUP BY t2.id', 9999, $table);
        $getAdmin=array();
        if (!empty($re)) {
            foreach ($re as $k => $v) {
                if (!empty($v['phone'])) {
                    $getAdmin[$v['fullname']] = $v['phone'];
                }
            }
            $getAdmin['报价系统'] = '9';
        }
        return $getAdmin;
    }
    static function  pieChart($admin,$data){

        $keys = array_fill(0, count($admin), '');

        $newArr = array_combine(array_values($admin),$keys);
        $newAdmin=array_flip($admin);
//        q($newArr,$newAdmin,$data);
        foreach($data as $k=>$v){
            if(!empty($v['sale_phone']) && !empty($v['c'])){
                if(array_key_exists($v['sale_phone'],$newArr)){
                    $newArr[$v['sale_phone']]+=$v['c'];
                }
            }

        }
        $nes=array();
        foreach($newAdmin as $k=>$v){
            if(!empty($newArr[$k])){
                $nes[] = '{value:'.$newArr[$k].',name:"'.$v.'"}';
                $nes['name'][] = $v;
            }
        }
        return $nes;
    }

}