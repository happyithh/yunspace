<?php

/**
 * Created by PhpStorm.
 * User: liushengchun
 * Date: 15/3/30
 * Time: 19:15
 */
if (empty($_REQUEST['action'])) {
    $_REQUEST['action'] = 'info';
}
if (empty($_REQUEST['tab'])) {
    $_REQUEST['tab'] = 1;
}
if (empty($_REQUEST['is_manager'])) {
    $_REQUEST['is_manager'] = 0;
}

class OA_Contact_Detail
{
    static function handleGlobal($type = 0)
    {
        $_REQUEST['type'] = $type;
        switch ($_REQUEST['action']) {
            case 'add':
                self::handleAdd();
                break;
            case 'contacts':
                self::handleEditSubmit();
                break;
            case 'get_contact_demand':
                self::handleDemand();
                break;
            case 'demand_detail':
                self::handleDemandDetail();
                break;
            case 'recommend_submit':
                OA_My_Customer_Account::recommendSubmit();
                break;
            default:
                self::handleInfo();
                break;
        }
    }

    static function handle($type = 0, $isMy = 0, $is_urgent = 0)
    {
        $_REQUEST['type'] = $type;
        switch ($_REQUEST['action']) {
            case 'add':
                self::handleAdd();
                break;
            case 'contacts':
                self::handleEditSubmit($isMy || $is_urgent);
                break;
            case 'bind_account_submit':
                self::handleBindAccountSubmit();
                break;
            case 'unbind_account':
                self::handleAjaxUnbindAccount();
                break;
            case 'ajax_user_json':
                self::handleGetAccountToJson();
                break;
//            case 'ajax_admin_json':
//                self::handleGetAdminToJson();
//                break;
            case 'ajax_change_receiver':
                self::handleChangeReceiverToJson();
                break;
            case 'add_contact_record':
                self::handleRecord();
                break;
            case 'get_contact_demand':
                self::handleDemand();
                break;
            case 'demand_detail':
                self::handleDemandDetail();
                break;
            default:
                self::handleInfo($isMy || $is_urgent);
                break;
        }
    }

    static function handleAdd()
    {
        Tpl_Smarty::assign('data', $_REQUEST);
        Tpl_Smarty::assign('categoryList', Data_Mysql_Table_Product_Category::getTreeCache());
        Tpl_Smarty::display('OA', 'contacts/contact_add.tpl');
    }

    static function handleInfo($isAdmin = 0)
    {
        $request = Func_Input::filter(array(
            'id' => 'int',
            'tab' => 'string',
            'is_urgent' => 'int',    //紧急联系人
        ));
//        Tpl_Smarty::assign('is_urgent', empty($request['is_urgent']) ? 0 : $request['is_urgent']);
//        Tpl_Smarty::assign('is_manager', empty($request['is_manager']) ? 0 : $request['is_manager']);
        if (!$request['id']) {
            Func_Header::back('参数错误!');
        }
        $data = self::getInfo($request['id']);
        if (!$data) {
            Func_Header::back('参数错误!');
        }
        if ($isAdmin) {//如果允许管理
            $data['is_admin'] = 1;
        }
        Tpl_Smarty::assign('data', $data);
        if ($request['tab'] == 1) {
            Tpl_Smarty::assign('_data', self::getRecord($request['id']));
        }
        if (empty($_REQUEST['url_back'])) {
            $_REQUEST['url_back'] = Core::$urls['referer'];
        }
        if ($request['tab'] == 'edit') {
            Tpl_Smarty::assign('categoryList', Data_Mysql_Table_Product_Category::getTreeCache());
        }
        if ($request['tab'] == 3) {
            if (!$data['is_admin'] && !$data['is_my']) {
                Func_Header::notFound();
            }
            if (!empty($_REQUEST['demand_id'])) {
                if (empty($_REQUEST['demand_id'])) {
                    Func_Header::notFound();
                }
                $demand = OA_My_Customer_Account::getContactsByDemand($_REQUEST['demand_id']);
                if (!empty($demand[0]['demand'])) {
                    $demand[0]['demand'] = json_decode($demand[0]['demand'], 1);
                }
                if (!empty($_REQUEST['recommend_type']) && $_REQUEST['recommend_type'] == 'take_look') {
                    $data = OA_Demand_Handle_Take_Look::takeLookList();
                } elseif(!empty($_REQUEST['recommend_type'])){
                    $data = OA_My_Customer_Account::demandRecommend($_REQUEST['recommend_type']);
                }
                Tpl_Smarty::assign('demand_recommend', $data);
                Tpl_Smarty::assign('demand', $demand[0]);
            } else {
                $contact_demand = self::handleDemand();
                Tpl_Smarty::assign('contact_demand', $contact_demand);
            }
        }
//        Tpl_Smarty::display('OA', 'contact_detail.tpl');
        Tpl_Smarty::display('OA', 'contacts/contact_detail.tpl');
    }

    static function handleEditSubmit($isAdmin = 0)
    {
        $request = Func_Input::filter(array(
            'id' => 'int',
            'is_my' => 'int',
            'data' => 'array',
            'account_id' => 'int',
        ));
        $requestData = Func_Input::filter(array(
            '姓名' => 'string',
            '城市' => 'string',
            '手机号' => 'phone',
            '公司电话' => 'string',
            '业务类型' => 'string',
            '业务子类' => 'string',
            '公司名称' => 'string',
            '公司职位' => 'string',
            'attr' => 'array',
            'state' => 'int',
            'type' => 'int',
            'customer_type' => 'string',        //客户类型
        ), $request['data']);
        //如果是供应商  客户类型字段为 0
        if ($requestData['type'] == 21) {
            $requestData['customer_type'] = 0;
        }

        if (empty($_REQUEST['data']['手机号'])) {
            Func_Header::back('手机号字段不能为空！');
        }
        if (empty($requestData['手机号'])) {
            preg_match_all('/^(0(10|21|22|23|[1-9][0-9]{2})(-|))?[0-9]{7,8}$/', $_REQUEST['data']['手机号'], $tel);
            if (!empty($tel[0][0])) {
                $requestData['手机号'] = $tel[0][0];
            } else {
                Func_Header::back('请正确输入手机号！');
            }
        }
        if (!$requestData['姓名']) {
            Func_Header::back('姓名必须正确填写!');
        }
        if (!$requestData['业务类型'] || !$requestData['城市']) {
            Func_Header::back('业务类型和城市必须填写！');
        }
        $data = array(
            'username' => $requestData['姓名'],
            'phone' => $requestData['手机号'],
            'tel' => $requestData['公司电话'],
            'city' => $requestData['城市'],
            'business' => $requestData['业务类型'],
            'sub_business' => $requestData['业务子类'],
            'company' => $requestData['公司名称'],
            'position' => $requestData['公司职位'],
            'attr' => $requestData['attr'],
            'type' => $requestData['type'],
            'customer_type' => $requestData['customer_type'],
            'state' => $requestData['state'],
            'account_id' => $request['account_id'],
        );

        if ($request['id']) {
            $data['id'] = $request['id'];
            $info = self::getInfo($request['id']);
            if ($isAdmin) {//如果允许管理
                $info['is_admin'] = 1;
            }
            if (!$info['is_my'] && !$info['is_admin']) {
                Func_Header::back('没有权限!');
            }
            $rs = Data_Mysql_Table_Contact_Library::update($data);
        } else {

            unset($data['id']);
            $data['status'] = 1;
            $data['admin_id'] = $_SESSION['administrator']['id'];
            $rs = Data_Mysql_Table_Contact_Library::insert($data);
        }
        if (!empty($rs[0])) {
            //如果是创建我的联系人
            if ($request['is_my'] && !$request['id']) {
                Data_Mysql_Table_Contact_Relation::insert(array(
                    'contact_id' => $rs[0],
                    'admin_id' => $_SESSION['administrator']['id'],
                    'allocate_time' => time(),
                ));
            }
            Func_Header::back(' 操作成功!');
        } else {
            Func_Header::back('操作失败，可能是联系人已存在!');
        }
    }

    /*
     * 查看需求详情
     */
    static function handleDemandDetail()
    {
        OA_Demand_Operate::demandDetail();
    }

    static function getInfo($contactId)
    {
        $rs = Data_Mysql_Table_Contact_Library::select('*', array('id' => $contactId));
        if (empty($rs[0])) {
            return false;
        }
        $data = $rs[0];
        $data['attr'] = json_decode($data['attr'], true);
        //TODO: 如果是联系人管理入口进来的,则有权限
        $data['is_admin'] = $data['admin_id'] == $_SESSION['administrator']['id'];
        $rs = Data_Mysql_Table_Contact_Relation::select('id', array(
            'contact_id' => $contactId,
            'admin_id' => $_SESSION['administrator']['id'],
        ));
        $data['is_my'] = !empty($rs[0]['id']);
        if ($data['account_id']) {
            $rs = Data_Mysql_Table_Account::select('id,username, fullname, identity_time', $data['account_id']);
            if (!empty($rs[0])) {
                $data['account'] = $rs[0];
            }
        } else {
            $rs = Data_Mysql_Table_Account::select('id,username, phone, fullname, identity_time', array('phone' => $data['phone']));
            if (!empty($rs[0])) {
                $data['account'] = $rs[0];
            }
        }
        return $data;
    }

    static function getRecord($contactId)
    {
        $col = array(
            'time', 'content', 'admin_name'
        );
        $record = Data_Mysql_Table_Contact_Record::page(0, 15, $col, array('contact_id' => $contactId), 'ORDER BY time DESC');
        foreach ($record['rows'] as $k => $v) {
            $record['rows'][$k]['time'] = date("Y-m-d H:i:s", $v['time']);
        }
        return $record;
    }

    static function handleRecord()
    {
        $request = Func_Input::filter(array(
            'contact_id' => 'int',
            'content' => 'text',
        ));
        if (empty($request['contact_id'])) {
            Func_Header::notFound();
        }
        if (empty($request['content'])) {
            Func_Header::back('联系记录内容不能为空！！');
        }
        $data['contact_id'] = $request['contact_id'];
        $data['content'] = $request['content'];
        $data['admin_id'] = $_SESSION['administrator']['id'];
        $data['admin_name'] = $_SESSION['administrator']['username'];
        $data['time'] = time();
        $rs = Data_Mysql_Table_Contact_Record::insert($data);
        if ($rs[0] > 0) {
            Func_Header::to(' 联系记录添加成功');
        }
        Func_Header::back('联系记录添加失败');

    }

    static function  handleGetAccountToJson()
    {

        Core::output('');
        $request = Func_Input::filter(array(
            'id' => 'int',
            'type' => 'int',
            'q' => 'string',
        ));
        if (!$request['id'] && !$request['q']) {
            die('参数错误!');
        }
        if ($request['id']) {
            $rs = Data_Mysql_Table_Account::select('id,username', array("id= ? " => array($request['id'])));
        } else {
            $rs = Data_Mysql_Table_Account::select('id, CONCAT( "[", id, "] ", username) as username', array("id like ? OR username like ?" => array($request['q'] . '%', $request['q'] . '%')), '', 5);
        }
        $ajax_arr = array(
            "total_count" => 2,
            "incomplete_results" => false,
            "items" => array(
                array(
                    'id' => '',
                    'full_name' => ''
                ),
            )
        );
        foreach ($rs as $key => $val) {
            $ajax_arr['items'][$key]['id'] = $val['id'];
            $ajax_arr['items'][$key]['full_name'] = $val['username'];
        }
        echo json_encode($ajax_arr);
        die();
    }

//    //ajax获取管理员信息
//    static function handleGetAdminToJson()
//    {
//        unset($_REQUEST['id']);
//        OA_Department_Manage::handleGetUserToJson();
//        die;
//    }

    //更新联系人数据提交
    static function handleChangeReceiverToJson()
    {
        Core::output('');
        $request = Func_Input::filter(array(
            'contact_id' => 'int',
            'admin_id' => 'int',
        ));
        if (empty($request['contact_id']) || empty($request['admin_id'])) {
            Func_Output::json('error', '', '参数错误');
        }
        $updateData = array(
            'contact_id' => $request['contact_id'],
            'admin_id' => $request['admin_id'],
            'allocate_time' => time(),
        );
        //关系人表
        $relation = Data_Mysql_Table_Contact_Relation::select('id', array('contact_id' => $request['contact_id'], 'status' => 0));
        if (!empty($relation[0]['id'])) {
            $updateData['id'] = $relation[0]['id'];
        }
        $rs = Data_Mysql_Table_Contact_Relation::update($updateData);
        if ($rs[0]) {
            //通知到 领取人
            $r = Data_Mysql_Table_Demand::select('{table}.id', array('t1.id=?' => $request['contact_id']), 'ORDER BY {table}.id DESC', 1, '{table} LEFT JOIN {prefix}contact_library as t1 ON {table}.phone = t1.phone');
            if (!empty($r[0]['id'])) {
                Data_Config_Demand_Notice::sendNotice($r[0]['id'], '分配需求');
            }
            Func_Output::json('success', '', '更新领取人成功');
        } else {
            Func_Output::json('error', '', '更新领取人失败！请重试');
        }
    }

    static function handleBindAccountSubmit()
    {
        $request = Func_Input::filter(array(
            'contact_id' => 'int',
            'account_id' => 'int',
            'vendor_id' => 'int',
            'username' => 'string',
            'phone' => 'phone',
            'password' => 'string',
            'passwordr' => 'string',
        ));
        if (!$request['contact_id']) {
            Func_Header::back('参数错误!');
        }
        $r = Data_Mysql_Table_Contact_Library::select('id, account_id, type,company', $request['contact_id']);
        if (empty($r[0]['type'])) {
            Func_Header::back('联系人错误!');
        } else {
            $_REQUEST['account_type'] = $r[0]['type'];
        }
        if ($request['username']) {
            $data = Data_Mysql_Table_Account::handleRegister();
            if (empty($data['id'])) {
                Func_Header::back('创建帐号失败,请联系管理员!');
            }
            $request['account_id'] = $data['id'];
        }
        if (!$request['account_id']) {
            Func_Header::back('参数错误2!');
        }
        //创建该账户的操作日志
        Data_Mysql_Table_Account_Log::insertAccountLog($request['account_id'], $_SESSION['administrator']['id'], '联系人【' . $request['contact_id'] . '】绑定账户成功', '联系人绑定账号', $request['contact_id']);
        //修改联系人表中的Account_id
        $rs = Data_Mysql_Table_Contact_Library::update($request['contact_id'], array('account_id' => $request['account_id']));
        if (!empty($rs[0])) {
            $company = $r[0]['company'];
            if (!$request['vendor_id']) {
                $vendor = Data_Mysql_Table_Vendor_Info::select('id,vendor_name', array('vendor_name=?' => $company, 'vendor_account_id' => 0), 'ORDER BY status DESC');
                if (!empty($vendor[0]['id'])) {
                    $request['vendor_id'] = $vendor[0]['id'];
                }
            }
            if ($request['vendor_id']) {
                //TODO: 这里有修改 vendor_info 的account_id
//                $v_rs = Data_Mysql_Table_Vendor_Info::update(array('id' => $request['vendor_id']), array('vendor_account_id' => $request['account_id']));
//                $vp_rs = Data_Mysql_Table_Vendor_Info::subTable('_update')->update(array('id' => $request['vendor_id']), array('vendor_account_id' => $request['account_id']));
            }
            //绑定账户成功，更新demand中的account_id
            $demandInfo = self::handleDemand();
            if (!empty($demandInfo['rows'])) {
                foreach ($demandInfo['rows'] as $key => $value) {
                    $demand_ids[] = $value['id'];
                }
                $demand_condition[] = 'id in (' . implode($demand_ids, ',') . ')';
                Data_Mysql_Table_Demand::update($demand_condition, array('account_id' => $request['account_id']));
            }
            Func_Header::to(' 绑定成功!', Core::$urls['path'] . '?id=' . $request['contact_id'] . '&is_manager=' . $_REQUEST['is_manager']);
        } else {
            Func_Header::back('绑定帐号失败,请联系管理员!');
        }
    }

    //解除联系人绑定的账户
    static function handleAjaxUnbindAccount()
    {
        Core::output('');
        if (empty($_REQUEST['contact_id'])) {
            echo 'fail';
            die;
        }
        $r = Data_Mysql_Table_Contact_Library::select('id, account_id', $_REQUEST['contact_id']);
        if (empty($r[0]['account_id'])) {
            echo 'fail';
            die;
        }
        //修改联系人表中的Account_id
        $rs = Data_Mysql_Table_Contact_Library::update($_REQUEST['contact_id'], array('account_id' => 0));
        if (!empty($rs[0])) {
            //创建该账户的操作日志
            Data_Mysql_Table_Account_Log::insertAccountLog($r[0]['account_id'], $_SESSION['administrator']['id'], '联系人【' . $_REQUEST['contact_id'] . '】解除绑定账户', '联系人解除绑定账号', $_REQUEST['contact_id']);
            echo "success";
        } else {
            echo "fail";
        }
        die;
    }

    //获取当前联系人的所有需求
    static function handleDemand()
    {
        if (empty($_REQUEST['phone'])) {
            Func_Header::back('参数有误');
        }
        $data = Data_Mysql_Table_Demand::page(0, 0, '*', array('phone' => $_REQUEST['phone'],
            'demand_status' => 1), 'ORDER BY create_time desc');
        if (!empty($data['rows'])) {
            foreach ($data['rows'] as $key => $value) {
                $data['rows'][$key]['demand'] = json_decode($value['demand'], 1);
            }
        }
        return $data;
    }
}