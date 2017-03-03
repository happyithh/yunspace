<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/8/27
 * Time: 11:18
 */
Class  Api_Demand_Tender_Create extends Api
{
    /**
     *  1.创建一个需求招标
     *  2.
     *
     */
    static function  create($args)
    {
        $request = Func_Input::filter(array(
            'demand_id' => 'int',
            'type'=>'int'
        ), $args);
        $insert = array(
            'demand_id' => $request['demand_id'],
            'update_time' => time(),
        );


        if (empty($request['demand_id'])) {
            return false;
        }
        $is_exist = Data_Mysql_Table_Demand::select('id,phone,admin_id', array('id=?' => $request['demand_id']));
        if (empty($is_exist[0])) {
            return Api::request('error', '', '没有这个需求');
        }
        $agent_info =array();
        //需要添加代理人信息就是这个需求的执行者
            $administratorAccount = Api_Administrator_GetBaseAccountInfo::getBastAccountInfo(array('admin_id'=>$is_exist[0]['admin_id']));
            if(!empty($administratorAccount['account_id'])){
                $agent_info['account_id']  =$administratorAccount['account_id'];
            }
        $agent_info['email'] =  $administratorAccount['email'];
        $agent_info['phone'] =  $administratorAccount['phone'];
        $insert['agent_info'] = $agent_info;
        $insert['agent_status'] = empty($request['type']) ? 0 :$request['type'];
        Core::log("baojiaxitong", "新增报价", $request['demand_id'],implode(',',$insert));
        $data = Data_Mysql_table_Demand_Tender::insert($insert);
        if ($data[0] > 0) {
            //触发匹数据
            Api_Demand_Tender_MatchingProduct::matching(array(
                'demand_id' => $request['demand_id'],
                'tender_id' => $data[0],
            ));
            //创建成功暂时不发给用户，可能选择发送邮件给代理人
            if($insert['agent_status']==1){
                $noticeData = array(
                    'tender_id' => $data[0],
                    'title'=>"需求没有商家提交方案",
                    'content'=>'需求没有商家提交方案：<br>' . '需求ID:' . $request['demand_id'] . '<br>',
                    'type'=>2,
                );
                Core::log("baojiaxitong", "计划任务，通知代理人",implode(',',$noticeData));
                Core::cron(2 * 30 * 60, 'Api_Demand_Tender_NoticeAgent', 'NoticeAgentByEmail',
                    $noticeData);
            }else{
                Core::log("baojiaxitong", "计划任务，一个小时以后通知客户未找到", $is_exist[0]['phone']);
                Core::cron(2 * 30 * 60, 'Api_Demand_Tender_NoticeCustomer', 'noSchemeNotice',
               array(
                   'phone' => $is_exist[0]['phone'],
                   'tender_id' => $data[0]
               ));
            }
            return true;
        }
        return false;
    }
}