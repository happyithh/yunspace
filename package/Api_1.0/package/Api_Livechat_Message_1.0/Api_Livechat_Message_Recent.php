<?php

/**
 * 接口
 * 读取指定人的最新消息列表
 * 直接读最新消息表即可, 在前端显示的时候要注意移除重复项 Data_Mysql_Table_LiveChat_Message_Recent
 */
class Api_Livechat_Message_Recent extends Api
{
    /**
     * @param string $args
     *       {
     *       * to_account_id:  [handle: Api_Session::user_id()] ,
     *       num: 20-100 ,
     *       }
     * @return array
     *      {
     *
     *      }
     */
    static function handle($args = '')
    {
        Api_Session::checkToken();
        $userInfo = Api_Session::user_info();
        $args['to_account_id'] = $userInfo['id'];
        $data = self::handleGetRecentList($args);
        //如果是供应商
        if (!empty($userInfo['vendor_id'])) {
            $demand_tender[] = array(
                'from_account_id' => '-2',
                'to_account_id' => $args['to_account_id'],
                'from_name' => '需求报价',
                'message' => '需求报价',
                'total' => 0,
            );
            $data['data'] = array_merge($demand_tender,$data['data']);
        }
        return $data;
    }

    /**
     * 接受用户id。接受用户ID，查找消息列表中联系人聊天列表  Data_Mysql_Table_Live_Chat_Message_List
     */
    static function handleGetRecentList($args)
    {
        $request = Func_Input::filter(array(
            'to_account_id' => 'int',
            'num' => 'int',
        ), $args);
        if (!$request['to_account_id']) {
            $request['to_account_id'] = Api_Session::user_id();
            if (!$request['to_account_id']) {
                return self::request('error', '', "用户未登陆");
            }
        }
        if (!$request['num']) {
            $request['num'] = 20;
        }
        //读取数据并返回
        $recent_msg = Data_Mysql_Table_LiveChat_Message_Recent::select('*', array('to_account_id' => $request['to_account_id']), 'ORDER BY update_time DESC', $request['num']);
        if (empty($recent_msg)) {
            //如果没有任何一条新消息,则向他发送一条初始化系统通知.
            Api_Livechat_Message_SendDefaultMessage::sendSystemNotice1($request['to_account_id']);
            $recent_msg = Data_Mysql_Table_LiveChat_Message_Recent::select('*', array('to_account_id' => $request['to_account_id']), 'ORDER BY update_time DESC', $request['num']);
        }
        if (is_array($recent_msg)) {
            foreach ($recent_msg as $k => $val) {
                $recent_msg[$k]['format_time'] = Func_Time::format($val['update_time']);
            }
        }

        return self::request('success', $recent_msg, "最新消息");

    }

    //更新最新一条消息
    static function updateMessageRecent($args)
    {
        $request = Func_Input::filter(array(
            'to_account_id' => 'int',
            'from_account_id' => 'int',
            'from_name' => 'string',
            'message' => 'text',
            'update_time' => 'int',
        ), $args);
        if (Data_Mysql_Table_LiveChat_Group::isGroupId($request['to_account_id'])) {
            return self::updateGroupMessageRecent($request);
        }
        //TODO： 读取 to_account_id 对 from_account_id 的联系人设置, 以决定是否通知
        $sql = 'INSERT INTO {table} (to_account_id, from_account_id, from_name, message, update_time, total, is_notice)VALUES (?, ?, ?, ?, ?, ?, 0) ON DUPLICATE KEY UPDATE message = ?, update_time = ?, total = total+?, is_notice = 0';
        //接收人需要更新数量
        $r = Data_Mysql_Table_LiveChat_Message_Recent::query($sql, array(
            $request['to_account_id'],
            $request['from_account_id'],
            Api_Account_GetBaseInfo::getSystemNameById($request['from_account_id']),
            $request['message'],
            $request['update_time'],
            1,
            $request['message'],
            $request['update_time'],
            1,
        ), 1);
        if (!empty($r[0]) && $r[0] > 1 && $request['from_account_id'] > 0) {
            $accountInfo = Api_Account_GetBaseInfo::getBaseInfoById(array('account_id' => $request['from_account_id']));
            Data_Mysql_Table_LiveChat_Message_Recent::query('UPDATE {table} SET from_name = ? WHERE id = ?', array(
                $accountInfo['vendor_name'] ? $accountInfo['fullname'] . "({$accountInfo['vendor_name']})" : $accountInfo['fullname'],
                $r[0]
            ));
        }
        //发送人不需要更新数量
        if ($request['from_account_id'] > 0) { //发送人状态的变更仅针对正常用户
            $r = Data_Mysql_Table_LiveChat_Message_Recent::query($sql, array(
                $request['from_account_id'],
                $request['to_account_id'],
                Api_Account_GetBaseInfo::getSystemNameById($request['to_account_id']),
                $request['message'],
                $request['update_time'],
                0,
                $request['message'],
                $request['update_time'],
                0,
            ), 1);
            if (!empty($r[0]) && $r[0] > 1 && $request['to_account_id'] > 0) {
                $accountInfo = Api_Account_GetBaseInfo::getBaseInfoById(array('account_id' => $request['to_account_id']));
                Data_Mysql_Table_LiveChat_Message_Recent::query('UPDATE {table} SET from_name = ? WHERE id = ?', array(
                    $accountInfo['vendor_name'] ? $accountInfo['fullname'] . "({$accountInfo['vendor_name']})" : $accountInfo['fullname'],
                    $r[0]
                ));
            }
        }
    }

    static function updateGroupMessageRecent($request)
    {
//        $request = Func_Input::filter(array(
//            'to_account_id' => 'int',
//            'from_account_id' => 'int',
//            'from_name' => 'string',
//            'message' => 'text',
//            'update_time' => 'int',
//        ), $request);

        $group = Api_Livechat_Group_GetInfo::getGroupInfoById(array(
            'group_id' => $request['to_account_id'],
        ));

        if (empty($group['members'])) {
            return false;
        }
        $sql = 'INSERT INTO {table} (to_account_id, from_account_id, from_name, message, update_time, total, is_notice)VALUES (?, ?, ?, ?, ?, ?, 0) ON DUPLICATE KEY UPDATE message = ?, update_time = ?, total = total+?, is_notice = 0';

        if (!empty($group['members'][$request['from_account_id']])) {
            //发送人不需要更新数量
            if ($request['from_account_id'] > 0) {
                Data_Mysql_Table_LiveChat_Message_Recent::query($sql, array(
                    $request['from_account_id'],
                    $request['to_account_id'],
                    $group['name'],
                    $request['message'],
                    $request['update_time'],
                    0,
                    $request['message'],
                    $request['update_time'],
                    0,
                ));
            }
            unset($group['members'][$request['from_account_id']]);
        } else {
            return false;
        }
        //以group_id 作为 to_account_id 向成员发最新消息
        foreach ($group['members'] as $k => $v) {

            Data_Mysql_Table_LiveChat_Message_Recent::query($sql, array(
                $v['account_id'],
                $request['to_account_id'],
                $group['name'],
                $request['message'],
                $request['update_time'],
                1,
                $request['message'],
                $request['update_time'],
                1,
            ));
        }
    }


    /**
     * 获取供应商的需求报价
     */
    static function   getVendorDemandTender()
    {
//        'to_account_id' => 'int',  //接收人id
//        'from_account_id' => 'int',  //来源id   >0 是用户,  <0 是群组
//        'from_name' => '50',
//        'update_time' => 'int',  //消息更新时间
//        'message' => 'text',
//        'total' => 'tinyint',        //未读消息数
    }

}

