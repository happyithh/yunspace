<?php

/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2015/12/9
 * Time: 10:35
 */
class Api_Grab_Order_Get_Info extends Api
{

    /**
     * 获取订单详情
     * 根据订单ID 及是否登录
     *后台登录session
     */
    static function  handle($args = '')
    {
        Api_Session::checkToken(1);

        return self::getInfo($args);
    }

    static function  getInfo($args)
    {
        $request = Func_Input::filter(array(
            'id' => 'int',
            'phone' => 'phone'
        ), $args);
        if (empty($request['id'])) {
            return Api::request('error', '', '缺少参数');
        }
        if (!empty($request['phone'])) {
            $conditions[] = "t2.id =" . $request['id'] . " AND t1.sale_phone=" . $request['phone'];
        } else {
            $conditions[] = "t2.id =" . $request['id'] . " AND t1.sale_phone=0";
        }
        $table = "{table} as t1 LEFT JOIN {prefix}demand as t2 ON t1.id = t2.id";
        $data = Data_Mysql_Table_Grab_Order::select('t1.*,t2.phone,t2.demand_type,t2.create_time as demand_create_time,t2.demand,t2.backup_demand,t2.demand_name,t2.price_up,t2.price_down,t2.mark_tags,t2.integral', $conditions, '', 1, $table);
        if (empty($data[0]['id'])) {
            return Api::request('error', '', '没有找到数据~');
        }

        $rs = Data_Mysql_Table_Grab_Order::format($data);
        return Api::request('success', $rs[0], '成功');
    }

}