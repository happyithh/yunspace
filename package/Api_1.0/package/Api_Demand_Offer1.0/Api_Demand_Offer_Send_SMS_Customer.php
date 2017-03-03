<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/10/16
 * Time: 17:00
 *
 * 通知客户
 */

/**
 * Class Api_Demand_Offer_Send_SMS_Customer
 * 1. 通知客户（存在方案的情况下）（报价没有结束的情况下）（客户没有查看报价的情况下）
 * 2. 发送短网址
 */
class Api_Demand_Offer_Send_SMS_Customer extends Api
{
    static $A_Tail = ',请关注服务号:yunspacefwh,随时查看报价哦。';
    static $B_Tail = ',微信关注:yunspacefwh，随时查看报价哦';

    /**
     * @param $args
     * 处理 通知客户的计划任务
     *
     * 。哒哒哒哒。。。。 我在这里处理 如果是抢单系统的报价，就通知销售咯，推送微信
     */
    static function  cron($args)
    {
        $request = Func_Input::filter(array(
            'demand_id' => 'int',
            'type' => 'string',
        ), $args);
        if (empty($request['demand_id'])) {
            return false;
        }

        if ($request['type'] == 'create') {
            $timeOut = 1800;
        } elseif ($request['type'] == 'add_offer') {

            //如果是销售代理的
            $isSaleOrder = Api_Grab_Order_Check::goCheckIsExist(array('id' => $request['demand_id']));
            if (!empty($isSaleOrder['sale_phone']) && $isSaleOrder['sale_phone'] > 9) {

                Api_Demand_Notice_V2::saleOfferNotice_C($request['demand_id']);
                return true;
            } else {
                Api_Demand_Notice_V2::customerNotice_D($request['demand_id']);
                return true;
            }
            $timeOut = 2;
        }
        if (!empty($timeOut)) {
            //TODO::转移至Api_Demand_Notice_V2::

//            Core::cron($timeOut, 'Api_Demand_Offer_Send_SMS_Customer', 'NewNoticeOffer', array(array('demand_id' => $request['demand_id'])));
        }
    }

    /**
     * @param $args
     * @return array
     *1.查询状态大于=0 的
     *2.通知时间 30分钟
     * 新报价通知客户
     */
    static function  NewNoticeOffer($args)
    {
        //12/11
        if (Core::$urls['host'] == 'www.yunspace.com.cn') {
            return false;
        }

        $request = Func_Input::filter(array(
            'demand_id' => 'int'
        ), $args);
        Core::log('demand_offer_log', '【通知客户】----第一步' . $request['demand_id']);
        if (empty($request['demand_id'])) {
            return false;
        }
        self::init();
//        //获取需求报价信息
        $conditions['t1.demand_id =?'] = array($request['demand_id']);
        $table = "{table} as t1 LEFT JOIN {prefix}demand as t2 ON  t1.demand_id = t2.id";
        $rs = Data_Mysql_Table_Demand_Offer::select('t1.demand_id,t1.status,t1.create_time,t2.phone,t2.account_id', $conditions, "ORDER BY t1.id ASC", '1', $table);
        if (empty($rs[0])) {
            return Api::request('error', '', '没有找到符合发送的需求');
        }
        Core::log('demand_offer_log', '【通知客户】----第二步');
        $data = $rs[0];
        $A = array();
        if ($data['status'] == 0 && ($data['create_time'] > time() - 2100)) {

            $A = self::send(array(
                'demand_id' => $data['demand_id'],
                'account_id' => $data['account_id'],
                'phone' => $data['phone'],
                'status' => 1
            ));
        }

        /***
         * 微信推送
         */
        $B = self::wechatPush(array(
            'account_id' => $data['account_id'],
            'demand_id' => $data['demand_id']
        ));
        return array($A, $B);


    }


    static function  init()
    {
        Core::cron(1, 'Api_Demand_Offer_Send_SMS_Customer', 'ThirtyHourAfter', '', 1);
        Core::cron(1, 'Api_Demand_Offer_Send_SMS_Customer', 'OneDayAfter', '', 1);
    }

    /**
     * 3个小时
     */
    static function  ThirtyHourAfter()
    {
        //大于 3小时小于1天
        $conditions['jiange >? AND jiange <? AND t1.status =?'] = array(10800, 86400, 1);
        $table = "{table} as t1 LEFT JOIN {prefix}demand as t2 ON t1.demand_id = t2.id";
        $data = Data_Mysql_Table_Demand_Offer::select('t1.demand_id,t2.phone,t2.account_id,unix_timestamp - t1.create_time as jiange', $conditions, "ORDER BY t1.id ASC", '50', $table);
        foreach ($data as $val) {
            self::send(array(
                'demand_id' => $val['demand_id'],
                'phone' => $val['phone'],
                'account_id' => $val['account_id'],
                'status' => 2,
            ));
        }
    }

    /**
     * 1天后
     */
    static function  OneDayAfter()
    {
        //大于1天
        $conditions['jiange >? AND t1.status =?'] = array(86400, 2);
        $table = "{table} as t1 LEFT JOIN {prefix}demand as t2 ON t1.demand_id = t2.id";
        $data = Data_Mysql_Table_Demand_Offer::select('t1.demand_id,t2.phone,t2.account_id,unix_timestamp - t1.create_time as jiange', $conditions, "ORDER BY t1.id ASC", '50', $table);
        foreach ($data as $val) {
            self::send(array(
                'demand_id' => $val['demand_id'],
                'phone' => $val['phone'],
                'account_id' => $val['account_id'],
                'status' => 3,
            ));
        }
    }

    /**
     * @param $args
     * 发送 短信
     * @return array
     */
    static function  send($args)
    {
        $request = Func_Input::filter(array(
            'demand_id' => 'int',
            'phone' => 'phone',
            'account_id' => 'int',
            'status' => 'int',  //1  2  3
        ), $args);
        if (empty($request['phone']) || empty($request['demand_id']) || empty($request['account_id'])) {
            return Api::request('error', '', '缺失参数');
        }

        Core::log('demand_offer_log', '【通知客户】----第三步' . $request['phone'] . '-' . $request['account_id'] . '-' . $request['demand_id']);

        Data_Mysql_Table_Demand_Offer::update(array(
            'demand_id' => $request['demand_id'],
        ), array(
            'notice_time' => time(),
            'status' => $request['status']
        ));
        if ($request['status'] == 2) {
            $sum = Api_Demand_Offer_GetData::getSchemeSum(array('demand_id' => $request['demand_id']));
            if ($sum == 0) {

                Core::log('demand_offer_log', '【通知客户】----需求没有商家报价' . 'demand_id' . $request['demand_id']);
                return Api::request('error', '', '没有方案不予通知客户！');
            }
        }
        $smsInfo_t = "您在云space提交的活动需求单(#" . Func_NumEncode::e($request['demand_id']) . "),最新报价情况：";

        $host = "http://" . Core::$urls['host'] . "/m";

        //发送短信模板，内容
        $getData = array(
            'account_id' => $request['account_id'],
            'access_url' => $host . "/demand_offer.v2/customer?demand_id=" . Func_NumEncode::e($request['demand_id']),
            'overdue_time' => 60,
            'is_return_data' => 1,
        );

        $url = Api_Get_Login_DWZ::getLoginLink($getData);
        if (!empty($url['data'])) {
            Core::log('demand_offer_log', '【通知客户】----第四步--发送短信' . $request['demand_id']);

            $smsInfo = $smsInfo_t . '查看详情:' . $url['data']['url'] . ' ';
            $code = $url['data']['auth_code'];

            $smsInfo = Api_Demand_Offer_Send_SMS_Customer::randTail($request['demand_id'], $smsInfo);

            Core::log('demand_offer_log', '【客户发送短信】---' . $request['phone'] . '-' . $smsInfo . $code);
//            Func_Mail::send('zzc@yunspace.com.cn;', '【通知客户】', $smsInfo . ' -' . $code);

            return Func_Message::sendSMS($request['phone'], array(
                $smsInfo,
                $code
            ), 35370);

        }

    }

    /**
     * @param $args
     * @return array
     * 微信推送
     */
    static function  wechatPush($args)
    {
        $request = Func_Input::filter(array(
            'account_id' => 'int',
            'demand_id' => 'int',
        ), $args);

        if (Func_Input::isLocal()) {

//            $openId = 'oP1nzsr36Vk06yf1zUWD-t-Cj5eU';
            $host = 'd16.yunspace.com.cn';

            $openId = Data_Mysql_Table_Account_Wechat::handleGetOpenid($request['account_id']);
        } else {
            $host = 'www.yunspace.com.cn';
            $openId = Data_Mysql_Table_Account_Wechat::handleGetOpenid($request['account_id']);
        }
        $send = array(
            "touser" => $openId,
            "template_id" => "lTFV2jkPpY1VChR3m2NKtQ51_KWrOt4PUSqc2kv6lCo",
            "url" => 'http://' . $host . '/m/demand_offer.v2/customer?demand_id=' . $request['demand_id'],
            "topcolor" => "#FF0000",
            "data" => array(
                "first" => array(
                    "value" => "您提交的活动需求有新回复",
                    "color" => "#173177",
                ),
                "keyword1" => array(
                    "value" => "需求编号(#" . Func_NumEncode::e($request['demand_id']) . ")",
                    'color' => '#173177'
                ),
                "keyword2" => array(
                    "value" => '有商家对您的需求提出了报价',
                    'color' => '#173177'
                ),
                "remark" => array(
                    "value" => "点击进入页面",
                    "color" => "#173177",
                )
            )
        );
        return Wechat_Messag_Push::push($send);

    }

    /***
     * @param $int
     * @param $string
     * @return string
     *
     * 随机小尾巴
     */
    static function  randTail($int, $string)
    {
        switch (intval($int) % 3) {
            case 1 :
                $string = $string . self::$A_Tail;
                break;
            case 2 :
                $string = $string . self::$B_Tail;
                break;
        }
        return $string;
    }
}