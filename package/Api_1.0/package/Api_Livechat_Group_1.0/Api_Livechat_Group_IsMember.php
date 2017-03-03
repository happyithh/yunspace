<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/7/6
 * Time: 13:21
 * @新需求,创建聊天分组
 */
class  Api_Livechat_Group_IsMember extends Api
{
    /*
    *判断是否是组成员
    *@param user_id  要判断的用户id                               
    *@param group_id  分组的id
    *@return    布尔 true 或者 false
    */
    static function isMember($args)
    {
        $request = Func_Input::filter(array(
            'account_id' => 'int',       //要判断的成员
            'group_id' => 'int',        //分组的ID
        ), $args);
        if (empty($request['group_id']) || empty($request['account_id'])) {
            return Api::request('error', '', '缺少参数或者参数不正确，请检查参数合法性');
        }
        //判断成员是否属于当前组
        $conditions['id'] = Data_Mysql_Table_LiveChat_Group::convertFromAccountId($request['group_id']);
        $conditions['members'][$request['account_id']] = $request['account_id'];
        $group = Data_Mysql_Table_LiveChat_Group::select('id', $conditions);

        if (empty($group[0])) {
            return false;
        }
        return true;

    }

}