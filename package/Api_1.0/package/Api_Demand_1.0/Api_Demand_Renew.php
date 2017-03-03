<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2015/7/27
 * Time: 16:15
 *
 * 1.恢复一条需求记录
 * 2.暂时不用管群的相关操作
 */
class Api_Demand_Renew extends APi
{
    /**
     *    传入参数
     *$args= array(
     *          account_id => [Api_Session::user_id()]
     *          demand_id =>   需求ID
     * )
     * 返回  array()
     */

    static function  handle($args = '')
    {
        Api_Session::checkToken(1);
        $args['account_id'] = Api_Session::user_id();
        return self::demandRenew($args);
    }

    static function  demandRenew($args)
    {
        $request = Func_Input::filter(array(
            'account_id' => 'int',
            'demand_id' => 'int',
        ), $args);
        if (empty($request['account_id']) || empty($request['demand_id'])) {
            return Api::request('error', '', '缺少参数或者参数不正确，请检查参数合法性');
        }
        $status = Data_Mysql_Table_Demand::update(array('id=?' => $request['demand_id'], 'account_id =?' => $request['account_id']),
            array('step' => '0', 'demand_status' => '0'));
        if ($status[0] > 0) {
            return Api::request('success', '', '恢复成功');
        }
        return Api::request('success', '', '操作失败，如有问题请致电400-056-0599');

    }
}
