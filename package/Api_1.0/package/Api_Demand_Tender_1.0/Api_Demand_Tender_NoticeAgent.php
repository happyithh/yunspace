<?php

/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2015/10/10
 * Time: 13:53
 * 通知销售代理人（邮件）
 */
class Api_Demand_Tender_NoticeAgent extends Api
{
    /**
     *  通知销售代理人（邮件）
     */
    static function   NoticeAgentByEmail($args)
    {
        $request = Func_Input::filter(array(
            'tender_id' => 'int',
            'demand_id' => 'int',
            'title' => 'string',
            'content' => 'string',
            'type' => 'int', //1表示有新的需求，2表示
        ), $args);
        if (empty($request['tender_id']) && empty($request['demand_id'])) {
            return false;
        }
        if (!empty($request['tender_id'])) {
            $condition = array(
                'id=?' => $request['tender_id']
            );
        }
        if (!empty($request['demand_id'])) {
            $condition = array(
                'demand_id=?' => $request['demand_id']
            );
        }
        $tender_info = Data_Mysql_Table_Demand_Tender::select("*", $condition, '', 1);
        Core::log("baojiaxitong", "代理人发邮件信息第一步",implode(',',$tender_info));
        if (empty($tender_info)) {
            return false;
        }
        if (!empty($tender_info) && isset($tender_info[0]['agent_info'])) {
            $agent_info = json_decode($tender_info[0]['agent_info'], 1);
            if($agent_info['email']){
                Core::log("baojiaxitong", "代理人发邮件信息第二步",$agent_info['email'], $request['title'], $request['content']);
                Func_Mail::send($agent_info['email'], $request['title'], $request['content']);
            }
        } else {
            return false;
        }

    }
}