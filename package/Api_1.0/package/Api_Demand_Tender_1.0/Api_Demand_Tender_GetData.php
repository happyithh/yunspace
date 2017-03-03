<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/8/27
 * Time: 11:18
 */
class  Api_Demand_Tender_GetData extends Api
{

    /**
     * 获取竞标信息
     * 1.状态大于等于 0 的
     */
    static $dataTemplate = array();

    static function  getDemandTenderByCondition($args)
    {
        $request = Func_Input::filter(array(
            'account_id' => 'int',
            'id' => 'int',
            'demand_id' => 'int',
        ), $args);
        if (empty($request['account_id']) && empty($request['id']) && empty($request['demand_id'])) {
            return false;
        }
        if (isset(self::$dataTemplate[$request['id']])) {
            return self::$dataTemplate[$request['id']];
        }
        $conditions = array();
        if (!empty($request['id'])) {
            $conditions['t1.id =?'] = $request['id'];
        }
        if (!empty($request['demand_id'])) {
            $conditions['t1.demand_id =?'] = $request['demand_id'];
        }
        if (!empty($request['account_id'])) {
            $conditions['t2.account_id =?'] = $request['account_id'];
        }

        $table = "{table} as t1 LEFT JOIN {prefix}demand  as t2 ON t1.demand_id = t2.id";
        $cols = "t1.id,t1.create_time,t1.product_sum,t1.scheme_sum,t1.scheme_id,t1.status,t2.id as demand_id,t2.city,t2.account_id,t2.phone,t2.demand,t2.price_up,t2.price_down,t2.create_time as demand_create";
//        Data_Mysql_table_Demand_Tender::debug(1);
        $data = Data_Mysql_table_Demand_Tender::select($cols, $conditions, '', 1, $table);
        if (empty($data[0])) {
            return false;
        }
        $ddd = $data[0];
        $ddd['demand'] = json_decode($ddd['demand'], 1);
        $ddd['nick_phone'] = substr($ddd['phone'], 0, 3) . '****' . substr($ddd['phone'], 7, 10);
        $ddd['nick_username'] = mb_substr($ddd['demand']['联系人'], 0, 1, 'utf-8') . '**';
        $ddd['create_time'] = Date('Y-m-d H:i:s', $ddd['create_time']);
        $day = (strtotime(@$ddd['demand']['结束时间']) - strtotime(@$ddd['demand']['开始时间'])) / 86400;
        $ddd['day'] = $day == 0 ? 1 : $day + 1;
        return self::$dataTemplate[$request['id']] = $ddd;
    }

    /***
     * 获取投标记录
     *
     * array(
     *
     * )
     */
    static function  getBidRecord($args)
    {
        $request = Func_Input::filter(array(
            'tender_id' => 'int',
            'last_id' => 'int',
            'vendor_account_id' => 'int',
            'num' => 'int',
        ), $args);
        if (empty($request['num'])) {
            $num = 20;
        } else {
            $num = $request['num'];
        }
        if (!empty($request['last_id'])) {
            $conditions['t1.id >? '] = $request['last_id'];
        }
        if (!empty($request['vendor_account_id'])) {
            $conditions['t1.vendor_account_id =? '] = $request['vendor_account_id'];
        }

        $conditions['t1.tender_id =?'] = $request['tender_id'];
        $table = "{table} as t1 LEFT JOIN {prefix}product_search as t2 ON t1.product_id=t2.id LEFT JOIN {prefix}product_set as t3 ON t1.set_id = t3.id";
        $cols = "t1.*,t2.attr_index,t2.product_name,t2.logo as product_logo,t2.addr as product_addr,t2.order_product_size as product_size,
        t3.set_name,t3.logo as set_logo,t3.addr as set_addr";

        $data = Data_Mysql_table_Demand_Tender_Scheme::select($cols, $conditions, '', $num, $table);

        foreach ($data as $k => $val) {
            $data[$k]['scheme'] = @json_decode($val['scheme'], 1);
            $data[$k]['attr_index'] = @json_decode($val['attr_index'], 1);
            $data[$k]['create_time'] = Date('Y-m-d H:i:s', $val['create_time']);
            if (!empty($val['set_name'])) {
                $data[$k]['product_name'] = $val['set_name'];
                $data[$k]['product_logo'] = $val['set_logo'];
                $data[$k]['product_addr'] = $val['set_addr'];
            }
        }

        return $data;
    }
}