<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/12/11
 * Time: 13:04
 * 拨打电话记录
 */
class Api_Demand_Offer_CallPhone extends Api
{
    static function  handle($args = '')
    {

        if (!empty($args['result_id'])) {
            $args['result_id'] = Func_NumEncode::d($args['result_id']);
        }
        $args['demand_id'] = Func_NumEncode::d($args['demand_id']);

        return self::handleCallPhone($args);
    }

    static function  handleCallPhone($args)
    {
        $request = Func_Input::filter(array(
            'result_id' => 'int',
            'demand_id' => 'int',
            'type' => 'string',
        ), $args);

        $demand = Data_Mysql_Table_Demand_Offer::select('create_time', array('demand_id=?' => $request['demand_id']));
        if (empty($demand[0]['create_time'])) {
            return Api::request('error', '', '失败');
        }


        if ($request['type'] == 'vendor') {
            $data = array(
                'call_customer_time' => time()
            );
        } elseif ($request['type'] == 'customer') {

            $data = array(
                'call_vendor_time' => time()
            );
        }
        Data_Mysql_Table_Demand_Match_Result::subTable('_' . date('Ym', $demand[0]['create_time']))->update(
            array('demand_id=?' => $request['demand_id'], 'id=?' => $request['result_id']),
            $data);
        return Api::request('success','','成功');

    }

}