<?php

/**
 * Created by PhpStorm.
 * User: yl
 * Date: 2015/9/8
 * Time: 15:00
 * 获取所有匹配指定商家的投标信息
 */
class  Api_Demand_Tender_Get_All_Tender extends Api
{
    static function  handle()
    {
        Api_Session::checkToken(1);
        return self::getAllVendorTender();
    }

    static function  getAllVendorTender()
    {
        $request = Func_Input::filter(array(
            'user_id' => 'int',
            'last_id' => 'id',
        ), $_REQUEST);
        if (empty($request['user_id'])) {
            return self::request('error', '', '参数缺失！！');
        }
        //获取该账户的手机号
        $phone_rs = Data_Mysql_Table_Account::select('id,phone', array('id' => $request['user_id']));
        if (empty($phone_rs[0])) {
            return self::request('error', '', '账号的手机号码不存在！！');
        }

        if (!empty($request['last_id'])) {
            $condition['{table}.id < ?'] = $request['last_id'];
        }

        //获取该供应商的所有招标信息
        $condition['phones'][] = $request['user_id'] . ':' . $phone_rs[0]['phone'];
        $cols = '{table}.id,{table}.tender_id,{prefix}demand.phone,{prefix}demand.account_id,{prefix}demand.demand';
        $table = "{table} LEFT JOIN {prefix}demand_tender ON {table}.tender_id = {prefix}demand_tender.id LEFT JOIN {prefix}demand ON {prefix}demand_tender.demand_id = {prefix}demand.id";
        $rs = Data_Mysql_Table_Demand_Tender_Matching_Product::select($cols, $condition, 'ORDER BY {table}.id DESC', 15, $table);
        if (empty($rs)) {
            return self::request('error', '', '没有竞标数据！！');
        }
        foreach ($rs as $k => $v) {
            if (!empty($v['demand'])) {
                $rs[$k]['demand'] = json_decode($v['demand'], 1);
            }
//            $rs[$k]['title'] = Func_NumEncode::e($v['tender_id']) . substr($v['phone'], 0, 3) . '****' . substr($v['phone'], 7, 10) . '的活动需求';
            $rs[$k]['title'] = '(No.' . Func_NumEncode::e($v['tender_id']) . ')活动需求';
            $rs[$k]['detail_url'] = "http://" . Core::$urls['host'] . "/m/demand_tender/vendor?tender_id=" . $v['tender_id'];
        }
        return self::request('success', $rs, '返回竞标列表！！');
    }

}