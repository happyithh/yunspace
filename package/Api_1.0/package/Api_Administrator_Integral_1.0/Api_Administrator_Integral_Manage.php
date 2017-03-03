<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/12/15
 * Time: 11:44
 */
class Api_Administrator_Integral_Manage extends Api
{

    /***
     * 积分操作，增加，减少积分
     * 根据用户id来增减
     */
    static function  handle($args = '')
    {
        if (!Api_Session::admin_id()) {
            return Api::request('error', '', '请先登录！');
        }
        return self::integralManages($args);

    }

    /**
     * @param $args
     * @return array
     * 积分管理
     */
    static function  integralManages($args)
    {
        $request = Func_Input::filter(array(
            'phone' => 'phone',
            'integral' => 'int',
            'type' => 'string',
            'title' => 'string',
            'reason' => 'string',
            'demand_id' => 'int',

        ), $args);
        if (empty($request['phone']) || empty($request['integral']) || empty($request['type'])) {
            return Api::request('error', '', '缺少参数或者参数不正确');
        }
        $data = Api_Administrator_GetBaseAccountInfo::getBastAccountInfoByPhone(array('phone' => $request['phone']));

        if (empty($data['id'])) {
            return Api::request('error', '', '不存在，请检查手机号是否正确~');
        }
        if (empty($data['integral'])) {
            $update = array('integral' => $request['integral']);
        } else {
            if ($request['type'] == 'add') {
                $update = array('integral' => ($request['integral']) + $data['integral']);
            } elseif ($request['type'] == 'reduce') {
                $update = array('integral' => ($data['integral']) - ($request['integral']));
            }
        }
        $rs = Data_Mysql_Table_Administrator::update(array('phone' => $request['phone']), $update);
        if ($rs[0] > 0) {
            if (empty($request['title'])) {
                $title = 'OA积分管理';
            } else {
                $title = $request['title'];
            }
            $request['integral'] = $request['type'] == 'add' ? '+' . $request['integral'] : '-' . $request['integral'];

            Api_Administrator_Integral_Log::create(array(
                'account_id' => $data['account_id'],
                'intro' => $title,
                'integral' => $request['integral'],
                'demand_id' => $request['demand_id']
            ));
            $account = Api_Administrator_GetBaseAccountInfo::getBastAccountInfo(array('admin_id' => Api_Session::admin_id()));
            Data_Mysql_Table_Account_Log::insertAccountLog(@$account['account_id'], Api_Session::admin_id(), '积分:' . $request['integral'] . ',理由：' . $request['reason'], '操作积分', $data['admin_id']);

            return Api::request('success', '', '  成功');
        }
        return Api::request('error', '', '失败');

    }


}