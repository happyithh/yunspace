<?php

/**
 * Created by PhpStorm.
 * User: zhaozhichao
 * Date: 2015/12/20
 * Time: 21:24
 */
class Api_Demand_SetDelay extends Api
{

    static function  handle($args = '')
    {
        if (!Api_Session::admin_id()) {
            return Api::request('error', '', '请先登录');
        }
        $args['demand_id'] = Func_NumEncode::d($args['demand_id']);
        return self::setDeldyTime($args);
    }

    static function  setDeldyTime($args)
    {
        $request = Func_Input::filter(array(
            'demand_id' => 'int',
            'time' => 'int',
        ), $args);
        if (empty($request['demand_id']) || empty($request['time'])) {
            return Api::request('error', '', '参数缺失！');
        }
        $delay_time = time() + $request['time'];
        Data_Mysql_Table_Account_Log::insertAccountLog('', Api_Session::admin_id(), '延时操作', '设置了延时,ID=' . $request['demand_id'], $request['demand_id']);
        $data = Data_Mysql_Table_Demand::update(array('id=? AND delay_time=?' => array($request['demand_id'], 0)), array('delay_time' => $delay_time));
        if ($data[0] > 0) {
            return Api::request('success', '', '  成功');
        }
        if ($data[0] == false) {

            return Api::request('error', '', '您已经设置过延时不可以在设置！');

        }
        return Api::request('error', '', '失败');

    }
}