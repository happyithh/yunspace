<?php
/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2015/10/16
 * Time: 15:38
 * 新需求进入报价系统。搜索条件
 */
@session_start();

class Api_Demand_Offer_Insert extends Api
{


    //添加新需求报价。搜索条件
    static function insertData($args)
    {
        /**
         * 参数。需求id，选择条件（人数范围，价格范围。标签数组）
         */

        //查出需求客户的手机号。插入数据库
        $request = Func_Input::filter(array(
            'demand_id' => 'int',       //需求ID
            'search' => 'array',     //需求筛选条件
            // 'admin_id' => 'int',         //操作人id（报价系统操作员）
            //'customer_phone'=>'string', //客户手机号
        ), $args);
        if (empty($request['demand_id'])) {
            Func_Header::back('参数错误26');
        }
        $data = array(
            'demand_id' => $request['demand_id'],
            'demand_filter' => $request['search'],
//            'admin_id'=>$_SESSION['administrator']['id'],
            'status' => 0,         //本次报价状态。-1 关闭  0 正常 1 等到一小时 2 等待三小时 3 等待一天
        );
        $demand_info = Data_Mysql_Table_Demand::select('*', array('id=?' => $request['demand_id']), '', 1);
        if (empty($demand_info)) {
            return self::request('error', '', "需求id错误");
        }
        $offer_info = Data_Mysql_Table_Demand_Offer::select('*', array('demand_id=?' => $request['demand_id']), '', 1);
        if (empty($offer_info)) {
            $rs = Data_Mysql_Table_Demand_Offer::insert($data);
            $_offer_id = $rs[0];
        } else {
            //如果是修改的话  就修改需求表  //不影响需求表20151109
            /**
             * $demand_info[0]['demand'] = json_decode( $demand_info[0]['demand'],1);
             * $demand_info[0]['demand']['活动人数']=$request['search']['start_people'].'-'.$request['search']['end_people'];
             * $demand_info[0]['demand']['price_up']=$request['search']['start_price'];
             * $demand_info[0]['demand']['price_down']=$request['search']['end_price'];
             * $data_demand = array(
             * 'city' => $request['search']['city'],
             * 'update_time' =>time(),
             * 'price_up' => $request['search']['start_price'],          //最低价
             * 'price_down' => $request['search']['end_price'],
             * 'demand' =>  $demand_info[0]['demand'],//最高价
             * );
             **/
            Data_Mysql_Table_Demand::update(array('id=?' => $request['demand_id']), array(
                'city' => $request['search']['city'],
            ));
            //删除所有匹配中未发送短信的
            $args_data = array(
                'demand_id' => $offer_info[0]['demand_id'],
                'offer_id' => $offer_info[0]['id'],
                'create_time' => $offer_info[0]['create_time'],
            );
            Api_Demand_Offer_Match_Result_Insert::deleteResult($args_data);
            $rs = Data_Mysql_Table_Demand_Offer::update(array('id=?' => $offer_info[0]['id']), $data);
            $_offer_id = $offer_info[0]['id'];
        }

        if ($rs) {
            Api_Demand_Offer_Send_SMS_Customer::cron(array('type' => 'create', 'demand_id' => $request['demand_id']));
            return self::request('success', $_offer_id, "添加报价系统主表成功40!");
        } else {
            return self::request('error', '', "插入数据失败42!");
        }
    }

    /**
     * @param $args
     * @创建需求报价
     * @return array
     */
    static function create($args)
    {
        $request = Func_Input::filter(array(
            'demand_id' => 'int',
        ), $args);
        if (empty($request['demand_id'])) {
            return Api::request('error', '', '参数缺失');
        }
        $demand_info = Data_Mysql_Table_Demand::select('demand', array('id=?' => $request['demand_id']));
        if (empty($demand_info[0])) {
            return Api::request('error', '', '没有找到数据');
        }
        $demand = json_decode($demand_info[0]['demand'], 1);
        $tagsId = array();
        if ($demand['活动标签']) {
            //处理存在的标签
            $tagsArray = implode(',', $demand['活动标签']);
            if (!is_array($tagsArray)) {
                $tagsArray = array(
                    $demand['活动标签']
                );
            }
            $tagsData = Data_Mysql_Table_Demand_Tag::convertKey($tagsArray);
            if ($tagsData) {

                foreach ($tagsData as $key => $val) {
                    $tagsId[$val['id']] = 3;
                }
            }
        }

        $people = explode('-', $demand['活动人数']);
        $demand_filter = array(
            'start_price' => @intval($demand['price_up']),
            'end_price' => @intval($demand['price_down']),
            'start_people' => @intval($people[0]),
            'end_people' => @intval($people[1]),
            'city' => @$demand['活动城市'],
            'tags' => $tagsId,
        );
        $data = array(
            'demand_id' => $request['demand_id'],
            'demand_filter' => $demand_filter
        );
        //插入报价系统
        $rs = Data_Mysql_Table_Demand_Offer::insert($data);
        //通知报价人员
        Api_Demand_Notice_V2::adminNoticeDemandOffer($request['demand_id'], '');
        return Api::request('success', $rs[0], '成功');
    }
}