<?php

/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2015/12/9
 * Time: 10:23
 */
class Api_Grab_Order_Get_Wait_List extends Api
{
    /**
     * 获取待抢单列表
     * 所有待抢订单列表
     * 主要条件是，客服完善信息的，或者过20分钟没有完善信息的需求。需求表添加，抢单状态字段
     *
     */
    /**
     * @param string $args
     * @return array
     * zzc  12/14
     */
    static function handle($args = '')
    {
        Api_Session::checkToken(1);
        return self::handleList($args);
    }

    /**
     * @param $args
     * @return array
     */
    static function  handleList($args)
    {
        $request = Func_Input::filter(array(
            'type' => 'string',
            'phone' => 'phone',
        ), $args);

        $cols = "t1.id ,t1.step,t1.create_time,t2.price_up,t2.price_down,t2.demand,t2.backup_demand,t2.mark_tags,t2.integral";
        $table = "{table} as t1 LEFT JOIN {prefix}demand as t2 ON t1.id = t2.id";
        //个人单
        if (!empty($request['type']) && $request['type'] == 'B') {
            if (empty($request['phone'])) {
                return Api::request('error', '', '手机号错误~');
            }
            $conditions[] = "t1.sale_phone = " . $request['phone'];
        } else {
            if (empty($_COOKIE['GRAB_CITY'])) {
                @session_start();
                $adminInfo = Api_Administrator_getBaseInfo::getAdminInfoByPhone(array('phone' => $_SESSION['user']['phone']));
                $city = $adminInfo['city'];
            } else {
                $city = $_COOKIE['GRAB_CITY'];
            }
            $conditions[] = "( t2.city = '" . $city . "'  OR t2.notice_city ='" . $city . "')";
            $conditions[] = "( t1.status=0 AND t1.sale_phone='' AND t2.demand_status=1 AND t1.create_time >" . (time() - 1209) . ") OR (t1.is_holiday=1 )";
        }
        //关闭状态， 完成的 不可见
//        $conditions[] = 't1.step >=0 AND t1.step < 100';
        $data = Data_Mysql_Table_Grab_Order::select($cols, $conditions, 'ORDER BY t1.create_time DESC', 30, $table);

        if (empty($data[0])) {
            return Api::request('error', '', '没有更多');
        }
        return Api::request('success', Data_Mysql_Table_Grab_Order::format($data), '');


    }

}