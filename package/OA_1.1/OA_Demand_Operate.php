<?php

/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 15-3-31
 * Time: 上午11:39
 * 运营部管理---需求管理
 * yl
 */
class OA_Demand_Operate
{
    static function handle()
    {
        $action = empty($_REQUEST['action']) ? 'list' : $_REQUEST['action'];
        switch ($action) {
            case 'list':
                self::demandList();
                break;
            case 'detail':
                self::demandDetail();
                break;
            case 'abandon':
                self::demandAbandon();
                break;
            case 'receive':
                self::handleDemandReceive();
                break;
            case 'receive_from_submit':
                self::handleDemandReceiveFromSubmit();
                break;
            case 'ajaxSelectRecentDemand':
                OA_Demand_getRecent::getRecentDemand();
                break;
            case 'offer':
                self::handleDemandOffer();
                break;
            case 'backout':
                self::handleDemandBackout();
                break;
            default :
                self::demandList();
                break;
        }
    }


    /*
     *需求管理
     */
    static function demandList()
    {
        $type = isset($_REQUEST['type']) ? $_REQUEST['type'] : "all";
        $order = 'order by create_time desc';
        $conditions = array();
        //获取所有需求总数
        $totalNum = array(
            '0' => 0,
            '1' => 0,
            '-1' => 0,
            '2' => 0,
            '5' => 0
        );
        if (!empty($_REQUEST['search'])) {
            $search = Func_Input::filter(array(
                'city' => 'string',
                'demandType' => 'string',
                'start_time' => 'string',
                'end_time' => 'string',
                'username' => 'string',
                'phone' => 'int',
                'no' => 'int',
                'demand_level' => 'int',
            ), $_REQUEST['search']);
            if (!empty($search['city'])) {
                $conditions['city'] = $search['city'];
            }
            if (isset($search['demand_level'])) {
                $conditions['demand_level'] = $search['demand_level'];
            }
            if (!empty($search['demandType'])) {
                $conditions['demand_type'] = $search['demandType'];
            }
            if (!empty($search['start_time']) && !empty($search['end_time'])) {
                if (strtotime($search['start_time']) > strtotime($search['end_time'])) {
                    Func_Header::back('请正确选择时间范围！！');
                } else {
                    $conditions['create_time between ? and ?'] = array(strtotime($search['start_time']), strtotime($search['end_time']));
                }
            } elseif (!empty($search['start_time']) && empty($search['end_time'])) {
                $conditions['create_time > ?'] = strtotime($search['start_time']);
            } elseif (empty($search['start_time']) && !empty($search['end_time'])) {
                $conditions['create_time < ?'] = strtotime($search['end_time']);
            }
            if (!empty($search['username'])) {
                $conditions['demand_name like ?'] = '%' . $search['username'] . '%';
            }
            if (!empty($search['phone'])) {
                $conditions['phone'] = $search['phone'];
            }
            if (!empty($search['no'])) {
                $conditions['(id =? OR id =?)'] = array($search['no'], Func_NumEncode::d($search['no']));
            }
            $countCondition = $conditions;
        }
        //搜索tab进行处理
        if (!empty($_REQUEST['search'])) {
            $searchArray = 'search[city]=' . $search['city'] . '&search[demandType]=' . $search['demandType'] . '&search[start_time]=' . $search['start_time'] . '&search[end_time]=' . $search['end_time'] . '&search[username]=' . $search['username'] . '&search[phone]=' . $search['phone'];
            Tpl_Smarty::assign('urls', $searchArray);
        }
        $countCondition[] = '1 GROUP BY demand_status';
        $total = Data_Mysql_Table_Demand::select('count(*) as count, demand_status', $countCondition, '', 4);
        foreach ($total as $v) {
            $totalNum[$v['demand_status']] = $v['count'];
            $totalNum[2] += $v['count'];
        }
        //获取所有未处理需求
        switch ($type) {
            case 'all':
                /**
                 * 测试状态的需求不显示在全部里面
                 */
                $conditions['demand_status !=?'] = 5;
                $data = Data_Mysql_Table_Demand::page(0, 0, '*', $conditions, $order);
                break;
            case 'waiting':
                $conditions['demand_status'] = 0;
                $data = Data_Mysql_Table_Demand::page(0, 0, '*', $conditions, $order);
                break;
            case 'done':
                $conditions['demand_status'] = 1;
                $data = Data_Mysql_Table_Demand::page(0, 0, '*', $conditions, $order);
                break;
            case 'abandon':
                $conditions['demand_status'] = '-1';
                $data = Data_Mysql_Table_Demand::page(0, 0, '*', $conditions, $order);
                break;
            case 'offer':
                $conditions['demand_status'] = 5;
                $data = Data_Mysql_Table_Demand::page(0, 0, '*', $conditions, $order);
                break;
            default :
                $data = Data_Mysql_Table_Demand::page(0, 0, '*', '', $order);
                break;
        }
        if (!empty($data['rows'])) {
            $demand = self::changeArr($data);
            foreach ($demand['rows'] as $k => $v) {
                if (!empty($v['resolve_time'])) {
                    $demand['rows'][$k]['response'] = self::response($v['create_time'], $v['resolve_time']);
                } else {

                    $demand['rows'][$k]['response'] = self::response($v['create_time'], $v['refuse_time']);
                }
            }
            Tpl_Smarty::assign('_data', $demand);
        }
        Tpl_Smarty::assign('type', $type);
//        Tpl_Smarty::assign('_total', array_sum($totalNum));
        Tpl_Smarty::assign('_waitingtotal', $totalNum['0']);
        Tpl_Smarty::assign('_donetotal', $totalNum['1']);
        Tpl_Smarty::assign('_abandontotal', $totalNum['-1']);
        Tpl_Smarty::assign('_alltotal', $totalNum[2]);
        Tpl_Smarty::assign('_offertotal', $totalNum[5]);
        Tpl_Smarty::assign('_demandType', Data_Mysql_Table_Demand::$_demandType);
        Tpl_Smarty::display('OA_Static::demands/operate/operate_demand.tpl');
    }

    /*
     * 查看需求详情
     */
    static function demandDetail()
    {
        if (empty($_REQUEST['id'])) {
            Func_Header::notFound();
        }
        $demandInfo = Data_Mysql_Table_Demand::select('tb1.*,tb2.id as offer_id', array('tb1.id=?' => $_REQUEST['id']), '', 1, '{table} as tb1 LEFT JOIN  {prefix}demand_offer as tb2 ON tb1.id=tb2.demand_id');
        $demand = self::changeArr($demandInfo);
        Tpl_Smarty::assign('recent_demand', Api_Demand_Admin_Recent::getRecent(array('phone' => $demand[0]['phone'], 'demand_id' => $_REQUEST['id'])));
        foreach ($demand as $k => $v) {
            if (!empty($v['demand_reason'])) {
                $demand[$k]['demand_reason'] = json_decode($v['demand_reason'], 1);
            }
            $demand[$k]['response'] = self::response($v['create_time'], $v['resolve_time']);
        }

        Tpl_Smarty::assign('_demand', $demand[0]);
        Tpl_Smarty::display('OA_Static::demands/operational_demand_detail.tpl');

    }

//响应时间
    static function response($create, $resolve, $type = '')
    {
        if (empty($resolve)) {
            return false;
        } elseif ($resolve < $create) {
            return Null;
        } elseif ($resolve == $create) {
            return Null;
        } else {
            $time = $resolve - $create;
        }
        $year = floor($time / 60 / 60 / 24 / 365);
        $time -= $year * 60 * 60 * 24 * 365;
        $month = floor($time / 60 / 60 / 24 / 30);
        $time -= $month * 60 * 60 * 24 * 30;
        $day = floor($time / 60 / 60 / 24);
        $time -= $day * 60 * 60 * 24;
        $hour = floor($time / 60 / 60);
        $time -= $hour * 60 * 60;
        $minute = floor($time / 60);
        $time -= $minute * 60;
        $second = $time;
        $elapse = '';

        $unitArr = array('年' => 'year', '个月' => 'month', '天' => 'day',
            '小时' => 'hour', '分钟' => 'minute', '秒' => 'second'
        );
        switch ($type) {
            case 'DHM':
                $elapse = $day . '天' . $hour . '小时' . $minute . '分钟';
                break;
            default:
                foreach ($unitArr as $cn => $u) {
                    if ($u == 'year') {
                        if ($$u > 0) {
                            $elapses[] = $$u . $cn;

                        }
                    } elseif ($u == 'month') {
                        if ($$u > 0) {
                            $elapses[] = $$u . $cn;
                        } elseif ($year > 0 && $$u > 0) {
                            $elapses[] = $$u . $cn;
                        }
                    } elseif ($u == 'day') {
                        if ($$u > 0) {
                            $elapses[] = $$u . $cn;
                        } elseif ($month > 0 && $$u > 0) {
                            $elapses[] = $$u . $cn;
                        }
                    } elseif ($u == 'hour') {
                        if ($$u > 0) {
                            $elapses[] = $$u . $cn;
                        } elseif ($day > 0 && $$u > 0) {
                            $elapses[] = $$u . $cn;
                        }
                    } elseif ($u == 'minute') {
                        if ($$u > 0) {
                            $elapses[] = $$u . $cn;
                        } elseif ($hour > 0 && $$u > 0) {
                            $elapses[] = $$u . $cn;
                        }
                    } elseif ($u == 'second') {

                        if (empty($year) && empty($month) && empty($day) && empty($hour) && empty($minute) && $$u > 0) {
                            $elapses[] = '';
                        } elseif ($minute > 0 && $$u > 0) {
                            $elapses[] = '';
                        }

                        break;
                    }


                };
        }
        return $elapses;


    }

    /**
     * 接收需求
     */
    static function  handleDemandReceive()
    {
        $request = Func_Input::filter(array(
            'demand_id' => 'int',
        ), $_REQUEST);
        $demandInfo = Data_Mysql_Table_Demand::select('*', array('id' => $request['demand_id']));
        $dataDemand = self::changeArr($demandInfo);
        Tpl_Smarty::assign('demand_options', Data_Demand_Option_Config::all());
        Tpl_Smarty::assign('_demand', $dataDemand[0]);
        Tpl_Smarty::assign('_demandType', Data_Mysql_Table_Demand::$_demandType);
        Tpl_Smarty::assign('categoryList', Data_Mysql_Table_Product_Category::getTreeCache());
        $tags = Data_Config_Vendor_Attr::get('attr');
        if (!empty($tags['活动类型'])) {
            Tpl_Smarty::assign('tags', $tags['活动类型']);
        }
        $categoryTree = Data_Mysql_Table_Product_Category::getTreeCache();
        if (!empty($categoryTree)) {
            Tpl_Smarty::assign('categoryTree', $categoryTree);
        }

        Tpl_Smarty::display('OA_Static::demands/demand_edit.tpl');
    }

//接收需求表单
    static function  handleDemandReceiveFromSubmit()
    {
        $request = Func_Input::filter(array(
            'demand_id' => 'int',
            'notice_city' => 'string',
            'notice_team' => 'string',
            'notice_department' => 'string',
            'demand_name' => 'string',
            'data' => 'array',
            'price_up' => 'int',
            'price_down' => 'int',
            'is_offer' => 'int',
        ), $_REQUEST);
        $demand = Func_Input::filter(array(
            '联系电话' => 'string',
            '联系人' => 'string',
            '公司名称' => 'string',
//            '业务类型' => 'string',
//            '业务子类' => 'string',
            '场地类型' => 'string',
            '活动类型' => 'string',
            '活动人数' => 'string',
            '开始时间' => 'string',
            '结束时间' => 'string',
            '需求场地' => 'string',
            '具体要求' => 'string',
        ), $request['data']);

        $demand['price_up'] = $request['price_up'];
        $demand['price_down'] = $request['price_down'];
        $demand['城市'] = $request['notice_city'];
        $oldDemand = Data_Mysql_Table_Demand::select('account_id,demand', array('id =?' => $request['demand_id']));
        if (empty($oldDemand[0]['demand'])) {
            Func_Header::back('该需求不存在，请返回列表页重试');
        }
        $GroupLeader_Admin = 0;
        //如果不是 提交到需求竞标  就去发短信通知
        if (empty($request['is_offer'])) {
            if (empty($request['notice_city']) || empty($request['notice_team']) || empty($request['notice_department'])) {
                Func_Header::back('请选择要通知的部门');
            }
            $groupLeader = self::noticeGroupLeader($request);

            $GroupLeader_Admin = $groupLeader['admin_id'];
        }
        foreach ($demand as $k => $v) {
            if ($v == '') {
                unset($demand[$k]);
            }
        }
        $oldDemand['demand'] = json_decode($oldDemand[0]['demand'], true);
        $newDemand = array_merge($oldDemand['demand'], $demand);
        $demand['account_id'] = $oldDemand[0]['account_id'];
        $newData = array(
            'demand_id' => $request['demand_id'],
            'demand_name' => $request['demand_name'],
            'demand_status' => 1,
            'city' => $request['notice_city'],
            'admin_id' => $GroupLeader_Admin,
            'resolve_time' => time(),
            'price_up' => $request['price_up'],          //价格上限
            'price_down' => $request['price_down'],
            'demand' => $newDemand,
        );
        $status = Api_Demand_Edit::demandEdit($newData);

        if ($status) {

            $data = array(
                'username' => $demand['联系人'],
                'phone' => $demand['联系电话'],
                'city' => $demand['城市'],
//                'business' => $demand['业务类型'],
//                'sub_business' => $demand['业务子类'],
                'type' => 1,
                'create_time' => time(),
                'account_id' => $demand['account_id'],
                'price_up' => $demand['price_up'],
                'price_down' => $demand['price_down'],
            );
            $contacts = Data_Mysql_Table_Contact_Library::update($data);

            $account = Data_Mysql_Table_Demand::select('account_id', array('id =?' => $request['demand_id']));
            //创建操作日志
            Data_Mysql_Table_Account_Log::insertAccountLog($account[0]['account_id'], $_SESSION['administrator']['id'], '接受需求', '审核需求', $request['demand_id']);
            /***
             *   //如果是提交到报价系统
             */
            if (!empty($request['is_offer']) && $request['is_offer'] == 1) {
                //直接跳转
                Func_Header::to('', 'http://' . Core::$urls['host'] . Core::$urls['root'] . Core::$urls['package'] . 'operation/demand_tender?act=demand_offer&demand_id=' . $request['demand_id']);
//                Api_Demand_Tender_Create::create(array('demand_id' => $request['demand_id']));
//                Data_Mysql_Table_Account_Log::insertAccountLog($oldDemand[0]['account_id'],
//                    $_SESSION['administrator']['id'], '创建需求竞标', '需求竞标', $request['demand_id']);
            }
            Func_Header::to('  操作成功', Core::$urls['base_path'] . '?action=list');

        }
        Func_Header::back('操作失败，请返回列表页重试', Core::$urls['base_path'] . '?action=list');
    }

    /*
     * 放弃需求
     */
    static function demandAbandon()
    {
        Core::output('');
        $request = Func_Input::filter(array(
            'id' => 'int',
            'demo' => 'string',
            'reason' => 'string',
        ));

        if (empty($request['id'])) {
            Func_Header::notFound();
        }
        if (empty($request['reason'])) {
            Func_Output::json('error', '', '理由不能为空');
        }
        $condition = array('id' => $_REQUEST['id']);
        $data = array(
            'demand_status' => -1,
            'demand_reason' => array($request['reason'], $request['demo']),
            'refuse_time' => time(),
        );
        $rs = Data_Mysql_Table_Demand::update($condition, $data);
        if ($rs[0] > 0) {
            $account = Data_Mysql_Table_Demand::select('account_id', array('id =?' => $request['id']));
            Data_Mysql_Table_Account_Log::insertAccountLog($account[0]['account_id'], $_SESSION['administrator']['id'], '放弃需求', '审核需求', $request['id']);

            Func_Output::json('success', '', '  需求放弃成功');
        }
        Func_Output::json('error', '', '需求放弃失败');

    }


    static function  noticeGroupLeader($request)
    {
        //新需求通知销售组长
        $department_contacts = Data_Mysql_Table_Department_Member::select('t1.admin_id,t2.email',
            array('t1.department_name =?' => $request['notice_department'],
                't1.team_name LIKE ?' => $request['notice_team'] . '%',
                't1.city  =?' => $request['notice_city'],
                't1.level =?' => 1,
            ), '', 5, "{table} as t1 RIGHT JOIN {prefix}administrator as t2 ON t1.admin_id = t2.id");
        if (empty($department_contacts[0])) {

            Func_Header::back('这个小组没有设置组长，请联系这个组设置组长');
        }
        $notice_email = array();
        if (!empty($department_contacts[0])) {
            foreach ($department_contacts as $k => $val) {
                $notice_email[] = $val['email'];
            }
        } else {
            $notice_email[] = Data_Config_Demand_Notice::get('销售部');
        }
        Api_Demand_Notice::noticeGroupLeader(array('demand_id' => $request['demand_id'], 'email' => implode(';', $notice_email)));

        return $department_contacts[0];
    }

    /*
     * 需求数组的格式转换
     */
    static function changeArr($arr)
    {
        if (!empty($arr['rows'])) {
            foreach ($arr['rows'] as $k => $v) {
                $arr['rows'][$k]['demand'] = json_decode($v['demand'], 1);
                $arr['rows'][$k]['demand_reason'] = json_decode($v['demand_reason'], 1);
                $account_ids[] = $v['account_id'];
                $phone[] = $v['phone'];
            }
            //获取账户信息
            if (!empty($account_ids)) {
                $conditions = array("id IN (" . implode(',', $account_ids) . ") ");
                $userInfo = Data_Mysql_Table_Account::select('username,id', $conditions, '', 99999999);
                if ($userInfo) {
                    foreach ($userInfo as $key => $value) {
                        foreach ($arr['rows'] as $k => $v) {
                            if ($value['id'] == $v['account_id']) {
                                $arr['rows'][$k]['username'] = $value['username'];
                            }
                        }
                    }
                }
            }
            if (!empty($phone)) {
                $conditions = array("phone IN (" . implode(',', $phone) . ") ");
                $userInfo = Data_Mysql_Table_Account::select('username,id,phone', $conditions, '', 99999999);
                if ($userInfo) {
                    foreach ($userInfo as $key => $value) {
                        foreach ($arr['rows'] as $k => $v) {
                            if ($value['phone'] == $v['phone']) {
                                $arr['rows'][$k]['username'] = $value['username'];
                            }
                        }
                    }
                }
            }
        } else {
            foreach ($arr as $k => $v) {
                $arr[$k]['demand'] = json_decode($v['demand'], 1);
                $account_ids[] = $v['account_id'];
                $phone[] = $v['phone'];
            }
            //获取账户信息
            if (!empty($account_ids)) {
                $conditions = array("id IN (" . implode(',', $account_ids) . ") ");
                $userInfo = Data_Mysql_Table_Account::select('username,id', $conditions, '', 99999999);
                if ($userInfo) {
                    foreach ($userInfo as $key => $value) {
                        foreach ($arr as $k => $v) {
                            if ($value['id'] == $v['account_id']) {
                                $arr[$k]['username'] = $value['username'];
                            }
                        }
                    }
                }
            }
            if (!empty($phone)) {
                $conditions = array("phone IN (" . implode(',', $phone) . ") ");
                $userInfo = Data_Mysql_Table_Account::select('username,id,phone', $conditions, '', 99999999);
                if ($userInfo) {
                    foreach ($userInfo as $key => $value) {
                        foreach ($arr as $k => $v) {
                            if ($value['phone'] == $v['phone']) {
                                $arr[$k]['username'] = $value['username'];
                            }
                        }
                    }
                }
            }
        }
        return $arr;
    }

    //转为测试
    static function handleDemandOffer()
    {
        Core::output('');
        $request = Func_Input::filter(array(
            'id' => 'int',
        ));

        if (empty($request['id'])) {
            Func_Header::notFound();
        }
        $condition = array('id' => $request['id']);
        $data = array(
            'demand_status' => 5,
        );
        $rs = Data_Mysql_Table_Demand::update($condition, $data);
        if ($rs[0] > 0) {
            $account = Data_Mysql_Table_Demand::select('account_id', array('id =?' => $request['id']));
            Data_Mysql_Table_Account_Log::insertAccountLog($account[0]['account_id'], $_SESSION['administrator']['id'], '转为测试', '转为测试', $request['id']);

            Func_Output::json('success', '', '  转为测试成功');
        }
        Func_Output::json('error', '', '转为测试失败');

    }

    static function handleDemandBackout()
    {
        Core::output('');
        $request = Func_Input::filter(array(
            'id' => 'int',
        ));

        if (empty($request['id'])) {
            Func_Header::notFound();
        }
        $condition = array('id' => $request['id']);
        $data = array(
            'demand_status' => 0,
        );

        $rs = Data_Mysql_Table_Demand::update($condition, $data);
        if ($rs[0] > 0) {
            $account = Data_Mysql_Table_Demand::select('account_id', array('id =?' => $request['id']));
            Data_Mysql_Table_Account_Log::insertAccountLog($account[0]['account_id'], $_SESSION['administrator']['id'], '撤销测试', '撤销测试', $request['id']);
            Func_Output::json('success', '', '  撤销成功');
        }
        Func_Output::json('error', '', '撤销失败！');

    }
}