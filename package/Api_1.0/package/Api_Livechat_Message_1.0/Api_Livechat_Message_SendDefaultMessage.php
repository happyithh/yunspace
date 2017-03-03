<?php

/**
 * 接口
 * 发送一条消息
 * 1. 消息发送到人,  Data_Mysql_Table_LiveChat_Message
 *      1.1 需要判断接收人的设置,是否拒收等等, 发送人与接收人的关系等等  /  群组则判断是否群组成员
 * 2. 更新接收人的最新消息列表, Data_Mysql_Table_LiveChat_Message_Recent
 * 3. 如果不是群组,且双方是陌生人,则需要更新联系人
 * 4. 激活一个通知任务 Core::cron(time, class, func, args);
 */
class Api_Livechat_Message_SendDefaultMessage extends Api
{
    /**
     * 系统消息1， 新用户引导。
     */
    static function sendSystemNotice1($to_account_id)
    {

        Api_Livechat_Message_Send::handleSendMessage(array(
            'from_account_id' => -1, //系统通知
            'to_account_id' => $to_account_id,
            'message' => "欢迎您使用『云·Space活动定制开放平台』，云·Space为您提供丰富的活动资源和专业的活动方案。
            六步完成您的活动：
            ①、提交您的活动需求；
            ②、云·Space为您推荐适合的场地/配套服务/套餐；
            ③、活动顾问带您实地看场完善活动细节；
            ④、在线下单、签约、支付；
            ⑤、通过云·Space移动端或微信实时跟踪线下准备情况和活动进展，成功举办活动；
            ⑥、完成订单，并填写服务评价。
            云·Space将全程协助您成功的举办活动哦，快来开启您的云·Space之旅吧！",
        ));
    }

    /**
     * 新需求竞标通知
     *
     */
    static function   sendNewDemandTenderNotice($to_account_id)
    {
        Api_Livechat_Message_Send::handleSendMessage(array(
            'from_account_id' => -2,
            'to_account_id' => $to_account_id,
            'message' => '有新的需求竞标',
        ));

    }

}

