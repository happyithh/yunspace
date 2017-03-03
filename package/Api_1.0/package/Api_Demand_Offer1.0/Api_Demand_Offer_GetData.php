<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/10/20
 * Time: 13:57
 * 根据ID获取这个报价的数据
 */
class Api_Demand_Offer_GetData extends Api
{


    static function  getDemandOfferByCondition($args)
    {
        $request = Func_Input::filter(array(
            'account_id' => 'int',
            'demand_id' => 'int',
        ), $args);
        if (empty($request['demand_id'])) {
            return false;
        }

        $conditions = array();
        if (!empty($request['demand_id'])) {
            $conditions['t1.demand_id =?'] = $request['demand_id'];
        }
        $cols = 't2.price_up,t2.price_down,t2.account_id,t2.phone,t2.demand_type,t2.demand,t2.create_time,t1.id,t1.demand_id,t1.demand_filter,t1.create_time as offer_create_time,t1.update_time,t1.status,t3.fullname as admin_name,t3.phone as admin_phone';
        $table = '{table} as t1 LEFT JOIN {prefix}demand as t2 ON t1.demand_id = t2.id LEFT JOIN {prefix}administrator as t3 ON t1.admin_id= t3.id';
        /**
         * V2  增加领取人的手机号，用于前台显示   11/24
         */
        $data = Data_Mysql_Table_Demand_Offer::select($cols, $conditions, '', 1, $table);
        if (empty($data[0])) {
            return false;
        }
        $ddd = @$data[0];
        $ddd['demand'] = json_decode($ddd['demand'], 1);
        $ddd['demand_filter'] = json_decode($ddd['demand_filter'], 1);
        if (!empty($ddd['demand_filter']['tags'])) {
            foreach ($ddd['demand_filter']['tags'] as $k => $v) {
                if ($v != 1) {
                    unset($ddd['demand_filter']['tags'][$k]);
                }
            }
        }
        $ddd['tags'] = @Data_Mysql_Table_Demand_Tag::convertVal($ddd['demand_filter']['tags']);
        $ddd['nick_phone'] = substr($ddd['demand']['联系电话'], 0, 3) . '****' . substr($ddd['demand']['联系电话'], 7, 10);
        $ddd['nick_username'] = mb_substr(@$ddd['demand']['联系人'], 0, 1, 'utf-8') . '**';
        $ddd['create_time'] = Date('Y-m-d H:i:s', $ddd['create_time']);
        $ddd['isThirty'] = !empty($ddd['offer_create_time']) && ($ddd['offer_create_time'] > time() - 1800) ? '1' : '';

        $day = (strtotime(@$ddd['demand']['结束时间']) - strtotime(@$ddd['demand']['开始时间'])) / 86400;
        $ddd['day'] = $day == 0 ? 1 : $day + 1;
        return $ddd;
    }

    /**
     * @param $args
     * @return bool
     *
     */

    static function  getSchemeSum($args)
    {
        $request = Func_Input::filter(array(
            'demand_id' => 'int',
        ), $args);
        if (empty($request['demand_id'])) {
            return 0;
        }
        $demand_offer_info = Data_Mysql_Table_Demand_Offer::select("create_time", array('demand_id=?' => $request['demand_id']), '', 1);
        if (empty($demand_offer_info)) {
            return 0;
        }
        $month = date('Ym', $demand_offer_info[0]['create_time']);
        $conditions['demand_id =? AND offer_price >? AND offer_time >?'] = array($request['demand_id'], 0, 0);
//        Data_Mysql_Table_Demand_Match_Result::subTable('_' . $month)->debug(1);
        $dd = Data_Mysql_Table_Demand_Match_Result::subTable('_' . $month)->select(" COUNT(id) as c", $conditions);
        if (empty($dd[0])) {
            return 0;
        }
        return $dd[0]['c'];
    }

    /**
     *
     */
    static function  getMatchSum($args)
    {
        $request = Func_Input::filter(array(
            'demand_id' => 'int',
            'offer_id' => 'int',
        ), $args);
        if (empty($request['demand_id'])) {
            return 0;
        }
        $demand_offer_info = Data_Mysql_Table_Demand_Offer::select("*", array('demand_id=?' => $request['demand_id']), '', 1);
        if (empty($demand_offer_info)) {
            return 0;
        }
        $month = date('Ym', $demand_offer_info[0]['create_time']);
        $conditions['demand_id =? AND offer_id =?'] = array($request['demand_id'], $request['offer_id']);
//        Data_Mysql_Table_Demand_Match_Result::debug(1);
        $dd = Data_Mysql_Table_Demand_Match_Result::subTable('_' . $month)->select(" COUNT(id) as c", $conditions);
        if (empty($dd[0])) {
            return 0;
        }
        return $dd[0]['c'];
    }
}