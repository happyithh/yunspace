<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/5/15
 * Time: 17:29
 * @ 部门需求列表
 * department
 */
Class  OA_Demand_List
{
    static function  handle($department, $is_team, $is_check = 0, $is_my = 0)
    {
        $type = empty($_REQUEST['action']) ? 'list' : $_REQUEST['action'];
        if ($type == 'list') {
            self::handleDepartmentDemandList($department, $is_team, $is_check, $is_my);
        } elseif ($type == 'ajaxCustomerStepUpdate') {
            self::ajaxCustomerStepUpdate();
        } elseif ($type == 'my_demand') {
            self::handleMyDemandList();
        }
    }

    static function  handleDepartmentDemandList($department, $is_team, $is_check = 0, $is_my)
    {
        //获取该部门下的所有管理员信息
        $admin_ids = array();
        $admin = array();
        $city = empty($_REQUEST['city']) ? '' : $_REQUEST['city'];
        if (empty($_REQUEST['city'])) {
            $quota = Api_Administrator_Department_Normal_Api::getMemberInfo($department, $_SESSION['administrator']['id']);
            if (!empty($quota['city'])) {
                $city = $quota['city'];
            } else {
                $city = '上海';
            }
        }
        if ($is_team) {
            $memberInfo = Api_Administrator_Department_Normal_Api::getMemberInfo($department, $_SESSION['administrator']['id']);
            if (!empty($memberInfo)) {
                $adminInfo = Api_Administrator_Department_Normal_Api::getTeamList($department, $memberInfo['team_name'], $city);
            } else {
                die('请添加自身到部门管理员！！');
            }

        } else {
            $adminInfo = Api_Administrator_Department_Normal_Api::getMemberList($department, $city, 1);
        }
        if (!empty($adminInfo)) {
            foreach ($adminInfo as $key => $value) {
                $admin_ids[] = $value['admin_id'];
                $admin[$value['admin_id']] = $value['fullname'];
            }
        }

        if (!empty($_REQUEST['search'])) {
            $search = Func_Input::filter(array(
                'title' => 'string',
                'admin_id' => 'int',
                'start_time' => 'string',
                'end_time' => 'string',
                'city' => 'string',
                'category_id' => 'int',
            ), $_REQUEST['search']);
            if (!empty($search['title'])) {
                if (is_numeric($_REQUEST['search']['title'])) {
                    $conditions['id'] = $search['title'];
                } else {
                    $conditions['vendor_name'] = $search['title'];
                }
            }
            if (!empty($search['admin_id'])) {
                $conditions['{prefix}contact_relation.admin_id = ?'] = $search['admin_id'];
            }
            if (!empty($search['category_id'])) {
                $conditions['{table}.categories_id = ?'] = $search['category_id'];
            }
            if (!empty($search['start_time']) && !empty($search['end_time'])) {
                if (strtotime($search['start_time']) > strtotime($search['end_time'])) {
                    Func_Header::back('请正确选择时间范围！！');
                } else {
                    $conditions['{table}.create_time between ? and ?'] = array(strtotime($search['start_time']), strtotime($search['end_time']));
                }
            } elseif (!empty($search['start_time']) && empty($search['end_time'])) {
                $conditions['{table}.create_time > ?'] = strtotime($search['start_time']);
            } elseif (empty($search['start_time']) && !empty($search['end_time'])) {
                $conditions['{table}.create_time < ?'] = strtotime($search['end_time']);
            }
        }

        if ($is_my == 1) {
            $conditions[] = '{prefix}contact_relation.admin_id =' . $_SESSION['administrator']['id'];
        } else {
            if (!$is_team) {

                $conditions['{table}.city = ? AND ({prefix}contact_relation.admin_id in (' . implode(',', $admin_ids) . ") OR  {prefix}contact_relation.admin_id NOT IN (" . implode(',', $admin_ids) . ") )"] = $city;
            } else {
                $conditions['{prefix}contact_relation.admin_id in (' . implode(',', $admin_ids) . " AND {table}.city = ?)"] = $city;
            }
        }
        if ($is_check) {
        } else {
            $conditions['{table}.demand_status > 0 AND {table}.demand_type <>?'] = '供应商加盟';
        }
        $demand = self::getDemandList($conditions);

        Tpl_Smarty::assign('_adminInfo', $admin);
        Tpl_Smarty::assign('_data', $demand);
        Tpl_Smarty::assign('_step_AE', Data_Mysql_Table_Demand::$step_AE);
        Tpl_Smarty::assign('_step_funnel', Data_Mysql_Table_Demand::$step_funnel);
        Tpl_Smarty::display('OA', 'department_demand_list.tpl');

    }

    static function ajaxCustomerStepUpdate()
    {
        Core::output('');
        $request = Func_Input::filter(array(
            'id' => 'int',
            'step' => 'int',
        ));
        if (empty($_SESSION['administrator']['id'])) {
            Func_Output::json('error', '', '请先登录！');
        }
        $rs = Data_Mysql_Table_Demand::query("UPDATE {table} SET step =? WHERE id = ? AND step !=? ",
            array($request['step'], $request['id'], 100), 1);
        if ($rs[0] > 0) {
            Data_Mysql_Table_Account_Log::insertAccountLog('1', $_SESSION['administrator']['id'], 'ID为' . $request['id'] . '需求进度改为' . $request['step'] . '成功', '需求进度', $request['id']);
            Func_Output::json('success', '', ' 修改成功');
        }
        Func_Output::json('error', '', '修改失败,请稍后再试！');

    }

    static function getDemandList($conditions)
    {
        $cols = array(
            '{table}.id', '{table}.step', '{table}.demand_type', '{table}.demand_name', '{table}.demand','{table}.mark', '{prefix}contact_library.customer_type', '{prefix}contact_library.id as contact_id', '{table}.city', '{table}.create_time', '{prefix}contact_library.username', '{prefix}contact_library.phone, {prefix}contact_relation.admin_id'
        );
        $table = "{table} LEFT JOIN {prefix}contact_library ON {table}.phone = {prefix}contact_library.phone LEFT JOIN {prefix}contact_relation ON {prefix}contact_library.id = {prefix}contact_relation.contact_id";
        $demand = Data_Mysql_Table_Demand::page(0, 15, $cols, $conditions, 'ORDER BY {table}.create_time DESC', $table);
        if (!empty($demand['rows'])) {
            foreach ($demand['rows'] as $key => $value) {
                if (!empty($value['demand'])) {
                    $demand['rows'][$key]['demand'] = json_decode($value['demand'], 1);
                }
            }
        }
        return $demand;
    }

}
