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
            case 'contacts':
                if (!empty($_REQUEST['is_submit'])) {
                    self::demandAddContacts();
                } else {
                    self::demandContacts();
                }
                break;
            case 'abandon':
                self::demandAbandon();
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
        $type = isset($_REQUEST['type']) ? $_REQUEST['type'] : "waiting";
        $order = 'order by create_time desc';
        //获取所有需求总数
        $totalNum = array(
            '0' => 0,
            '1' => 0,
            '-1' => 0,
        );
        if (!empty($_REQUEST['search'])) {
            $search = Func_Input::filter(array(
                'city' => 'string',
                'demandType' => 'string',
                'start_time' => 'string',
                'end_time' => 'string',
            ), $_REQUEST['search']);

            if (!empty($search['city'])) {
                $conditions['city'] = $search['city'];
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

        }
        $total = Data_Mysql_Table_Demand::select('count(*) as count, demand_status', '1 GROUP BY demand_status', '', 3);
        foreach ($total as $v) {
            $totalNum[$v['demand_status']] = $v['count'];
        }
        //获取所有未处理需求
        switch ($type) {
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
            default :
                $data = Data_Mysql_Table_Demand::page(0, 0, '*', array('demand_status' => 0), $order);
                break;
        }
        if (!empty($data['rows'])) {
            $demand = self::changeArr($data);
            Tpl_Smarty::assign('_data', $demand);
        }

        Tpl_Smarty::assign('type', $type);
        Tpl_Smarty::assign('_total', array_sum($totalNum));
        Tpl_Smarty::assign('_waitingtotal', $totalNum['0']);
        Tpl_Smarty::assign('_donetotal', $totalNum['1']);
        Tpl_Smarty::assign('_abandontotal', $totalNum['-1']);
        Tpl_Smarty::assign('_demandType', Data_Mysql_Table_Demand::$_demandType);
        Tpl_Smarty::display('Admin_Action', 'operational_demand.tpl');
    }

    /*
     * 查看需求详情
     */
    static function demandDetail()
    {
        if (empty($_REQUEST['id'])) {
            Func_Header::notFound();
        }
        $demandInfo = Data_Mysql_Table_Demand::select('*', array('id' => $_REQUEST['id']));
        if (!empty($demandInfo[0]['account_id'])) {
            $accountInfo = Data_Mysql_Table_Account::select('id,username,account_type', array('id' => $demandInfo[0]['account_id']));
            $demandInfo[0]['username'] = $accountInfo[0]['username'];
            $demandInfo[0]['account_type'] = $accountInfo[0]['account_type'];
        }
        if (!empty($demandInfo[0]['phone'])) {
            $accountInfo = Data_Mysql_Table_Account::select('id,username,account_type', array('phone' => $demandInfo[0]['phone']));
            if (!empty($accountInfo[0])) {
                $demandInfo[0]['username'] = $accountInfo[0]['username'];
                $demandInfo[0]['account_id'] = $accountInfo[0]['id'];
                $demandInfo[0]['account_type'] = $accountInfo[0]['account_type'];
            }
        }
        $demand = self::changeArr($demandInfo);
        $demandInfo = $demand[0];
        Tpl_Smarty::assign('_demand', $demandInfo);
        Tpl_Smarty::display('Admin_Action', 'operational_demand_detail.tpl');
    }

    /*
     * 放弃需求
     */
    static function demandAbandon()
    {
        if (empty($_REQUEST['id'])) {
            Func_Header::notFound();
        }
        $data = array('demand_status' => -1);
        $rs = Data_Mysql_Table_Demand::update($_REQUEST['id'], $data);
        if ($rs[0] > 0) {
            Func_Header::to('需求已放弃', 'demand_operate');
        }
        Func_Header::to('需求放弃失败');
    }

    /*
     * 添加联系人
     */
    static function demandContacts()
    {
        //获取联系人基本信息
        $request = Func_Input::filter(array(
            'demand_id' => 'int',
            'account_id' => 'int',
            'phone' => 'string',
            'company' => 'string',
            'username' => 'string',
            'city' => 'string',
            'type' => 'int',
            'business' => 'string',
        ), $_REQUEST);
        $type = empty($request['type']) ? 1 : $request['type'];
        $account_name = empty($request['username']) ? '未知用户' : $request['username'];
        if (!empty($request['account_id'])) {
            $contact_rs = Data_Mysql_Table_Contact_Library::select('id,username', array('account_id' => $request['account_id']));
            //联系人库中是否已存在该联系人,更新联系人表中的需求时间
            if (!empty($contact_rs[0]['id']) && $contact_rs[0]['id'] > 0) {
                $rs = Data_Mysql_Table_Contact_Library::update(array('account_id' => $request['account_id']), array('new_demand_time' => time()));
                if ($rs[0] > 0) {
                    //更新需求状态
                    $d = Data_Mysql_Table_Demand::update($request['demand_id'], array('demand_status' => 1, 'account_id' => $request['account_id']));
                    if ($d[0] > 0) {
                        //发送邮件
                        if ($type == 1) {
                            $email = Data_Config_Demand_Notice::get('销售部');
                        } elseif ($type == 21) {
                            $email = Data_Config_Demand_Notice::get('市场部');
                        }
                        Data_Config_Demand_Notice::sendNotice($request['demand_id'], '新需求');
                        //创建该账户的操作日志
                        Data_Mysql_Table_Account_Log::insertAccountLog($request['account_id'], $_SESSION['administrator']['id'], '更新该账户下联系人的信息');
                        Func_Header::to(' 联系人已更新,需求已处理', 'demand_operate');
                    }
                }
            }
            $account = Data_Mysql_Table_Account::select('id,username', array('id' => $request['account_id']));
            if ($account[0]) {
                $account_name = $account[0]['username'];
            }
        } else {
            $contact_rs = Data_Mysql_Table_Contact_Library::select('id,username', array('phone' => $request['phone']));
            //联系人库中是否已存在该联系人,更新联系人表中的需求时间
            if (!empty($contact_rs[0]['id'])) {
                $rs = Data_Mysql_Table_Contact_Library::update(array('phone' => $request['phone']), array('new_demand_time' => time()));
                if (!empty($rs[0])) {
                    //更新需求状态
                    $d = Data_Mysql_Table_Demand::update($request['demand_id'], array('demand_status' => 1));
                    //发送邮件
                    if ($type == 1) {
                        $email = Data_Config_Demand_Notice::get('销售部');
                    } elseif ($type == 21) {
                        $email = Data_Config_Demand_Notice::get('市场部');
                    }
                    Data_Config_Demand_Notice::sendNotice($request['demand_id'], '新需求');
                    Func_Header::to(' 联系人已更新,需求已处理', 'demand_operate');
                }
            }
            $account = Data_Mysql_Table_Account::select('id,username', array('phone' => $request['phone']));
            if (!empty($account[0])) {
                $account_name = $account[0]['username'];
                $request['account_id'] = $account[0]['id'];
            }
        }
        $contactsInfo = array('account_id' => $request['account_id'], 'username' => $account_name, 'phone' => $request['phone'], 'demand_id' => $request['demand_id'],
            'company' => $request['company'], 'business' => $request['business'], 'position' => empty($request['position']) ? '' : $request['position'], 'city' => $request['city'], 'type' => $type, 'state' => 5);
        Tpl_Smarty::assign('data', $contactsInfo);
        Tpl_Smarty::assign('categoryList', Data_Mysql_Table_Product_Category::getTreeCache());
        Tpl_Smarty::display('OA', 'contacts/contact_add.tpl');
    }

    /*
     *添加联系人动作
     */
    static function demandAddContacts()
    {
        if (empty($_REQUEST['url_back'])) {
            $_REQUEST['url_back'] = Core::$urls['referer'];
        }
        $request = Func_Input::filter(array(
            'id' => 'int',
            'is_my' => 'int',
            'data' => 'array',
            'account_id' => 'int',
            'demand_id' => 'int'
        ));
        $requestData = Func_Input::filter(array(
            '姓名' => 'string',
            '城市' => 'string',
            '手机号' => 'phone',
            '业务类型' => 'string',
            '业务子类' => 'string',
            '公司名称' => 'string',
            '公司职位' => 'string',
            'attr' => 'array',
            'state' => 'int',
            'type' => 'int',
            'customer_type' => 'int',
        ), $request['data']);
        //如果是供应商  客户类型字段为 0
        if ($requestData['type'] == 21) {
            $requestData['customer_type'] = 0;
        }
        $data = array(
            'username' => $requestData['姓名'],
            'phone' => $requestData['手机号'],
            'city' => $requestData['城市'],
            'business' => $requestData['业务类型'],
            'sub_business' => $requestData['业务子类'],
            'company' => $requestData['公司名称'],
            'position' => $requestData['公司职位'],
            'attr' => $requestData['attr'],
            'type' => $requestData['type'],
            'state' => $requestData['state'],
            'account_id' => $request['account_id'],
            'customer_type' => $requestData['customer_type'],
            'new_demand_time' => time(),
            'admin_id' => $_SESSION['administrator']['id'],
        );
        if ($request['id']) {
            $data['id'] = $request['id'];
            unset($data['phone']);
            $info = self::getInfo($request['id']);
            if (!$info['is_my'] && !$info['is_admin']) {
                Func_Header::back('没有权限!');
            }
            $rs = Data_Mysql_Table_Contact_Library::update($data);
        } else {
            if (!$data['phone'] || !$data['username']) {
                Func_Header::back('手机号和姓名必须正确填写!', $_REQUEST['url_back']);
            }
            unset($data['id']);
            $data['status'] = 1;
            $rs = Data_Mysql_Table_Contact_Library::insert($data);
        }
        if (!empty($rs[0])) {
            if ($request['is_my'] && !$request['id']) {
                Data_Mysql_Table_Contact_Relation::insert(array(
                    'contact_id' => $rs[0],
                    'admin_id' => $_SESSION['administrator']['id'],
                    'allocate_time' => time(),
                ));
            }
            //更新需求信息
            $d = Data_Mysql_Table_Demand::update($request['demand_id'], array('demand_status' => 1));
            if ($d[0] > 0) {
                //发送邮件
                Data_Config_Demand_Notice::sendNotice($request['demand_id'], '新需求');
                Func_Header::to(' 操作成功!', 'demand_operate?action=list');
            }
        } else {
            Func_Header::back('操作失败!');
        }

    }

    /*
     * 需求数组的格式转换
     */
    static function changeArr($arr)
    {
        if (!empty($arr['rows'])) {
            foreach ($arr['rows'] as $k => $v) {
                $arr['rows'][$k]['demand'] = json_decode($v['demand'], 1);
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
}