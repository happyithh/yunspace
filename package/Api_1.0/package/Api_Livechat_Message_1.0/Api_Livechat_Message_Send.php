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
class Api_Livechat_Message_Send extends Api
{
    /**
     * @param string $args
     *       {
     *       * from_account_id:  [handle: Api_Session::user_id()] ,
     *       * to_account_id:  ,
     *       * message: '' ,
     *       time: ,
     *       media: {
     *                      pic,
     *                      title,
     *                      des,
     *                      url,
     *                  }
     *       }
     * @return array
     *      {
     *
     *      }
     */
    static function handle($args = '')
    {
        Api_Session::checkToken();
        $args['from_account_id'] = Api_Session::user_id();
        return self::handleSendMessage($args);
    }

    /**
     *
     */
    static function handleSendMessage($args)
    {

        $request = Func_Input::filter(array(
            'from_account_id' => 'int',
            'to_account_id' => 'int',
            'message' => 'string',
            'media' => 'array',
        ), $args);

        if (empty($request['from_account_id']) || empty($request['to_account_id']) || (empty($request['message']) && empty($request['media']))) {
            return self::request('error', '', '提交参数不正确或者缺少参数，请检查参数的合法性');
        }
        if (!empty($request['media'])) {
            $media = Func_Input::filter(array(
                'title' => 'string',
                'pic' => 'string',
                'des' => 'string',
                'url' => 'string',
            ), $request['media']);
            if (empty($media['pic'])) {
                return self::request('error', '', '提交的多媒体参数不正确或者缺少参数，请检查参数的合法性');
            }
            $request['message'] = "@media@" . json_encode($media);
            $request['recent_message'] = $media['url'] ? '[链接]' . $media['title'] : '[图片]';
        }


        //TODO: 1.1 需要判断接收人的设置,是否拒收等等, 发送人与接收人的关系等等
        //1.2 群组则判断是否群组成员
        $is_group = Data_Mysql_Table_LiveChat_Group::isGroupId($request['to_account_id']);

        if ($is_group && $request['from_account_id'] > 0 && !Api_Livechat_Group_IsMember::isMember(array(
                'account_id' => $request['from_account_id'],
                'group_id' => $request['to_account_id'],
            ))
        ) {
            return self::request('error', '', '不是群组成员!');
        }
        $message = array(
            'to_account_id' => $request['to_account_id'],
            'from_account_id' => $request['from_account_id'],
            'message' => $request['message'],
            'create_time' => time(),
        );
        $stats = Data_Mysql_Table_LiveChat_Message::insert($message);

        //2. 更新接收人的最新消息列表, Data_Mysql_Table_LiveChat_Message_Recent

        Api_Livechat_Message_Recent::updateMessageRecent(array(
            'to_account_id' => $request['to_account_id'],
            'from_account_id' => $request['from_account_id'],
            'message' => empty($request['recent_message']) ? $request['message'] : $request['recent_message'],
            'update_time' => $message['create_time'],
        ));

        //更新联系人
        //3. 如果不是群组,且双方是陌生人,则需要更新联系人
        if (!$is_group) {
            //添加联系人
            Api_Livechat_Contacts_Add::addContact(
                array(
                    'account_id' => $request['from_account_id'],
                    'contact_account_id' => $request['to_account_id']
                )
            );
            Api_Livechat_Contacts_Add::addContact(
                array(
                    'account_id' => $request['to_account_id'],
                    'contact_account_id' => $request['from_account_id']
                )
            );
        }
        //4.激活一个通知任务 Core::cron(time, class, func, args);  //12/11 zzc
//        Core::cron(10, 'Api_Livechat_Message_Notice', 'handleAllRecentMessageNotice', '', true);
        if (!empty($stats[0])) {

            return Api::request('success',
                array(
                    'id' => $stats[0],
                    'create_time' => $message['create_time'],
                    'format_time' => Func_Time::format($message['create_time'])
                ), '发送成功！');

        }
        return Api::request('error', '', '发送失败！');

    }


}

