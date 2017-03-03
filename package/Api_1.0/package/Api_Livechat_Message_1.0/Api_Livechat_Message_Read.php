<?php

/**
 * 接口
 * 读取聊天双方的消息列表 Data_Mysql_Table_LiveChat_Message
 * 1. from_account_id =account_id OR  to_account_id  = account_id
 * 2. 更新Recent表, 修改 未读条数为0
 */
class Api_Livechat_Message_Read extends Api
{
    /**
     * @param string $args
     *       {
     *       * from_account_id:  [handle: Api_Session::user_id()] ,  //聊天参与者本人
     *       * to_account_id:   ,  //聊天对象
     *       time_before: [time()], //结束时间
     *       time_after: [time()], //开始时间
     *       num: 20-100
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
        return self::handleReadMessage($args);
    }


    /**
     *获取聊天双方用户从time开始的前num条数据
     */
    static function handleReadMessage($args)
    {
        $request = Func_Input::filter(array(
            'to_account_id' => 'int',
            'from_account_id' => 'int',
            'time_before' => 'int',
            'time_after' => 'int',
            'num' => 'int',
        ), $args);
        if (empty($request['to_account_id']) || empty($request['from_account_id'])) {
            return self::request('error', '', "参数缺失！");
        }
        //判断to_account_id是否为群组
        $is_group = Data_Mysql_Table_LiveChat_Group::isGroupId($request['to_account_id']);
        if (!$is_group) {
            $conditions['((from_account_id = ? AND to_account_id = ?) OR ( from_account_id = ? AND to_account_id = ?))'] = array($request['from_account_id'], $request['to_account_id'], $request['to_account_id'], $request['from_account_id']);
        } else {
            //判断from_account_id是不是属于该群组
            $is_member = Api_Livechat_Group_IsMember::isMember(array('account_id' => $request['from_account_id'], 'group_id' => $request['to_account_id']));
            if (!$is_member) {
                return self::request('error', '', "成员不属于该群组！！");
            }
            $conditions['to_account_id'] = $request['to_account_id'];
        }
        //修改Recent 表中的 对应的 total 为0
        if (Api_Session::user_id() == $request['from_account_id']) {
            Data_Mysql_Table_LiveChat_Message_Recent::query('UPDATE {table} SET total = 0 WHERE to_account_id = ? AND from_account_id = ?', array(
                $request['from_account_id'],
                $request['to_account_id']
            ));
        }

        if (!$request['num']) {
            $request['num'] = 10;
        }
        if (!$request['time_before'] && !$request['time_after']) {
            $request['time_before'] = time();
        }
        if ($request['time_after']) {
            if ($request['time_after'] < time() - 18000) {
                $request['time_after'] = time();
            }
            $conditions['create_time > ?'] = $request['time_after'];
            $request['num'] = 10;
            $order = 'ORDER BY id ASC';
        } else {
            $conditions['create_time < ?'] = $request['time_before'];
            $order = 'ORDER BY id DESC';
        }
        $chat_data = Data_Mysql_Table_LiveChat_Message::select('*, from_account_id=' . $request['from_account_id'] . ' AS is_sender', $conditions, $order, $request['num']);
        foreach ($chat_data as $k => $v) {

            if ($v['message'] && substr($v['message'], 0, 7) == '@media@') {
                $chat_data[$k]['message'] = '';
                $chat_data[$k]['media'] = json_decode(substr($v['message'], 7), 1);
            } else {
                if (empty($_REQUEST['user_id']) && empty($_REQUEST['token'])) {
                    $chat_data[$k]['message'] = nl2br($v['message']);
                }
                $chat_data[$k]['media'] = null;
            }
            $chat_data[$k]['format_time'] = Func_Time::format($v['create_time']);
        }
        return self::request('success', $chat_data, "获取当前用户与指定用户的聊天记录");
    }


}

