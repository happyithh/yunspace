<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/12/17
 * Time: 10:40
 * 关于商家的通知
 */
class Api_Demand_Notice_Vendor_V2 extends Api
{
    /**
     * @param $args
     * @return array
     * 客户意向通知 --有意向
     */
    static function Customer_Intention_Notice_Vendor_A($args)
    {
        $request = Func_Input::filter(array(
            'demand_id' => 'int',
            'result_id' => 'int',
            'item_id' => 'int',
        ), $args);
        $item = Data_Mysql_Table_Space_Item::select('phone,email', array('id=? AND status=1' => array($request['item_id'])));
        if (!empty($item[0]['phone'])) {
            $request['phone'] = $item[0]['phone'];
            $account = Api_Account_GetBaseInfo::getBaseInfoByPhone(array('phone' => $request['phone']));
            if (!$account) {
                return Api::request('error', '', '没有负责人账户信息');
            }
            $demand_data = Data_Mysql_Table_Demand::select('demand,create_time', array('id=? AND demand_status =1 ' => array($request['demand_id'])));
            if (!empty($demand_data[0])) {

                $deamnd = json_decode($demand_data[0]['demand'], 1);
                $nick_phone = substr($deamnd['联系电话'], 0, 3) . '****' . substr($deamnd['联系电话'], 7, 10);
                $nick_username = mb_substr(@$deamnd['联系人'], 0, 1, 'utf-8') . '**';
                $host = "http://" . Core::$urls['host'] . "/m";
                $getDWZ = array(
                    'account_id' => $account['id'],
                    'access_url' => $host . "/demand_offer.v2/vendor?result_id=" . Func_NumEncode::e($request['result_id']) . '&demand_id=' . Func_NumEncode::e($request['demand_id']),
                    'overdue_time' => 60,
                    'is_return_data' => 1,
                );

                $url = Api_Get_Login_DWZ::getLoginLink($getDWZ);

                if (!empty($url['data'])) {

                    $code = $url['data']['auth_code'];

                    $content = '客户（' . $nick_username . ',' . $nick_phone . '）对您提供的场地报价有意向，快去联系他吧。点击查看详情' . $url['data']['url'] . '，微信关注“云Space管家”及时查看报价最新动态，如有疑问请咨询400-056-0599';

                    if (Func_Input::isLocal()) {
                        Core::log('vendor_v2', '有意向' . $content . $code);
                    }
                    Func_Message::sendSMS($request['phone'], array(
                        $content,
                        $code
                    ), 35370);

                    return Api::request('success ', '', '成功');
                }
                return Api::request('error', '', '生成短网址失败' . $request['demand_id']);
            }

            return Api::request('error', '', '没有找到需求记录' . $request['demand_id']);

        }
        return Api::request('error', '', '没有负责人手机号');

    }


    /**
     * @param $args
     * @return array
     * 客户意向通知 --无意向
     */
    static function Customer_Intention_Notice_Vendor_B($args)
    {
        $request = Func_Input::filter(array(
            'demand_id' => 'int',
            'result_id' => 'int',
            'item_id' => 'int',
        ), $args);
        $item = Data_Mysql_Table_Space_Item::select('phone,email', array('id=? AND status=1' => array($request['item_id'])));
        if (!empty($item[0]['phone'])) {
            $request['phone'] = $item[0]['phone'];
            $account = Api_Account_GetBaseInfo::getBaseInfoByPhone(array('phone' => $request['phone']));
            if (!$account) {
                return Api::request('error', '', '没有负责人账户信息');
            }
            $demand_data = Data_Mysql_Table_Demand::select('demand,create_time', array('id=? AND demand_status =1 ' => array($request['demand_id'])));
            if (!empty($demand_data[0])) {

                $deamnd = json_decode($demand_data[0]['demand'], 1);
                $nick_phone = substr($deamnd['联系电话'], 0, 3) . '****' . substr($deamnd['联系电话'], 7, 10);
                $nick_username = mb_substr(@$deamnd['联系人'], 0, 1, 'utf-8') . '**';
                $host = "http://" . Core::$urls['host'] . "/m";
                $getDWZ = array(
                    'account_id' => $account['id'],
                    'access_url' => $host . "/demand_offer.v2/vendor?result_id=" . Func_NumEncode::e($request['result_id']) . '&demand_id=' . Func_NumEncode::e($request['demand_id']),
                    'overdue_time' => 60,
                    'is_return_data' => 1,
                );
                $url = Api_Get_Login_DWZ::getLoginLink($getDWZ);
                if (!empty($url['data'])) {

                    $code = $url['data']['auth_code'];

                    $content = '客户（' . $nick_username . ',' . $nick_phone . '）对您提供的场地报价无意向，重新报个价吧。点击查看详情' . $url['data']['url'] . '，微信关注“云Space管家”及时查看报价最新动态，如有疑问请咨询400-056-0599';

                    if (Func_Input::isLocal()) {
                        Core::log('vendor_v2', '无意向' . $content . $code);
                    }
                    Func_Message::sendSMS($request['phone'], array(
                        $content,
                        $code
                    ), 35370);
                    return Api::request('success ', '', '成功');

                }
                return Api::request('error', '', '生成短网址失败' . $request['demand_id']);
            }

            return Api::request('error', '', '没有找到需求记录' . $request['demand_id']);

        }
        return Api::request('error', '', '没有负责人手机号');

    }

}