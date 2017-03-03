<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/12/14
 * Time: 15:30
 * 销售抢单
 */
class Api_Grab_Order_GrabSingle extends Api
{
    /**
     *
     *  1.销售的积分大于 单 所需积分
     *  2.抢单成功扣除销售相应的积分
     *  3.更改抢单的状态
     */
    static function handle($args = '')
    {
        Api_Session::checkToken(1);
        return self::GrabSingle($args);

    }

    static function  GrabSingle($args)
    {
        @session_start();
        $request = Func_Input::filter(array(
            'id' => 'int'
        ), $args);

        $conditions[] = "t1.sale_phone = 0 AND t1.id = " . $request['id'];
        $table = "{table} as t1 LEFT JOIN {prefix}demand as t2 ON t1.id = t2.id";
        $exist = Data_Mysql_Table_Grab_Order::select('t1.status,t1.create_time,t2.integral', $conditions, '', 1, $table);

        if (empty($exist[0])) {
            return Api::request('error', '', '您来晚了，已经被抢走了！');
        }
        $myIntegral = Api_Grab_Order_OperationIntegral::getIntegralByPhone(array('phone' => $_SESSION['user']['phone']));
        if (empty($exist[0]['integral'])) {
            return Api::request('error', '', '不存在您的积分信息！~');
        }
        if ($myIntegral < $exist[0]['integral']) {
            return Api::request('error', '', '您的积分不符合条件！~');
        }
//
//        if (($exist[0]['create_time'] + 1200) < time()) {
//            return Api::request('error', '', '失败，订单已经超时');
//        }
        $data = Data_Mysql_Table_Grab_Order::update(array('id=?' => $request['id']), array(
            'sale_phone' => $_SESSION['user']['phone'],
            'status' => 1
        ));
        Data_Mysql_Table_Account_Log::insertAccountLog($_SESSION['user']['id'], '', '抢单', '抢单操作' . $_SESSION['user']['phone'], $request['id']);

        if ($data[0] > 0) {

            $integralArray = array(
                'phone' => $_SESSION['user']['phone'],
                'integral' => intval(@$exist[0]['integral']),
                'type' => 'reduce',
                'title' => '抢单',
                'reason' => '抢单' . $request['id'],
            );
            Api_Administrator_Integral_Manage::integralManages($integralArray);
            $admin_info = Api_Administrator_getBaseInfo::getAdminInfoByPhone(array('phone' => $_SESSION['user']['phone']));
            Data_Mysql_Table_Demand::query("UPDATE {table} SET admin_id=? WHERE id=?", array($admin_info['id'], $request['id']), 1);

            return Api::request('success', '', '抢单成功,记得要更新进度哦！');
        }
        return Api::request('error', '', '失败，下次记得早点来！');


    }

} 