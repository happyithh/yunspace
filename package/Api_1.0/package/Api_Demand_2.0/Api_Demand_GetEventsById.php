<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2016/1/21
 * Time: 16:37
 * 获取意向的场地ID
 */
class Api_Demand_GetEventsById
{
    /**
     * 获取意向场地
     */
    static function  getEvents($args)
    {
        $request = Func_Input::filter(array(
            'id' => 'int',
        ), $args);
//        yun_spacepedia
        if (empty($request['id'])) {
            return Api::request('error', '', '缺失参数~');
        }
        $table = "{table} as t1 LEFT JOIN {prefix}spacepedia as t2 ON t1.object_id = t2.id";
        $data = Data_Mysql_Table_Demand_Events::select("t1.demand_id,t1.create_time,t1.demand,t2.space_name,t2.addr,t2.city", array('t1.demand_id=?' => $request['id']), '', 5, $table);
        if (!empty($data[0])) {
            return Api::request('success', self::format($data), '  成功');
        }
        return Api::request('error', '', '没有');

    }

    static function  format($array)
    {
        foreach ($array as $k => $val) {
            if (!empty($val['demand'])) {
                $array[$k]['demand'] = json_decode($val['demand'], 1);
            }
            if (!empty($val['create_time'])) {
                $array[$k]['create_time'] = Date('Y-m-d H:i', $val['create_time']);
            }
        }
        return $array;

    }

} 