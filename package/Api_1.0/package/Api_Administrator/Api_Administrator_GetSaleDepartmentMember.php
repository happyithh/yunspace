<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2016/6/22
 * Time: 16:39
 *
 */
class Api_Administrator_GetSaleDepartmentMember extends Api
{
    static function  handle($args = '')
    {
        if (!Api_Session::admin_id()) {
            return Api::request('error', '', '请先登录！');
        }
        return self::getSaleDepartmentMember($args);
    }

    static function  getSaleDepartmentMember($args)
    {
        $request = Func_Input::filter(array(
            'q' => 'string',
        ), $args);
        if (!empty($request['q'])) {
            $conditions[] = "(t1.team_name  LIKE '%" . $request['q'] . "%' OR t1.city  LIKE '%" . $request['q'] . "%' OR t2.fullname  LIKE '%" . $request['q'] . "%' OR t2.username  LIKE '%" . $request['q'] . "%' )";
        }
        $conditions['t1.department_name =?'] = '销售部';
        $conditions[] = "t2.status = 1 AND t2.phone !=''";
        $table = '{table} as t1 LEFT JOIN {prefix}administrator as t2 ON t1.admin_id = t2.id LEFT JOIN {prefix}account as t3 ON t2.phone = t3.phone';
        $rs = Data_Mysql_Table_Department_Member::select('t1.*,t2.id as admin_id,t2.phone, t2.fullname,t2.username,t3.id as response_account_id',
            $conditions, ' GROUP BY t2.id ORDER BY t1.city ASC,t1.team_name ASC', 999, $table);
        $team_data = Data_Mysql_Table_Department_Member::select('CONCAT(city,team_name) as team_name', '',
            'GROUP BY team_name,city', 100);
        $team_all = array_column($team_data, 'team_name');
        $newData = array();
        foreach ($rs as $key => $val) {
            if ($val['admin_id']) {
                $city_team_name = $val['city'] . $val['team_name'];
                $search_rs = array_search($city_team_name, $team_all);
                if (is_numeric($search_rs)) {

                    if (!empty($val['team_name'])) {
                        $text = $val['fullname'] . '-' . $val['username'];
                        $oneClass = $val['city'] . '-' . $val['team_name'];
                    } else {
                        $text = $val['fullname'];
                        $oneClass = $val['city'];
                    }
                    $newData[$search_rs]['text'] = $oneClass;
                    $newData[$search_rs]['children'][] = array(
                        'id' => $val['phone'],
                        'text' => $text,
                        'admin_id' => $val['admin_id']
                    );
                }
            }
        }
        return Api::request('success', array_values($newData), 'ok');
    }

} 