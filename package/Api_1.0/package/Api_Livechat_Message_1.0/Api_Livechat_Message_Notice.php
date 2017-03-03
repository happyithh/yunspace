<?php

/**
 * 接口
 * 提醒用户他有几条未读消息 ()
 * 1. 读取最新消息表中的未读>0, 且未通知的消息来源
 * 2. 发送通知
 *      2.1  微信
 *      2.2  App
 *      2.3  如果两者都没激活, 则发短信
 */
class Api_Livechat_Message_Notice extends Api
{
    /**
     * @param string $args
     *       {
     *       * to_account_id: [handle: Api_Session::user_id()],
     *       }
     * @return array
     *      {
     *
     *      }
     */
//    static function handle($args = '')
//    {
//        Api_Session::checkToken();
//        $args['to_account_id'] = Api_Session::user_id();
//        return self::handleSendNotice($args);
//
//    }
    /**
     * 指处理所有5分钟内未通知的新消息
     */
    static function handleAllRecentMessageNotice()
    {
        $rs = Data_Mysql_Table_LiveChat_Message_Recent::select('to_account_id, sum(total) as total', array(
            'is_notice' => 0,
            'update_time > ?' => time() - 600,
        ), 'GROUP BY to_account_id', 10);
        if (empty($rs)) {
            return false;
        }
        foreach ($rs as $r) {
            if ($r['total'] > 0) {
                self::sendRecentMessageNotice($r);
            }
        }
    }

    /**
     * 根据 to_account_id 来提醒, 接收者才需要提醒.
     */
    static function sendRecentMessageNotice($args)
    {
        $request = Func_Input::filter(array(
            'to_account_id' => 'int',
            'total' => 'int',
        ), $args);
        if (!$request['total']) {
            // 读取  to_account_id 对应的所有未提醒过的未读消息条数
            $rs = Data_Mysql_Table_LiveChat_Message_Recent::select('sum(total) as total', array(
                'to_account_id' => $request['to_account_id'],
                'is_notice' => 0,
            ));
            $request['total'] = empty($rs[0]['total']) ? 0 : $rs[0]['total'];
        }
        if (!$request['total']) {
            return false;
        }
        $content = '您好，您收到' . $request['total'] . '条未读消息。';
        Data_Mysql_Table_LiveChat_Message_Recent::query('UPDATE {table} SET is_notice = 1 WHERE to_account_id =?', $request['to_account_id']);
        //通知微信
        $sendSms = false;
        $accountInfo = Api_Account_GetBaseInfo::getBaseInfoById(array('account_id' => $request['to_account_id']));
        if (!empty($accountInfo['openid'])) {
            $loginUrl = Api_Get_Login_DWZ::getLoginLink(array(
                'account_id' => $request['to_account_id'],
                'access_url' => "http://" . Core::$urls['host'] . '/m/chat/?index=0',
                'overdue_time' => '60',
                'is_get_auth_code' => 0,
            ));
            Api_Wechat_Notice_Push::handleNewMsg(array(
                'to_openid' => $accountInfo['openid'],
                'content' => $content,
                'url' => $loginUrl['data'],
            ));
            $sendSms = true;
        }
        $sendSms = Api_Mobile_Push::appPush(array(
            'to_account_id' => $request['to_account_id'],
            'content' => $content,
            'total' => $request['total']
        ));
        //通知短信
        if (0 && !$sendSms && !empty($accountInfo['phone'])) {
            //生成临时免登录地址
            $loginUrl = Api_Get_Login_DWZ::getLoginLink(array(
                'account_id' => $request['to_account_id'],
                'access_url' => "http://" . Core::$urls['host'] . '/m/chat/?index=0',
                'overdue_time' => '30',
            ));
            //【云SPACE】您收到{1}条未读消息,请前往云SPACE查看:{2}   //12月11日  zzc注释的
//            Func_Message::sendSMS($accountInfo['phone'], array($request['total'], $loginUrl['data']), 28205);
        }
    }
}

