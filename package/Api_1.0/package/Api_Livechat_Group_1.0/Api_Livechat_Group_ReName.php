<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/7/6
 * Time: 13:21
 * 群组改名字
 */

/**
 * 1.根据群ID修改 群的名称
 * 2. 修改人必须是群内的成员
 */
class  Api_Livechat_Group_ReName extends Api
{

    static function  handle($args = '')
    {
        /**
         * @param string $args
         *       {
         *       * account_id:[ handle Api_Session::user_id()] ,
         *       * group_id: ,
         *       * name: ,
         *       }
         * @return array
         *      {
         *
         *      }
         */
        $args['account_id'] = Api_Session::user_id();
        return self::handleReName($args);
    }

    static function  handleRename($args)
    {
        $request = Func_Input::filter(array(
            'account_id' => 'int',
            'group_id' => 'int',
            'name' => 'string',
        ), $args);
        if (empty($request['name']) || empty($request['account_id']) || empty($request['group_id'])) {
            return Api::request('error', '', '缺少参数或者参数不正确，请检查参数的合法性');
        }
        $group_id = Data_Mysql_Table_LiveChat_Group::convertFromAccountId($request['group_id']);
        $conditions['id =?'] = $group_id;
        $conditions['members'][$request['account_id']] = $request['account_id'];
        $is_exist = Data_Mysql_Table_LiveChat_Group::select('name,members', $conditions);
        if (empty($is_exist[0])) {
            return Api::request('error', '', '未能查询到该群信息，请检查该群是否存在或是您是否存在群中');
        }
        $status = Data_Mysql_Table_LiveChat_Group::update(array('id =?' => $group_id), array('name' => $request['name']));
        if (empty($status[0])) {
            return Api::request('error', '', '修改失败');
        }
        Data_Mysql_Table_LiveChat_Message_Recent::update(
            array('from_account_id ' => Data_Mysql_Table_LiveChat_Group::convertToAccountId($request['group_id'])),
            array('from_name' => $request['name']));

        return Api::request('success', '', '修改成功');
    }
}