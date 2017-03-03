<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/7/6
 * Time: 13:21
 * @新需求,创建聊天分组
 */
class  Api_Livechat_Group_AddMember extends Api
{
    /**
     *
     * 传入参数
     *
     * members  新增加的成员  array(
     *                        '用户的ID'=>array(
     *                                  'account_id'=>         //用户的id
     *                                  'username'=>            用户名称
     *                                  )
     *  )
     * group_id  分组的id
     *
     */
    static function  handleAddMember($args)
    {
        $request = Func_Input::filter(array(
            'members' => 'array',       //新增的成员
            'group_id' => 'int',        //分组的ID
        ), $args);
        if (empty($request['group_id']) || empty($request['members'])) {
            return Api::request('error', '', '缺少参数或者参数不正确，请检查参数合法性');
        }
        $request['group_id'] = Data_Mysql_Table_LiveChat_Group::convertFromAccountId($request['group_id']);
        $is_exist = Data_Mysql_Table_LiveChat_Group::select('id,members', array(
            'id =?' => $request['group_id']));
        $newMembers = array();
        foreach ($request['members'] as $v) {
            if (!empty($v['account_id'])) {
                $newMembers[$v['account_id']] = array(
                    'account_id' => $v['account_id'],
                    'username' => $v['username'],
                );
            }
        }
        if (!empty($is_exist[0]['id'])) {
            $members = json_decode($is_exist[0]['members'], true);
            $newAll = array();
            foreach ($members as $k => $val) {
                if (!empty($val['account_id'])) {
                    $newAll[$val['account_id']] = $val;
                }
            }
            foreach ($newMembers as $k => $val) {
                $newAll[$val['account_id']] = $val;
            }
            $members_total = count($newAll);
            $status = Data_Mysql_Table_LiveChat_Group::update(array('id =?' => $request['group_id']),
                array(
                    'members' => $newAll,
                    'members_total' => $members_total
                ));
            if (!empty($status[0])) {
                //清除群头像缓存
                @unlink(Core::$paths['root'] . "upload/group/" . $request['group_id'] . ".jpg");
                return Api::request('success', '', '成员添加成功');
            }
            return Api::request('error', '', '成员添加失败');
        } else {
            return Api::request('error', '', '不存在这个分组');
        }

    }
}