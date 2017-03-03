<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2016/9/26
 * Time: 15:14
 */
class OA_Demand_Export
{
    static function handle()
    {
//        $request = Func_Input::filter(array(
//            'type' => 'int',
//        ), $_REQUEST);
//        if (empty($request['type'])) {
//            q('请选择城市：1表示北京，2表示上海');
//        }

//ssID	创建时间	活动名称	需求类型	联系人	城市	预算范围	具体要求	负责人	进度	操作

        $cvs_cols = array('ssID',
            '创建时间',
            '活动名称',
            '公司名称',
            '需求类型',
            '联系人',
            '联系方式',
            '城市',
            '预算范围',
            '档期',
            '具体要求',
            '负责人',
            '进度'
        );
        $data = array();
        $cols = array(
            '{table}.*',
            't1.id as grab_id,t1.sale_phone,t1.step as grab_step'
        );
        $conditions = array();

        $table = '{table}  LEFT JOIN {prefix}grab_order as t1 ON {table}.id=t1.id ';
//        if (!empty($request['type'])) {
//            if ($request['type'] == 1) {
//                $conditions["{table}.city=?"] = "北京";
//            } elseif ($request['type'] == 2) {
//                $conditions["{table}.city=?"] = "上海";
//            }
//        }
//        Data_Mysql_Table_Demand::rebuildIndex(1);
//        $conditions['{table}.demand_status=?'] = 1;
        $conditions['{table}.create_time>?']= time()-86400*90;
        $list = Data_Mysql_Table_Demand::select($cols, $conditions, 'ORDER BY {table}.id DESC', 3500, $table);
        $adminALL = OA_Demand_Lists_All::getMemberList('销售部');
        foreach ($adminALL as $k => $val) {
            $salephone[$val['phone']]['fullname'] = $val['city'] . '-' . $val['fullname'];
        }
        $salephone[9]['fullname'] = '报价系统';

        $grab_step = Data_Mysql_Table_Demand::$step_funnel;
        //ssID	创建时间	活动名称	需求类型	联系人	城市	预算范围	具体要求	负责人	进度	操作
        foreach ($list as $k => $v) {
            $demand = json_decode($v['demand'], 1);
            $data[$k][] = $v['id'];
            $data[$k][] = date("Y-m-d H:i", $v['create_time']);
            $data[$k][] = $v['demand_name'];
            $data[$k][] = @$demand['公司名称'];
            $data[$k][] = $v['demand_type'];
            $data[$k][] = @$demand['联系人'];
            $data[$k][] = @$demand['联系电话'];
            $data[$k][] = $v['city'];
            $data[$k][] = $v['price_up'] . '-' . $v['price_down'];
            $data[$k][] = @$demand['开始时间'] . '-' . @$demand['结束时间'];
            $data[$k][] = $demand ? @implode(',', $demand) : '';
            $data[$k][] = !empty($salephone[$v['sale_phone']]) ? $salephone[$v['sale_phone']]['fullname'] : $v['sale_phone'];
            $data[$k][] = $grab_step[intval($v['grab_step'])];
        }
        Func_Csv::writeRow($cvs_cols, $data);

    }
}
