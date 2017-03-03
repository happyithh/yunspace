<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/10/16
 * Time: 17:00
 *
 * 发短信给商家
 */

/**
 * Class Api_Demand_Offer_Send_SMS_Vendor
 * 1.通知商家进行商品的报价
 * 2. 短信发送短网址，（推送微信，APP）
 * 3. 发送的顺序时是调用时预先排好的(状态为 -1 )
 * 4. 更新匹配记录表（将发送的内容存入）
 */
class Api_Demand_Offer_Send_SMS_Vendor extends Api
{

    static $ttt = '【通知商家】';

    /**
     * 计划任务
     */
    static function  Cron()
    {
        //12/11
        if (Core::$urls['host'] == 'www.yunspace.com.cn') {
            return false;
        }
//        Core::log('adu_test', '计划任务创建');
        Core::cron(60, 'Api_Demand_Offer_Send_SMS_Vendor', 'init', '', 1);
//        Core::log('adu_test', '计划任务创建成功');
    }

    static function init()
    {
        $month = date('Ym', time());
//        Data_Mysql_Table_Demand_Match_Result::subTable('_' . $month)->debug(1);
        $match_list = Data_Mysql_Table_Demand_Match_Result::subTable('_' . $month)->select('id,demand_id,offer_id', array('notice_time =?' => '-1'), 'GROUP BY demand_id ORDER BY id ASC', 20);
        Core::log('adu_test', '查询数据');

        foreach ($match_list as $val) {
            Core::log('adu_test', $val['offer_id'] . $val['demand_id']);
            self::ready(array(
                'offer_id' => $val['offer_id'],
                'demand_id' => $val['demand_id'],
            ));
        }
    }

    /**
     * @param $args
     * 1步
     * 获取需求信息准备通知商家
     */
    static function ready($args)
    {

        $request = Func_Input::filter(array(
            'offer_id' => 'int',
            'demand_id' => 'int',
        ), $args);
//        Core::log('adu_test', '进如第一步1' . implode(',', $request));
        if (empty($request['offer_id']) || empty($request['demand_id'])) {
            return Api::request('error', '请检查参数的合法性~', '');
        }
        //1.获取需求信息
        $cols = 't2.account_id,t2.phone,t2.demand,t1.id,t1.status';
        $table = '{table} as t1 LEFT JOIN {prefix}demand as t2 ON t1.demand_id = t2.id';
        $conditions['t1.id =? AND t1.demand_id =? AND t1.status >=?'] = array(
            $request['offer_id'], $request['demand_id'], 0
        );
//        Data_Mysql_Table_Demand_Offer::debug(1);
        $data = Data_Mysql_Table_Demand_Offer::select($cols, $conditions, '', 1, $table);
        if (empty($data[0]['demand'])) {
//            Core::log('demand_offer_log', self::$ttt . '没有找到需求无法继续,demand_id:' . $request['demand_id'] . '。');
            return Api::request('error', '', '该需求不可操作~');
        }
        $demand = json_decode($data[0]['demand'], 1);
//        Core::log('adu_test', '进如第一步');

        self::notice(array(
            'offer_id' => $request['offer_id'],
            'demand_id' => $request['demand_id'],
            'demand' => $demand,
        ));
    }

    /**
     * @param $args
     * @return array;
     *
     * 2步
     * 通知哪个商家
     *
     * 2.1创建计划任务
     */
    static function  notice($args)
    {
        $request = Func_Input::filter(array(
            'offer_id' => 'int',
            'demand_id' => 'int',
            'demand' => 'array',
        ), $args);

        if (empty($request['offer_id']) || empty($request['demand_id'])) {
            return Api::request('error', '请检查参数的合法性~', '');
        }
        if (empty($request['demand'])) {
            Core::log('demand_offer_log', self::$ttt . '第二步---需求信息缺失demand_id:' . $request['demand_id']);
            return Api::request('error', '', '需求信息缺失');
        }
        //2.找出需求报价匹配的商品ID
        $where['t1.demand_id =? AND t1.offer_id =? AND t1.notice_time =?'] = array(
            $request['demand_id'], $request['offer_id'], '-1'
        );
        $table = "{table} as t1 LEFT JOIN {prefix}space_item as t2 ON t1.item_id = t2.id";
        $month = date('Ym', time());
//        Core::log('adu_test', '进如第2步' . $month);
        $match_list = Data_Mysql_Table_Demand_Match_Result::subTable('_' . $month)->select('t1.id,t1.item_id,t2.space_id,t2.phone,t2.email,t2.item_name', $where, 'ORDER BY t1.id ASC', 50, $table);
        foreach ($match_list as $k => $val) {
//            Core::log('adu_test', '进如第2步数据' . $val['phone'] . $val['phone'] . $val['email']);
            $register = Api_Account_Register::SpacepediaQuickRegister(array(
                'phone' => $val['phone'],
                'username' => $val['phone'],
                'email' => $val['email']
            ));

            if (is_array($register['data'])) {

                $isOK = Data_Mysql_Table_Demand_Match_Result::subTable('_' . $month)->update(array('id =?' => array($val['id'])), array('notice_time' => time()));

                Api_Demand_Offer_Match_Space_Archives_Update::NoticeUpdate($val['item_id']);

                if ($isOK[0] > 0) {

                    self::send(array(
                        'result_id' => $val['id'],
                        'account_id' => $register['data']['id'],
                        'phone' => $val['phone'],
                        'email' => $val['email'],
                        'demand_id' => $request['demand_id'],
                        'demand' => $request['demand'],
                        'item_name' => $val['item_name'],
                    ));
                    Core::log('adu_test', '进如第2步数据' . '更新发送时间');
                } else {

                    Func_Mail::send('zzc@yunspace.com.cn', '【报价系统】', '通知商家更新notice_time 时间失败,ID' . $val['id'] . '_' . $month);

                }
            } else {

                Core::log('demand_offer_log', self::$ttt . '第二步---商品的负责人账户注册失败了phone:' . $val['phone']);

            }
        }
    }

    /**
     *
     * 3步 发送通知
     * @param $args
     *
     */
    static function  send($args)
    {
        $request = Func_Input::filter(array(
            'result_id' => 'int',
            'account_id' => 'int',
            'phone' => 'phone',
            'email' => 'email',
            'demand_id' => 'int',
            'item_name' => 'string',
            'demand' => 'array',
        ), $args);
        if (empty($request['result_id']) || empty($request['account_id']) || empty($request['demand_id']) || empty($request['phone']) || empty($request['demand'])) {

            Core::log('demand_offer_log', self::$ttt . '第三步---准备发送的参数不正确~demand_id:' . $request['demand_id'] . ',phone:' .
                $request['phone'] . ',result_id:' . $request['result_id'] . ',account_id:' . $request['account_id'] . ',demand:' . json_decode($request['demand'], 1));

            return Api::request('error', '', '通知供应商的参数不合法~send');
        }
        $host = "http://" . Core::$urls['host'] . "/m";
        $getDWZ = array(
            'account_id' => $request['account_id'],
            'access_url' => $host . "/demand_offer.v2/vendor?result_id=" . Func_NumEncode::e($request['result_id']) . '&demand_id=' . Func_NumEncode::e($request['demand_id']),
            'overdue_time' => 60,
            'is_return_data' => 1,
        );
        Core::log('adu_test', '进如第3步数据');
        //发送短信
        self::SMSPush(array(
                'urlDWZ' => $getDWZ,
                'phone' => $request['phone'],
                'email' => $request['email'],
                'demand_id' => $request['demand_id'],
                'item_name' => $request['item_name'],
                'demand_data' => $request['demand'])
        );
        //发送微信
        self::wxVendorPush(array(
            'demand_id' => Func_NumEncode::e($request['demand_id']),
            'account_id' => $request['account_id'],
            'result_id' => Func_NumEncode::e($request['result_id']),
            'demand_data' => $request['demand'],
        ));
        //发送app
//        self::mobileAppPush($request['account_id'], $getDWZ);


    }

    /**
     * @param $array
     *发送短信
     *
     */
    static function  SMSPush($array)
    {

        $request = Func_Input::filter(array(
            'urlDWZ' => "array",
            'phone' => "phone",
            'demand_id' => "int",
            'email' => 'email',
            'item_name' => 'string',
            'demand_data' => 'array',
        ), $array);
        if (empty($request['phone']) || empty($request['urlDWZ']) || empty($request['demand_data'])) {
            Core::log('demand_offer_log', self::$ttt . '第四步---短信发送的参数不正确~urlDWZ:' . $request['urlDWZ'] . ',phone:' .
                $request['phone'] . ',item_name:' . $request['item_name'] . ',demand_data:' . json_decode($request['demand_data'], 1));

            return Api::request('error', '', '参数不正确~');
        }


        $demand_data = $request['demand_data'];
        $request['nick_phone'] = @substr($demand_data['联系电话'], 0, 3) . '****' . @substr($demand_data['联系电话'], 7, 10);
        $request['nick_username'] = mb_substr($demand_data['联系人'], 0, 1, 'utf-8') . '**';
        $smsInfo_t = "您收到一个询价单(No." . Func_NumEncode::e($request['demand_id']) . "),报价截止日期：" . date('Y-m-d H:i', strtotime('+2 day')) . "；请及时报价！立即报价 ！点击查看:";
        $url = Api_Get_Login_DWZ::getLoginLink($request['urlDWZ']);
        if (!empty($url['data'])) {
            $smsInfo = $smsInfo_t . $url['data']['url'] . ' ' . ",微信关注“云SPACE管家”及时获取信息，如有问题也可在服务号中反馈。";
            $code = $url['data']['auth_code'];
            Core::log('adu_test', '进如第4步数据' . '发送邮件');
//            Func_Mail::send('zzc@yunspace.com.cn;1107110350@qq.com;brown@yunspace.com.cn;', '【云·Space活动需求推荐】', $smsInfo . ' -' . $code);

            Core::log('adu_test', '进如第4步数据' . '发送邮件成功' . $request['email'], '【云·Space活动需求推荐】', $smsInfo . ' -' . $code);
            if (Func_Input::isLocal()) {

                Func_Mail::send($request['email'], '【云·Space活动需求推荐】', $smsInfo . ' -' . $code);
            } else {
                Func_Message::sendSMS($request['phone'], array(
                    $smsInfo,
                    $code
                ), 35370);
            }
        }
    }


    //APP推送
    static function  mobileAppPush($accountId, $url)
    {
        if (empty($accountId)) {
            return false;
        }
//        Api_Mobile_Push::appPush(array(
//            'to_account_id' => $accountId,
//            'content' => '您有1份新的需求报价',
//            'total' => '1',
//            'tags' => array(
//                'key' => 1002,
//                'val' => array(
//                    'url' => $url,
//                    'message' => '您有1份新的需求报价'
//                ),
//            ),
//        ));
    }

    /**
     * @param $args
     * @return array
     * 微信推送供应商的服务号
     *
     */
    static function  wxVendorPush($args)
    {
        $request = Func_Input::filter(array(
            'demand_id' => 'int',           //需求ID
            'account_id' => 'int',          //账户ID
            'result_id' => 'int',           //匹配记录ID
            'demand_data' => 'array',
        ), $args);
        if (Func_Input::isLocal()) {
//            $openId = 'okykjuEds6bt4ifKhPZ_crZ1jSLQ';
            $host = 'http://d16.yunspace.com.cn';
            $openId = Data_Mysql_Table_Account_Wechat_Manager::handleGetOpenid($request['account_id']);

        } else {
            $host = 'http://' . Core::$urls['host'];
            $openId = Data_Mysql_Table_Account_Wechat_Manager::handleGetOpenid($request['account_id']);
        }
        if (empty($request['demand_data']['开始时间'])) {
            $request['demand_data']['开始时间'] = '暂无';
        }
        if (empty($request['demand_data']['结束时间'])) {
            $request['demand_data']['结束时间'] = '暂无';
        }
        $send = array(
            "touser" => $openId,
            "template_id" => "53Y4Xsimwq-GJgJeRIpjHJe8zCsR8IOIX1rXn6ddkPw",
            "url" => $host . "/m/demand_offer.v2/vendor?action=home&result_id=" . $request['result_id'] . '&demand_id=' . $request['demand_id'],
            "topcolor" => "#FF0000",
            "data" => array(
                "first" => array(
                    "value" => "你好，你有一条待处理的报价单",
                    "color" => "#173177",
                ),
                "keyword1" => array(
                    "value" => empty($request['demand_data']['活动城市']) ? $request['demand_data']['城市'] : $request['demand_data']['活动城市'],
                    'color' => '#173177'
                ),
                "keyword2" => array(
                    "value" => @$request['demand_data']['开始时间'] . '至' . @ $request['demand_data']['结束时间'],
                    'color' => '#173177'
                ),
                "keyword3" => array(
                    "value" => @$request['demand_data']['price_up'] . '-' . @$request['demand_data']['price_down'],
                    'color' => '#173177'
                ),
                "keyword4" => array(
                    "value" => @$request['demand_data']['活动人数'],
                    'color' => '#173177'
                ),
                "remark" => array(
                    "value" => "点击进入",
                    "color" => "#173177",
                )
            )
        );
        return Wechat_Messag_Push::ManagerPush($send);

    }

}