<?php
/*
 * Created by PhpStorm
 * User: Yangchenglin
 * Date: 2015/11/27
 * Time: 13:33
 */
//场地管理列表页面
@session_start();
class Api_Demand_Product_List_Byid extends Api
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
            'status' => 'int',
            'account_phone'=>'string',
        ),$args);
        $conditions = array();
        if ($request['item_id']) {
            $conditions['item_id = ?'] = $request['item_id'];
        }

        //检测该手机号下的所有子空间id，控制手机号子空间权限
        $rs_name = Api_Demand_Product_Name::handle(array('phone' => $_SESSION['user']['phone']));
        $item_ids = array();
        foreach($rs_name['data'] as $key=>$val) {
            $item_ids[]= $val['id'];
        }
        $conditions[] = 'item_id IN ('.implode(',',$item_ids).')';

        if(!empty($request['status'])) {
            $conditions['status = ?'] = $request['status'];
        }
        $order = 'ORDER BY {table}.demand_time desc';
        $rs['data'] = Data_Mysql_Table_Product_Demand::select('*', $conditions,$order,999);
        foreach($rs['data'] as $k=>$v) {
            $rs['data'][$k]['demand'] = json_decode($v['demand'], 1);
            $rs['data'][$k]['detail'] = json_decode($v['detail'], 1);
        }
        foreach($rs['data'] as $k=>$v) {
            //活动日期没有跨年
            if(date('Y',$v['activity_start_time']) == date('Y',$v['activity_end_time'])) {
                $end_start = date('z',$v['activity_end_time']) - date('z',$v['activity_start_time']);
                //活动日期为1天
                if($end_start == 0) {
                    $rs['data'][$k]['detail']['活动名称'] = mb_strimwidth($v['detail']['活动名称'],0,8,'','utf-8');
                }elseif($end_start == 1) {
                    //活动日期为2天
                    $rs['data'][$k]['detail']['活动名称'] = mb_strimwidth($v['detail']['活动名称'],0,20,'','utf-8');
                }elseif($end_start == 2) {
                    //活动日期为3天
                    $rs['data'][$k]['detail']['活动名称'] = mb_strimwidth($v['detail']['活动名称'],0,30,'','utf-8');
                }elseif($end_start >= 3) {
                    //活动日期>=4天
                    $rs['data'][$k]['detail']['活动名称'] = mb_strimwidth($v['detail']['活动名称'],0,40,'','utf-8');
                }
            }elseif(date('Y',$v['activity_start_time']) != date('Y',$v['activity_end_time'])) {
                //活动日期跨年
                $end_start = 365 + date('z',$v['activity_end_time']) - date('z',$v['activity_start_time']);
                //活动日期为2天
                if($end_start == 1) {
                    $rs['data'][$k]['detail']['活动名称'] = mb_strimwidth($v['detail']['活动名称'],0,20,'','utf-8');
                }elseif($end_start == 2) {
                    //活动日期为3天
                    $rs['data'][$k]['detail']['活动名称'] = mb_strimwidth($v['detail']['活动名称'],0,30,'','utf-8');
                }elseif($end_start >= 3) {
                    //活动日期>=4天
                    $rs['data'][$k]['detail']['活动名称'] = mb_strimwidth($v['detail']['活动名称'],0,40,'','utf-8');
                }
            }
            $rs['data'][$k]['activity_start_time'] = date('Y-m-d',$v['activity_start_time']);
            $rs['data'][$k]['activity_end_time'] = date('Y-m-d',$v['activity_end_time']);
        }
//        q($rs);
        if(!empty($rs)) {
            $result = self::request('success',$rs,'成功');
        }else{
            $result = self::request('error','','失败');
        }
        return $result;
    }
}