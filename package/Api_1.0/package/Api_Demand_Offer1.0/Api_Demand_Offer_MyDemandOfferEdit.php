<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/10/26
 * Time: 15:30
 * 报价的修改
 */
$_REQUEST['demand_id'] = Func_NumEncode::d($_REQUEST['demand_id']);

class  Api_Demand_Offer_MyDemandOfferEdit extends Api
{
    static function  handle($args = '')
    {

        Api_Session::checkToken(1);
        $args['account_id'] = Api_Session::user_id();
        return self::handleEdit($args);
    }

    /**
     * @param $args
     * @return array
     */
    static function  handleEdit($args)
    {
        $request = Func_Input::filter(array(
            'demand_id' => 'int',
            'tags_data' => 'array',
            'offer_id' => 'int',
            'account_id' => 'int',
            'people' => 'string',
            'activity_type' => 'string',
            'price_up' => 'int',
            'price_down' => 'int',
            'city' => 'string',
            'phone_c' => 'phone',   //手机号
            'name_c' => 'string',   //姓名
            'end_time' => 'string',
            'start_time' => 'string',
        ), $args);
        if (empty($request['demand_id']) || empty($request['offer_id'])) {
            return Api::request('error', '', '请检查参数是否填写正确~');
        }
        if (empty($request['phone_c'])) {
            return Api::request('error', '', '请正确填写手机号~');
        }
        if (empty($request['city'])) {
            return Api::request('error', '', '请选择城市');
        }
        if (empty($request['end_time']) || empty($request['start_time'])) {
            return Api::request('error', '', '请正确的选择起始时间');
        }
        $conditions['t1.id =? AND t2.id =?'] = array($request['offer_id'], $request['demand_id']);
        $table = "{table} as t1 LEFT JOIN {prefix}demand as t2 ON t1.demand_id = t2.id";
//        Data_Mysql_Table_Demand_Offer::debug(1);
        $is_exist = Data_Mysql_Table_Demand_Offer::select('t1.id,t1.demand_filter,t2.demand', $conditions, '', '1', $table);
        if (empty($is_exist[0])) {
            return Api::request('error', '', '不存在的记录~');
        }
        $oldData = $is_exist[0];
        $oldData['demand_filter'] = json_decode($oldData['demand_filter'], 1);
        $oldData['demand'] = json_decode($oldData['demand'], 1);

        $NewIds = $request['tags_data'];
        if (empty($NewIds)) {
            unset($request['tags_data']);
        }
        if (!empty($oldData['demand_filter']['tags']) && !empty($NewIds)) {

            foreach ($oldData['demand_filter']['tags'] as $key => $val) {
                if (!array_key_exists($key, $NewIds)) {
                    unset($oldData['demand_filter']['tags'][$key]);
                }
            }
        }
        $oldData['demand']['活动城市'] = $request['city'];
        $oldData['demand']['联系人'] = $request['name_c'];
        $oldData['demand']['联系电话'] = $request['phone_c'];
        $oldData['demand']['活动类型'] = $request['activity_type'];
        $oldData['demand']['活动人数'] = $request['people'];
        $oldData['demand']['price_up'] = $request['price_up'];
        $oldData['demand']['price_down'] = $request['price_down'];
        $oldData['demand']['开始时间'] = $request['start_time'];
        $oldData['demand']['结束时间'] = $request['end_time'];
        $ddddd = array(
            'price_up' => $request['price_up'],
            'price_down' => $request['price_down'],
            'demand' => $oldData['demand'],
//            'demand_status' => 0,
            'mark' => '需求报价修改'
        );

        $demand_status = Data_Mysql_Table_Demand::update(array(
            'id =? AND account_id =?' => array(
                $request['demand_id'], $request['account_id'])
        ), $ddddd);
        if (empty($demand_status[0])) {
            return Api::request('error', '', '抱歉，修改失败~！');
        }
//        if (!empty($request['tags_data'])) {
////            $offer = Data_Mysql_Table_Demand_Offer::update(array('id =? AND demand_id =?' => array($request['offer_id'], $request['demand_id'])),
////                array(
////                    'demand_filter' => $oldData['demand_filter']
////                ));
////            if (empty($offer[0])) {
////                return Api::request('error', '', '需求已经成功修改，请联系客服为您重新匹配报价~');
////            }
//        }
        return Api::request('success', '', '成功');
    }

}