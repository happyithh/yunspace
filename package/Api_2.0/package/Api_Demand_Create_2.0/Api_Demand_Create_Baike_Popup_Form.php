<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2016/8/17
 * Time: 16:30
 */
class Api_Demand_Create_Baike_Popup_Form extends Api
{
    static function  handleBaikePopupFormCreate($args)
    {
        $request = Func_Input::filter(array(
            'auth_code' => 'int',
            'phone' => 'phone',
            'name' => 'string',
            'data' => 'array',
            'showString' => 'string',
        ), $args);
        if (empty($request['phone'])) {
            return Api::request('error', '', '您的手机号输入有误~！');
        }
        if (empty($request['name'])) {
            return Api::request('error', '', '请输入您的称呼~！');
        }
        if (!empty($request['auth_code'])) {
            $check_status = Api_Common_Check_Auth_Code::handle();
            if ($check_status['status'] == 0) {
                return $check_status;
            }
        }

        $account = Api_Demand_Create::getAccountByPhone(array('phone' => $request['phone'], 'name' => $request['name']));

        $demand = array(
            'demand' => array(
                '联系人'=>$request['name'],
                '活动城市' => $request['data']['city'],
                '具体要求' => $request['showString'],
                '来源' => '来自百科页面弹框提交'
            ),
            'city' => $request['data']['city'],
            'demand_type' => '预约咨询',
            'demand_name' => '预约咨询',
            'phone' => $request['phone'],
            'account_id' => $account['id'],
            'ip' => Func_Input::ip(),
            'session_id' => session_id(),
        );
        return Api_Demand_Create::create($demand);
    }
}