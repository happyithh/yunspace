<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/10/21
 * Time: 11:16
 *
 */
$_REQUEST['result_id'] = Func_NumEncode::d($_REQUEST['result_id']);

class Api_Demand_Offer_GetDataVendor extends Api
{
    static function  handle($args = '')
    {
        Api_Session::checkToken(1);

        $args['account_info'] = Api_Session::user_info();

        return self::getProduct($args);


    }

    /**
     * @param $args
     * @return int
     * 获取供应商下属的商品
     */
    static function  getProduct($args)
    {
        $request = Func_Input::filter(array(
            'demand_id' => 'int',
            'result_id' => 'int',
            'account_info' => 'array',
        ), $args);

        if (empty($request['result_id']) || empty($request['account_info']) || empty($request['demand_id'])) {
            return Api::request('error', '', '请检查参数合法性');
        }
        $demand_offer_info = Data_Mysql_Table_Demand_Offer::select("id,create_time", array('demand_id=?' => $request['demand_id']), '', 1);
        if (empty($demand_offer_info[0])) {
            return Api::request('error', '', '当前需求不存在。');
        }
        $month = date('Ym', $demand_offer_info[0]['create_time']);

        $request['phone'] = $request['account_info']['phone'];

        $table_a = "{table} as t1 LEFT JOIN {prefix}demand_offer as t2 ON t1.demand_id = t2.demand_id";
        $conditions['t1.demand_id =? AND t1.id =?'] = array($request['demand_id'], $request['result_id']);
        $cols = "t1.vendor_close_time,t1.vendor_close_mark,t1.last_view_time,t1.id,t1.hits,t1.id as result_id,t1.item_id,t1.demand_id,t1.offer_info,t1.offer_price,t1.offer_unit,t1.offer_time,t1.change_phone_time,t2.demand_filter";
//        Data_Mysql_Table_Demand_Match_Result::subTable('_' . $month)->debug(1);
        $is_exist = Data_Mysql_Table_Demand_Match_Result::subTable('_' . $month)->select($cols, $conditions, '', 1, $table_a);
        $exist = $is_exist[0];

        if (empty($exist['item_id'])) {
            return Api::request('error', '', '不存在记录');
        }
        Data_Mysql_Table_Demand_Match_Result::subTable('_' . $month)->update(array('id =?' => $is_exist[0]['id']), array('hits' => intval($is_exist[0]['hits']) + 1));
        if (!empty($exist['offer_info']) && !empty($exist['offer_time'])) {
            $exist['offer_info'] = json_decode($exist['offer_info'], 1);
            $exist['offer_time'] = date('Y-m-d H:i:s', $exist['offer_time']);
            if (!empty($exist['last_view_time'])) {
                $exist['countdown'] = $exist['last_view_time'] - time();
                if ($exist['countdown'] < 0 && $exist['change_phone_time'] == 0 && $exist['vendor_close_time'] == 0) {
                    Data_Mysql_Table_Demand_Match_Result::subTable('_' . $month)->update(array('id =?' => $is_exist[0]['id']), array('change_phone_time' => '-1'));
                }
                $exist['last_view_time'] = Date('Y-m-d H:i:s', $exist['last_view_time']);
            }
            $item_table = "{table}  as t1 LEFT JOIN {prefix}spacepedia as t2 ON t1.space_id = t2.id";
            $where['t1.id =?'] = array($exist['item_id']);
            $item = Data_Mysql_Table_Space_Item::select('t1.id,t1.item_name,t1.tags,t1.city,t1.logo,t1.size,t1.phone,t1.contacts,t2.addr,t2.space_name', $where, '', 1, $item_table);
            $item_data = $item[0];
            $item_data['tags'] = Data_Mysql_Table_Demand_Tag::convertVal(json_decode($item_data['tags'], 1));

            return array(
                'status' => 2,
                'data' => $exist,
                'item' => $item_data,
                'msg' => '已经报过价'
            );
        } elseif (!empty($exist['vendor_close_time']) && $exist['vendor_close_time'] > 0) {
            return array(
                'status' => 3,  //
                'data' => $exist,
                'msg' => '已经报过价'
            );
        }

        $table = '{table} as t1 LEFT JOIN {prefix}spacepedia as t2 ON t1.space_id = t2.id  ';
        $data = Data_Mysql_Table_Space_Item::select('t1.id,t1.space_id,t1.item_name,t1.tags,t1.phone,t1.contacts,t2.space_name',
            array('t1.phone = ? AND t1.status >?' => array($request['phone'], 0)
            ), '', '20', $table);

        if (empty($data[0]['space_id'])) {
            return Api::request('error', '', '您当前没有可以操作的商品~');
        }

        $tags = self::tags($is_exist[0], $data);
        return array(
            'status' => 1,
            'msg' => '成功',
            'data' => $tags['data'],
            'tagsNotHave' => $tags['tagsNotHave'],
            'result_id' => Func_NumEncode::e($request['result_id']),
        );

    }

    /**
     *
     */
    static function  getOfferEditData($args)
    {
        Api_Session::checkToken(1);
        $args['account_info'] = Api_Session::user_info();
        $request = Func_Input::filter(array(
            'demand_id' => 'int',
            'result_id' => 'int',
            'account_info' => 'array',
        ), $args);

        if (empty($request['result_id']) || empty($request['account_info']) || empty($request['demand_id'])) {
            return Api::request('error', '', '请检查参数合法性');
        }
        $demand_offer_info = Data_Mysql_Table_Demand_Offer::select("*", array('demand_id=?' => $request['demand_id']), '', 1);
        if (empty($demand_offer_info[0])) {
            return Api::request('error', '', '当前需求不存在。');
        }
        $month = date('Ym', $demand_offer_info[0]['create_time']);

        $request['phone'] = $request['account_info']['phone'];

        $table_a = "{table} as t1 LEFT JOIN {prefix}demand_offer as t2 ON t1.demand_id = t2.demand_id";
        $conditions['t1.demand_id =? AND t1.id =?'] = array($request['demand_id'], $request['result_id']);
        $cols = "t1.id,t1.id as result_id,t1.item_id,t1.demand_id,t1.offer_info,t1.offer_price,t1.offer_unit,t1.offer_time,t1.change_phone_time,t2.demand_filter";

        $is_exist = Data_Mysql_Table_Demand_Match_Result::subTable('_' . $month)->select($cols, $conditions, '', 1, $table_a);

        $exist = $is_exist[0];

        if (empty($exist['item_id'])) {
            return Api::request('error', '', '不存在记录');
        }

        $table = '{table} as t1 LEFT JOIN {prefix}spacepedia as t2 ON t1.space_id = t2.id  ';
        $data = Data_Mysql_Table_Space_Item::select('t1.id,t1.space_id,t1.item_name,t1.tags,t1.phone,t1.contacts,t2.space_name',
            array('t1.phone = ? AND t1.status >?' => array($request['phone'], 0)
            ), '', '20', $table);

        if (empty($data[0]['space_id'])) {
            return Api::request('error', '', '您当前没有可以操作的商品~');
        }

        $tags = self::tags($is_exist[0], $data);

        return array(
            'status' => 1,
            'msg' => '成功',
            'data' => $tags['data'],
            'offer' => $tags['offer'],
            'tagsNotHave' => $tags['tagsNotHave'],
            'result_id' => Func_NumEncode::e($request['result_id']),
        );
    }

    /**
     * @param $data
     * @param $result
     * @return array
     * 处理标签
     */
    static function  tags($result, $data)
    {
        $demand_filter = array();
        $TagsNotHave = false;
        if (!empty($result['demand_filter'])) {
            $demand_filter = json_decode($result['demand_filter'], 1);
            if (!empty($demand_filter['tags'])) {
                foreach ($demand_filter['tags'] as $k => $v) {
                    if ($v != 1) {
                        unset($demand_filter['tags'][$k]);
                    }
                }
            }
        }
        foreach ($data as $k => $val) {
            $tags = json_decode($val['tags'], 1);

            $data[$k]['tags'] = Data_Mysql_Table_Demand_Tag::convertVal($tags);

            if ($val['id'] == $result['item_id']) {
                $data[$k]['selected'] = 1;
                //如果这个商品没有标签的
                $TagsID = empty($tags) ? $demand_filter['tags'] : @array_diff_key($demand_filter['tags'], $tags);
                if ($TagsID) {
                    $TTTags = Data_Mysql_Table_Demand_Tag::convertVal($TagsID);
                    if ($TTTags) {
                        $TagsNotHave['newTags'] = $TTTags;
                        $TagsNotHave['item_name'] = $val['item_name'];
                        $TagsNotHave['id'] = $val['id'];
                    }
                }
            }
        }
        $return = array(
            'data' => $data,
            'tagsNotHave' => $TagsNotHave
        );
        if (!empty($result['offer_info'])) {
            $result['offer_info'] = json_decode($result['offer_info'], 1);
            $return['offer'] = $result;
        }
        return $return;

    }
}