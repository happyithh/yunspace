<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2015/7/15
 * Time: 13:26
 * 部门需求管理
 */
class OA_Demand_Lists
{
    //$is_offer传值判断所以需求是否含有报价
    static function handle($department, $is_team, $is_all, $is_my = '', $is_offer = "")
    {
        $action = empty($_REQUEST['action']) ? 'list' : $_REQUEST['action'];
        switch ($action) {
            case 'list':
                self::handleDepartmentDemandList($department, $is_team, $is_all, $is_my, $is_offer);
                break;
            case 'add_contact_record':
                OA_Demand_Detail::handleAddContactRecord();
                break;
            case 'ajaxCustomerStepUpdate':
                OA_Demand_Lists_All::ajaxCustomerStepUpdate();
                break;
            case 'ajaxRecommendSubmit':
                self::ajaxRecommendSubmit();
                break;
            case 'demand_edit_tpl':
                OA_Demand_Edit::handleDemandEditTpl();
                break;
            case 'demand_edit_submit':
                OA_Demand_Edit::handleDemandEditFrom();
                break;
            case 'pdf':
                if (empty($_REQUEST['product_id'])) {
                    Func_Header::notFound();
                }
                Web_User_Center_Pdf::handleProductPdf($_REQUEST['product_id']);
                break;
            case 'set_pdf':
                if (empty($_REQUEST['set_id'])) {
                    Func_Header::notFound();
                }
                Web_User_Center_Pdf::handleProductSetPdf($_REQUEST['set_id']);
                break;
            case 'remark':
                OA_Demand_Detail::handleDemandCreateRemark();
                break;
            case 'selectremark':
                OA_Demand_Detail::handleDemandSelectRemark();
                break;
            case 'contact_detail_from':
                OA_Demand_Detail::handleContactFrom();
                break;
            case 'contact_detail_from_submit':
                OA_Demand_Detail::handleContactFromSubmit();
                break;
            case 'takeLook':
                OA_Demand_Detail::handleTakeLook();
                break;
            case 'tender_create':
                self::tenderCreate();
                break;
            case 'tender_audit':
                self::tenderAudit();
                break;
            case 'tender_sendMessage':
                self::tenderSendMessage();
                break;
            case 'ajaxNoticeAdmin':
                self::handleNoticeAdmin();
                break;
            case 'demand_info':
                OA_Demand_All_Detail::handleDemandInfo($department, $is_team, $is_all, $is_my, $is_offer);
                break;
        }
    }


    static function handleDepartmentDemandList($department, $is_team, $is_all, $is_my = '', $is_offer = '')
    {
        if (!empty($is_my)) {
            OA_Demand_Lists_All::handleMyDemandList();
            die();
        }
        $conditions = array();
        $account_id = array();
        $admin_ids = array();
        $admins = array();
        // 对城市进行处理
        $city = empty($_REQUEST['city']) ? '' : $_REQUEST['city'];
        if (empty($_REQUEST['city'])) {
            $getCity = Api_Administrator_Department_Normal_Api::getMemberInfo($department, $_SESSION['administrator']['id']);
            if (!empty($getCity['city'])) {
                $city = $getCity['city'];
            } else {
                $city = '上海';
            }
        }
        //  获取(组/部门/全部)所有管理员信息
        if (!empty($is_team)) {

            $getTeam = Api_Administrator_Department_Normal_Api::getMemberInfo($department, $_SESSION['administrator']['id']);
            if (!empty($getTeam['team_name'])) {
                $getResponse = self::getTeamList($department, $getTeam['team_name'], $city);
            } else {
                die('请添加自身到部门管理员！！');
            }
        } else {
            $getResponse = self::getMemberList($department, empty($is_all) ? $city : '', '');
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
                'demandType' => 'string',
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
            if (!empty($search['demandType'])) {
                $conditions['{table}.demand_type =?'] = $search['demandType'];
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
            '{table}.*', '{prefix}contact_library.id as contact_id', 't3.id as offer_id,t3.status as offer_status'
        );

        $table = '{table} LEFT JOIN {prefix}contact_library ON {table}.phone = {prefix}contact_library.phone LEFT JOIN {prefix}demand_offer as t3 ON {table}.id=t3.demand_id';

        $conditions['{table}.demand_status=?'] = 1;

        //类型切换
        $type = empty($_REQUEST['type']) ? 'all' : $_REQUEST['type'];

        $totalAll = Data_Mysql_Table_Demand::select('COUNT(*) as c', $conditions);
        $waitingConditions = $conditions;
        $waitingConditions['step =?'] = 0;
        $totalWaiting = Data_Mysql_Table_Demand::select('COUNT(*) as c', $waitingConditions);
        $doneConditions = $conditions;
        $doneConditions['step >=? AND step<?'] = array(1, 100);
        $totalDone = Data_Mysql_Table_Demand::select('COUNT(*) as c', $doneConditions);
        $endConditions = $conditions;
        $endConditions['step =?'] = 100;
        $totalEnd = Data_Mysql_Table_Demand::select('COUNT(*) as c', $endConditions);
        $abandonConditions = $conditions;
        $abandonConditions['step <?'] = 0;
        $totalAbandon = Data_Mysql_Table_Demand::select('COUNT(*) as c', $abandonConditions);
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
        //是否显示报价需求
        if (empty($is_offer)) {
            $conditions[] = 't3.id IS NULL';
        }
        switch ($type) {
            case'all':
                $res = Data_Mysql_Table_Demand::page(0, 30, $cols, $conditions, 'ORDER BY {table}.create_time DESC', $table);
                break;
            case 'waiting':             //待处理
                $conditions['step =?'] = 0;
                $res = Data_Mysql_Table_Demand::page(0, 30, $cols, $conditions, 'ORDER BY {table}.create_time DESC', $table);
                break;
            case 'done':                //已处理
                $conditions['step >=? AND step<?'] = array(1, 100);
                $res = Data_Mysql_Table_Demand::page(0, 30, $cols, $conditions, 'ORDER BY {table}.create_time DESC', $table);

                break;
            case 'end':             //已完成
                $conditions['step=?'] = 100;
                $res = Data_Mysql_Table_Demand::page(0, 30, $cols, $conditions, 'ORDER BY {table}.create_time DESC', $table);
                break;
            case 'abandon':             //已关闭
                $conditions['step<?'] = 0;
                $res = Data_Mysql_Table_Demand::page(0, 30, $cols, $conditions, 'ORDER BY {table}.create_time DESC', $table);
                break;
            default:
                Func_Header::back('错误！');
                break;
        }
        //  q($res);
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
        Tpl_Smarty::assign('_adminInfo', $admins);
        Tpl_Smarty::assign('admin', $getResponse);
        Tpl_Smarty::assign('type', $type);
        Tpl_Smarty::assign('total', $total);
        Tpl_Smarty::assign('_step_funnel', Data_Mysql_Table_Demand::$step_funnel);
        Tpl_Smarty::assign('_data', $res);
        Tpl_Smarty::assign('_demandType', Data_Mysql_Table_Demand::$_demandType);
        Tpl_Smarty::display('OA_Static::demands/department_demand_list.tpl');
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
        $re = Data_Mysql_Table_Department_Member::select('t1.*,t2.phone, t2.fullname,t3.id as response_account_id', $conditions, 'GROUP BY t2.id', 9999, $table);
        if (!empty($re)) {
            foreach ($re as $k => $v) {
                if (!empty($v['admin_id'])) {
                    $getAdmin[$k] = $v;
                }
            }
        }
        return $getAdmin;
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
        $res = Data_Mysql_Table_Department_Member::select('{table}.*, {prefix}administrator.fullname,{prefix}account.id as response_account_id', $conditions, 'GROUP BY {prefix}administrator.id', 9999, $table);

        if (!empty($res)) {
            foreach ($res as $k => $v) {
                if (!empty($v['admin_id'])) {
                    $getAdmin[$k] = $v;
                }
            }
        }
        return $getAdmin;
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

    // 需求通知负责人
    static function handleNoticeAdmin()
    {
        Core::output('');
        $request = Func_Input::filter(
            array(
                'account_id' => 'int',
            ), $_REQUEST);
        if (empty($request['account_id'])) {
            Func_Header::back('请求异常');
        }
        $getEmail = Data_Mysql_Table_Account::select('{prefix}administrator.fullname,{table}.email', array('id' => $request['account_id']), '', 1, '{table} LEFT JOIN {prefix}administrator ON {table}.phone={prefix}administrator.phone');
        if (!empty($getEmail[0])) {
            $data = $_REQUEST;
            $data['email'] = $getEmail[0]['email'];
            $data['notice_type'] = 1;
            Api_Demand_Notice::noticeSalePersonnel($data);
            Func_Output::json('success', '', $da['msg'] = '已通知到' . $getEmail[0]['fullname']);
        }
    }

    //添加需求到报价系统（初期是由客服选择 。现在由销售（代理人）来选择）
    static function tenderCreate()
    {
        $request = Func_Input::filter(array(
            'demand_id' => 'int',
        ), $_REQUEST);
        if (empty($request['demand_id'])) {
            Func_Header::back('不正确的操作');
        }
        $oldDemand = Data_Mysql_Table_Demand::select('account_id,demand', array('id =?' => $request['demand_id']));
        if (empty($oldDemand[0]['demand'])) {
            Func_Header::back('该需求不存在，请返回列表页重试');
        }
        $result = Data_Mysql_table_Demand_Tender::select('id', array("demand_id=?" => $request['demand_id']), '', 1);
        if (!empty($result) && isset($result[0]['id'])) {
            Func_Header::to(' 已提交至报价系统，不要重复提交，注意查收邮件获取最新报价！ ');
        }
        $rs = Api_Demand_Tender_Create::create(array('demand_id' => $request['demand_id'], 'type' => 1));
        if ($rs) {
            Func_Header::to(' 创建成功，等待供应商报价，注意查收邮件！ ');
        } else {
            Func_Header::back('创建失败！385569');
        }
    }

    //反馈方案的确认和取消
    static function tenderAudit()
    {
        $request = Func_Input::filter(array(
            'tender_id' => 'int',
            'status' => 'int',
        ), $_REQUEST);
        if (empty($request['tender_id']) || empty($request['status'])) {
            Func_Header::back('参数错误414');
        }
        //如果通过审核是否需要发送短信给客户，还是另外进行操作 todo
        $condition = array('tender_id=?' => $request['tender_id']);
        $rs = Data_Mysql_Table_Demand_Tender_Scheme::update($condition, array('agent_status=?' => $request['status']));
        if ($rs) {
            Func_Header::to(' 操作成功 ');
        } else {
            Func_Header::to('操作失败');
        }
    }

    //暂时代理人不发短信给客户了。此方法暂时不用
    static function tenderSendMessage()
    {
        $request = Func_Input::filter(array(
            'tender_id' => 'int',
        ), $_REQUEST);
        if (empty($request['tender_id'])) {
            Func_Header::back('参数错误414');
        }
        Api_Demand_Tender_NoticeCustomer::newSchemeNotice($request);
    }


}