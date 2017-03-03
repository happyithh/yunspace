<?php

/**
 * Created by PhpStorm.
 * User: adu
 * Date: 15/7/9
 * Time: 15:09
 * @获取部门小组
 */
class Api_Administrator_DepartmentGroup extends Api
{
    /**
     * @传入参数 @args = array(
     *                      admin_id =>[self::admin()],
     *                      city=>'' ,          城市
     *                      department=>'' ,    部门
     * );
     *
     *
     */
    static function handle($args = '')
    {
        $args['admin_id'] = Api_Session::admin_id();
        if (empty($args['admin_id'])) {
            return Api::request('error', '', '如果您是管理员请先登录');
        }
        return self::getList($args);
    }

    //返回参数
    static function getList($args)
    {
        $request = Func_Input::filter(array(
            'city' => 'string',
            'department' => 'string',
        ), $args);
        if (empty($request['department'])) {
            return Api::request('error', '', '缺少参数或者参数不正确，请检查参数合法性');
        }
        $condition['department_name =?'] = $request['department'];
        if (empty($request['city'])) {
            $condition['city =?'] = $_COOKIE['city'];
        } else {
            $condition['city =?'] = $request['city'];
        }
        $condition['team_name !=?'] = '';
        $cols = 'team_name,level';
        $data = Data_Mysql_Table_Department_Member::select($cols, $condition, ' GROUP BY team_name', 100);
        if (empty($data[0])) {
            return Api::request('error', '', '没有数据');
        }
        return Api::request('success', $data, '成功');

    }

}

