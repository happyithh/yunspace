<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/7/6
 * Time: 13:21
 * @创建聊天分组
 * 1.创建群组
 * 2.如果是需求创建的，需要将group_id  更新到demand表中
 */
class  Api_Livechat_Group_Create extends Api
{
    /**
     *
     * demand_id   需求ID
     * members array(
     *              array(
     *               account_id =>'',
     *               username =>'',
     *                  )
     *             )
     *
     *名称
     */

    static function  handleCreate($args)
    {
        $request = Func_Input::filter(array(
            'demand_id' => 'int',
            'members' => 'array',
        ), $args);

        if (empty($request['members'])) {
            return self::request('error', '', '成员信息缺少或者参数不正确，请检查参数合法性');
        }
        $members = array();
        $groupName = '&&';

        foreach ($request['members'] as $v) {
            if ($v['account_id']) {
                $members[$v['account_id']] = array(
                    'account_id' => $v['account_id'],
                    'username' => $v['username'],
                );
                $groupName .= $v['username'] . ' ';
            }
        }
        $data = array(
            'name' => trim($groupName),
            'members' => $members,
            'demand_id' => $request['demand_id'],
            'members_total' => count($members),
            'update_time' => time(),
            'create_time' => time(),
        );

        $status = Data_Mysql_Table_LiveChat_Group::insert($data);
        if (empty($status[0])) {
            return Api::request('error', '', '群组创建失败,请检查,相关需求是否已经创建过群组');
        }
        if (!empty($request['demand_id'])) {
            Data_Mysql_Table_Demand::update(array('id =?' => $request['demand_id']), array('group_id' => $status[0]));
        }
        return Api::request('success', array('group_id' => $status[0]), '创建成功');

    }
}