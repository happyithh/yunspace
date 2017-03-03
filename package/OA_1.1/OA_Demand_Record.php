<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2015/10/10
 * Time: 14:34
 */
class OA_Demand_Record
{
    static function handle($is_team, $is_all, $is_my = '')
    {
        Func_Header::to('非法请求','http://www.yunspace.com.cn');
        $action = empty($_REQUEST['action']) ? 'list' : $_REQUEST['action'];
        switch ($action) {
            case 'list':
//                self::demandRecord($is_team, $is_all, $is_my);
                self::handleDemandRecord();
                break;
            case 'demand_info':
                OA_Demand_Detail::handleDemandInfo('销售部', $is_team, $is_all, $is_my);
                break;
            case 'ajaxCustomerStepUpdate':
                self::ajaxCustomerStepUpdate();
                break;
            case 'ajaxRecommendSubmit':
                self::ajaxRecommendSubmit();
                break;
            case 'ajaxNoticeAdmin':
                self::handleNoticeAdmin();
                break;
            case 'ajaxGetStepRecord':
                self::ajaxGetStepRecord();
                break;
        }

    }

    static function demandRecord($is_team, $is_all, $is_my = '')
    {
        $conditions = array();
        $account_id = array();
        $admin_ids = array();
        $admins = array();
        // 对城市进行处理
        $city = empty($_REQUEST['city']) ? '' : $_REQUEST['city'];
        if (empty($_REQUEST['city'])) {
            $getCity = Api_Administrator_Department_Normal_Api::getMemberInfo('销售部', $_SESSION['administrator']['id']);
            if (!empty($getCity['city'])) {
                $city = $getCity['city'];
            } else {
                $city = '上海';
            }
        }
        //  获取(组/部门/全部)所有管理员信息
        if (!empty($is_team)) {

            $getTeam = Api_Administrator_Department_Normal_Api::getMemberInfo('销售部', $_SESSION['administrator']['id']);
            if (!empty($getTeam['team_name'])) {
                $getResponse = self::getTeamList('销售部', $getTeam['team_name'], $city);
            } else {
                die('请添加自身到部门管理员！！');
            }
        } else {
            $getResponse = self::getMemberList('销售部', empty($is_all) ? $city : '', '');
        }

        if (!empty($getResponse)) {
            foreach ($getResponse as $k => $v) {
                if ($v['response_account_id']) {
                    $account_id[] = $v['response_account_id'];
                    $admins[$v['response_account_id']] = $v['fullname'];
                }
                $admin_ids[] = $v['admin_id'];
            }
        }

        if (empty($is_my)) {
            if (empty($is_all)) {
                if ($is_team) {
                    $conditions[] = '({table}.admin_id IN(' . implode(',', $admin_ids) . ') OR {table}.response_account_id in(' . implode(",", $account_id) . '))';
                } else {
                    $conditions['({table}.admin_id IN(' . implode(',', $admin_ids) . ') OR {table}.response_account_id in(' . implode(",", $account_id) . ') OR ( {table}.city=? AND  {table}.response_account_id=0) )'] = $city;
                }
            }
        } else {
            $accountInfo = Api_Administrator_GetBaseAccountInfo::getBastAccountInfo(array('admin_id' => $_SESSION['administrator']['id']));
            $conditions["({table}.admin_id=? OR {table}.response_account_id =?)"] = array($accountInfo['admin_id'], $accountInfo['account_id']);
        }

        //搜索筛选处理
        if (!empty($_REQUEST['search'])) {
            $search = Func_Input::filter(array(
                'response_account_id' => 'int',
                'admin_id' => 'int',
                'start_time' => 'string',
                'end_time' => 'string',
                'city' => 'string',
            ), $_REQUEST['search']);
            if (!empty($search['response_account_id'])) {
                $conditions['{table}.response_account_id = ?'] = $search['response_account_id'];
            }
            if (!empty($search['admin_id'])) {
                $conditions["{table}.admin_id =?"] = $search['admin_id'];
            }
            if (!empty($search['city'])) {
                $conditions['{table}.city =?'] = $search['city'];
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
        $request = Func_Input::filter(array(
            'record' => 'string'
        ));
//        q($request);
        if (empty($request['record']) || $request['record'] == 'doneR') {
            $conditions['{prefix}demand_step_record.reason !=?'] = 'null';
        }
        if (!empty($request['record']) && $request['record'] == 'waitingR') {
            $conditions[] = '{prefix}demand_step_record.reason IS NULL';
        }

        $cols = array(
            '{table}.*', '{prefix}contact_library.id as contact_id', '{prefix}demand_step_record.reason,{prefix}demand_offer.id as offer_id'
        );
        $table = '{table} LEFT JOIN {prefix}contact_library ON {table}.phone = {prefix}contact_library.phone LEFT JOIN {prefix}demand_step_record ON {table}.id={prefix}demand_step_record.demand_id LEFT JOIN {prefix}demand_offer  ON {table}.id={prefix}demand_offer.demand_id';
        $conditions['{table}.demand_status=?'] = 1;
        //类型切换
        $type = empty($_REQUEST['type']) ? 'all' : $_REQUEST['type'];
        switch ($type) {
            case'all':
                //Data_Mysql_Table_Demand::debug(1);
                $res = Data_Mysql_Table_Demand::page(0, 30, $cols, $conditions, 'GROUP BY id ORDER BY {table}.create_time DESC', $table);
                break;
            case 'waiting':             //待处理
                $conditions['{table}.step =?'] = 0;
                $res = Data_Mysql_Table_Demand::page(0, 30, $cols, $conditions, 'GROUP BY id ORDER BY {table}.create_time DESC', $table);
                break;
            case 'done':                //已处理
                $conditions['{table}.step >=? AND {table}.step<?'] = array(1, 100);
                $res = Data_Mysql_Table_Demand::page(0, 30, $cols, $conditions, 'GROUP BY id ORDER BY {table}.create_time DESC', $table);

                break;
            case 'end':             //已完成
                $conditions['{table}.step=?'] = 100;
                $res = Data_Mysql_Table_Demand::page(0, 30, $cols, $conditions, 'GROUP BY id ORDER BY {table}.create_time DESC', $table);
                break;
            case 'abandon':             //已关闭
                $conditions['{table}.step<?'] = 0;
                $res = Data_Mysql_Table_Demand::page(0, 30, $cols, $conditions, 'GROUP BY id ORDER BY {table}.create_time DESC', $table);
                break;
            default:
                Func_Header::back('错误！');
                break;
        }
        if (!empty($res)) {
            foreach ($res['rows'] as $k => $v) {
                if (!empty($v['demand'])) {
                    $res['rows'][$k]['demand'] = json_decode($v['demand'], 1);
                }
            }
        }
        // 搜索tab
        if (!empty($search)) {
            $searchKey = array_keys($search);
            $searchValue = array_values($search);
            $searchNum = count($search);
            $urls = '';
            for ($i = 0; $i < $searchNum; $i++) {
                $urls .= 'search[' . $searchKey[$i] . ']=' . $searchValue[$i] . '&';
            }
            Tpl_Smarty::assign('urls', $urls);
        }
//        q($_REQUEST);
//        q(empty($request['record'])?'已回访':$request['record']);
        $record = empty($request['record']) ? 'doneR' : $request['record'];
        Tpl_Smarty::assign('record', $record);
        Tpl_Smarty::assign('_adminInfo', $admins);
        Tpl_Smarty::assign('admin', $getResponse);
        Tpl_Smarty::assign('type', $type);
        Tpl_Smarty::assign('_step_funnel', Data_Mysql_Table_Demand::$step_funnel);
        Tpl_Smarty::assign('_data', $res);


        Tpl_Smarty::display('OA_Static::demands/demand_record/department_demand_record.tpl');
    }

    static function handleDemandRecord()
    {
        //搜索筛选处理
        if (!empty($_REQUEST['search'])) {
            $search = Func_Input::filter(array(
                'admin_id' => 'int',
                'start_time' => 'string',
                'demandType' => 'string',
                'end_time' => 'string',
                'city' => 'string',
                'demand_id' => 'int',
            ), $_REQUEST['search']);
            if (!empty($search['admin_id'])) {
                $phone = Data_Mysql_Table_Administrator::select("phone", array('id =?' => $search['admin_id']));
                $account = Api_Administrator_GetBaseAccountInfo::getBastAccountInfoByPhone(array('phone' => $phone[0]['phone']));
                if (!empty($account['id'])) {
                    $account['response_account_id'] = $account['id'];
                    $admin_account[$account['id']] = $account;
                    $conditions["(t1.sale_phone =? OR {table}.response_account_id=?)"] = array($phone[0]['phone'], $account['id']);
                } else {
                    $conditions["(t1.sale_phone =? OR {table}.admin_id=?)"] = array($phone[0]['phone'], $search['admin_id']);
                }
            }
            if (!empty($search['city'])) {
                $conditions['({table}.city =? OR {table}.notice_city =?)'] = array($search['city'], $search['city']);
            }
            if (!empty($search['demandType'])) {
                $conditions['{table}.demand_type =?'] = $search['demandType'];
            }
            if (!empty($search['demand_id'])) {
                $conditions['{table}.id=?'] = $search['demand_id'];
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
        $cols = array(
            '{table}.*', 't1.id as grab_id,t1.sale_phone,t1.step as grab_step'
        );

        $table = '{table} LEFT JOIN {prefix}grab_order as t1 ON {table}.id=t1.id ';

        $conditions['{table}.demand_status=?'] = 1;

        //类型切换
        $type = empty($_REQUEST['type']) ? 'all' : $_REQUEST['type'];
        $totalAll = Data_Mysql_Table_Demand::select('COUNT(*) as c', $conditions, '', 999, $table);
        $waitingConditions = $conditions;
        $waitingConditions['t1.step =?'] = 0;
        $totalWaiting = Data_Mysql_Table_Demand::select('COUNT(*) as c', $waitingConditions, '', 999, $table);
        $doneConditions = $conditions;
        $doneConditions['t1.step >=? AND t1.step<?'] = array(1, 100);
        $totalDone = Data_Mysql_Table_Demand::select('COUNT(*) as c', $doneConditions, '', 999, $table);
        $endConditions = $conditions;
        $endConditions['t1.step =?'] = 100;
        $totalEnd = Data_Mysql_Table_Demand::select('COUNT(*) as c', $endConditions, '', 999, $table);
        $abandonConditions = $conditions;
        $abandonConditions['t1.step <?'] = 0;
        $totalAbandon = Data_Mysql_Table_Demand::select('COUNT(*) as c', $abandonConditions, '', 999, $table);
        $total['all'] = empty($totalAll[0]['c']) ? 0 : $totalAll[0]['c'];
        $total['waiting'] = empty($totalWaiting[0]['c']) ? 0 : $totalWaiting[0]['c'];
        $total['done'] = empty($totalDone[0]['c']) ? 0 : $totalDone[0]['c'];
        $total['end'] = empty($totalEnd[0]['c']) ? 0 : $totalEnd[0]['c'];
        $total['abandon'] = empty($totalAbandon[0]['c']) ? 0 : $totalAbandon[0]['c'];
        //在默认情况下
        if (empty($_REQUEST['type'])) {
            if ($total['waiting'] > 0) {
                $type = 'waiting';
            } else if ($total['done'] > 0) {
                $type = 'done';
            }
        }
        switch ($type) {
            case'all':
                $res = Data_Mysql_Table_Demand::page(0, 30, $cols, $conditions, 'ORDER BY {table}.create_time DESC', $table);
                break;
            case 'waiting':             //待处理
                $conditions['t1.step =?'] = 0;
                // Data_Mysql_Table_Demand::debug(1);
                $res = Data_Mysql_Table_Demand::page(0, 30, $cols, $conditions, 'ORDER BY {table}.create_time DESC', $table);
                break;
            case 'done':                //已处理
                $conditions['t1.step >=? AND t1.step<?'] = array(1, 100);
                $res = Data_Mysql_Table_Demand::page(0, 30, $cols, $conditions, 'ORDER BY {table}.create_time DESC', $table);

                break;
            case 'end':             //已完成
                $conditions['t1.step=?'] = 100;
                $res = Data_Mysql_Table_Demand::page(0, 30, $cols, $conditions, 'ORDER BY {table}.create_time DESC', $table);
                break;
            case 'abandon':             //已关闭
                $conditions['t1.step<?'] = 0;
                $res = Data_Mysql_Table_Demand::page(0, 30, $cols, $conditions, 'ORDER BY {table}.create_time DESC', $table);
                break;
            default:
                Func_Header::back('错误！');
                break;
        }
        if (!empty($res['rows'])) {
//
//            $adminALL = self::getMemberList('销售部');
//            foreach ($adminALL as $k => $val) {
//                $salephone[$val['phone']]['fullname'] = $val['city'] . '-' . $val['fullname'];
//            }
//            $salephone[9]['fullname'] = '报价系统';
//            Tpl_Smarty::assign('sale_name', $salephone);

            foreach ($res['rows'] as $k => $val) {
                $res['rows'][$k]['demand'] = json_decode($val['demand'], 1);
            }
        }
        // 搜索tab
        if (!empty($search)) {
            $searchKey = array_keys($search);
            $searchValue = array_values($search);
            $searchNum = count($search);
            $urls = '';
            for ($i = 0; $i < $searchNum; $i++) {
                $urls .= 'search[' . $searchKey[$i] . ']=' . $searchValue[$i] . '&';
            }
            Tpl_Smarty::assign('urls', $urls);
        }

        Tpl_Smarty::assign('type', $type);
        Tpl_Smarty::assign('total', $total);
        Tpl_Smarty::assign('_step_funnel', Data_Mysql_Table_Demand::$step_funnel);

        Tpl_Smarty::assign('_data', $res);
        Tpl_Smarty::assign('_demandType', Data_Mysql_Table_Demand::$_demandType);

//        Tpl_Smarty::display('OA_Static::demands/demand_record/department_demand_record.tpl');

        Tpl_Smarty::display('OA_Static::Demand.v2.0/record/list.tpl');
    }

    //获取部门的联系人信息
    static function getMemberList($department, $city = '', $is_alladmin)
    {
        $getAdmin = array();

        if (empty($is_alladmin) && !empty($city)) {
            $conditions['t1.city =?'] = $city;
        }
        $conditions['t1.department_name =?'] = $department;
        $conditions[] = 't2.status = 1';
        $table = '{table} as t1 LEFT JOIN {prefix}administrator as t2 ON t1.admin_id = t2.id LEFT JOIN {prefix}account as t3 ON t2.phone = t3.phone';
        $re = Data_Mysql_Table_Department_Member::select('t1.*, t2.fullname,t3.id as response_account_id', $conditions, 'GROUP BY t2.id', 9999, $table);
        if (!empty($re)) {
            foreach ($re as $k => $v) {
                if (!empty($v['admin_id'])) {
                    $getAdmin[$k] = $v;
                }
            }
        }
        return $getAdmin;
    }

    static function ajaxCustomerStepUpdate()
    {
        Core::output('');
        $request = Func_Input::filter(array(
            'id' => 'int',
            'step' => 'int',
            'reason' => 'string',
        ));
        $admin_id = Api_Session::admin_id();
        if (empty($admin_id)) {
            Func_Output::json('error', '', '请先登录！');
        }
        if (empty($request['id'])) {
            Func_Output::json('error', '', '缺少参数！');
        }
        $request['reason'] = trim($request['reason']);
        if (empty($request['reason'])) {
            Func_Output::json('error', '', '请填写备注！');
        }
        if (mb_strwidth($request['reason'], 'UTF-8') < 30) {
            Func_Output::json('error', '', '至少输入15个字！');
        }
        $data = array(
            'demand_id' => $request['id'],
            'step' => $request['step'],
            'admin_id' => $admin_id,
            'reason' => $request['reason']);
        $rs = Data_Mysql_Table_Demand_Step_Record::insert($data);
        if ($rs[0] > 0) {
            Data_Mysql_Table_Account_Log::insertAccountLog('1', $admin_id, 'ID为' . $request['id'] . '回访记录：' . $request['reason'] . '成功', '需求回访', $request['id']);
            Func_Output::json('success', '', ' 修改成功');
        }
        Func_Output::json('error', '', '修改失败,请稍后再试！');
    }


    // 回访记录展示
    static function ajaxGetStepRecord()
    {
        Core::output('');
        $request = Func_Input::filter(array(
            'demand_id' => 'int'
        ), $_REQUEST);
        if (empty($request['demand_id'])) {
            Func_Output::json('error', '', '数据请求异常！');
        }
        $res = Data_Mysql_Table_Demand_Step_Record::select('{table}.demand_id,{table}.reason,FROM_UNIXTIME({table}.create_time,"%Y-%m-%d %H:%i:%S") days,{prefix}administrator.fullname', array('demand_id' => $request['demand_id']), 'ORDER BY {table}.create_time DESC', 200, '{table} LEFT JOIN {prefix}administrator ON {table}.admin_id = {prefix}administrator.id');
        if (!empty($res)) {
            Func_Output::json('success', $res, '');
        } else {
            Func_Output::json('error', '', '没有更多记录哦');
        }
    }
}