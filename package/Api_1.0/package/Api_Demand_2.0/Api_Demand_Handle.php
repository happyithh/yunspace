<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/12/17
 * Time: 10:40
 * 需求处理
 *1.进入抢单
 * 2.进入报价
 * 3.选择分配
 *
 */
class Api_Demand_Handle extends Api
{
    static function  cron()
    {
        if (Func_Input::isLocal()) {

            self::autoIntoGrabOrder();
            self::handleNoticeLeaderAllot();
            self::autoHandleMatchResult();
            self::autoInDemandOffer();

//            Core::cron(300, "Api_Demand_Handle", "autoGo", '', 1);
            Core::cron(10, "Api_Demand_Handle", "cron", '', 1);

        } else {

            Core::cron(300, "Api_Demand_Handle", "autoGo", '', 1);
            Core::cron(600, "Api_Demand_Handle", "cron", '', 1);
        }
    }


    static function  autoGo()
    {
        //进入抢单系统        //客户第 1 次发送信息       、1/11  没有20分自动处理
//        self::autoIntoGrabOrder();
//        //处理分配
//        self::handleNoticeLeaderAllot();
//        //处理匹配信息         //客户第3 次发送信息
        self::autoHandleMatchResult();
        //没有人分配的单子 2 万以下的 进入报价系统
        self::autoInDemandOffer();
    }

    /**
     * @param $args
     * @return array
     * 手动进入抢单系统
     *
     * 1.进入抢单系统
     * 2.短信通知客户 A_a
     * 3.通知销售
     */
    static function getIntoGrabOrder($args)
    {
        $request = Func_Input::filter(array(
            'city' => 'string',     //通知的城市
            'phone' => 'phone',
            'demand_id' => 'int',
            'demand' => 'array',
            'is_holiday' => 'int',      //是否是节假日
        ), $args);
        if (empty($request['demand_id']) || empty($request['phone']) || empty($request['city'])) {
            return Api::request('error', '', '缺少参数~');
        }
        $create = Api_Grab_Order_Create::create(array('demand_id' => $request['demand_id']));
        if ($create['data'] == '文创项目合作') {
            return $create;
        }
        //判断是否重复
        $checkRs = Api_Demand_checkRepeat::checkRepeat(array('phone' => $request['phone']));
        if ($checkRs['status'] == 0) {
            return $checkRs;
        }


        //如果设置假日为1
        if ($request['is_holiday'] == 1) {

            Data_Mysql_Table_Grab_Order::update(array('id=?' => $request['demand_id']), array('is_holiday' => 1));

            Data_Mysql_Table_Account_Log::insertAccountLog(1, '', '节假日', '节假日进入抢单', $request['demand_id']);
        }

        Api_Demand_Notice_V2::customerNotice_A_a(array(
            'phone' => $request['phone'],
            'demand_id' => $request['demand_id']
        ));

        Api_Demand_Notice_V2::saleGrabOrderNotice_All(array(
            'city' => trim($request['city']),
            'demand_id' => $request['demand_id'],
            'demand' => $request['demand'],
        ));
        return Api::request('success', $create['data'], '成功');
    }

    /**
     * 20 分钟没有处理的需求
     * 进入抢单系统
     * 1.第一次通知客户 A_a  系统自动触发
     */
    static function  autoIntoGrabOrder()
    {
        return true;

        $conditions["demand_status =? AND create_time < ?"] = array(0, time() - 1209);
        $conditions["demand_type !=? "] = array('查看参考价');
        $data = Data_Mysql_Table_Demand::select('id,phone,demand_type,demand_status,delay_time', $conditions, ' ORDER BY create_time DESC', 10);
        $count = 0;  //计数
        $ids = array();
        foreach ($data as $val) {

            //如果设置了延迟的时间且时间还没过期
            if (!empty($val['delay_time']) && time() < $val['delay_time']) {
                continue;
            }
            if ($val['demand_type'] == '文创项目合作') {
                $winIds[$val['id']] = $val;
                continue;
            }
            /**
             * 重复规则,不进入抢单
             */
            $checkRs = Api_Demand_checkRepeat::checkRepeat(array(
                'phone' => $val['phone']
            ));
            if ($checkRs['status'] == 0) {
                $checkArray[] = $val['id'];
                continue;
            }
            $log = Api_Grab_Order_Create::create(array(
                'demand_id' => $val['id']
            ));
            if ($log['status'] == 0) {
                Data_Mysql_Table_Demand::update(array('id=?' => $val['id']), array('demand_status' => -10));
                Core::log('grab_order_error', '进入抢单失败了】' . $log['msg'] . '/ID=' . $val['id'] . '===<>');

                Func_Mail::send('zzc@yunspace.com.cn', '【进入抢单失败】', $log['msg'] . '/ID=' . $val['id'] . '===<>');
            } else {

                Data_Mysql_Table_Demand::handleAddMarkTags(array(
                    'demand_id' => $val['id'],
                    'mark_id' => 1
                ));
                ++$count;
                $ids[] = $val['id'];
                /**
                 * 进入抢单系统成功的去通知客户 A_b
                 */
                Api_Demand_Notice_V2::customerNotice_A_b(array('phone' => $val['phone']));
            }
            Core::log('grab_order', '【创建】' . '需求超时自动流入抢单系统ID=' . $val['id'] . '===<>');
        }

        /**
         * 通知文创负责人
         */
        if (!empty($winIds)) {
            foreach ($winIds as $k => $val) {

                Data_Mysql_Table_Demand::update(array('id=?' => $val['id']), array('demand_status' => 1));

                Api_Demand_Notice_V2::saleGroupWinChance(array('id' => $val['id']));
            }
        }

        /**
         * 如果存在有效的执行结果 就
         * 通知各个城市的销售
         */
        if ($count != 0) {
            $where[] = "id IN(" . implode(',', $ids) . ")";
            $city = Data_Mysql_Table_Demand::select('city,demand', $where, 'GROUP BY city ', 10);
            if (!empty($city[0])) {
                foreach ($city as $val) {
                    $demand = json_decode($val['demand'], 1);
                    Api_Demand_Notice_V2::saleGrabOrderNotice_All(array(
                        'city' => $val['city'],
                        'demand_id' => $val['id'],
                        'username' => $demand['联系人'],
                    ));
                }
            }
        }
    }

    /**
     * 通知组长 去分配
     */
    static function  handleNoticeLeaderAllot()
    {
        return true;
        $conditions["sale_phone =? AND status =? AND create_time <?"] = array('', 0, time() - 1209);
        $data = Data_Mysql_Table_Grab_Order::select('id', $conditions, '', 10);
        if (empty($data[0])) {
            return false;
        }
        $ids = array();
        foreach ($data as $key => $val) {
            $ids[] = $val['id'];
        }
        $where[] = " id IN(" . implode(',', $ids) . ")";
        $u_where[] = "id IN (" . implode(',', $ids) . ")";
        Data_Mysql_Table_Grab_Order::update($u_where, array('sale_phone' => 1));
        $demand = Data_Mysql_Table_Demand::select('city', $where, ' GROUP BY city', 10);
        if (!empty($demand[0])) {
            foreach ($demand as $val) {
                if (!empty($val['city'])) {
                    Api_Demand_Notice_V2::saleNoticeLeaderAllot(array('city' => $val['city']));
                }
            }
        } else {

            //通知上海的
            Api_Demand_Notice_V2::saleNoticeLeaderAllot(array('city' => '上海'));
        }

        Func_Mail::send('zzc@yunspace.com', '[处理抢单]', '有一个单没人抢');

    }

    /**
     * 进入报价系统30分钟后，把 匹配结果告知客户
     */
    static function autoHandleMatchResult()
    {

        //1.处理创建时间大于30分的需求单,
        $where["create_time <? AND match_result =? AND status=?"] = array((time() - 1800), 0, 0);

        $rs = Data_Mysql_Table_Demand_Offer::select('demand_id,create_time', $where, '', 15);

        if (!empty($rs[0])) {

            foreach ($rs as $k => $val) {
                $offer_count = 0;
                $match_count = 0;
                $data = Data_Mysql_Table_Demand_Match_Result::subTable('_' . date('Ym', $val['create_time']))->select(' id,offer_info', array('demand_id=?' => $val['demand_id']), '', 30);
                if (empty($data[0])) {
                    $c = -1;
//                    Api_Demand_Notice_V2::adminNoticeDemandOffer($val['demand_id'], 'no_result_id');
                } else {
                    foreach ($data as $kk => $vv) {
                        if ($vv['id']) {
                            ++$match_count;
                        }
                        if ($vv['offer_info']) {
                            ++$offer_count;
                        }
                    }
                    $c = $match_count;
                }
                $isOK = Data_Mysql_Table_Demand_Offer::update(array(
                        'demand_id=? AND result_notice_time=?' => array($val['demand_id'], 0)
                    ),
                    array(
                        'match_result' => $c,
                        'result_notice_time' => time(),
                    ));
                //                //把匹配结果通知客户
                //成功采取发送短信
                if ($isOK[0] > 0) {

                    Core::cron(5, "Api_Demand_Notice_V2", "customerNotice_B", array(array(
                        'demand_id' => $val['demand_id'],
                        'match_num' => $c,
                        'offer_count' => $offer_count,
                    )));

                }
            }

        }
    }

    /**
     * v1  2万以下 的订单，
     *
     * v2   没有及时抢单的全部进入报价   1/11
     *
     * 20分钟没人抢单 进入报价系统
     */
    static function  autoInDemandOffer()
    {

        //** 没有分配逻辑所以sale_phone == 0 */
        if (Func_Input::isLocal()) {
            $conditions["t1.status =?  AND t1.create_time <?"] = array(0, time() - 300);
        } else {
            $conditions["t1.status =? AND t1.create_time <?"] = array(0, time() - 1209);
        }
        //$conditions['t2.demand_type !=? AND t2.price_up=? AND t2.price_down <=? '] = array('文创项目合作', 0, 20000);
        $conditions['t2.demand_type !=?'] = array('文创项目合作');
        $table = "{table} as t1 LEFT JOIN {prefix}demand as t2 ON t1.id = t2.id ";
        $data = Data_Mysql_Table_Grab_Order::select('t1.id', $conditions, '', 10, $table);

        if (empty($data[0])) {
            return false;
        }
        $ids = array();
        if (!empty($data[0])) {
            foreach ($data as $key => $val) {
                $log = Api_Demand_Offer_Insert::create(array(
                    'demand_id' => $val['id']
                ));
                $ids[] = $val['id'];
                if ($log['status'] == 0) {
                    Core::log('grab_order_error', '【进入报价】' . $log['msg'] . '/ID=' . $val['id'] . '===<>');
                }
                Core::log('grab_order', '【进入报价】' . '抢单超时自动流入报价系统ID=' . $val['id'] . '===<>');
            }
            self::updateGrabOrderStatus($ids);
        }
    }

    static function  updateGrabOrderStatus($ids)
    {
        if (!empty($ids)) {

            $where[] = "id IN(" . implode(',', $ids) . ")";
            Data_Mysql_Table_Grab_Order::update($where, array(
                'sale_phone' => 9,
                'status' => 1,
                'gather_offer_time' => time(),
            ));
            return true;
        }
        return false;

    }

    /**
     * @param $args
     * @return array
     * 手动进入报价系统
     */
    static function  handleInDemandOffer($args)
    {
        $request = Func_Input::filter(array(
            'id' => 'int',
        ), $args);

        $status = Api_Demand_Offer_Insert::create(array(
            'demand_id' => $request['id']
        ));
        if ($status['status'] == 1) {

            self::updateGrabOrderStatus(array($request['id']));
            return Api::request('success', '', '  成功');
        }
        return Api::request('error', '', $status['msg']);
    }


}