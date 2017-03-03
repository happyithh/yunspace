<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/10/29
 * Time: 14:30
 * 获取报价记录 根据条件
 */
class Api_Demand_Offer_GetListByCondition extends Api
{

    static function  handle($args = '')
    {
        Api_Session::checkToken(1);
        $args['account_info'] = Api_Session::user_info();
        switch ($args['action']) {
            case 'customer':
                return self::getCustomerRecord($args);
                break;
            case 'vendor':
                return self::getVendorRecord($args);
                break;
        }
    }

    /**
     * @param $args
     * @return array
     */
    static function  getCustomerRecord($args)
    {
        $request = Func_Input::filter(array(
            'account_info' => 'array',
            'last_id' => 'int',
            'status' => 'string'
        ), $args);
        $table = "{table} as t1 LEFT JOIN {prefix}demand as t2 ON t1.demand_Id=t2.id";
        $conditions["t2.account_id =? "] = $request['account_info']['id'];
        if (!empty($request['last_id'])) {
            $conditions['t1.id <?'] = $request['last_id'];
        }
        if ($request['status'] == 'close') {
            $conditions['t1.status <?'] = 0;
        } else {
            $conditions['t1.status >=?'] = 0;
        }
        $data = Data_Mysql_Table_Demand_Offer::select('t1.id,t1.demand_id,t1.demand_filter,t1.update_time,t1.status,t1.create_time as offer_create_time,t2.demand,t2.phone,t2.create_time', $conditions, 'ORDER BY t1.id DESC', 20, $table);
        if (empty($data)) {
            return Api::request('error', '', '没有数据了~');
        }
        return Api::request('success', self::HandleField($data), '成功');

    }

    /**
     * @param $args
     * @return array
     * 供应商的报价列表
     * 根据月份筛选
     */
    static function getVendorRecord($args)
    {
        $request = Func_Input::filter(array(
            'account_info' => 'array',
            'last_id' => 'int',
            'status' => 'string',
            'search' => 'array'
        ), $args);
        if (empty($request['account_info']['phone'])) {
            return Api::request('error', '', '没有手机号无法查询所用有的商品');
        }
        $ids = Api_Space_Item_GetItemInfoByConditions::getItemIdsByPhone(array('phone' => $request['account_info']['phone']));

        if (empty($ids)) {
            return Api::request('error', '', '没有相关记录存在~');
        }
        $conditions[] = "t1.item_id IN (" . $ids . ")";
        if (!empty($request['last_id'])) {
            $conditions[] = "t1.id <" . $request['last_id'];
        }
        if (empty($request['search'])) {
            $request['search'] = array(
                'year' => date('Y'),
                'month' => date('m'),
            );
        }
        if (!empty($request['search'])) {
            $search = Func_Input::filter(array(
                'year' => 'int',
                'month' => 'string',
                'reported' => 'string',
            ), $request['search']);
            if (!empty($search['year'])) {
                $table_year = $search['year'];
            } else {
                $table_year = date('Y');
            }
            if (!empty($search['month'])) {
                $table_month = $search['month'];
            } else {
                $table_month = date('m');
            }
            if (!empty($search['reported'])) {
                $request['status'] = $search['reported'];
            }
            $table_name = '_' . $table_year . $table_month;
        }
        $_REQUEST['search'] = $request['search'];
        switch ($request['status']) {
            case 'reported':        //已经报过价的
                $conditions[] = "t1.offer_time >0 AND t1.vendor_close_time = 0";
                $order = ' ORDER BY t1.offer_time DESC';
                break;
            case 'reported-A':
                //有意向
                $conditions[] = "t1.change_phone_time >0 AND t1.vendor_close_time = 0";
                $order = ' ORDER BY t1.update_time DESC';
                break;
            case 'reported-B':
                //待确认
                $conditions[] = "t1.offer_time >0 AND t1.vendor_close_time = 0";
                $order = ' ORDER BY t1.offer_time DESC';
                break;
            case 'reported-C':
                //无意向
                $conditions[] = "t1.change_phone_time < 0 AND t1.offer_time >0 AND t1.vendor_close_time = 0";
                $order = ' ORDER BY t1.offer_time DESC';
                break;
            case 'ok':
                $conditions[] = "t1.change_phone_time>0  AND t1.vendor_close_time > 0";
                $order = ' ORDER BY t1.change_phone_time DESC';
                break;
            case 'no':
                $conditions[] = "t1.vendor_close_time > 0";
                $order = ' ORDER BY t1.change_phone_time DESC';
                break;
            default:
                $conditions[] = " t1.offer_time=0 AND t2.status >=0  AND t1.vendor_close_time = 0";
                $order = ' ORDER BY t1.id DESC';
                break;
        }

        $t1 = 't1.*';
        $t2 = 't2.demand_id,t2.create_time';
        $t3 = 't3.demand ';
        $cols = "$t1,$t2 , $t3";


        //        $data = Data_Mysql_Table_Demand_Match_Result::query($sql . $where . ' 1 ' . $order, '', 1);
        $table = "{table} as t1 LEFT JOIN {prefix}demand_offer as t2 ON t1.demand_id = t2.demand_id LEFT JOIN {prefix}demand as t3 ON t3.id = t2.demand_id ";
//        Data_Mysql_Table_Demand_Match_Result::subTable($table_name)->debug(1);
        $data = Data_Mysql_Table_Demand_Match_Result::subTable($table_name)->select($cols, $conditions, $order, 10, $table);
        foreach ($data as $k => $val) {
            $data[$k]['result_id'] = $val['id'];
        }

        if (is_numeric(strpos($request['status'], 'reported'))) {
            //有意向
            $r_A = Data_Mysql_Table_Demand_Match_Result::subTable($table_name)->query("SELECT COUNT(id) as c  FROM {table} as  t1 WHERE t1.item_id IN (" . $ids . ") AND t1.offer_time > 0 AND t1.change_phone_time >0", '', 1);
            //待确认
            $r_B = Data_Mysql_Table_Demand_Match_Result::subTable($table_name)->query("SELECT COUNT(id) as c  FROM {table} as  t1 WHERE t1.item_id IN (" . $ids . ") AND t1.offer_time > 0 AND t1.change_phone_time = 0", '', 1);
            //无意向
            $r_C = Data_Mysql_Table_Demand_Match_Result::subTable($table_name)->query("SELECT COUNT(id) as c  FROM {table} as  t1 WHERE t1.item_id IN (" . $ids . ") AND t1.offer_time > 0 AND t1.change_phone_time < 0", '', 1);
            $sum = ($r_A[0]['c']) + ($r_B[0]['c']) + ($r_C[0]['c']);
        }
        if (empty($data)) {
            return array(
                'status' => 0,
                'data' => array(),
                'msg' => ' 没有更多数据了',
                'reported_count' => array(
                    'sum' => @intval($sum),
                    'A' => @intval($r_A[0]['c']),
                    'B' => @intval($r_B[0]['c']),
                    'C' => @intval($r_C[0]['c']),
                ),
            );
        }
        return array(
            'status' => 1,
            'data' => self::HandleField($data),
            'msg' => '成功',
            'reported_count' => array(
                'sum' => @intval($sum),
                'A' => @intval($r_A[0]['c']),
                'B' => @intval($r_B[0]['c']),
                'C' => @intval($r_C[0]['c']),
            ),
        );
//        return Api::request('success', self::HandleField($data), '成功');
    }

    static function HandleField($array)
    {
        if (!is_array($array)) {
            return false;
        }
        foreach ($array as $key => $val) {
            $array[$key]['demand_id'] = Func_NumEncode::e($val['demand_id']);
            $array[$key]['demand'] = json_decode($val['demand'], 1);
            $array[$key]['sum'] = Api_Demand_Offer_GetData::getSchemeSum(array('demand_id' => $val['demand_id']));

            if (!empty($val['demand_filter'])) {
                $array[$key]['demand_filter'] = json_decode($val['demand_filter'], 1);
            }
            if (!empty($val['result_id'])) {
                $array[$key]['result_id'] = Func_NumEncode::e($val['result_id']);
            }
            $array[$key]['create_time'] = Date('Y-m-d H:i:s', $val['create_time']);
            $array[$key]['isThirty'] = !empty($val['offer_create_time']) && ($val['offer_create_time'] > time() - 1800) ? 1 : '';
        }
        return $array;
    }

}