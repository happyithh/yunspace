<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/8/27
 * Time: 11:27
 * 供应商竞标
 *
 */
class  Api_Demand_Tender_VendorBid extends Api
{
    /**
     * 1.
     *
     */
    static function  handle($args = '')
    {
        Api_Session::checkToken(1);
        $args['account_info'] = Api_Session::user_info();

        return self::bid($args);
    }

    static function  bid($args)
    {
        $request = Func_Input::filter(array(
            'tender_id' => 'int',
            'product_id' => 'int',
            'type' => 'int',
            'quote' => 'string',
            'scheme' => 'array',
            'account_info' => 'array',
        ), $args);
        if (empty($request['tender_id']) || empty($request['product_id']) || empty($request['type']) || empty($request['scheme'])) {
            return Api::request('error', '', '缺少参数,请您刷新重试~');
        }

        //验证该供应商是否是 我们通知的供应商
        $conditions['t2.id =?'] = $request['tender_id'];
        $table = "{table} as t1 RIGHT JOIN {prefix}demand_tender as t2 ON t1.tender_id = t2.id LEFT JOIN {prefix}demand_tender_matching_product as t3 ON t3.tender_id = t2.id";
//        Data_Mysql_Table_Demand_Tender_Scheme::debug(1);
        $is_repeat = Data_Mysql_Table_Demand_Tender_Scheme::select('t1.id,t1.vendor_account_id,t2.status,t3.vendor_ids', $conditions, '', 1, $table);

        if (empty($is_repeat[0]['vendor_ids']) ||
            !self::checkVendor($is_repeat[0]['vendor_ids'], $request['account_info']['vendor_id'])
        ) {
            return Api::request('error', '', '抱歉，系统没有找到这个活动需求~');
        }

        if ($is_repeat[0]['status'] < 0) {
            return Api::request('error', '', '您提交晚了~该需求已经结束~');
        }

        if (!empty($is_repeat[0]['vendor_account_id']) && $is_repeat[0]['vendor_account_id'] == $request['account_info']['id']) {
            return Api::request('error', '', '您已经提交过报价了，请耐心等候客户回复，谢谢~');
        }

        $insert = $request;
        $insert['scheme'] = $request['scheme'];

        if ($request['type'] == 2) {
            $insert['set_id'] = $request['product_id'];
        } else {
            $insert['product_id'] = $request['product_id'];
        }
        //日志
        Api_Log_Create::handle(array(
            'class' => get_called_class(),
            'func' => __FUNCTION__,
            'tender_id' => $request['tender_id'],
            'behavior' => '商家提交方案'
        ));
        $insert['update_time'] = time();
        $insert['vendor_account_id'] = $request['account_info']['id'];
        $data = Data_Mysql_Table_Demand_Tender_Scheme::insert($insert);
        if (empty($data[0])) {
            return Api::request('error', '', '报价失败~请重试，如有问题请致电400-056-0599');
        }
        Data_Mysql_Table_Demand_Tender::query("UPDATE {table} SET scheme_sum = scheme_sum+1 WHERE id=?", array(
            $request['tender_id']
        ), 1);
        $agent_result = Data_Mysql_Table_Demand_Tender::select("id,demand_id,agent_status",array("id=?"=>$request['tender_id']),'',1);
        if($agent_result[0]['agent_status']==1) {
            //新的报价 直接通知销售（代理人）
            $noticeData = array(
                'tender_id' => $request['tender_id'],
                'title' => "您的需求单(#" . Func_NumEncode::e($request['tender_id']) . ")有一个新的场地报价",
                'content' => "您的需求单有一个新的场地报价,登录管理后台，在我的需求里列表里。点击管理。查看最新报价！",
                'type' => 1,
            );
            Core::log("baojiaxitong", "发送给代理人。有供应商提交报价了",implode(',',$noticeData));
            Api_Demand_Tender_NoticeAgent::NoticeAgentByEmail($noticeData);
        }else{
            Core::log("baojiaxitong", "计划任务，发送给客户。有供应商提交报价了",implode(',',$request['tender_id']));
            Core::cron(30, 'Api_Demand_Tender_NoticeCustomer', 'newSchemeNotice', array(array('tender_id' => $request['tender_id'])));
        }

        return Api::request('success', '', '您的报价已经成功提交，请耐心等候客户确认！');
    }

    static function  checkVendor($vendorIds, $vendor_id)
    {
        $new = array();
        $vendor_ids = json_decode($vendorIds, 1);
        foreach ($vendor_ids as $k => $v) {
            foreach ($v as $vv) {
                $new[] = $vv;
            }
        }
        return in_array($vendor_id, $new);
    }
}