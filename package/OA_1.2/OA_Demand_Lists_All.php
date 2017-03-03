<?php

/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2016/1/5
 * Time: 9:22
 */
class OA_Demand_Lists_All
{
    static function handle($department, $is_team, $is_all, $is_my = '', $is_offer = "", $is_city_partner = '')
    {
        $action = empty($_REQUEST['action']) ? 'list' : $_REQUEST['action'];
        switch ($action) {
            case 'list':
                self::handleDepartmentDemandList($department, $is_team, $is_all, $is_my, $is_offer, $is_city_partner);
                break;
            case 'ajaxCustomerStepUpdate':
                self::ajaxCustomerStepUpdate();
                break;
            case 'demand_info':
                OA_Demand_All_Detail::handleDemandInfo($department, $is_team, $is_all, $is_my, $is_offer,
                    $is_city_partner);
                break;
            case 'add_contact_record':
                OA_Demand_All_Detail::handleAddContactRecord();
                break;
            case 'contact_detail_from':
                OA_Demand_All_Detail::handleContactFrom();
                break;
            case 'demand_edit_submit':
                OA_Demand_Edit::handleDemandEditFrom();
                break;
            case 'ajaxNoticeAdmin':
                self::handleNoticeAdmin();
                break;
            case 'demand_edit_tpl':
                OA_Demand_Edit::handleDemandEditTpl();
                break;
            case 'contact_detail_from_submit':
                OA_Demand_All_Detail::handleContactFromSubmit();
                break;
            case 'takeLook':
                OA_Demand_All_Detail::handleTakeLook();
                break;
            case 'ajaxRecommendSubmit':
                self::ajaxRecommendSubmit();
                break;
            case 'pdf':
                if (empty($_REQUEST['product_id'])) {
                    Func_Header::notFound();
                }
                Web_User_Center_Pdf::handleProductPdf($_REQUEST['product_id']);
                break;
            case 'remark':
                OA_Demand_All_Detail::handleDemandCreateRemark();
                break;
            case 'selectremark':
                OA_Demand_All_Detail::handleDemandSelectRemark();
                break;
            /* case 'add_contact_record':
                 OA_Demand_All_Detail::handleAddContactRecord();
                 break;*/

        }
    }

    static function  handleMyDemandList()
    {
        self::handleDepartmentDemandList('销售部', '', '', 1);
    }

    static function handleDepartmentDemandList($department, $is_team, $is_all, $is_my = '', $is_city_partner = '')
    {
        @session_start();
        $conditions = array();
        if (!empty($is_team)) {
            // 对城市进行处理
            $city = empty($_REQUEST['search']['city']) ? '' : $_REQUEST['search']['city'];
        }

        if (empty($city)) {
            if (empty($_COOKIE['admin_city'])) {
                $admin_info = Api_Administrator_getBaseInfo::getAdminInfo(array('admin_id' => $_SESSION['administrator']['id']));
                if (!empty($admin_info['city'])) {
                    $city = $admin_info['city'];
                } else {
                    die('请设置您当前所在城市~~~');
                }
                setcookie('admin_city', $city);
            } else {
                $city = $_COOKIE['admin_city'];
            }
        }
        if ($is_city_partner == 1) {
            if ($city == '北京' || $city == '深圳' || $city == '广州' || $city == '上海') {
                $city = '';
            } else {
                $_REQUEST['search']['city'] = $city;
            }
            $conditions[] = "{table}.city NOT IN ('北京','上海','广州','深圳')";
            Tpl_Smarty::assign('is_city_partner', 1);

        }
        $admin_account = array();

        if (empty($is_my)) {
            //获取所有联系人
            if (!empty($is_team)) {
                $getTeam = Api_Administrator_Department_Normal_Api::getMemberInfo($department,
                    $_SESSION['administrator']['id']);
                if (!empty($getTeam['team_name'])) {
                    $getResponse = self::getTeamList($department, $getTeam['team_name'], $getTeam['city']);
                } else {
                    die('请添加自身到部门管理员！！');
                }
            } else {
                $getResponse = self::getMemberList($department, empty($is_all) ? $city : '', '');

            }
            if (!empty($getResponse)) {
                foreach ($getResponse as $k => $v) {
                    if (!empty($v['response_account_id'])) {
                        $admin_account[$v['response_account_id']] = $v['fullname'];
                        $admin_phone[] = $v['phone'];
                        $admin_account_ids[] = $v['response_account_id'];
                    }
                    if (!empty($v['admin_id'])) {
                        $admin_ids[] = $v['admin_id'];
                    }
                }
            }
        } else {
            if (empty($_SESSION['administrator'])) {
                Func_Header::back('请先登录~！');
            }
            $_REQUEST['search']['admin_id'] = $_SESSION['administrator']['id'];
//            $conditions["t1.sale_phone =?"] = 13127808798;

            Tpl_Smarty::assign('is_my', 1);
        }
        if (empty($is_my)) {
            //获取所有联系人
            if (!empty($is_team)) {
                $conditions[] = "( {table}.admin_id IN (" . implode(',',
                        $admin_ids) . ") OR  t1.sale_phone IN (" . implode(',',
                        $admin_phone) . ") OR {table}.response_account_id IN (" . implode(',',
                        $admin_account_ids) . "))";

            } elseif (empty($is_all)) {
                $_REQUEST['search']['city'] = $city;
            }
        }
        //搜索筛选处理
        if (!empty($_REQUEST['search'])) {
            $search = Func_Input::filter(array(
                'admin_id' => 'int',
                'start_time' => 'string',
                'demandType' => 'string',
                'end_time' => 'string',
                'city' => 'string',
                'phone' => 'string',
                'demand_id' => 'int',
            ), $_REQUEST['search']);
            if (!empty($search['admin_id'])) {
                if ($search['admin_id'] == 9) {
                    $conditions["t1.sale_phone =?"] = array(9);
                } else {
                    $phone = Data_Mysql_Table_Administrator::select("phone", array('id =?' => $search['admin_id']));
                    $account = Api_Administrator_GetBaseAccountInfo::getBastAccountInfoByPhone(array('phone' => $phone[0]['phone']));
                    if (!empty($account['id'])) {
                        $account['response_account_id'] = $account['id'];
                        $admin_account[$account['id']] = $account;
                        $conditions["(t1.sale_phone =? OR {table}.response_account_id=?)"] = array(
                            $phone[0]['phone'],
                            $account['id']
                        );
                    } else {
                        $conditions["(t1.sale_phone =? OR {table}.admin_id=?)"] = array(
                            $phone[0]['phone'],
                            $search['admin_id']
                        );
                    }
                }
            }
            if (!empty($search['phone'])) {
                $conditions['{table}.phone=?'] = $search['phone'];
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
                    $conditions['{table}.create_time between ? and ?'] = array(
                        strtotime($search['start_time']),
                        strtotime($search['end_time']) + 86340
                    );
                }
            } elseif (!empty($search['start_time']) && empty($search['end_time'])) {
                $conditions['{table}.create_time > ?'] = strtotime($search['start_time']);
            } elseif (empty($search['start_time']) && !empty($search['end_time'])) {
                $conditions['{table}.create_time < ?'] = strtotime($search['end_time']) + 86340;
            }
        }
        $cols = array(
            '{table}.*',
            't1.id as grab_id,t1.sale_phone,t1.step as grab_step'
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
            } else {
                if ($total['done'] > 0) {
                    $type = 'done';
                }
            }
        }
        switch ($type) {
            case'all':
                $res = Data_Mysql_Table_Demand::page(0, 30, $cols, $conditions, 'ORDER BY {table}.create_time DESC',
                    $table);
                break;
            case 'waiting':             //待处理
                $conditions['t1.step =?'] = 0;
                $res = Data_Mysql_Table_Demand::page(0, 30, $cols, $conditions, 'ORDER BY {table}.create_time DESC',
                    $table);
                break;
            case 'done':                //已处理
                $conditions['t1.step >=? AND t1.step<?'] = array(1, 100);
                $res = Data_Mysql_Table_Demand::page(0, 30, $cols, $conditions, 'ORDER BY {table}.create_time DESC',
                    $table);

                break;
            case 'end':             //已完成
                $conditions['t1.step=?'] = 100;
                $res = Data_Mysql_Table_Demand::page(0, 30, $cols, $conditions, 'ORDER BY {table}.create_time DESC',
                    $table);
                break;
            case 'abandon':             //已关闭
                $conditions['t1.step<?'] = 0;
                $res = Data_Mysql_Table_Demand::page(0, 30, $cols, $conditions, 'ORDER BY {table}.create_time DESC',
                    $table);
                break;
            default:
                Func_Header::back('错误！');
                break;
        }
        if (!empty($res['rows'])) {

            $adminALL = self::getMemberList('销售部');
            foreach ($adminALL as $k => $val) {
                $salephone[$val['phone']]['fullname'] = $val['city'] . '-' . $val['fullname'];
            }
            $salephone[9]['fullname'] = '报价系统';
            Tpl_Smarty::assign('sale_name', $salephone);

            foreach ($res['rows'] as $k => $val) {
                $res['rows'][$k]['demand'] = json_decode($val['demand'], 1);
//                //2/2 日
//                //在这个时间之前的 进度有问题
//                if ($val['create_time'] < 1452700800) {
//
//                    if (empty($val['sale_phone']) && !empty($val['response_account_id'])) {
//                        $account_two = Data_Mysql_Table_Account::select('phone', array('id=?' => array($val['response_account_id'])));
//                        if (!empty($account_two[0]['phone'])) {
//                            $update['sale_phone'] = $account_two[0]['phone'];
//                        }
//                    }
//                    if (!empty($val['step']) && empty($val['grab_step'])) {
//
//                        $near = self::near($val['step']);
//                        $update['step'] = $near;
//                    }
//                    if (!empty($update)) {
//                        if (!empty($val['grab_id'])) {
//                            $update['id'] = intval($val['id']);
//                            Data_Mysql_Table_Grab_Order::update($update);
//                        } else {
//                            $update['status'] = 1;
//                            if (!empty($val['backup_demand'])) {
//                                $backup_demand = json_decode($val['backup_demand'], 1);
//                                $update['customer_phone'] = $backup_demand['联系电话'];
//                            } else {
//                                $update['customer_phone'] = $val['phone'];
//                            }
//                            $update['notice_time'] = $val['create_time'];
//                            $update['create_time'] = $val['create_time'];
//                            Data_Mysql_Table_Grab_Order::insert($update);
//                        }
//                    }
//                }
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
        $getResponse = self::getMemberList($department);
        Tpl_Smarty::assign('admin', $getResponse);
        foreach ($getResponse as $k => $v) {
            if (!empty($v['response_account_id'])) {
                $admin_account[$v['response_account_id']] = $v;
            }
        }
        Tpl_Smarty::assign('admin_account', $admin_account);

        Tpl_Smarty::assign('type', $type);
        Tpl_Smarty::assign('total', $total);
        Tpl_Smarty::assign('_step_funnel', Data_Mysql_Table_Demand::$step_funnel);
        Tpl_Smarty::assign('_data', $res);
        Tpl_Smarty::assign('_demandType', Data_Mysql_Table_Demand::$_demandType);

        Tpl_Smarty::display('OA_Static::Demand.v2.0/department_demand_list_all.tpl');
    }

    static function  near($x)
    {
        $array = Data_Mysql_Table_Demand::$grab_order_step;
        $arr1 = array_keys($array);
        $count = count($arr1);
        for ($i = 0; $i < $count; $i++) {
            $arr2[] = abs($x - $arr1[$i]);
        }

        $min = min($arr2);
        for ($i = 0; $i < $count; $i++) {
            if ($min == $arr2[$i]) {
                return $arr1[$i];
            }
        }

    }

    //获取组联系人信息
    static function getTeamList($department, $team_name, $city)
    {
        $getAdmin = array();
        $conditions = array(
            'department_name' => $department,
            'team_name like ?' => $team_name . '%',
        );
        $conditions[] = '{prefix}administrator.status = 1';
        if ($city) {
            $conditions['{table}.city=?'] = $city;
        }
        if (!$team_name) {
            unset($conditions['team_name like ?']);
            $conditions['team_name'] = '';
        }
        $table = '{table}  RIGHT JOIN {prefix}administrator  ON {table}.admin_id = {prefix}administrator.id LEFT JOIN {prefix}account  ON {prefix}administrator.phone = {prefix}account.phone';
        $res = Data_Mysql_Table_Department_Member::select('{table}.*,{prefix}administrator.id as admin_id,{prefix}administrator.phone,{prefix}administrator.fullname,{prefix}account.id as response_account_id',
            $conditions, 'GROUP BY {prefix}administrator.id', 9999, $table);

        if (!empty($res)) {
            foreach ($res as $k => $v) {
                if (!empty($v['admin_id'])) {
                    $getAdmin[$k] = $v;
                }
            }
        }
        return $getAdmin;
    }

    //获取部门的联系人信息
    static function getMemberList($department, $city = '', $is_alladmin = '')
    {
        $getAdmin = array();

        if (empty($is_alladmin) && !empty($city)) {
            $conditions['t1.city =?'] = $city;
        }
        $conditions['t1.department_name =?'] = $department;
        $conditions[] = 't2.status = 1';
        $table = '{table} as t1 LEFT JOIN {prefix}administrator as t2 ON t1.admin_id = t2.id LEFT JOIN {prefix}account as t3 ON t2.phone = t3.phone';
        $re = Data_Mysql_Table_Department_Member::select('t1.*,t2.id as admin_id,t2.phone, t2.fullname,t3.id as response_account_id',
            $conditions, ' GROUP BY t2.id ORDER BY t1.city ASC', 9999, $table);
        if (!empty($re)) {
            foreach ($re as $k => $v) {
                if (!empty($v['admin_id'])) {
                    $getAdmin[$k] = $v;
                }
            }
        }
        return $getAdmin;
    }

//修改纪录
    static function ajaxCustomerStepUpdate()
    {
        @session_start();
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
        if (mb_strwidth($request['reason'], 'UTF-8') < 8) {
            Func_Output::json('error', '', '原因至少输入5个字！');
        }
        $demand_time = Data_Mysql_Table_Demand::select('phone,demand_type,create_time',
            array('id=?' => array($request['id'])));
        if (empty($demand_time[0]['create_time'])) {
            Func_Output::json('error', '', '刷新重试');
        }
        //创建时间大于  13 号的需要验证
        if ($demand_time[0]['create_time'] > 1452700800) {

            $status = Data_Mysql_Table_Grab_Order::select('sale_phone', array('id=?' => $request['id']));
            if (empty($status[0]['sale_phone'])) {
                Func_Output::json('error', '', '该需求没有负责人无法修改其进度，请先分配负责人！');
            }
            if (empty($request['reason'])) {
                Func_Output::json('error', '', '请填写备注！');
            }
            $order = Api_Grab_Order_Get_Info::getInfo(array(
                'id' => $request['id'],
                'phone' => $status[0]['sale_phone']
            ));
            if (empty($order['data'])) {
                Func_Output::json('error', '', '没有找到数据信息~');
            }
            if (($order['data']['step'] >= $request['step']) && $request['step'] > 0) {
                Func_Output::json('error', '', '不能小于当前进度哦~');
            }
        }

        if ($request['step'] < 0) {
            $update = array('id' => $request['id'], 'status' => '-1', 'step' => '-1');
        } else {
            $update = array('id' => $request['id'], 'step' => $request['step']);
        }
        if ($demand_time[0]['create_time'] < 1452700800) {
            $is_order = Data_Mysql_Table_Grab_Order::select('sale_phone', array('id=?' => array($request['id'])));
            if (empty($is_order[0]['sale_phone'])) {

                $admin = Api_Administrator_getBaseInfo::getAdminInfo(array('admin_id' => $admin_id));
                $update['status'] = 1;
                $update['sale_phone'] = $admin['phone'];
                $update['customer_phone'] = $demand_time[0]['phone'];
                $update['notice_time'] = $demand_time[0]['create_time'];
                $update['create_time'] = $demand_time[0]['create_time'];

            }
        }
        $rs = Data_Mysql_Table_Grab_Order::update($update);
        $data = array(
            'demand_id' => $request['id'],
            'step' => $request['step'],
            'admin_id' => $admin_id,
            'reason' => $request['reason']
        );

        /**处理积分 开始**/
        $step_integral = Data_Mysql_Table_Demand::$step_integral;
        if (isset($step_integral[$request['step']])) {
            if ($request['step'] == 100) {
                $integral = $order['data']['integral'] * 7;
            } else {
                $integral = $step_integral[$request['step']];

            }
            $log = Api_Administrator_Integral_Manage::integralManages(array(
                'phone' => $_SESSION['administrator']['phone'],
                'type' => 'add',
                'reason' => '更新订单进度.ID=' . $request['id'],
                'title' => '更新订单进度',
                'integral' => $integral,
                'demand_id' => $request['id'],
            ));
            Core::log('grab_order_error', '积分记录' . $log['msg'] . '/ID=' . $request['id'] . '===<>');
        } elseif ($request['step'] < 0 && ($order['data']['integral'] > 0)) {
            //如没有联系 就扣分
            if (($order['data']['step'] == 0 && empty($request['reason'])) ||
                $order['data']['demand_type'] == '销售创建'
            ) {
                //如果是关闭
                if ($order['data']['demand_type'] == '销售创建') {
                    $number = $order['data']['integral'];
                } else {
                    $number = ($order['data']['integral'] * 2);
                }

                $log = Api_Administrator_Integral_Manage::integralManages(array(
                    'phone' => $_SESSION['administrator']['phone'],
                    'type' => 'reduce',
                    'reason' => '更新订单进度.ID=' . $request['id'],
                    'title' => '关闭订单',
                    'integral' => $number,
                    'demand_id' => $request['id'],
                ));

            } else {
                //2016 3 2  关闭将扣减的积分还回去
                $log = Api_Administrator_Integral_Manage::integralManages(array(
                    'phone' => $_SESSION['administrator']['phone'],
                    'type' => 'add',
                    'reason' => '更新订单进度.ID=' . $request['id'],
                    'title' => '更新订单进度',
                    'integral' => $order['data']['integral'],
                ));
            }
        }
        /**处理积分 结束**/

        if ($rs[0] > 0) {
            Data_Mysql_Table_Demand_Step_Record::insert($data);

            Data_Mysql_Table_Account_Log::insertAccountLog('1', $admin_id,
                'ID为' . $request['id'] . '需求进度改为' . $request['step'] . '成功', '需求进度', $request['id']);
            Func_Output::json('success', '', ' 修改成功 ');
        }
        Func_Output::json('error', '', '修改失败,请稍后再试！');
    }

    // 需求通知负责人
    static function handleNoticeAdmin()
    {
        Core::output('');
        $request = Func_Input::filter(
            array(
                'sale_phone' => 'int',
            ), $_REQUEST);
        // q($request);
        if (empty($request['sale_phone'])) {
            Func_Header::back('请求异常');
        }
        $getEmail = Data_Mysql_Table_Administrator::select('fullname,email,id',
            array('phone =?' => $request['sale_phone']), '', 1);
        if (!empty($getEmail[0])) {
            $data['account_id'] = $getEmail[0]['id'];
            $data['email'] = $getEmail[0]['email'];
            $data['notice_type'] = 1;
            Api_Demand_Notice::noticeSalePersonnel($data);
            Func_Output::json('success', '', $da['msg'] = '已通知到' . $getEmail[0]['fullname']);
        }
    }

    static function  ajaxRecommendSubmit()
    {
        Core::output('');
        $request = Func_Input::filter(array(
            'demand_id' => 'int',
            'set_id' => 'int',
            'demo' => 'string',
            'product_id' => 'int',
        ));
        if (empty($request['demand_id']) && (empty($request['set_id']) && empty($request['product_id']))) {
            Func_Output::json('error', '', '缺少参数');
        }
        $account = Api_Administrator_GetBaseAccountInfo::getBastAccountInfo(array('admin_id' => Api_Session::admin_id()));
        $status = Api_Recommend_Add::addRecommend(array(
            'account_id' => $account['account_id'],
            'product_id' => $request['product_id'],
            'set_id' => $request['set_id'],
            'demand_id' => $request['demand_id'],
            'demo' => $request['demo'],
            'only_add' => 0,
        ));
        if ($status['status'] == 1) {

            Func_Output::json('success', '', $status['msg']);
        }
        Func_Output::json('error', '', $status['msg']);

    }


}