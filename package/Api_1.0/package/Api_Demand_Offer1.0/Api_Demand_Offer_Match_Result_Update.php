<?php

/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2015/10/16
 * Time: 16:19
 * 更新商品匹配表
 *
 * 1.商家提交报价
 * 2.商家更新需求标签
 *
 * 客户交换电话
 *
 */

$_REQUEST['result_id'] = Func_NumEncode::d($_REQUEST['result_id']);
$_REQUEST['demand_id'] = Func_NumEncode::d($_REQUEST['demand_id']);

class Api_Demand_Offer_Match_Result_Update extends Api
{

    static function  handle($args = '')
    {

        Api_Session::checkToken(1);
        $args['account_info'] = Api_Session::user_info();
        switch ($_REQUEST['action']) {
            case 'changePhone':
                return self::changePhone($args);
                break;
            case 'tags':
                $return = self::TagsUpdate($args);
                break;
            case 'del_tags':
                $return = self::TagsDelete($args);
                break;
            case 'add_tags':
                $return = self::TagsAdd($args);
                break;
            case 'offer_edit':
                $return = self::OfferEdit($args);
                break;
            case 'couldNotConnect':
                $return = self::CouldNotConnect($args);
                break;
            default:
                $return = self::VendorOffer($args);
                break;
        }
        return $return;
    }

    /**
     * @param $args
     * @return array
     * 接不了
     */
    static function  CouldNotConnect($args)
    {
        $request = Func_Input::filter(array(
            'result_id' => 'int',
            'demand_id' => 'int',
            'content' => 'string',
        ), $args);
        $demand_offer = Data_Mysql_Table_Demand_Offer::select('create_time', array('demand_id =?' => array($request['demand_id'])));
        if (empty($demand_offer[0]['create_time'])) {
            return Api::request('error', '', '没有找到数据');
        }
        $month = date('Ym', $demand_offer[0]['create_time']);
        $result_data = Data_Mysql_Table_Demand_Match_Result::subTable('_' . $month)->select('*', array('id=?' => $request['result_id']), '', 1);
        if (empty($result_data[0])) {
            return Api::request('error', '', '无法操作');
        }
        $data = Data_Mysql_Table_Demand_Match_Result::subTable('_' . $month)->update(array('id=?' => array($request['result_id'])),
            array('vendor_close_time' => time(), 'vendor_close_mark' => $request['content']));
        if (!empty($data[0])) {
            return Api::request('success', '', '  成功');
        }
        return Api::request('error', '', '失败');

    }

    /**
     * @param $args
     * @return array
     * 商家提交报价
     */
    static function VendorOffer($args)
    {
        /**
         * 接受数据
         * 产品id ，需求id，主表id 或撇配结果表id.
         * 要修改的参数， 商家报价，报价备注信息等，报价时间， 交换联系方式时间 拨打400电话时间 ，浏览次数（待定），需求标签完善记录（待定）
         *
         * 只要有参数修改的。直接修改。（后期真正使用中会完善。分离吧）
         */

        $request = Func_Input::filter(array(
            'demand_id' => "int",
            'offer_id' => 'int',
            'result_id' => 'int',        //匹配记录表主键
            'offer_info' => 'array',        //商家报价信息
            'offer_price' => 'int',          //价格
            'account_info' => 'array',
            'offer_unit' => 'string',       //单位
        ), $args);
        if (empty($request['demand_id'])) {
            return Api::request('error', '', '请检查参数合法性~');
        }

        $demand_offer_info = Data_Mysql_Table_Demand_Offer::select("create_time", array('demand_id=?' => $request['demand_id'], 'status >=?' => 0), '', 1);
        if (empty($demand_offer_info)) {
            return Api::request('error', '', '当前需求已经是关闭状态。');
        }
        $month = date('Ym', $demand_offer_info[0]['create_time']);
        $is_exist = Data_Mysql_Table_Demand_Match_Result::subTable('_' . $month)->select('*', array('id=?' => $request['result_id']), '', 1);

        $item_id = $is_exist[0]['item_id'];

        $data = array(
            'offer_info' => $request['offer_info'],
            'offer_price' => $request['offer_price'],
            'offer_time' => time(),
            'offer_unit' => $request['offer_unit'],
        );
        if (!empty($is_exist[0]['view_time'])) {
            $data['last_view_time'] = $is_exist[0]['view_time'];
        } else {
            $data['last_view_time'] = time() + 129600;
        }
        $updateWhere["demand_id =? AND offer_id =? AND item_id =?"] = array($request['demand_id'], $request['offer_id'], $item_id);

         Core::cron(50, 'Api_Demand_Offer_Send_SMS_Customer', 'cron', array(array('type' => 'add_offer', 'demand_id' => $request['demand_id'])));

        $rs = Data_Mysql_Table_Demand_Match_Result::subTable('_' . $month)->update($updateWhere, $data);

        //当商家提交报价之后，同时在订单档期表（data_mysql_table_product_demand）里插入一条数据

        $result = Data_Mysql_Table_Demand_Match_Result::subTable('_' . $month)->select('id', $updateWhere);
        $demand_result = Data_Mysql_Table_Demand::select('demand', array('id' => $request['demand_id']));
        $space_result = Data_Mysql_Table_Space_Item::select('item_name', array('id' => $item_id));
        $demand_result[0]['demand'] = json_decode($demand_result[0]['demand'], 1);
        $product_demand_data = array();

        //匹配表的id,当商家更新报价信息的时候，拿此id作为标识来更新档期表中的数据
        $product_demand_data['match_result_id'] = $result[0]['id'];

        $product_demand_data['demand_time'] = $data['offer_time'];
        $product_demand_data['account_phone'] = $data['offer_info']['联系电话'];
        $product_demand_data['status'] = 1;  //1为订单档期有意向
        $product_demand_data['activity_start_time'] = strtotime($demand_result[0]['demand']['开始时间']);
        $product_demand_data['activity_end_time'] = strtotime($demand_result[0]['demand']['结束时间']);
        $product_demand_data['item_id'] = $item_id;
        $product_demand_data['item_name'] = $space_result[0]['item_name'];
        $product_demand_data['from_where'] = 1;
        $product_demand_data['demand_id'] = $request['demand_id'];

        $product_demand_data['detail']['price'] = $data['offer_price'];
        $product_demand_data['detail']['per_price'] = $data['offer_unit'];  //报价单位
        $product_demand_data['detail']['other_price'] = '';
        $product_demand_data['detail']['per_other_price'] = '';
        $product_demand_data['detail']['活动名称'] = !empty($demand_result[0]['demand']['活动名称']) ? $demand_result[0]['demand']['活动名称'] : '';
        $product_demand_data['detail']['活动类型'] = !empty($demand_result[0]['demand']['活动类型']) ? $demand_result[0]['demand']['活动类型'] : '';
        $product_demand_data['detail']['活动人数'] = !empty($demand_result[0]['demand']['活动人数']) ? $demand_result[0]['demand']['活动人数'] : '';
        $product_demand_data['detail']['活动备注'] = !empty($demand_result[0]['demand']['具体要求']) ? $demand_result[0]['demand']['具体要求'] : '';

        $product_demand_data['demand']['people'] = !empty($demand_result[0]['demand']['联系人']) ? $demand_result[0]['demand']['联系人'] : '';
        $product_demand_data['demand']['phone'] = !empty($demand_result[0]['demand']['联系电话']) ? $demand_result[0]['demand']['联系电话'] : '';
        $product_demand_data['demand']['email'] = !empty($demand_result[0]['demand']['邮箱']) ? $demand_result[0]['demand']['邮箱'] : '';
        $product_demand_data['demand']['company'] = !empty($demand_result[0]['demand']['公司名称']) ? $demand_result[0]['demand']['公司名称'] : '';
        $product_demand_data['demand']['company_type'] = '';
        $rs_demand_product = Data_Mysql_Table_Product_Demand::insert($product_demand_data);

        if (empty($rs[0]) || empty($rs_demand_product[0])) {
            return Api::request('error', '', '提交失败~请稍后再试~');
        }

        /*   */
        $match = Data_Mysql_Table_Demand_Match_Result::subTable('_' . $month)->select('count(offer_time) as offer_num', array('demand_id =?' => $request['demand_id'], 'offer_time !=0'));
        $es = Data_Mysql_Table_Demand_Offer_Quantity::select('*', array('demand_id =?' => $request['demand_id']));
        if ($match[0]['offer_num'] == 1 && empty($es[0]['offer_num'])) {
            $sql = "UPDATE {table} SET order_quality=order_quality+20 WHERE demand_id=?";
            Data_Mysql_Table_Demand_Offer::query($sql, array($request['demand_id']));
            if (empty($es)) {
                $data = array(
                    'demand_id' => $request['demand_id'],
                    'offer_num' => 1
                );
                Data_Mysql_Table_Demand_Offer_Quantity::insert($data);
            } else {
                $sql_query = "UPDATE {table} SET offer_num=offer_num+1 WHERE demand_id=?";
                Data_Mysql_Table_Demand_Offer_Quantity::query($sql_query, array($request['demand_id']));
            }
        }

        if ($match[0]['offer_num'] == 4 && empty($es[0]['offer_num_three'])) {
            $sql = "UPDATE {table} SET order_quality=order_quality+15 WHERE demand_id=?";
            Data_Mysql_Table_Demand_Offer::query($sql, array($request['demand_id']));
            $sql_query = "UPDATE {table} SET offer_num_three=offer_num_three+1 WHERE demand_id=?";
            Data_Mysql_Table_Demand_Offer_Quantity::query($sql_query, array($request['demand_id']));
        }
        Api_Demand_Offer_Match_Space_Archives_Update::ResponseUpdate($item_id);

        return Api::request('success', $rs[0], '提交成功');

    }

    /**
     * @param $args
     * @return array
     * 更新商家的商品标签
     */
    static function  TagsUpdate($args)
    {
        @session_start();
        $request = Func_Input::filter(array(
            'demand_id' => 'int',
            'result_id' => 'int',       //匹配记录表主键
            'account_info' => 'array',
            'tags_data' => 'array',
        ), $args);

        $request_Tags = $request['tags_data'];
        if (!Func_Input::isLocal()) {
            if (empty($request['demand_id'])) {
                return Api::request('error', '', '检查参数合法性~');
            }
        }
        $demand_offer_info = Data_Mysql_Table_Demand_Offer::select("create_time", array('demand_id=?' => $request['demand_id'], 'status >=?' => 0), '', 1);
        if (empty($demand_offer_info)) {
            return Api::request('error', '', '当前需求已经是关闭状态。');
        }
        $month = date('Ym', $demand_offer_info[0]['create_time']);
        $is_exist = Data_Mysql_Table_Demand_Match_Result::subTable('_' . $month)->select('*', array('id=?' => $request['result_id']), '', 1);
//        $is_exist = Data_Mysql_Table_Demand_Offer::select('t1.id,t1.status,t2.item_id',
//            array(
//                't1.status >=? AND t1.demand_id =? AND t2.id=?' => array(0, $request['demand_id'], $request['result_id'])
//            ), '', 1,
//            "{table} as t1 LEFT JOIN {prefix}demand_match_result as t2 ON t1.demand_id =t2.demand_id");
        if (empty($is_exist[0]['item_id'])) {
            return Api::request('error', '', '您当前不可以操作该商品');
        }
        $item_id = $is_exist[0]['item_id'];

        Data_Mysql_Table_Demand_Match_Result::subTable('_' . $month)->update(
            array(
                'demand_id =?' => $request['demand_id'],
                'item_id =?' => $item_id
            ),
            array(
                'demand_tag_complete' => $request_Tags
            ));

        foreach ($request_Tags as $key => $val) {
            if ($val != 1) {
                unset($request_Tags[$key]);
            }
        }
//        更新到商品数据库
        if (!empty($request_Tags)) {
            $where['id =? AND phone =?'] = array($item_id, $_SESSION['user']['phone']);
            $item_data = Data_Mysql_Table_Space_Item::select('id,tags', $where);
            if (empty($item_data[0])) {
                return Api::request('error', '', '您修改的商品信息不存在~');
            }
            $oldTags = json_decode($item_data[0]['tags'], 1);
            $newTags = array();
            foreach ($oldTags as $key => $value) {
                $newTags[$key] = $value;
            }
            foreach ($request_Tags as $key => $value) {
                $newTags[$key] = $value;
            }
            if (!empty($newTags)) {
                /**
                 * 这里操作了两张表 1商品表  2.商品表匹配表
                 *
                 */
                $status = Data_Mysql_Table_Space_Item::update(array(
                        'id =?' => array($item_id)),
                    array('tags' => $newTags));

                Data_Mysql_Table_Demand_Match_Space_Archives::update(array(
                        'item_id =?' => array($item_id)),
                    array('tags' => $newTags));

                if (empty($status[0])) {
                    return Api::request('error', '', '操作失败~');
                }
                return Api::request('success', '', '成功');
            }
        }
        return Api::request('error', '', '数据没有更新');

    }

    /**
     * @param $args
     * @return array
     */
    static function  changePhone($args)
    {
        $request = Func_Input::filter(array(
            'demand_id' => 'int',
            'result_id' => "int",
        ), $args);
        if (empty($request['result_id']) || empty($request['demand_id'])) {
            return Api::request('error', '', '参数不合法~');
        }
        $demand_offer_info = Data_Mysql_Table_Demand_Offer::select("create_time", array('demand_id=?' => $request['demand_id']), '', 1);
//        if (empty($demand_offer_info)) {
//            return Api::request('error', '', '当前需求已经是关闭状态。');
//        }

        $month = date('Ym', $demand_offer_info[0]['create_time']);
        $conditions['id =?'] = $request['result_id'];
        $conditions['demand_id =?'] = $request['demand_id'];
        $conditions['change_phone_time =?'] = 0;
        $data = array(
            'change_phone_time' => time(),
        );
        $result_data = Data_Mysql_Table_Demand_Match_Result::subTable('_' . $month)->select("*", array('id=?' => $request['result_id']));
        if (empty($result_data[0])) {
            return Api::request('error', '', '报价记录错误~');
        }

        $status = Data_Mysql_Table_Demand_Match_Result::subTable('_' . $month)->update($conditions, $data);
        if (empty($status[0])) {
            return Api::request('error', '', '操作失败');
        }
        $count = Data_Mysql_Table_Demand_Match_Result::subTable('_' . $month)->select("count(change_phone_time) as change_num", array('demand_id=?' => $request['demand_id'], 'change_phone_time !=0'));
        $es = Data_Mysql_Table_Demand_Offer_Quantity::select('*', array('demand_id =?' => $request['demand_id']));
        if (empty($es)) {
            $data = array(
                'demand_id' => $request['demand_id'],
            );
            Data_Mysql_Table_Demand_Offer_Quantity::insert($data);
        }
        if ($count[0]['change_num'] == 2 && empty($es[0]['change_num_one'])) {
            $sql = "UPDATE {table} SET order_quality=order_quality+25 WHERE demand_id=?";
            Data_Mysql_Table_Demand_Offer::query($sql, array($request['demand_id']));
            $sql_query = "UPDATE {table} SET change_num_one=change_num_one+1 WHERE demand_id=?";
            Data_Mysql_Table_Demand_Offer_Quantity::query($sql_query, array($request['demand_id']));
        }
        if (empty($result_data['intention_time'])) {

            $a = Api_Demand_Notice_Vendor_V2::Customer_Intention_Notice_Vendor_A(array(
                'demand_id' => $request['demand_id'],
                'result_id' => $request['result_id'],
                'item_id' => $result_data[0]['item_id'],
            ));
            Data_Mysql_Table_Demand_Match_Result::subTable('_' . $month)->update(array('id=?' => array($request['result_id'])), array('intention_time' => time()));
        }

        return Api::request('success', $status[0], '成功');
    }

    /**
     * @param $args
     * @return array
     */
    static function  TagsDelete($args)
    {
        $request = Func_Input::filter(array(
            'result_id' => "int",
            'item_id' => 'int',
            'tags_ids' => 'array',
            'account_info' => 'array',
        ), $args);
        if (empty($request['tags_ids']) || empty($request['result_id']) || empty($request['item_id']) || empty($request['account_info'])) {
            return Api::request('error', '', '参数不合法~');
        }
        $TIds = $request['tags_ids'];
        $where['id =? AND phone =?'] = array($request['item_id'], $request['account_info']['phone']);
        $item_data = Data_Mysql_Table_Space_Item::select('id,tags', $where);
        if (empty($item_data[0])) {
            return Api::request('error', '', '您修改的商品信息不存在~');
        }
        $oldTags = json_decode($item_data[0]['tags'], 1);
        foreach ($oldTags as $key => $val) {
            if (array_key_exists($key, $TIds)) {
                unset($oldTags[$key]);
                unset($TIds[$key]);
            }
        }
        if (empty($TIds)) {

            $status = Data_Mysql_Table_Space_Item::update(array(
                    'id =? AND phone=?' => array(
                        $request['item_id'], $request['account_info']['phone']
                    )),
                array('tags' => $oldTags)
            );

            Data_Mysql_Table_Demand_Match_Space_Archives::update(array(
                    'item_id =?' => array($request['item_id'])),
                array('tags' => $oldTags));

            if (!empty($status[0])) {
                return Api::request('success', $status[0], '成功');
            }
        }
        return Api::request('error', '', '修改失败~');

    }

    /**
     * 添加标签
     *
     * 1.插入到demand_tags 表中
     * 2.将 tags_id  存入到space_item 表中
     */
    static function  TagsAdd($args)
    {
        $request = Func_Input::filter(array(
            'result_id' => "int",
            'item_id' => 'int',
            'tags_id' => 'int',
            'tags_string' => 'string',
            'account_info' => 'array',
        ), $args);

        if (empty($request['item_id']) || empty($request['account_info'])) {
            return Api::request('error', '', '参数不合法~');
        }
        if (mb_strlen($request['tags_string'], 'utf-8') > 10) {
            return Api::request('error', '', '文字长度超出限制~~');
        }
        $where['id =? AND phone =?'] = array($request['item_id'], $request['account_info']['phone']);
        $item_data = Data_Mysql_Table_Space_Item::select('id,tags', $where);
        if (empty($item_data[0])) {
            return Api::request('error', '', '您修改的商品信息不存在~');
        }
        if (empty($request['tags_id'])) {
            $tags_status = Data_Mysql_Table_Demand_Tag::update(array('tag_value' => $request['tags_string']));
            $tags_data_id = $tags_status[0];
        } else {
            $tags_data_id = $request['tags_id'];
        }
        if ($tags_data_id > 0) {
            $oldTags = json_decode($item_data[0]['tags'], 1);
            $oldTags[$tags_data_id] = 1;
            $status = Data_Mysql_Table_Space_Item::update(array(
                    'id =? AND phone=?' => array(
                        $request['item_id'], $request['account_info']['phone']
                    )),
                array('tags' => $oldTags)
            );
            Data_Mysql_Table_Demand_Match_Space_Archives::update(array(
                    'item_id =?' => array($request['item_id'])),
                array('tags' => $oldTags));

            if (!empty($status[0])) {
                return Api::request('success', $tags_status[0], '成功');
            }
        }

        return Api::request('error', '', '修改失败~，请再试');
    }

    /**
     * 报价修改
     */
    static function  OfferEdit($args)
    {
        $request = Func_Input::filter(array(
            'demand_id' => 'int',
            'result_id' => 'int',
            'item_id' => 'int',
            'offer_info' => 'array',
            'offer_unit' => 'string',
            'offer_price' => 'int',
        ), $args);
        if (empty($request['demand_id']) || empty($request['offer_price']) || empty($request['item_id'])) {
            return Api::request('error', '', '缺少参数~');
        }

        $demand_offer_info = Data_Mysql_Table_Demand_Offer::select("create_time", array('demand_id=?' => $request['demand_id'], 'status >=?' => 0), '', 1);
        if (empty($demand_offer_info)) {
            return Api::request('error', '', '当前需求已经是关闭状态。');
        }
        $month = date('Ym', $demand_offer_info[0]['create_time']);

        $is_exist = Data_Mysql_Table_Demand_Match_Result::subTable('_' . $month)->select('id,change_phone_time', array('id=?' => $request['result_id']), '', 1);
        if (empty($is_exist[0])) {
            return Api::request('error', '', '不可修改');
        }
        if ($is_exist[0]['change_phone_time'] == -1) {
            $change_phone_time = 0;
        } else {
            $change_phone_time = $is_exist[0]['change_phone_time'];
        }
        $where ['id =? AND demand_id =?'] = array($request['result_id'], $request['demand_id']);
        $data = array(
            'item_id' => $request['item_id'],
            'offer_info' => $request['offer_info'],
            'offer_price' => $request['offer_price'],
            'offer_unit' => $request['offer_unit'],
            'change_phone_time' => $change_phone_time,
            'last_view_time' => time() + 86400 + 43200,
            'is_update' => 1,
        );
        $status = Data_Mysql_Table_Demand_Match_Result::subTable('_' . $month)->update($where, $data);


        //当商家更新报价之后，同时在订单档期表（data_mysql_table_product_demand）里更新一条数据
        $result_item = Data_Mysql_Table_Space_Item::select('item_name', array('id' => $request['item_id']));
        $product_demand_data['detail']['price'] = $data['offer_price'];
        $product_demand_data['detail']['per_price'] = $data['offer_unit'];  //报价单位
        $product_demand_data['item_id'] = $request['item_id'];
        $product_demand_data['item_name'] = $result_item[0]['item_name'];
        $product_demand_data['demand']['people'] = $data['offer_info']['联系人'];
        $product_demand_data['demand']['phone'] = $data['offer_info']['联系电话'];
        $product_demand_data['detail']['活动备注'] = $data['offer_info']['其他备注'];
        $rs_demand_product = Data_Mysql_Table_Product_Demand::update(array('match_result_id=?' => $request['result_id']), $product_demand_data);

        if ($status[0] > 0 && $rs_demand_product[0] > 0) {
            return Api::request('success', '', '成功');
        }
        return Api::request('error', '', '失败');

    }


}