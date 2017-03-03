<?php
/*
 * Created by PhpStorm
 * User: Yangchenglin
 * Date: 2015/11/27
 * Time: 13:33
 */
//场地管理列表页面
@session_start();
class Api_Demand_Product_List extends Api
{
    static function handle($args='')
    {
//        Api_Session::checkToken(1);
        return self::handlegetList($args);
    }


    static function handlegetList($args)
    {
        $request = Func_Input::filter(array(
            'item_id' => 'int',
            'activity_time' => 'int',
            'status' => 'int',
            'account_phone'=>'string',
        ),$args);
        $conditions = array();
        if(empty($request['activity_time'])) {
            $conditions['{table}.activity_end_time >= ?'] = strtotime(date('Y',time()).'-'.date('m',time()).'-01');
            $conditions['{table}.activity_start_time <= ?'] = strtotime(date('Y',time()).'-'.date('m',time()).'-'.date('t',time()));
            $request['activity_time'] = time();
        }
        elseif(!empty($request['activity_time'])) {
            $activity_time = strrev($request['activity_time']);
            if($activity_time[0]==9) {
                $request['activity_time'] = substr($request['activity_time'],0,-1);
                $conditions['{table}.activity_end_time >= ?'] = strtotime(date('Y',$request['activity_time']).'-'.date('m',$request['activity_time']).'-01');
                $conditions['{table}.activity_start_time <= ?'] = strtotime(date('Y',$request['activity_time']).'-'.date('m',$request['activity_time']).'-'.date('t',$request['activity_time']));
            } else {
                $conditions['{table}.activity_start_time <= ?'] = $request['activity_time'];
                $conditions['{table}.activity_end_time >= ?'] = $request['activity_time'];
            }
        }
            $conditions['item_id = ?'] = $request['item_id'];

        //检测该手机号下的所有子空间id，控制手机号子空间权限(比如地址栏上输入该手机号没有访问权限的子空间id)
        $rs_name = Api_Demand_Product_Name::handle(array('phone' => $_SESSION['user']['phone']));
        $item_ids = array();
        foreach($rs_name['data'] as $key=>$val) {
            $item_ids[]= $val['id'];
        }
        if(!empty($request['item_id'])) {
            $conditions[] = 'item_id IN ('.implode(',',$item_ids).')';
        }
        if(!empty($request['status'])) {
            $conditions['status = ?'] = $request['status'];
        }
        $order = 'ORDER BY {table}.demand_time desc';
        $rs['data'] = Data_Mysql_Table_Product_Demand::select('*', $conditions,$order,999);
        foreach($rs['data'] as $k=>$v) {
            $rs['data'][$k]['demand'] = json_decode($v['demand'],1);
            $rs['data'][$k]['detail'] = json_decode($v['detail'],1);
            $rs['data'][$k]['activity_start_time'] = $v['activity_start_time'];
            $rs['data'][$k]['activity_end_time'] = $v['activity_end_time'];
            $rs['data'][$k]['demand_id'] = Func_NumEncode::e($rs['data'][$k]['demand_id']);
        }

        if($request['activity_time']) {
            $start_day = strtotime(date('Y',$request['activity_time']).'-'.date('m',$request['activity_time']).'-01');
            $total_mon_day = date('t',$request['activity_time']);
            $end_day = strtotime(date('Y',$request['activity_time']).'-'.date('m',$request['activity_time']).'-'.$total_mon_day);
            $condition = array();
            $condition['{table}.activity_end_time >= ?'] = $start_day;
            $condition['{table}.activity_start_time <= ?'] = $end_day;
            $condition['item_id = ?'] = $request['item_id'];
            $rs_total = Data_Mysql_Table_Product_Demand::select('*', $condition,$order,999);
            foreach($rs_total as $k=>$v) {
                $rs_total[$k]['demand'] = json_decode($v['demand'],1);
                $rs_total[$k]['detail'] = json_decode($v['detail'],1);
            }
            if(empty($rs_total)) {
                $rs['total']['total_day'] = 0;
                $rs['total']['total_item'] = 0;
                $rs['total']['total_rate'] = 0;
                $rs['total']['实际租金'] = 0;
                $rs['total']['目标租金'] = 0;
                $rs['total']['租金达成率'] = 0;
                $rs['total']['year'] = date('Y',$request['activity_time']);
                $rs['total']['month'] = date('n',$request['activity_time']);
            }elseif(count($rs_total)==1) {
                //跨年
                if(date('Y',$rs_total[0]['activity_start_time']) !=date('Y',$rs_total[0]['activity_end_time'])) {
                    $total_day = 365-date('z',$rs_total[0]['activity_start_time'])+date('z',$rs_total[0]['activity_end_time']);
                }
            else {
                    $total_day = 1+date('z',$rs_total[0]['activity_end_time'])-date('z',$rs_total[0]['activity_start_time']);
                }
                $rs['total']['total_day'] = $total_day;
                $rs['total']['total_item'] = 1;
                $rs['total']['total_rate'] = $rs['total']['total_day']/0.3;
                $rs['total']['实际租金'] = $rs_total[0]['status']==2 || $rs_total[0]['status']==3 ||$rs_total[0]['status']==4 ||$rs_total[0]['status']==6 ? $rs_total[0]['detail']['price'] : 0;
                $rs['total']['目标租金'] = $rs_total[0]['detail']['price'];
                if($rs['total']['目标租金']!=0) {
                    $rs['total']['租金达成率'] = $rs['total']['实际租金']/$rs['total']['目标租金']*100;
                }else{
                    $rs['total']['租金达成率'] = 0;
                }
                $rs['total']['year'] = date('Y',$request['activity_time']);
                $rs['total']['month'] = date('n',$request['activity_time']);
            } else {
                $total_day = $total_sj_price = $total_mb_price = array();
                foreach($rs_total as $k=>$v) {
                    //跨月份
                    if(date('m',$v['activity_start_time'])!=date('m',$v['activity_end_time'])) {
                        //开始时间所属月份的总天数
                        $total_day[] = date('t',$v['activity_start_time'])+date('d',$v['activity_end_time'])-date('d',$v['activity_start_time'])+1;
                    } else {
                        $total_day[] = date('d',$v['activity_end_time'])-date('d',$v['activity_start_time'])+1;
                    }
                    if($v['status']==2 || $v['status']==3 || $v['status']==4 || $v['status']==6) {
                        $total_sj_price[] = $v['detail']['price'];
                    }
                    $total_mb_price[] = $v['detail']['price'];

                    $rs['total']['total_day'] = array_sum($total_day);
                }
                $rs['total']['total_item'] = count($rs_total);
                $rs['total']['total_rate'] = $rs['total']['total_day']/0.3;
                $rs['total']['实际租金'] = array_sum($total_sj_price);
                $rs['total']['目标租金'] = array_sum($total_mb_price);
                @$rs['total']['租金达成率'] = ($rs['total']['实际租金']/$rs['total']['目标租金'])*100;
                $rs['total']['year'] = date('Y',$request['activity_time']);
                $rs['total']['month'] = date('n',$request['activity_time']);
            }
            $rs['total']['activity_time'] = $request['activity_time'];
            $rs_name = Api_Demand_Product_Name::handle(array('phone' => $_SESSION['user']['phone']));
            $item_info = $item_id = $yixiang = $yuding = array();
            foreach ($rs_name['data'] as $k => $v) {
                $item_info[$v['id']] = $v['item_name'];
            }
            foreach($item_info as $k=>$v) {
                $item_id[] = $k;
                if($request['item_id'] ==$k) {
                    $rs['total']['item_name'] = $v;
                }
            }
        }

        if(!empty($request['item_id'])) {
            $rs['item']['item_id'] = $request['item_id'];
        }
        if(!empty($rs)) {
            $result = self::request('success',$rs,'成功');
        }else{
            $result = self::request('error','','失败');
        }
        return $result;
    }
}