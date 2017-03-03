<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/12/17
 * Time: 10:40
 * 需求的通知
 */
class Api_Demand_Notice_V2 extends Api
{

    /**
     * 通知客服处理订单
     */
    static function  servicesNotice_new($args)
    {
        $request = Func_Input::filter(array(
            'phone' => 'phone',
        ), $args);
        if (empty($request['phone'])) {
            return false;
        }

        $data = Data_Mysql_Table_Demand::select('*', array('phone =?' => array($request['phone'])), 'ORDER BY create_time DESC', 3);
        $demand = array();
        foreach ($data as $val) {
            $demand[] = Data_Mysql_Table_Demand::rowFormat($val);
        }
        Tpl_Smarty::assign('data', $demand);


        $content = Tpl_Smarty::fetch('Web_Mobile_Static::email.v1.0/servicesNotice_new.tpl');


        $title = '【新需求】';
        $email = Data_Config_Demand_Notice::get('客服部');
        if (Func_Input::isLocal()) {
            //TODO::emd 问题未解决
            $a = Func_Mail::send('zzc@yunspace.com.cn', $title, $content);
        }
//        $content_new = '有新需求单进来' . $data[0]['id'];
//        Func_Mail::send($email, $title, $content_new);

    }

    /**
     *
     *@通知客服
     */
    static function  servicesNotice_new_v1($args)
    {
        $request = Func_Input::filter(array(
            'demand_id' => 'int',
        ), $args);
        //1. 根据 $demandId 查询 需求
        $r = Data_Mysql_Table_Demand::select('*', $request['demand_id']);
        if (empty($r[0])) {
            return false;
        }
        $title = ' 【有新需求】';
        $demand = $r[0];
        $demand['demand'] = json_decode($demand['demand'], 1);
        $title = "【通知】{$title} {$demand['id']} /{$demand['city']} /{$demand['demand_type']} /{$demand['demand_name']}";
        $msg = "{$title}<br><dl>";
        $msg .= "<hr><dt>简单联系方式:</dt><dd>姓名:{$demand['demand']['联系人']}<br>\n电话:{$demand['phone']}";
        if (!empty($demand['demand'])) {
            $msg .= "</dd><hr><dt>需求:</dt><dd>";
            foreach ($demand['demand'] as $k => $v) {
                $msg .= "{$k}:{$v}<br/>\n";
            }
        }
        $msg .= '</dd><br/>';
        $email = Data_Config_Demand_Notice::get('客服部');

        if (Func_Input::isLocal()) {
            return true;
        }
        Func_Mail::send($email, $title, $msg . '</dl>');
    }

    /**
     * 系统通知
     */
    static function  servicesNotice_systemHandle($args)
    {
        $request = Func_Input::filter(array(
            'demand_id' => 'int',
            'type' => 'string',
        ), $args);

        $email = Data_Config_Demand_Notice::get('客服部');
        //标记重复通知
        if ($request['type'] == 'tags') {

            Func_Mail::send($email, '【系统处理】', '系统标记为重复单并且关闭，请核实ID=' . $request['demand_id']);

        }


    }

    /**
     *
     *   1.   20分钟内客服人工联系响应需求，确定需求发送短信  给 客户
     *   2.如果20分钟后客服没有联系，自动进入抢单系统，      给客户
     *
     *
     *
     *
     * 3.进入抢单系统，
     *          3.1没有匹配到任何场地，给路飞组发邮件
     *          3.2进入报价系统30分钟后，如果没有任何场地报价，则发短信告知用户预算可能较低，暂无场地方报价，如果是销售则发给销售
     *
     *
     */
    /**
     * @param $args
     * 客户的通知        微信推送、 云space服务号
     * 需求提交20分钟         ---------告诉客户我们理你---------------------
     */
    static function  customerNotice_A_a($args)
    {
        $request = Func_Input::filter(array(
            'phone' => 'phone',
            'demand_id' => 'int',
        ), $args);
//        Func_Message::sendSMS($request['phone'], array(), 1111);

        $content = '亲爱的小主，我们的工作人员已经处理了您的需求单，系统正在为您安排专业的活动顾问，请您耐心等候。如有问题可联系400-056-0599';
        $data = array(
            'one_notice' => time(),
        );
        Data_Mysql_Table_Grab_Order::update(array('customer_phone =?' => $request['phone']), $data);
        if (Func_Input::isLocal()) {
//            Func_Message::sendSMS($request['phone'], array($content, $request['demand_id']), 35370);
        } else {

//            Func_Message::sendSMS($request['phone'], array($content, $request['demand_id']), 35370);
        }

        self::customerWechatTpl(array('phone' => $request['phone'], 'first' => $content, 'keyword1' => '开始处理'));

    }

    /**
     * @param $args
     * 客户的通知
     * 系统触发
     * 需求提交20分钟         ---------告诉客户我们理你---------------------
     */
    static function  customerNotice_A_b($args)
    {
        $request = Func_Input::filter(array(
            'phone' => 'phone',
            'demand_id' => 'int',
        ), $args);
        if (empty($request['phone'])) {
            return false;
        }
        $content = '亲爱的小主，我们的工作人员已经处理了您的需求单，系统正在为您安排专业的活动顾问，请您耐心等候。如有问题可联系400-056-0599';
        $data = array(
            'two_notice' => time(),
        );

        Data_Mysql_Table_Grab_Order::update(array('customer_phone =?' => $request['phone']), $data);

        if (Func_Input::isLocal()) {
//            Func_Message::sendSMS($request['phone'], array($content, rand(3, 4)), 35370);

        } else {

//            Func_Message::sendSMS($request['phone'], array($content, $request['demand_id']), 35370);

        }
        self::customerWechatTpl(array('phone' => $request['phone'], 'first' => $content, 'keyword1' => '开始处理'));

    }

    /**
     * @param $args
     * @return bool
     * 客户的通知
     * 告诉客户有多少场地 ，让客户等待商家报价
     */
    static function  customerNotice_B($args)
    {
        /**
         * 1.销售接单 ，会告诉客户 我们有专业的销售 帮您处理这么些场地
         * 2.接入档期咨询的通知 TODO：：
         */
        $request = Func_Input::filter(array(
            'demand_id' => 'int',
            'match_num' => 'int',           //没有匹配到商家就是-1
            'offer_count' => 'int'
        ), $args);

        if (empty($request['demand_id'])) {
            return Api::request('error', '', '缺少参数');
        }
        //是需求单 抢单记录表中就会有记录
        $order = Data_Mysql_Table_Grab_Order::select('id,sale_phone,customer_phone', array('id=? AND three_notice=?' => array($request['demand_id'], 0)));
        if (empty($order[0])) {
            return Api::request('error', '', '不存数据');
        }
        /**
         * 设置一个开关 是否通知客户
         */
        $is_Notice_Customer = false;

        $orderData = $order[0];

        //没有商家报价通知客户
        if ($orderData['sale_phone'] == 9 && $request['offer_count'] == 0) {

            $data = Api_Demand_Notice_V2::customerNotice_B_b(array(
                'phone' => $orderData['customer_phone'],
                'demand_id' => $request['demand_id'],
            ));
            return $data;
//            return Api::request('success', '', '给客户通知发送成功');
        }

        // 暂停 给销售发送短信
        return true;


        //大于 10 就是销售的手机号
        if ($orderData['sale_phone'] > 10) {

            if ($request['match_num'] > 0) {
                /**
                 * 1.有匹配到商家通知销售
                 * 2.通知客户匹配了多少家场地
                 */
                self::saleOfferNotice_A($request['demand_id'], $orderData['sale_phone'], $request['match_num']);
                $is_Notice_Customer = true;
            } elseif ($request['match_num'] < 0) {
                //没有匹配到商家通知销售
                self::saleOfferNotice_B($request['demand_id'], $orderData['sale_phone']);
            }
            //9 代表报价系统
        } elseif ($orderData['sale_phone'] == 9) {
            $is_Notice_Customer = true;
        }

        if (true == $is_Notice_Customer && $request['match_num'] > 0) {
            Api_Demand_Notice_V2::customerNotice_B_a(array(
                'match_num' => $request['match_num'],
                'phone' => $orderData['customer_phone'],
                'demand_id' => $request['demand_id'],
            ));
        }


    }


    /**
     * @param $args
     * @return bool
     * 通知客户 有匹配了多少场地
     */
    static function  customerNotice_B_a($args)
    {
        $request = Func_Input::filter(array(
            'match_num' => 'int',
            'phone' => 'phone',
            'demand_id' => 'int',
        ), $args);
        if (empty($request['match_num']) || empty($request['phone']) || empty($request['demand_id'])) {
            return false;
        }
        $content = '哇！我们已经为您匹配的' . (intval($request['match_num']) + rand(3, 8)) . '家场地，商家正在报价中哦，30分钟后我们将给您发送场地报价结果。请您耐心等待,如有问题可联系400-056-0599';
        $data = array(
            'three_notice' => time(),
        );
        $status = Data_Mysql_Table_Grab_Order::update(array('customer_phone =? AND id=?' => array($request['phone'], $request['demand_id'])), $data);
        if (Func_Input::isLocal()) {

            Func_Message::sendSMS($request['phone'], array($content, rand(3, 8)), 35370);

        } else {

            Func_Message::sendSMS($request['phone'], array($content, $request['demand_id']), 35370);
        }
        if ($status[0] > 0) {
            self::customerWechatTpl(array(
                'openId' => '',
                'phone' => $request['phone'],
                'first' => $content,
                'keyword1' => '已经匹配到商家'
            ));
        }
        return true;
    }

    /**
     * @param $args
     * @return bool
     * 通知客户 没有场地，需要客户更新需求信息
     */
    static function  customerNotice_B_b($args)
    {
        $request = Func_Input::filter(array(
            'phone' => 'phone',
            'demand_id' => 'int',
        ), $args);
        if (empty($request['phone']) || empty($request['demand_id'])) {

            return Api::request('error', '', '缺少参数');

        }

        $content = '好伤心~，可能是您的报价太低啦，没有场地报价~，请更新您的需求信息,如有问题请致电客户400-056-0599。';
        $data = array(
            'three_notice' => time(),
        );
        $status = Data_Mysql_Table_Grab_Order::update(array('customer_phone =?' => $request['phone'], 'id=?' => $request['demand_id']), $data);
        if (Func_Input::isLocal()) {

            Func_Message::sendSMS(13127808798, array($content, 888, 35370));

        } else {

            Func_Message::sendSMS($request['phone'], array($content, 8888, 35370));

        }

        if ($status[0] > 0) {
            self::customerWechatTpl(array(
                'openId' => null,
                'phone' => $request['phone'],
                'first' => $content,
                'keyword1' => '没有匹配到商家'
            ));
        }
        return true;
    }

    /**
     * @param $args
     * 客户的通知
     * 一天后通知
     */
    static function  customerNotice_C($args)
    {

    }

    /**
     * @param $args
     * @return array
     * 客户的通知  短信，微信
     */
    static function  customerNotice_D($args)
    {
        $request = Func_Input::filter(array(
            'demand_id' => 'int',
        ), $args);
        $data = Data_Mysql_Table_Grab_Order::select('id,customer_phone,four_notice', array('id' => $request['demand_id']));
        if (empty($data[0])) {
            return Api::request('error', '', '没有找到数据');
        }
        $order = $data[0];
        $account = Data_Mysql_Table_Account_Wechat::handleGetOpenIdByPhone(array('phone' => $order['customer_phone']));
        if (!$account) {
            return Api::request('error', '', '没有找到用户信息~');
        }
        //短信通知  每个需求单 只执行一次
        if (empty($order['four_notice'])) {
            $smsInfo_t = "您在云SPACE提交的活动需求单(#" . Func_NumEncode::e($request['demand_id']) . "),您可以点击链接了解最新动态：";
            $host = 'www.yunspace.com.cn/m';

            //发送短信模板，内容
            $getData = array(
                'account_id' => $account['id'],
                'access_url' => $host . "/demand_offer.v2/customer?demand_id=" . Func_NumEncode::e($request['demand_id']),
                'overdue_time' => 60,
                'is_return_data' => 1,
            );

            $url = Api_Get_Login_DWZ::getLoginLink($getData);
            if (!empty($url['data'])) {
                $smsInfo = $smsInfo_t . '查看详情:' . $url['data']['url'] . ' ';
                $code = $url['data']['auth_code'];
                $smsInfo = Api_Demand_Offer_Send_SMS_Customer::randTail($request['demand_id'], $smsInfo);
                return Func_Message::sendSMS($order['customer_phone'], array(
                    $smsInfo,
                    $code
                ), 35370);
            }
            //记录发送时间
            Data_Mysql_Table_Grab_Order::update(array('id=?' => array($request['demand_id'])), array(
                'four_notice' => time(),
            ));
        }

        //微信推送
        if (Func_Input::isLocal()) {
            $host = 'd16.yunspace.com.cn';
        } else {
            $host = 'www.yunspace.com.cn';
        }
        $send = array(
            "touser" => $account['openid'],
            "template_id" => "lTFV2jkPpY1VChR3m2NKtQ51_KWrOt4PUSqc2kv6lCo",
            "url" => 'http://' . $host . '/m/demand_offer.v2/customer?demand_id=' . Func_NumEncode::e($request['demand_id']),
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

    static function  customerWechatTpl($args)
    {
        $request = Func_Input::filter(array(
            'openId' => 'string',
            'phone' => 'phone',
            'first' => 'string',
            'keyword1' => 'string',
        ), $args);
        if (empty($request['first']) || empty($request['keyword1'])) {
            return false;
        }
        if (empty($request['openId']) && !empty($request['phone'])) {

            $openid = Data_Mysql_Table_Account_Wechat::handleGetOpenIdByPhone($request['phone']);
            if ($openid) {

                $request['openId'] = $openid;
            } else {
                return false;
            }
        }
        if (empty($request['openId'])) {
            return false;
        }
        $wechat = array(
            "touser" => $request['openId'],
            "template_id" => "BGMDjzZBTbBHAuX81OrpV6itmKytBVWis3Zui1q9bRg",
            "url" => '',
            "topcolor" => "#FF0000",
            "data" => array(
                "first" => array(
                    "value" => $request['first'],
                    "color" => "#173177",
                ),
                "keyword1" => array(
                    "value" => $request['keyword1'],
                    'color' => '#173177'
                ),
                "keyword2" => array(
                    "value" => date('Y-m-d H:i:s', time()),
                    'color' => '#173177'
                ),
                "remark" => array(
                    "value" => "感谢关注云·SPACE,您的支持是我们进步的动力！",
                    "color" => "#173177",
                )
            )
        );
        $rs = Wechat_Messag_Push::push($wechat);
    }

    /**
     * @param $demand_id
     * @param string $type
     * 通知需求报价组长 让他处理报价
     * type   1.
     */
    static function  adminNoticeDemandOffer($demand_id, $type = '')
    {
        @session_start();
        if (empty($demand_id)) {
            return false;
        }
        switch ($type) {
            case 'no_result':

                $title = '【没有匹配结果】';
                $content = "没有匹配到商家，请尽快处理。,id=" . $demand_id;
                break;
            case 'clear':
                //管理员重新分配订单
                $title = '【系统通知】';
                $content = "管理员" . $_SESSION['administrator']['fullname'] . "将需求单" . $demand_id . ',重新分配到销售，系统将此订单关闭！';
                break;
            default:
                $title = '【订单流入】';
                $content = "有一个需求单进入报价系统，请注意查收,id=" . $demand_id;
        }

        if (Func_Input::isLocal()) {
//            $email = 'zzc@yunspace.com.cn';
        } else {
            $email = 'luffy@yunspace.com.cn';
        }
        $a = Func_Mail::send($email, $title, $content);
    }


    /**
     * @param $demand_id
     * @param $sale_phone
     * @param $match_num
     *   报价系统的通知
     *  把匹配的信息告诉销售  例如：匹配了 4家商家
     *nMa0-TdOxwO9eOLWeg-WAJ8rkWowEyN4B0whZwyN7OU
     */
    static function  saleOfferNotice_A($demand_id, $sale_phone, $match_num)
    {

        if (!$demand_id || !$sale_phone) {
            return false;
        }
        //微信推送

        $openid = Data_Mysql_Table_Account_Wechat_Sale::handleGetOpenidByPhone($sale_phone);
        if (!$openid) {
            return false;
        }
        $wechat = array(
            "touser" => $openid,
            "template_id" => "nMa0-TdOxwO9eOLWeg-WAJ8rkWowEyN4B0whZwyN7OU",
            "url" => 'http://pre0yunspace.com.cn' . Core::$urls['root'] . 'm/grab_order?type=B&action=detail&id=' . $demand_id,
            "topcolor" => "#FF0000",
            "data" => array(
                "first" => array(
                    "value" => "您的需求单" . $demand_id . '，已匹配到商家' . $match_num . '个，请及时联系获取报价！,',
                    "color" => "#173177",
                ),
                "keyword1" => array(
                    "value" => '匹配商家',
                    'color' => '#173177'
                ),
                "keyword2" => array(
                    "value" => date('Y-m-d H:i:s', time()),
                    'color' => '#173177'
                ),
                "remark" => array(
                    "value" => "请及时查看！",
                    "color" => "#173177",
                )
            )
        );
        Wechat_Messag_Push::salePush($wechat);

//        Func_Mail::send('zzc@yunspace.com.cn', '匹配了好多商家', '好多商家');
    }

    /**
     * @param $demand_id
     * @param $sale_phone
     *   报价系统的通知
     *  需求没有匹配到数据，请修改需求内容，价格等内容
     *
     */
    static function  saleOfferNotice_B($demand_id, $sale_phone)
    {
        if (!$demand_id || !$sale_phone) {
            return false;
        }
        //微信推送
        $openid = Data_Mysql_Table_Account_Wechat_Sale::handleGetOpenidByPhone($sale_phone);
        if (!$openid) {
            return false;
        }
        $wechat = array(
            "touser" => $openid,
            "template_id" => "nMa0-TdOxwO9eOLWeg-WAJ8rkWowEyN4B0whZwyN7OU",
            "url" => 'http://pre0.yunspace.com.cn' . Core::$urls['root'] . 'm/grab_order?type=B&action=detail&id=' . $demand_id,
            "topcolor" => "#FF0000",
            "data" => array(
                "first" => array(
                    "value" => "您的需求单" . $demand_id . '，没有匹配到商家，请及时联处理！,',
                    "color" => "#173177",
                ),
                "keyword1" => array(
                    "value" => '匹配商家',
                    'color' => '#173177'
                ),
                "keyword2" => array(
                    "value" => date('Y-m-d H:i:s', time()),
                    'color' => '#173177'
                ),
                "remark" => array(
                    "value" => "请及时查看！",
                    "color" => "#173177",
                )
            )
        );
        Wechat_Messag_Push::salePush($wechat);
    }


    /**
     * @param $demand_id
     *   报价系统的通知  销售
     *  啦啦啦      --------------------有报价-------快查看---------------------------
     *
     */
    static function  saleOfferNotice_C($demand_id)
    {
        if (empty($demand_id)) {
            return Api::request('error', '', '缺少参数');
        }
        $data = Data_Mysql_Table_Grab_Order::select('sale_phone', array('id =?' => $demand_id, 'status >?' => 0));
        if (empty($data[0]['sale_phone'])) {
            return Api::request('error', '', '没有通知的手机号');
        }
        $openid = Data_Mysql_Table_Account_Wechat_Sale::handleGetOpenidByPhone($data[0]['sale_phone']);
        if ($openid) {
            $wechat = array(
                "touser" => $openid,
                "template_id" => "7m95R4LwadRbtHTFlBUjI-yG3RQ5TR5mUkg42b1p5dw",
                "url" => 'http://pre0.yunspace.com.cn' . Core::$urls['root'] . 'm/grab_order?type=B&action=detail&id=' . $demand_id,
                "topcolor" => "#FF0000",
                "data" => array(
                    "first" => array(
                        "value" => "您的需求单有新的报价",
                        "color" => "#173177",
                    ),
                    "keyword1" => array(
                        "value" => Func_NumEncode::e($demand_id),
                        'color' => '#173177'
                    ),
                    "keyword2" => array(
                        "value" => date('Y-m-d H:i:s', time()),
                        'color' => '#173177'
                    ),
                    "remark" => array(
                        "value" => "请及时查看！",
                        "color" => "#173177",
                    )
                )
            );

            Wechat_Messag_Push::salePush($wechat);
        }
        if (Func_Input::isLocal()) {
//            Func_Mail::send('zzc@yunspace.com.cn', '有报价快查看', '有报价' . $demand_id);
        }
    }


    /**
     * 有一个需求单分配给你了  ， 微信。邮件 吧
     * @param $args
     */
    static function  saleAllotNotice_A($args)
    {
        $request = Func_Input::filter(array(
            'sale_phone' => 'phone',
            'id' => 'int',
        ), $args);
        if (empty($request['sale_phone'])) {
            return Api::request('error', '', '手机号不正确！');
        }
        $openId = Data_Mysql_Table_Account_Wechat_Sale::handleGetOpenidByPhone($request['sale_phone']);

        if (!empty($openId)) {
            $wechat = array(
                "touser" => $openId,
                "template_id" => "pOZtGh8p-M5LEOuu-tuyLuhHGrvMh7bAJ3DEmsz6qbg",
                "url" => 'http://pre0.yunspace.com.cn' . Core::$urls['root'] . 'm/grab_order?type=B',
                "topcolor" => "#FF0000",
                "data" => array(
                    "first" => array(
                        "value" => "【需求单到账】.",
                        "color" => "#173177",
                    ),
                    "keyword1" => array(
                        "value" => '云SPACE',
                        'color' => '#173177'
                    ),
                    "keyword2" => array(
                        "value" => '需求' . $request['id'] . ',分配给您了,请及时跟进！',
                        'color' => '#173177'
                    ),
                    "remark" => array(
                        "value" => "请及时查看！",
                        "color" => "#173177",
                    )
                )
            );
            Wechat_Messag_Push::salePush($wechat);
        }
        if (Func_Input::isLocal()) {
//            Func_Mail::send('zzc@yunspace.com.cn', '有一个需求单分配给你了快去处理吧', '------' . $request['id']);
        }
    }

    /**
     *param $args =>array(
     *           'demand_id' => 'int',
     *          'email' => 'int',
     * );
     * 邮件通知销售   重新分配会用到
     */
    static function  saleAllotNotice_A_email($args)
    {
        $request = Func_Input::filter(array(
            'demand_id' => 'int',
            'email' => 'string',
            'notice_type' => 'int',
        ), $args);
        if(empty($request['demand_id'])){
            return false;
        }
        //1. 根据 $demandId 查询 需求
        $r = Data_Mysql_Table_Demand::select('*', $request['demand_id']);
        if (empty($r[0])) {
            return false;
        }
        $title = ' 新的需求分配到您';
        $email = $request['email'];
        $demand = $r[0];
        $demand['demand'] = json_decode($demand['demand'], 1);
        if (!empty($request['notice_type']) && $request['notice_type'] == 1) {
            $title = "【加急】{$title} {$demand['id']} /{$demand['city']} /{$demand['demand_type']} /{$demand['demand_name']}";
        } else {
            $title = "【通知】{$title} {$demand['id']} /{$demand['city']} /{$demand['demand_type']} /{$demand['demand_name']}";

        }
        $msg = "{$title}<br><dl>";
        $msg .= "<hr><dt>简单联系方式:</dt><dd>姓名:{$demand['demand']['联系人']}<br>\n电话:{$demand['phone']}";
        if (!empty($demand['demand']['product_id'])) {
            $msg .= "</dd><hr><dt>具体要求:</dt><dd>{$demand['demand']['具体要求']}";
            $msg .= "<br>\n相关链接: <a href='http://www.yunspace.com.cn/service_info/{$demand['demand']['product_id']}.html' target='_blank'>点击访问(新窗口)</a>";
        } elseif (!empty($demand['demand']['set_id'])) {
            $msg .= "</dd><hr><dt>具体要求:</dt><dd>{$demand['demand']['具体要求']}";
            $msg .= "<br>\n相关链接: <a href='http://www.yunspace.com.cn/set_info/{$demand['demand']['set_id']}.html' target='_blank'>点击访问(新窗口)</a>";

        } else {
            $msg .= "</dd><hr><dt>需求:</dt><dd>";
            foreach ($demand['demand'] as $k => $v) {
                $msg .= "{$k}:{$v}<br/>\n";
            }
        }
        $msg .= '</dd><br/>';

        Func_Mail::send($email, $title, $msg . '</dl>');

    }

    /**
     * @param $args
     * 抢单系统的通知 给销售
     * 有新单了，快去抢单
     */
    static function  saleGrabOrderNotice_All($args)
    {
        $request = Func_Input::filter(array(
            'city' => 'string',
            'demand_id' => 'int',
            'demand' => 'array',
        ), $args);

        $k1_a = empty($request['demand']['联系人']) ? '新需求单' : "姓名:" . @$request['demand']['联系人'];
        $k1_b = empty($request['demand']['活动人数']) ? '' : ";" . $request['demand']['活动人数'];
        $k1_c = ';' . @$request['demand']['活动类型'];

        $k1 = $k1_a . $k1_b . $k1_c;

        $wechat = array(
            "touser" => '',
            "template_id" => "o5Cihdi7pkpN2KoT90pUrTz4-VvI0wC4ANPcGOdcOhs",
            "url" => 'http://pre0.yunspace.com.cn' . Core::$urls['root'] . 'm/grab_order?no_alert=1',
            "topcolor" => "#FF0000",
            "data" => array(
                "first" => array(
                    "value" => "【抢单#" . $request['demand_id'] . "】" . @$request['demand']['活动城市'],
                    "color" => "#173177",
                ),
                "keyword1" => array(
                    "value" => $k1,
                    'color' => '#173177'
                ),
                "keyword2" => array(
                    "value" => date('Y-m-d H:i', time()),
                    'color' => '#173177'
                ),
                "keyword3" => array(
                    "value" => '正在抢单',
                    'color' => '#173177'
                ),
                "remark" => array(
                    "value" => "请及时抢单，逾期将关闭！",
                    "color" => "#173177",
                )
            )
        );
        //通知城市的销售
        $citySale = Api_Administrator_SalePeopleByCity::getSaleAllByCity(array('city' => $request['city']));
        if (!empty($citySale)) {
            foreach ($citySale as $val) {
                $wechat['touser'] = $val['openid'];
                Wechat_Messag_Push::salePush($wechat);

            }
        }

    }

    /**
     * @param $args
     * 告知销售这个订单已经创建成功
     */
    static function saleOfferNoticeCreateSuccess($args)
    {
        $request = Func_Input::filter(array(
            'sale_phone' => 'phone',
        ), $args);
        if (empty($request['sale_phone'])) {
            return false;
        }
        $openid = 'o-ENYxECqrcAPQ2VZQ1LDj41cT_8';
        $wechat = array(
            "touser" => '',
            "template_id" => "pOZtGh8p-M5LEOuu-tuyLuhHGrvMh7bAJ3DEmsz6qbg",
            "url" => 'http://pre0.yunspace.com.cn' . Core::$urls['root'] . 'm/grab_order?type=B',
            "topcolor" => "#FF0000",
            "data" => array(
                "first" => array(
                    "value" => "【创建成功】",
                    "color" => "#173177",
                ),
                "keyword1" => array(
                    "value" => '云SPACE',
                    'color' => '#173177'
                ),
                "keyword2" => array(
                    "value" => '您的需求单创建成功',
                    'color' => '#173177'
                ),
                "remark" => array(
                    "value" => "ps:如果需要分配其他同事，您可以让领导重新分配其他人。避免重复创建！",
                    "color" => "#173177",
                )
            )
        );
        $openId = Data_Mysql_Table_Account_Wechat_Sale::handleGetOpenidByPhone($request['sale_phone']);
        if (!empty($openId)) {
            $wechat['touser'] = $openId;
            Wechat_Messag_Push::salePush($wechat);
        }

    }

    /**
     * @param $args
     * 通知组长去分配   系统通知
     */
    static function saleNoticeLeaderAllot($args)
    {

        $request = Func_Input::filter(array(
            'city' => 'string',
        ), $args);
        if (empty($request['city'])) {
            return false;
        }
        $openid = 'o-ENYxECqrcAPQ2VZQ1LDj41cT_8';
        $wechat = array(
            "touser" => '',
            "template_id" => "pOZtGh8p-M5LEOuu-tuyLuhHGrvMh7bAJ3DEmsz6qbg",
            "url" => 'http://pre0.yunspace.com.cn' . Core::$urls['root'] . 'm/grab_order/allot',
            "topcolor" => "#FF0000",
            "data" => array(
                "first" => array(
                    "value" => "【处理分配】",
                    "color" => "#173177",
                ),
                "keyword1" => array(
                    "value" => '云SPACE',
                    'color' => '#173177'
                ),
                "keyword2" => array(
                    "value" => '有新的需求单，由于销售没有及时抢单，超时进入待分配状态！',
                    'color' => '#173177'
                ),
                "remark" => array(
                    "value" => "请及时处理！",
                    "color" => "#173177",
                )
            )
        );
        //通知城市的销售
        $citySale = Api_Administrator_SalePeopleByCity::getSaleLeaderByCity(array('city' => $request['city']));
        if (!empty($citySale)) {
            foreach ($citySale as $val) {
                $wechat['touser'] = $val['openid'];
                Wechat_Messag_Push::salePush($wechat);
            }
        } else {
            Func_Mail::send('zzc@yunspace.com.cn', '【没有要通知的人】', '通知分配' . $request['city'] . '没有结果');
        }

    }

    /**
     * 通知文创组
     * 去处理文创需求
     *
     */
//    static function  saleGroupWinChance($args)
//    {
//        $request = Func_Input::filter(array(
//            'id' => 'int',
//        ), $args);
//        if (empty($request['id'])) {
//            return false;
//        }
//        if (Func_Input::isLocal()) {
//            Func_Mail::send('zzc@yunspace.com.cn', '【新文创需求单】', '新的文创需求等待处理ID=' . $request['id']);
//
//        } else {
//            Func_Mail::send('apple.cheng@yunspace.com.cn', '【新文创需求单】', '新的文创需求等待处理ID=' . $request['id']);
//        }
//
//
//    }

    static function  saleGroupWinChance($args)
    {
        $request = Func_Input::filter(array(
            'id' => 'int',
        ), $args);
        //1. 根据 $demandId 查询 需求
        if (empty($request['id'])) {
            return false;
        }
        $r = Data_Mysql_Table_Demand::select('*', $request['id']);
        if (empty($r[0])) {
            return false;
        }
        $title = ' 【新文创需求单】';
        $demand = $r[0];
        $demand['demand'] = json_decode($demand['demand'], 1);
        $title = "【通知】{$title} {$demand['id']} /{$demand['city']} /{$demand['demand_type']} /{$demand['demand_name']}";
        $msg = "{$title}<br><dl>";
        $msg .= "<hr><dt>简单联系方式:</dt><dd>姓名:{$demand['demand']['联系人']}<br>\n电话:{$demand['phone']}";
        if (!empty($demand['demand'])) {
            $msg .= "</dd><hr><dt>需求:</dt><dd>";
            foreach ($demand['demand'] as $k => $v) {
                $msg .= "{$k}:{$v}<br/>\n";
            }
        }
        $msg .= '</dd><br/>';
        //Apple 的 admin_id
        //分配到 文创组
        Data_Mysql_Table_Demand::update(array('id=?' => array($request['id'])), array('admin_id' => 85));

        if (Func_Input::isLocal()) {
            Func_Mail::send('zzc@yunspace.com.cn', $title, $msg . '</dl>');
            return true;
        }
//        Data_Mysql_Table_Grab_Order::update(array('id=?' => array($request['id']), array('sale_phone' => '18621111831')));
        Func_Mail::send('apple.cheng@yunspace.com.cn', $title, $msg . '</dl>');
    }
} 