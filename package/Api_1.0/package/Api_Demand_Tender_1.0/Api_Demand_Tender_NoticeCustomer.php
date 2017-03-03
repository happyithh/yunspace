<?php

/**
 * Created by PhpStorm.
 * User: zzzc
 * Date: 2015/9/10
 * Time: 13:53
 * 通知客户
 */
class Api_Demand_Tender_NoticeCustomer extends Api
{


    /**
     *  新方案通知客户
     */
    static function   newSchemeNotice($args)
    {
        $request = Func_Input::filter(array(
            'tender_id' => 'int'
        ), $args);
        if (empty($request['tender_id'])) {
            return false;
        }
        $data = Api_Demand_Tender_GetData::getDemandTenderByCondition(array('id' => $request['tender_id']));

        //统一 用 tender_id  作为编号
        $smsInfo_t = "您在云space提交的活动需求单(#" . Func_NumEncode::e($request['tender_id']) . ")有一个新的场地报价,";


        //报价方案小于 4分的   短信通知 客户

        if (isset($data['phone']) && $data['scheme_sum'] < 4) {

            //发送短信模板，内容
            $getData = array(
                'account_id' => $data['account_id'],
                'access_url' => "http://" . Core::$urls['host'] . "/m/demand_tender/customer?tender_id=" . $data['tender_id'],
                'overdue_time' => 60,
                'is_return_data' => 1,
            );
            $url = Api_Get_Login_DWZ::getLoginLink($getData);

            if (!empty($url['data'])) {
                $smsInfo = $smsInfo_t . '查看详情:' . $url['data']['url'] . ' ';
                $code = $url['data']['auth_code'];

                $code = Api_Demand_Tender_NoticeVendor::randTail($data['id'], $code);

                //日志
                Api_Log_Create::DemandTenderLog(array(
                    'class' => get_called_class(),
                    'func' => __FUNCTION__,
                    'accountInfo' => array('id' => $data['account_id'], 'phone' => $data['phone']),
                    'tender_id' => $request['tender_id'],
                    'behavior' => $smsInfo . ' -' . $code,
                ));
                Core::log("baojiaxitong", "发送给客户。有供应商提交报价了",$data['phone']);
//                Func_Message::sendSMS($data['phone'], array(
//                    $smsInfo,
//                    $code
//                ), 35370);


            }

        }


    }

    /**
     *  没有方案通知 客户
     */
    static function noSchemeNotice($args)
    {
        $request = Func_Input::filter(array(
            'phone' => 'phone',
            'tender_id' => 'int'
        ), $args);

        $sms = '您的活动需求单暂无商家响应，云Space工作人员将在稍后致电给您，为您提供进一步的服务。';
        $time = Data_Mysql_Table_Demand_Tender::select('scheme_sum', array('id =?' => $request['tender_id']));
        Core::log("baojiaxitong", "发送给客户，没有方案",$request['phone']);
        if ($time[0] && $time[0]['scheme_sum'] == 0) {

//            Func_Message::sendSMS($request['phone'], array($sms), '');
        }
        $demand = $time[0];
        //通知客服
        Core::log("baojiaxitong", "发送给客服，没有方案",$request['phone']);
        $content = '需求没有商家提交方案：<br>' . '需求ID:' . $demand['demand_id'] . '<br>';
        Func_Mail::send(Data_Config_Demand_Notice::get('客服'), '需求没有商家提交方案', $content);

        return false;

    }


    /*
     *
     *没有匹配到数据 通知客服
    */
    static function  noMatchingProductNotice($args)
    {
        $request = Func_Input::filter(array(
            'tender_id' => 'int'
        ), $args);
        $data = Data_Mysql_Table_Demand_Tender::select('id,create_time,status', array('id =?' => $request['tender_id']));
        if (empty($data[0])) {
            return false;
        }
        //将状态改为关闭,需求状态释放出来 ，
        //TODO::
        $demand = $data[0];

        Data_Mysql_Table_Demand::update(array('id=?' => $demand['demand_id']), array('status' => 0));

        //通知客服
        $content = '需求没有匹配到产品：<br>' . '需求ID:' . $demand['demand_id'] . '<br>';
        Func_Mail::send(Data_Config_Demand_Notice::get('客服'), '需求没有商家提交方案', $content);

        //日志
        Api_Log_Create::DemandTenderLog(array(
            'class' => get_called_class(),
            'func' => __FUNCTION__,
            'accountInfo' => array('id' => 0),
            'tender_id' => $request['tender_id'],
            'behavior' => $content,
        ));
    }

}