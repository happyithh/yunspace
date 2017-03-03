<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/8/27
 * Time: 11:27
 *
 */
class  Api_Demand_Tender_NoticeVendor extends Api
{
    static $A_Tail = ',请关注服务号：云Space,更及时的获取活动推荐。';
    static $B_Tail = ',微信关注：云Space，更及时的获取活动推荐';

    /**
     * 1.查询是否当前需求所匹配的供应商信息（手机号）
     *
     * 2.判断当前的报价数量（大于30份报价不继续发送）和发送状态（停止发送状态时。不继续发送）
     *
     * 当满足发送条件的时候。按照已发送条数来继续发送短信推送
     *
     * 3.间隔发送，当发送第一轮短信之后间隔 10 分钟 再次进行第二步操作
     *
     */


    static function  notice($args)
    {
        $request = Func_Input::filter(array(
            'tender_id' => 'int',
        ), $args);
        if (empty($request['tender_id'])) {
            $result = self::request('error', '', "报价ID不能为空");
            return $result;
        }
        Core::log("baojiaxitong", "进入供应商发送短信类，第一步",$request['tender_id']);
        self::sendMessage($request['tender_id']);
        /**
         *   1.第一次 直接发送
         *   2.如果还没发完 执行计划任务    每5分钟发一次
         */
    }

    static function sendMessage($tender_id)
    {
        //获取反馈条数
        $table = "{table} LEFT JOIN {prefix}demand_tender as t2 ON {table}.tender_id = t2.id";
        $where['{table}.tender_id=? AND t2.status =?'] = array($tender_id, 0);  //状态
        $info = Data_Mysql_Table_Demand_Tender_Matching_Product::select("{table}.*", $where, '', 1, $table);
        Core::log("baojiaxitong", "进入供应商发送短信类，第2步",implode(',',$info[0]));
        //发送第一批。完全匹配的供应商
        if (!$info[0]) {
            $result = self::request('error', '', "未匹配到相关商品！");
            return $result;
        }
        //判断是停止发送。
        if ($info[0]['status'] == -1) {
            $result = self::request('error', '', "已停止发送");
            return $result;
        }
        //当前报价数
        $total_num = Api_Demand_Tender_GetData::getDemandTenderByCondition(array('id' => $tender_id));
        if ($total_num && $total_num['scheme_sum'] > 30) {
            $result = self::request('error', '', "报价数已超过30个");
            Data_Mysql_Table_Demand_Tender_Matching_Product::update(
                array('tender_id' => $tender_id),
                array("status=?" => -1)
            );
            return $result;
        }

        //获取需求详情
        $demand_tender = Api_Demand_Tender_GetData::getDemandTenderByCondition(array('id' => $tender_id));
        //手机号
        $phoneArray = json_decode($info[0]['phones'], 1);
        $product_name = json_decode($info[0]['product_name'], 1);
        $count = 0;
        $sum = count($phoneArray);

        //查询当前发送数。读取接下来数据 循环发短信
        if ($phoneArray) {

            foreach ($phoneArray as $k => $v) {

                if ($k >= $info[0]['send_total_num'] && $count < 30) {
                    ++$count;

                    $phoneInfo = explode(":", $v);
                    //发送短信模板，内容
                    $getData = array(
                        'account_id' => $phoneInfo[0],
                        'access_url' => "http://" . Core::$urls['host'] . "/m/demand_tender/vendor?tender_id=" . $tender_id,
                        'overdue_time' => 60,
                        'is_return_data' => 1,
                    );
                    //短信通知供应商$phoneInfo[1]
                    Core::log("baojiaxitong", "进入供应商发送短信类，第3步",implode(',',$getData));
                    self::noticeVendor($getData, $phoneInfo[1], $product_name[$k], $demand_tender);

                    //推送 app
                    self::mobileAppPush($phoneInfo[0], $getData['access_url']);
                    unset($phoneInfo);
                }
            }
        }

        $sendCount = intval($info[0]['send_total_num']) + $count;
        //更新状态
        Data_Mysql_Table_Demand_Tender_Matching_Product::update(

            array('tender_id' => $tender_id),
            array("send_total_num" => $sendCount, "status=?" => 1)
        );
        //如果还没有发送完则继续发送
        if ($sendCount < $sum) {
            Core::cron(10 * 60 , 'Api_Demand_Tender_NoticeVendor', 'sendMessage', $tender_id);
////            Func_Cron::register();
//
        }

    }


    static function  noticeVendor($urlData, $phone, $product_name, $demand_data)
    {

        if (empty($demand_data)) {
            return false;
        }

        Core::log("baojiaxitong", "进入供应商发送短信类，第4步",implode(',',$demand_data));
        $smsInfo_t = "今日向您的场地" . $product_name . "推荐新的活动(联系人" . $demand_data['nick_username'] . "，电话" . $demand_data['nick_phone'] . "),点击查看详情:";

        $url = Api_Get_Login_DWZ::getLoginLink($urlData);
        if (!empty($url['data'])) {

            $smsInfo = $smsInfo_t . $url['data']['url'] . ' ';
            $code = $url['data']['auth_code'];

            $code = self::randTail($demand_data['id'], $code);

            //日志
            Api_Log_Create::handle(array(
                'class' => get_called_class(),
                'func' => __FUNCTION__,
                'tender_id' => $demand_data['id'],
                'behavior' => $smsInfo . ' -' . $code,
            ));

            Core::log('demand_tender_log', '【新的需求报价】' . $smsInfo . ' -' . $code);
            Core::log("baojiaxitong", "发给供应商的短信，有新的需求可以报价了",'【新的需求报价】' . $smsInfo . ' -' . $code);
            Func_Mail::send('zzc@yunspace.com.cn', '【新的需求报价】', $smsInfo . ' -' . $code);

//            Func_Message::sendSMS($phone, array(
//                $smsInfo,
//                $code
//            ), 35370);
        }
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

    //推送
    static function  mobileAppPush($accountId, $url)
    {
        if (empty($accountId)) {
            return false;
        }
        Api_Mobile_Push::appPush(array(
            'to_account_id' => $accountId,
            'content' => '您有1份新的需求报价',
            'total' => '1',
            'tags' => array(
                'key' => 1002,
                'val' => array(
                    'url' => $url,
                    'message' => '您有1份新的需求报价'
                ),
            ),
        ));
    }

    /**
     *
     * 通知供应商  报价被接收可以查看手机号了
     *
     * @param $account
     * @param $tender_id
     *
     *
     */
    static function  noticeVendorLookPhone($account, $tender_id)
    {
        if (!is_array($account) || !is_numeric($tender_id)) {
            return false;
        }
        $getData = array(
            'account_id' => $account['id'],
            'access_url' => "http://" . Core::$urls['host'] . "/m/demand_tender/vendor?tender_id=" . $tender_id,
            'overdue_time' => 60,
            'is_return_data' => 1,
        );
        //统一 用 tender_id  作为编号
        $smsInfo = '(#' . Func_NumEncode::e($tender_id) . ')活动报价已被接受，客户已开放联系方式，查看详情:';

        $url = Api_Get_Login_DWZ::getLoginLink($getData);
        if (!empty($url['data'])) {
            $smsInfo = $smsInfo . $url['data']['url'] . ' ';
            $code = $url['data']['auth_code'];
            $code = self::randTail(rand(1, 30), $code);

            //日志
            Api_Log_Create::handle(array(
                'class' => get_called_class(),
                'func' => __FUNCTION__,
                'tender_id' => $tender_id,
                'behavior' => $smsInfo . ' -' . $code,
            ));
            Core::log("baojiaxitong", "通知供应商  报价被接收可以查看手机号了",'【新的需求报价】' . $smsInfo . ' -' . $code);
            Func_Message::sendSMS($account['phone'], array(
                $smsInfo,
                $code
            ), 35370);
        }
    }
}