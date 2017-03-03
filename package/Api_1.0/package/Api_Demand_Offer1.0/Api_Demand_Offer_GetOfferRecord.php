<?php

/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/10/21
 * Time: 14:15
 */
class Api_Demand_Offer_GetOfferRecord extends Api
{


    static function  handle($args = '')
    {
        Api_Session::checkToken(1);

        $args['account_id'] = Api_Session::user_id();

        return self::offerRecord($args);
    }

    /**
     * @param $args
     * @return array
     * 报价记录
     */
    static function  offerRecord($args)
    {
        $request = Func_Input::filter(array(
            'demand_id' => 'int',
            'offer_id' => 'int',
            'account_id' => 'int'
        ), $args);
        if (empty($request['demand_id'])) {
            return Api::request('error', '', '检查参数合法性~');
        }

        $is_exist = Api_Demand_Offer_GetData::getDemandOfferByCondition(array('demand_id' => $request['demand_id'], 'account_id' => $request['account_id']));
        if (empty($is_exist)) {
            Api::request('error', '', '记录不存在~');
        }

        $month = date('Ym', $is_exist['offer_create_time']);
        $cols = "t1.is_update,t1.id,t1.id as result_id,t1.intention_time,t1.demand_id,t1.item_id,t1.offer_info,t1.offer_unit,t1.offer_price,t1.offer_time,t1.change_phone_time,t1.last_view_time,t2.city,t2.tags,t2.item_name,t2.space_id,t2.size,t2.logo,t3.addr,t3.space_name";
        $conditions["demand_id =? AND offer_time>? AND offer_price>?"] = array($request['demand_id'], 0, 0);

        $table = "{table} as t1 LEFT JOIN {prefix}space_item as t2 ON t1.item_id = t2.id LEFT JOIN {prefix}spacepedia as t3 ON t2.space_id = t3.id";
//        Data_Mysql_Table_Demand_Match_Result::debug(1);
        $data = Data_Mysql_Table_Demand_Match_Result::subTable('_' . $month)->select($cols, $conditions, 'ORDER BY t1.id ASC', 100, $table);
        if (empty($data[0])) {
            return Api::request('error', '', '没有数据~');
        }
        $rs = self::handleJSON($data);
        foreach ($rs as $v) {
            if (!empty($v['countdown']) && $v['countdown'] < 0) {
                if (!Func_Input::isLocal()) {
                    if ($month < 201603) {
                        return false;
                    }
                }
                if (empty($v['intention_time'])) {
                    Api_Demand_Notice_Vendor_V2::Customer_Intention_Notice_Vendor_B(array(
                        'demand_id' => $request['demand_id'],
                        'result_id' => $data[0]['id'],
                        'item_id' => $data[0]['item_id'],
                    ));
                    Data_Mysql_Table_Demand_Match_Result::subTable('_' . $month)->update(array('id=?' => array($v['id'])), array('intention_time' => time(), 'change_phone_time' => -1));

                } else {
                    Data_Mysql_Table_Demand_Match_Result::subTable('_' . $month)->update(array('id=?' => array($v['id'])), array('change_phone_time' => -1));

                }
            }
        }
        return Api::request('success', $rs, '成功');
    }

    /**
     * @param $data
     * @return array
     */
    static function  handleJSON($data)
    {
        if (!is_array($data)) {
            return array();
        }
        foreach ($data as $k => $val) {

            if (!empty($val['last_view_time'])) {
                $data[$k]['countdown'] = $val['last_view_time'] - time();

                $data[$k]['last_view_time'] = Date('Y-m-d H:i:s', $val['last_view_time']);
            }
            $data[$k]['result_id'] = Func_NumEncode::e($val['result_id']);
            $data[$k]['offer_time'] = Date('Y-m-d H:i:s', $val['offer_time']);
            $data[$k]['offer_info'] = json_decode($val['offer_info'], 1);
            $data[$k]['tags'] = json_decode($val['tags'], 1);

        }

        return $data;

    }
}