<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/12/15
 * Time: 15:23
 * 获取联系记录
 */
class Api_Grab_Order_GetContactRecord extends Api
{

    static function  handle($args = '')
    {
        Api_Session::checkToken(1);

    }

    static function  handleRecord($args)
    {
        $request = Func_Input::filter(array(
            'id' => 'int',
            'phone' => 'phone',      //客户手机号
            'demand_id' => 'int',     //需求ID
        ), $args);

        if (empty($request['demand_id'])) {
            return Api::request('error', '', '没有ID');
        }
        $conditions['demand_id=?'] = array($request['demand_id']);
//        $data = Data_Mysql_Table_Contact_Record::select("*", $conditions, ' ORDER BY time DESC', 30);
        $data = Data_Mysql_Table_Demand_Step_Record::select("*", $conditions, ' ORDER BY create_time DESC', 30);
        if (empty($data[0])) {
            return Api::request('error', '', '没有更多');
        }
        foreach ($data as $key => $val) {
            $data[$key]['create_time'] = date("Y-m-d H:i", $val['create_time']);
        }
        return Api::request('success', $data, '成功');
    }

} 