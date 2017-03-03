<?php

/**
 * Created by PhpStorm.
 * User: liuyuping
 * Date: 2015/11/26
 * Time: 14:09
 */

Data_Mysql_Table_Demand_Match_Result::subTable('_201509')->select();
Data_Mysql_Table_Demand_Match_Result::subTable('_201510')->select();
Data_Mysql_Table_Demand_Match_Result::subTable('_201511')->select();
Data_Mysql_Table_Demand_Match_Result::subTable('_201512')->select();

class OA_Demand_Tender_list_Statistics
{
    static function handle()
    {
        $action = empty($_REQUEST['action']) ? 'list' : $_REQUEST['action'];
        switch ($action) {
            case 'list':
                self::handleDemandOfferListCount();
                break;
            case 'list_v2':
                self::handleDemandOfferListCountV2();
                break;
            case 'list_v3':
                self::handleDataStatistics();
                break;
            case 'ajax':
                self::handleAjax();
                break;
            case 'list_v3_detail':
                self::handleV3Detail();
                break;
            case 'ajaxnew':
                self::handleAjaxNew();
                break;

        }

    }

    static function  handleAjax()
    {
        Core::output('');
        $rquest = Func_Input::filter(array(
            'type' => 'string',
            'time' => 'int',
        ), $_REQUEST);

        $return = array('legend_data' => '', 'series_data' => '', 'xAxis_data' => '');

        //需求报价数量
        if ($rquest['type'] == 'demand') {

            $data = Data_Mysql_Table_Demand_Offer::select(" COUNT(*) as c ,from_unixtime(create_time,'%m-%d') as day", array('create_time >?'=>strtotime('-1 month')), "GROUP BY day", 7);

            $legend_data = '需求报价数量';
            $count = array();
            $time = array();
            foreach ($data as $k => $val) {
                $count[] = $val['c'];
                $time[] = $val['day'];
            }
            $return = array('legend_data' => $legend_data, 'series_data' => $count, 'xAxis_data' => $time);

            Func_Output::json('success', $return, '1');

        }
        $data = Data_Mysql_Table_Demand_Offer::select("*,from_unixtime(create_time,'%m-%d') as day", '', "", 999);
        $demand_ids = array();
        foreach ($data as $k => $val) {
            $dataYM[] = date('Ym', $val['create_time']);
            $demand_ids[] = $val['demand_id'];
        }

//        //电话交换量
//        if ($return['type'] == 'changePhone') {
//
//            $union = Data_Mysql_Table_Demand_Match_Result::HandleSubSql(implode(',', $dataYM), '*');
//            $sql = 'SELECT * FROM ( ' . $union . ' )  t  WHERE demand_id IN (' . implode(',', $demand_ids) . ') ';
//            $match_data = Data_Mysql_Table_Demand_Match_Result::query($sql, '', 1);
//        }

    }
    //新的报价统计曲线图数据调用
    static function handleAjaxNew(){
        Core::output('');
        $rquest = Func_Input::filter(array(
            'type' => 'string',
            'time' => 'int',
        ), $_REQUEST);

        $return = array('legend_data' => '', 'series_data' => '', 'xAxis_data' => '');
        /**需求订单数量
         *根据demand_offer表的id求和（count(*)）
         */
        if ($rquest['type'] == 'demand_num') {
            $data = Data_Mysql_Table_Demand_Offer::select(" COUNT(*) as c ,from_unixtime(create_time,'%m-%d') as day", array('create_time >?'=>strtotime('-1 month')), "GROUP BY day", 7);
            $legend_data = '需求订单数';
            $count = array();
            $time = array();
            foreach ($data as $k => $val) {
                $count[] = $val['c'];
                $time[] = $val['day'];
            }
            $return = array('legend_data' => $legend_data, 'series_data' => $count, 'xAxis_data' => $time);

            Func_Output::json('success', $return, '1');
        }elseif($rquest['type'] == 'order_all_num'){
            /**客户打开超过3次订单数
             *客户浏览数量view_count_c大于2的求和
             */
            $conditions['view_count_c >?'] = 2;
            $conditions['create_time >?'] = strtotime('-1 month');
           // Data_Mysql_Table_Demand_Offer::debug();
            $data = Data_Mysql_Table_Demand_Offer::select("count(*) as c,from_unixtime(create_time,'%m-%d') as day", $conditions, "GROUP BY day", 7);
            $legend_data = '客户打开超过3次订单数';
            $count = array();
            $time = array();
            foreach ($data as $k => $val) {
                $count[] = intval($val['c']);
                $time[] = $val['day'];
            }
         //   q($count);
            $return = array('legend_data' => $legend_data, 'series_data' => $count, 'xAxis_data' => $time);
            Func_Output::json('success', $return, '1');
        }elseif($rquest['type'] == 'c_all_num'){
            /**客户打开总次数
             *客户浏览数量view_count_c大于0值求总数值sum(view_count_c)
             */
            $conditions['view_count_c >?'] = 0;
            $conditions['create_time >?'] = strtotime('-1 month');
            $data = Data_Mysql_Table_Demand_Offer::select("sum(view_count_c) as b,from_unixtime(create_time,'%m-%d') as day", $conditions, "GROUP BY day", 7);
            $legend_data = '客户打开总次数';
            $count = array();
            $time = array();
            foreach ($data as $k => $val) {
                $count[] = intval($val['b']);
                $time[] = $val['day'];
            }
            $return = array('legend_data' => $legend_data, 'series_data' => $count, 'xAxis_data' => $time);
            Func_Output::json('success', $return, '1');
        }elseif($rquest['type'] == 'c_order_num'){
            /**客户未打开订单数
             *客户浏览数量view_count_c等于0求和
             */
            $conditions['view_count_c =?'] = 0;
            $conditions['create_time >?'] = strtotime('-1 month');
            $data = Data_Mysql_Table_Demand_Offer::select("count(view_count_c) as c,from_unixtime(create_time,'%m-%d') as day", $conditions, "GROUP BY day", 7);
            $legend_data = '客户未打开订单数';
            $count = array();
            $time = array();
            foreach ($data as $k => $val) {
                $count[] = intval($val['c']);
                $time[] = $val['day'];
            }
            $return = array('legend_data' => $legend_data, 'series_data' => $count, 'xAxis_data' => $time);
            Func_Output::json('success', $return, '1');
        }elseif($rquest['type'] == 'v_all_num'){
            /**商家打开总次数
             *商家浏览数量view_count_V大于0值求总数值sum(view_count_v)
             */
            $conditions['view_count_v >?'] = 0;
            $conditions['create_time >?'] = strtotime('-1 month');
            $data = Data_Mysql_Table_Demand_Offer::select("sum(view_count_v) as b,from_unixtime(create_time,'%m-%d') as day", $conditions, "GROUP BY day", 7);
            $legend_data = '商家打开总次数';
            $count = array();
            $time = array();
            foreach ($data as $k => $val) {
                $count[] =intval($val['b']);
                $time[] = $val['day'];
            }
            $return = array('legend_data' => $legend_data, 'series_data' => $count, 'xAxis_data' => $time);
            Func_Output::json('success', $return, '1');
        }elseif($rquest['type'] == 'notice_num'){
            /** 通知总次数
             *通知时间notice_time不为空的求合
             */
            $conditions[] = 'notice_time != 0';
            $conditions['create_time >?'] = strtotime('-1 month');
            $data = Data_Mysql_Table_Demand_Offer::select("count(notice_time) as c,from_unixtime(create_time,'%m-%d') as day", $conditions, "GROUP BY day", 7);
            $legend_data = '通知总次数';
            $count = array();
            $time = array();
            foreach ($data as $k => $val) {
                $count[] =$val['c'];
                $time[] = $val['day'];
            }
            $return = array('legend_data' => $legend_data, 'series_data' => $count, 'xAxis_data' => $time);
            Func_Output::json('success', $return, '1');
        }
        $conditions['demand_id >?']=0;
        $B = Data_Mysql_Table_Demand_Offer::select("demand_id,create_time", $conditions, '', 9999);
        $demand_ids = array();      //需求ID
        if(!empty($B)){
            foreach($B as $k => $v){
                $demand_ids[] = $v['demand_id'];
                $dataYM[] = date("Ym", $v['create_time']);
            }
           // $dataYM[] = date("Ym", $v['create_time']);
            $dataYM = array_unique($dataYM);
        }

        foreach ($dataYM as $k => $val) {
            $dataYM[$k] = 'demand_match_result_' . $val;
        }

        if($rquest['type'] == 'change_num'){
            /** 交换电话订单数
             *交换联系方式时间change_phone_time不为空的求和
             */
            $union = Data_Mysql_Table_Demand_Match_Result::HandleSubSql(implode(',', $dataYM), '*');
            $sql = 'SELECT count(t.change_phone_time) AS c,from_unixtime(s.create_time,"%m-%d") as day FROM ( ' . $union . ' )  t LEFT JOIN yun_demand_offer as s ON t.demand_id=s.demand_id WHERE t.change_phone_time != 0 AND s.create_time >'.strtotime('-1 month').' order by s.create_time ';
            $match_data = Data_Mysql_Table_Demand_Match_Result::query($sql, '', 1);

            $legend_data = '交换电话订单数';
            $count = array();
            $time = array();
            foreach ($match_data as $k => $val) {
                $count[] =($val['c']);
                $time[] = $val['day'];
            }
            $return = array('legend_data' => $legend_data, 'series_data' => $count, 'xAxis_data' => $time);
            Func_Output::json('success', $return, '1');
        }elseif($rquest['type'] == 'merchant_num'){
            /** 无商家响应订单数
             *商家报价时间offer_time不为空求和
             */
            $union = Data_Mysql_Table_Demand_Match_Result::HandleSubSql(implode(',', $dataYM), '*');
            $sql = 'SELECT count(*) AS c,from_unixtime(s.create_time,"%m-%d") as day FROM ( ' . $union . ' )  t LEFT JOIN yun_demand_offer as s ON t.demand_id=s.demand_id WHERE t.offer_time = 0 AND s.create_time >'.strtotime('-1 month').' order by s.create_time ';
           $match_data = Data_Mysql_Table_Demand_Match_Result::query($sql, '', 1);

            $legend_data = '无商家响应订单数';
            $count = array();
            $time = array();
            foreach ($match_data as $k => $val) {
                $count[] =($val['c']);
                $time[] = $val['day'];
            }
            $return = array('legend_data' => $legend_data, 'series_data' => $count, 'xAxis_data' => $time);
            Func_Output::json('success', $return, '1');
        }elseif($rquest['type'] == 'change_all_num'){
            /** 交换电话总数
             *交换联系方式时间change_phone_time不为空求和
             */
            $union = Data_Mysql_Table_Demand_Match_Result::HandleSubSql(implode(',', $dataYM), '*');
            $sql = 'SELECT count(change_phone_time) AS c,from_unixtime(offer_time,"%m-%d") as day FROM ( ' . $union . ' )  t  WHERE change_phone_time != 0 and demand_id IN (' . implode(',', $demand_ids) . ') AND offer_time >'.strtotime('-1 month').' order by offer_time ';

            $match_data = Data_Mysql_Table_Demand_Match_Result::query($sql, '', 1);

            $legend_data = '交换电话总数';
            $count = array();
            $time = array();
            foreach ($match_data as $k => $val) {
                $count[] =($val['c']);
                $time[] = $val['day'];
            }
            $return = array('legend_data' => $legend_data, 'series_data' => $count, 'xAxis_data' => $time);
            Func_Output::json('success', $return, '1');
        }elseif($rquest['type'] == 'offer_num'){
            /** 报价总数
             *报价相关信息offer_info不为空求和
             */
            $union = Data_Mysql_Table_Demand_Match_Result::HandleSubSql(implode(',', $dataYM), '*');
            $sql = 'SELECT count(offer_info) AS c,from_unixtime(offer_time,"%m-%d") as day FROM ( ' . $union . ' )  t  WHERE offer_info is not null and demand_id IN (' . implode(',', $demand_ids) . ') AND offer_time >'.strtotime('-1 month').' order by offer_time ';
            $match_data = Data_Mysql_Table_Demand_Match_Result::query($sql, '', 1);

            $legend_data = '报价总数';
            $count = array();
            $time = array();
            foreach ($match_data as $k => $val) {
                $count[] =($val['c']);
                $time[] = $val['day'];
            }
            $return = array('legend_data' => $legend_data, 'series_data' => $count, 'xAxis_data' => $time);
            Func_Output::json('success', $return, '1');
        }


    }

    /**
     * 报价数据统计
     *
     * 需求订单量    拓展量    推荐量    订单关闭量
     *
     * 客户浏览量    商户浏览量    电话交换量
     *
     */
    static function  handleDemandOfferListCount()
    {
        @session_start();
        if (!empty($_REQUEST['search'])) {
            $search = Func_Input::filter(array(
                'account_id' => 'int',
                'start_time' => 'string',
                'end_time' => 'string',
                'city' => 'string',
            ), $_REQUEST['search']);
            if (!empty($search['account_id'])) {
                $conditions["account_id=?"] = $search['account_id'];
            }
            if (!empty($search['city'])) {
                $conditions['city =?'] = $search['city'];
            }
            if (!empty($search['start_time']) && !empty($search['end_time'])) {
                if (strtotime($search['start_time']) > strtotime($search['end_time'])) {
                    Func_Header::back('请正确选择时间范围！！');
                } else {
                    $conditions['create_time between ? and ?'] = array(strtotime($search['start_time']), strtotime($search['end_time']));
                }
            } elseif (!empty($search['start_time']) && empty($search['end_time'])) {
                $start_time = strtotime($search['start_time']);

                $conditions['create_time > ?'] = $start_time;
            } elseif (empty($search['start_time']) && !empty($search['end_time'])) {
                $end_time = strtotime($search['end_time']);

                $conditions['create_time < ?'] = $end_time;
            }
        } else {
            $start_time = strtotime('-1 week');
            //默认是一周
            $conditions['create_time >?'] = strtotime('-1 week');
        }
        $conditions['demand_id >?'] = 0;

        $B = Data_Mysql_Table_Demand_Offer::select("admin_id,demand_id,id,view_count_c,view_count_v,status,create_time", $conditions, '', 9999);
        $demand_ids = array();      //需求ID
        $admin_ids = array();       //负责人ID
        $close = 0;
        $close_ids = array();
        $dataYM = array();
        $customer_view_sum = 0;     //客户浏览量
        $vendor_view_sum = 0;     //商家浏览量
        foreach ($B as $k => $val) {
            if ($val['status'] < 0) {
                $close++;
                $close_ids[] = $val['demand_id'];
            }
            if ($val['view_count_c']) {
                $customer_view_sum = $customer_view_sum + intval($val['view_count_c']);
            }

            $demand_ids[] = $val['demand_id'];
            $admin_ids[] = $val['admin_id'];
            $dataYM[] = date("Ym", $val['create_time']);
        }
        /**需求订单量**/
        $data['offer_sum'] = count($B);
        /**客户浏览量***/
        $data['customer_view_sum'] = $customer_view_sum;

        /**订单关闭量**/
        $data['close_sum'] = $close;

        /**拓展量**/

        //拓展场地数据
        $administratorAccount = Api_Administrator_GetBaseAccountInfo::getBastAccountInfo(array('admin_id' => $_SESSION['administrator']['id']));
        if (!empty($administratorAccount['account_id'])) {
            $account_id = $administratorAccount['account_id'];
        }
        $expand_data = Data_Mysql_Table_Account_Log::selectAll(array(
            'dateYM' => $dataYM,
            'operate_type' => '拓展场地数据',
            'admin_id' => $_SESSION['administrator']['id'],
            'account_id' => $account_id,
            'start_time' => @$start_time,
            'end_time' => @$end_time,
        ));
        $data['expand_sum'] = @count($expand_data);

        foreach ($dataYM as $k => $val) {
            $dataYM[$k] = 'demand_match_result_' . $val;
        }

        $recommend_sum = 0;

        $change_phone_sum = 0;

        $union = Data_Mysql_Table_Demand_Match_Result::HandleSubSql(implode(',', $dataYM), '*');
        $sql = 'SELECT * FROM ( ' . $union . ' )  t  WHERE demand_id IN (' . implode(',', $demand_ids) . ') ';

        $match_data = Data_Mysql_Table_Demand_Match_Result::query($sql, '', 1);
        $isset_demand_id = array_flip($demand_ids);

        $pageDemand = array();
        foreach ($match_data as $k => $val) {

            if ($val['notice_time'] > 1) {
                $recommend_sum = ($recommend_sum + 1);
            }
            if ($val['hits']) {
                $vendor_view_sum = ($vendor_view_sum + intval($val['hits']));
            }
            if ($val['change_phone_time'] > 0) {
                $change_phone_sum = ($change_phone_sum + 1);
            }

            //需求ID	拓展量	推荐量	客户浏览量	商户浏览量	电话交换量	状态
            if (is_numeric($isset_demand_id[$val['demand_id']])) {

                if ($val['change_phone_time'] > 0) {
                    $pageDemand[$val['demand_id']]['change_phone_sum'] = @intval($pageDemand[$val['demand_id']]['change_phone_sum']) + 1;
                }
                $pageDemand[$val['demand_id']]['recommend_sum'] = @intval($pageDemand[$val['demand_id']]['recommend_sum']) + 1;
                $pageDemand[$val['demand_id']]['vendor_view_sum'] = @intval($pageDemand[$val['demand_id']]['vendor_view_sum']) + $val['hits'];
            }
        }
        if (!empty($expand_data)) {

            foreach ($expand_data as $k => $val) {
                if (@is_numeric($isset_demand_id[$val['object_id']])) {
                    $pageDemand[$val['object_id']]['expand_sum'] = @intval($pageDemand[$val['object_id']]['expand_sum']) + 1;
                }
            }
        }
        /**商家浏览量**/
        $data['vendor_view_sum'] = $vendor_view_sum;

        /**推荐量**/
        $data['recommend_sum'] = $recommend_sum;
        /***电话交换量**/
        $data['change_phone_sum'] = $change_phone_sum;
        Tpl_Smarty::assign('data', $data);
        Tpl_Smarty::assign('demand', $B);
        Tpl_Smarty::assign('other', $pageDemand);
        Tpl_Smarty::assign('status', Data_Mysql_Table_Demand_Offer::$_status);

        Tpl_Smarty::display('OA_Static::demands_tender/demand_tender_list_statistics.tpl');

    }

    /**
     * 比例统计
     */
    static function handleDemandOfferListCountV2()
    {

        $yesterdayIndex = Api_Demand_Offer_Count::yesterdayIndex('');
        Tpl_Smarty::assign('yesterdayIndex', $yesterdayIndex);
        Tpl_Smarty::display('OA_Static::demands_tender/demand_tender_list_statistics.v2.tpl');


    }

    /**
     * 新的数据统计
     */
    static function  handleDataStatistics(){
            $conditions['demand_id >?']=0;
        $B = Data_Mysql_Table_Demand_Offer::select("*", $conditions, '', 9999);
            $dataYM =array();
        $demand_ids = array();
        $data =array();
              if(!empty($B)){
            foreach($B as $k => $val){
                /**客户打开超过3次订单数*/
                if(!empty($val['view_count_c']) && $val['view_count_c'] >2){
                    $data[$val['demand_id']]['order_all_num']= @intval($data[$val['demand_id']]['order_all_num']) +1;
                }
                /**客户打开总次数*/
                if(!empty($val['view_count_c'])){
                    $data[$val['demand_id']]['c_all_num']= @intval($data[$val['demand_id']]['c_all_num']) + $val['view_count_c'];
                }
                /**客户未打开订单数*/
                if(empty($val['view_count_c'])){
                    $data[$val['demand_id']]['c_order_num']= @intval($data[$val['demand_id']]['c_order_num']) +1;
                }
                /**商家打开总次数*/
                if(!empty($val['view_count_v'])){
                    $data[$val['demand_id']]['v_all_num']= @intval($data[$val['demand_id']]['v_all_num']) + $val['view_count_v'];
                }
                /**通知总次数*/
                if(!empty($val['notice_time'])){
                    $data[$val['demand_id']]['notice_num']= @intval($data[$val['demand_id']]['notice_num']) +1;
                }
                $demand_ids[] =$val['demand_id'];
                $dataYM[] = date("Ym", $val['create_time']);
                $data[$val['demand_id']]['demand_num']= @intval($data[$val['demand_id']]['demand_num']) +count($val['demand_id']);
            }
        }

        if(!empty($dataYM)){
            $dataYM = array_unique($dataYM);
            foreach ($dataYM as $k => $val) {
                $dataYM[$k] = 'demand_match_result_' . $val;
            }
        }
        $union = Data_Mysql_Table_Demand_Match_Result::HandleSubSql(implode(',', $dataYM), '*');
        $sql = 'SELECT * FROM ( ' . $union . ' )  t  WHERE demand_id IN (' . implode(',', $demand_ids) . ') ';
        $match_data = Data_Mysql_Table_Demand_Match_Result::query($sql, '', 1);
        if(!empty($match_data)){
            foreach($match_data as $key => $val){
                /**交换电话订单数*/
                /**交换电话总数*/
                if(!empty($val['change_phone_time'])){
                    $data[$val['demand_id']]['change_num']= @intval($data[$val['demand_id']]['change_num']) +1;
                    $data[$val['demand_id']]['change_all_num']= @intval($data[$val['demand_id']]['change_all_num']) +1;

                }
                 /**无商家响应订单数*/
                if(empty($val['offer_time'])){
                    $data[$val['demand_id']]['merchant_num']= @intval($data[$val['demand_id']]['merchant_num']) +1;

                }
                 /**报价总数*/
                if(!empty($val['offer_info'])){
                    $data[$val['demand_id']]['offer_num']= @intval($data[$val['demand_id']]['offer_num']) +1;
                }
            }
        }
       // Data_Mysql_Table_Demand_Offer::debug(1);
        $cons['demand_id >?'] = '0';
        $demand = Data_Mysql_Table_Demand_Offer::page('',10,'*',$cons,'group by demand_id order by create_time');
    //  q($demand);
        Tpl_Smarty::assign('data_num',$data);
        Tpl_Smarty::assign('data_offer',$demand);
        Tpl_Smarty::assign('status', Data_Mysql_Table_Demand_Offer::$_status);
        Tpl_Smarty::display('OA_Static::demands_tender/demand_tender_list_statistics.v3.tpl');
    }

    /**统计详情页面*/
    static function handleV3Detail(){
        $requert = Func_Input::filter(array(
            'demand_id' => 'int',
        ), $_REQUEST);
        $conditions['t1.demand_id =?']=$requert['demand_id'];
        $table ="{table} as t1 LEFT JOIN {prefix}demand as t2 on t1.demand_id =t2.id";
        $B = Data_Mysql_Table_Demand_Offer::select("t1.*,t2.demand_name,t2.phone", $conditions, '',99,$table);
        $dataYM =array();
        $demand_ids = array();
        $data =array();
        if(!empty($B)){
            foreach($B as $k => $val){
                /**客户打开超过3次订单数*/
                if(!empty($val['view_count_c']) && $val['view_count_c'] >2){
                    $data[$val['demand_id']]['order_all_num']= @intval($data[$val['demand_id']]['order_all_num']) +1;
                }
                /**客户打开总次数*/
                if(!empty($val['view_count_c'])){
                    $data[$val['demand_id']]['c_all_num']= @intval($data[$val['demand_id']]['c_all_num']) + $val['view_count_c'];
                }
                /**客户未打开订单数*/
                if(empty($val['view_count_c'])){
                    $data[$val['demand_id']]['c_order_num']= @intval($data[$val['demand_id']]['c_order_num']) +1;
                }
                /**商家打开总次数*/
                if(!empty($val['view_count_v'])){
                    $data[$val['demand_id']]['v_all_num']= @intval($data[$val['demand_id']]['v_all_num']) + $val['view_count_v'];
                }
                /**通知总次数*/
                if(!empty($val['notice_time'])){
                    $data[$val['demand_id']]['notice_num']= @intval($data[$val['demand_id']]['notice_num']) +1;
                }
                $dataYM[] = date("Ym", $val['create_time']);
                $data[$val['demand_id']]['demand_num']= @intval($data[$val['demand_id']]['demand_num']) +count($val['demand_id']);
            }
        }
        if(!empty($dataYM)){
            $dataYM = array_unique($dataYM);
            foreach ($dataYM as $k => $val) {
                $dataYM[$k] = 'demand_match_result_' . $val;
            }
        }
        $union = Data_Mysql_Table_Demand_Match_Result::HandleSubSql(implode(',', $dataYM), '*');
        $sql = 'SELECT * FROM ( ' . $union . ' )  t  WHERE demand_id = '.$requert['demand_id'];
        $match_data = Data_Mysql_Table_Demand_Match_Result::query($sql, '', 1);
        if(!empty($match_data)){
            foreach($match_data as $key => $val){
                /**交换电话订单数*/
                /**交换电话总数*/
                if(!empty($val['change_phone_time'])){
                    $data[$val['demand_id']]['change_num']= @intval($data[$val['demand_id']]['change_num']) +1;
                    $data[$val['demand_id']]['change_all_num']= @intval($data[$val['demand_id']]['change_all_num']) +1;

                }
                /**无商家响应订单数*/
                if(empty($val['offer_time'])){
                    $data[$val['demand_id']]['merchant_num']= @intval($data[$val['demand_id']]['merchant_num']) +1;

                }
                /**报价总数*/
                if(!empty($val['offer_info'])){
                    $data[$val['demand_id']]['offer_num']= @intval($data[$val['demand_id']]['offer_num']) +1;
                }
            }
        }
        Tpl_Smarty::assign('status', Data_Mysql_Table_Demand_Offer::$_status);
        Tpl_Smarty::assign('data',$data);
        Tpl_Smarty::assign('demand',$B[0]);
        Tpl_Smarty::display('OA_Static::demands_tender/demand_tender_list_detail.v3.tpl');
    }
    static function handleExport()
    {
        $search = Func_Input::filter(array(
            'account_id' => 'int',
            'start_time' => 'string',
            'end_time' => 'string',
            'city' => 'string',
        ), $_REQUEST['search']);
        // q($_REQUEST);
        $conditions = array();
        if (!empty($search['account_id'])) {
            $conditions["t1.account_id=?"] = $search['account_id'];
        }
        if (!empty($search['city'])) {
            $conditions['t1.city =?'] = $search['city'];
        }
        if (!empty($search['start_time']) && !empty($search['end_time'])) {
            if (strtotime($search['start_time']) > strtotime($search['end_time'])) {
                Func_Header::back('请正确选择时间范围！！');
            } else {
                $conditions['t1.create_time between ? and ?'] = array(strtotime($search['start_time']), strtotime($search['end_time']));
            }
        } elseif (!empty($search['start_time']) && empty($search['end_time'])) {
            $conditions['t1.create_time > ?'] = strtotime($search['start_time']);
        } elseif (empty($search['start_time']) && !empty($search['end_time'])) {
            $conditions['t1.create_time < ?'] = strtotime($search['end_time']);
        }
        $table = "{table} as t1 left join {prefix}account as t2 on t1.account_id = t2.id";
        $demand_id = Data_Mysql_Table_Demand::select('t1.id,t2.fullname,t2.phone', $conditions, 'group by t1.id order by t1.create_time DESC', 999, $table);
        if (!empty($demand_id)) {
            foreach ($demand_id as $k => $v) {
                $idss[] = $v['id'];
            }
            $tmp_date = date("Ym");
            //切割出年份
            $tmp_year = substr($tmp_date, 0, 4);
            //切割出月份
            $tmp_mon = substr($tmp_date, 4, 2);
            $tmp_forwardmonth = date("Ym", mktime(0, 0, 0, $tmp_mon - 1, 1, $tmp_year));
            $demandids[] = 't1.demand_id IN(' . implode(',', $idss) . ')';
            $match = " ((SELECT * FROM  yun_demand_match_result_" . $tmp_forwardmonth . " ) union
    (SELECT * FROM  yun_demand_match_result_" . date('Ym') . " )) as  t2 Right JOIN {table} as t1 ON t2.demand_id = t1.demand_id";
            $staticname = Data_Mysql_Table_Demand_Offer::select('COUNT(t2.notice_time) as notice_num,COUNT(t2.change_phone_time) as change_num,COUNT(t1.demand_id) AS id_num,SUM(t1.view_count_c) AS c_num ,SUM(t1.view_count_v) AS v_num', $demandids, '', 1, $match);
            $statusids['status'] = '-1';
            $statusids[] = 'demand_id IN(' . implode(',', $idss) . ')';
            $status = Data_Mysql_Table_Demand_Offer::select('count(*) as sta_num', $statusids, '');

            if (!empty($staticname)) {
                foreach ($staticname as $k => $v) {
                    if (!empty($status)) {
                        $staticname[$k]['sta_num'] = $status[0]['sta_num'];
                    }
                }
            }
            //q($staticname);
            if (!empty($staticname)) {

                $cols = array('客户名称', '联系方式', '需求订单量', '拓展量', '推荐量', '订单关闭量', '客户浏览量', '商户浏览量', '电话交换量');
                $list = array();
                foreach ($staticname as $k => $v) {
                    $list[$k][] = !empty($demand_id[0]['fullname']) ? $demand_id[0]['fullname'] : '全部';
                    $list[$k][] = !empty($demand_id[0]['phone']) ? $demand_id[0]['phone'] : '无';
                    $list[$k][] = !empty($v['id_num']) ? $v['id_num'] : 0;
                    $list[$k][] = !empty($v['sta_num']) ? $v['sta_num'] : 0;
                    $list[$k][] = !empty($v['notice_num']) ? $v['notice_num'] : 0;
                    $list[$k][] = 0;
                    $list[$k][] = !empty($v['c_num']) ? $v['c_num'] : 0;
                    $list[$k][] = !empty($v['v_num']) ? $v['v_num'] : 0;
                    $list[$k][] = !empty($v['change_num']) ? $v['change_num'] : 0;
                }

                $res = Func_Csv::writeRow($cols, $list, '需求报价统计');
                Func_Header::back('导出数据成功！！');
            } else {
                Func_Header::back("没有数据！！");
            }
        }
    }
}