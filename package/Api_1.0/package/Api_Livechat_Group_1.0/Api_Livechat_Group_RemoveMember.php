<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/7/6
 * Time: 13:21
 * @群组 删除一个成员
 */
class  Api_Livechat_Group_RemoveMember extends Api
{
    /**
     * 1.需要删除成员的权限
     * 2 根据一个account_id  去删除这个成员
     * 3.删除recent表中的记录
     */

    static function  handle($args = '')
    {
        /**
         * @param string $args
         *       {
         *       * account_id:[ handle Api_Session::user_id()] ,
         *       * group_id: ,
         *       * remove_account_id: ,
         *       }
         * @return array
         *      {
         *
         *      }
         */
        $args['account_id'] = Api_Session::user_id();
        return self::handleRemoveMember($args);
    }

    static function  handleRemoveMember($args)
    {
        $request = Func_Input::filter(array(
            'account_id' => 'int',
            'group_id' => 'int',
            'remove_account_id' => 'int',
        ), $args);
        if (empty($request['account_id']) || empty($request['group_id']) || empty($request['remove_account_id'])) {
            return self::request('error', '', '缺少参数或者参数不正确，请检查参数合法性');
        }

        $is_exist = Data_Mysql_Table_LiveChat_Group::select('id,members', array('id =?' => $request['group_id']));
        if (!empty($is_exist[0])) {
            $members = json_decode($is_exist[0]['members'], true);
            foreach ($members as $key => $val) {
                if ($val['account_id'] = $request['remove_account_id']) {
                    unset($members[$request['remove_account_id']]);
                }
            }
            $status = Data_Mysql_Table_LiveChat_Group::update(array('id =?' => $is_exist[0]['id']), array('members' => $members));
            Data_Mysql_Table_LiveChat_Message_Recent::delete(array('to_account_id=? AND from_account_id =?' =>
                array($request['remove_account_id'], Data_Mysql_Table_LiveChat_Group::convertToAccountId($request['group_id']))));
            if (!empty($status[0])) {
                //清除群头像缓存
                @unlink(Core::$paths['root'] . "upload/group/" . $request['group_id'] . ".jpg");
                return Api::request('success', '', '成员成功移除群组');
            }
            return Api::request('error', '', '移除失败');

        }
        return Api::request('error', '', '群组不存在');

    }
}