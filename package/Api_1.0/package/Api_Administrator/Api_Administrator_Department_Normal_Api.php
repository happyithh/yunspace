<?php

/**
 * Created by PhpStorm.
 * User: yl
 * Date: 15/7/28
 * Time: 10:22
 * 内部管理--部门管理的相关通用方法
 */
class Api_Administrator_Department_Normal_Api extends Api
{
    //获取部门的联系人信息
    static function getMemberList($department, $city = '', $noPage = 0)
    {
        if (!empty($city)) {
            $conditions['city'] = $city;
        }
        $conditions['department_name'] = $department;
        $conditions[] = '{prefix}administrator.status = 1';
        $table = '{table} LEFT JOIN {prefix}administrator ON {table}.admin_id = {prefix}administrator.id';
        if ($noPage) {
            return Data_Mysql_Table_Department_Member::select('{table}.*, {prefix}administrator.fullname,{prefix}administrator.username', $conditions, '', 100, $table);
        }
        $rs = Data_Mysql_Table_Department_Member::page(0, 100, '{table}.*, {prefix}administrator.fullname,{prefix}administrator.username', $conditions, '', $table);
        $now = date("Y/m/d", time());//今天日期
        foreach ($rs['rows'] as $k => $v) {
            $v['reset_time'] = date("Y/m/d", $v['reset_time']);
            if ($v['reset_time'] != $now) {//不是今天,显示今日已用配额为0，但数据库quota_now不进行更新
                $rs['rows'][$k]['quota_now'] = 0;
            }
        }
        return $rs;
    }

    //获取部门下某个组的联系人信息
    static function getTeamList($department, $team_name = '', $city = '上海')
    {
        $conditions = array(
            'department_name' => $department,
            'team_name like ?' => $team_name . '%',
        );
        $conditions[] = '{prefix}administrator.status = 1';
        if ($city) {
            $conditions['city'] = $city;
        }
        if (!$team_name) {
            unset($conditions['team_name like ?']);
            $conditions['team_name'] = '';
        }
        $table = '{table} LEFT JOIN {prefix}administrator ON {table}.admin_id = {prefix}administrator.id';
        return Data_Mysql_Table_Department_Member::select('{table}.*, {prefix}administrator.fullname', $conditions, '', 100, $table);
    }

    static function getMemberInfo($department, $adminId)
    {
        $r = Data_Mysql_Table_Department_Member::select('*', array(
            'department_name' => $department,
            'admin_id' => $adminId,
        ));
        if (!empty($r[0])) {
            $info = $r[0];
            $info['data'] = json_decode($info['data'], 1);
            if (date('Y-m-d') != date('Y-m-d', $info['reset_time'])) {
                $info['reset_time'] = time();
                $info['quota_now'] = 0;
            }
            return $info;
        }
        return false;
    }

    static function updateMemberInfo($info)
    {
        $r = Data_Mysql_Table_Department_Member::update($info);
        return !empty($r[0]) ? 1 : 0;
    }

}

