<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2015/7/27
 * Time: 16:15
 *
 * 需求详情
 */
class Api_Demand_GetInfo extends Api
{
    /**
     * @传入参数  $args = array(
     *              account_id =>[Api_Session::user_id()],
     *              demand_id =>'',     需求ID
     *
     * )
     *返回值 array()
     *
     *
     */
    static function  handle($args = '')
    {
        Api_Session::checkToken(1);
        $args['account_id'] = Api_Session::user_id();
        return self::getInfo($args);
    }

    static function  getInfo($args)
    {
        $request = Func_Input::filter(array(
            'demand_id' => 'int',
            'account_id' => 'int',
        ), $args);
        if (empty($request['demand_id'])) {
            return Api::request('error', '', '缺少参数或者参数不正确，请检查参数合法性');
        }
        $data = Data_Mysql_Table_Demand::select('*', array('id=? ' =>
            array($request['demand_id'])));
        if (empty($data[0])) {
            return Api::request('error', '', '没有获取到数据');
        }
        if (empty($data[0]['demand_name'])) {
            $data[0]['demand_name'] = Date('Y-m-d') . '-新需求-' . $data[0]['demand_type'];
        }
        $rs = Data_Mysql_Table_Demand::rowFormat($data[0]);
        $rs['id'] = $request['demand_id'];

        if (!empty($request['account_id'])) {
            if ($rs['account_id'] != $request['account_id'] && $rs['response_account_id'] != $request['account_id']) {
                unset($rs);
            }
        }
        if (empty($rs)) {
            return Api::request('error', '', '没有获取到数据');
        }
        return Api::request('success', $rs, '获取成功');

    }

}
