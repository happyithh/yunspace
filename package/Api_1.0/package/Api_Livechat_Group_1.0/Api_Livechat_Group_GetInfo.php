<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/7/6
 * Time: 13:21
 * @获取分组信息
 */
class  Api_Livechat_Group_GetInfo extends Api
{
    /*
    *获取组信息
    *@param group_id  分组的id
    *@return    array()
    */
    static function  getGroupInfoById($args)
    {
        $request = Func_Input::filter(array(
            'group_id' => 'int',
        ), $args);
        if (empty($request['group_id'])) {
            return false;
        }
        $data = Data_Mysql_Table_LiveChat_Group::select('id,name,members,members_total,demand_id,create_time', array('id =?' => Data_Mysql_Table_LiveChat_Group::convertFromAccountId($request['group_id'])));
        if (empty($data[0])) {
            return false;
        }
        $data[0]['members'] = json_decode($data[0]['members'], 1);
        return $data[0];
    }
}