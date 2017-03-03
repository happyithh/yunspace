<?php

/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 15-5-6
 * Time: 上午9:57
 */
class OA_Demand_Contact
{
    static function handle($department = '运营部')
    {
        $action = empty($_REQUEST['action']) ? 'show' : $_REQUEST['action'];
        switch ($action) {
            case 'show':
                self::handleDemandContact($department);
                break;
            case 'submit_edit':
                self::handleDemandContactSubmit($department);
                break;
            case 'ajaxSelectRecentDemand':
                OA_Demand_getRecent::getRecentDemand();
                break;
        }
    }
//旧的创建 需求
//    static function handleDemandContact($department)
//    {
////        Tpl_Smarty::assign('_demandType', Data_Mysql_Table_Demand::$_demandType);
////        $tags = Data_Config_Vendor_Attr::get('attr');
////        if (!empty($tags['活动类型'])) {
////            Tpl_Smarty::assign('tags', $tags['活动类型']);
////        }
////        Tpl_Smarty::assign('categoryList', Data_Mysql_Table_Product_Category::getTreeCache());
////        Tpl_Smarty::assign('department', $department);
////
//////        Tpl_Smarty::display('OA', 'demand_contact_edit.tpl');
//    }


    static function handleDemandContact($department)
    {
        Tpl_Smarty::assign('_demandType', Data_Mysql_Table_Demand::$_demandType);
        Tpl_Smarty::assign('categoryList', Data_Mysql_Table_Product_Category::getTreeCache());
        $tags = Data_Config_Vendor_Attr::get('attr');
        if (!empty($tags['活动类型'])) {
            Tpl_Smarty::assign('tags', $tags['活动类型']);
        }
        $categoryTree = Data_Mysql_Table_Product_Category::getTreeCache();
        if(!empty($categoryTree)){
            Tpl_Smarty::assign('categoryTree', $categoryTree);
        }

//        Tpl_Smarty::assign('demand_options', Data_Demand_Option_Config::get('people'));
        Tpl_Smarty::assign('demand_options', Data_Demand_Option_Config::all());
        Tpl_Smarty::assign('department', $department);
        Tpl_Smarty::display('OA_Static::demands/demand_edit.tpl');
    }

    static function  handleDemandContactSubmit($department)
    {
        $request = Func_Input::filter(array(
            'notice_city' => 'string',
            'notice_team' => 'string',
            'notice_department' => 'string',
            'demand_name' => 'string',
            'data' => 'array',
            'price_up' => 'int',
            'price_down' => 'int',
            'is_offer' => 'int',
            'department' => 'string'
        ), $_REQUEST);
        if (empty($request['demand_name'])) {
            Func_Header::back('请填写活动名称');
        }
        if (!is_numeric($request['data']['联系电话'])) {
            Func_Header::back('请正确填写手机号！');
        }

        if (!empty($request['price_down']) && !empty($request['price_up']) && $request['price_down'] < $request['price_up']) {
            Func_Header::back('请正确填写预算上下限！');
        }
        if (!empty($request['data']['开始时间']) && !empty($request['data']['结束时间']) && $request['data']['结束时间'] < $request['data']['开始时间']) {
            Func_Header::back('请正确填写活动时间！');
        }

        if (!is_numeric($request['price_down']) || !is_numeric($request['price_up'])) {
            $request['price_down'] = $request['price_up'] = 0;
        }
        $demand = Func_Input::filter(array(
            '需求类型' => 'string',
            '联系电话' => 'string',
            '联系人' => 'string',
            '公司名称' => 'string',
//            '业务类型' => 'string',
            '场地类型' => 'string',
            '活动类型' => 'string',
            '活动人数' => 'string',
            '开始时间' => 'string',
            '结束时间' => 'string',
            '需求场地' => 'string',
            '具体要求' => 'string',

        ), $request['data']);
        $demand['活动城市'] = $request['notice_city'];

        $notice_email =array();
        foreach ($demand as $k => $v) {
            if ($v == '') {
                unset($demand[$k]);
            }
        }
        @session_start();
        $department_contacts[0]['admin_id'] = $_SESSION['administrator']['id'];
        //正常的创建需求
        if ($request['department'] != '销售部') {
            if (empty($request['is_offer'])) {

                if (empty($request['notice_city']) || empty($request['notice_team']) || empty($request['notice_department'])) {
                    Func_Header::back('请选择要通知的部门');
                }
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
            }else{
                /**
                 * 如果是提交报价系统  销售创建报价系统
                 * */
            }
        }
        //检查手机号是否存在
        $account = Api_Account_GetBaseInfo::getBaseInfoByPhone(array('phone' => $demand['联系电话']));
        if (empty($account['id'])) {
            //没有就去创建账户
            $account = Api_Demand_Create::quickAccount(array('phone' => $demand['联系电话']));
        }
        if (empty($account['id'])) {
            $account_id = 0;
        } else {
            $account_id = $account['id'];
        }

        //创建需求
        $demand_rs = Api_Demand_Create::create(array('demand' => $demand,
            'demand_type' => $demand['需求类型'],
            'phone' => $demand['联系电话'],
            'account_id' => $account_id,
            'demand_name' => $request['demand_name'],
            'admin_id' => $department_contacts[0]['admin_id'],
            'demand_status' => 1,
            'resolve_time' => time()+10,
            'price_up' => $request['price_up'],
            'price_down' => $request['price_down'],
        ));
        if (!empty($demand_rs['data'])) {
            //正常创建需求
            if (empty($request['is_offer'])) {
                //通知组长
                Api_Demand_Notice::noticeGroupLeader(array('demand_id' => $demand_rs['data'], 'email' => implode(';', $notice_email)));
                //如果是 销售部 创建的
                if ($department == "销售部") {
                    $admin_id = Api_Session::admin_id();
                    if (!$admin_id) {
                        Func_Header::to('如果您是销售人员，请先登录');
                    }
                    $adminAccount = Api_Administrator_GetBaseAccountInfo::getBastAccountInfo(array('admin_id' => $admin_id));
                    Data_Mysql_Table_Demand::update(array('id' => $demand_rs['data']), array('response_account_id' => $adminAccount['account_id']));
                    if (!empty($adminAccount)) {
                        Api_Demand_Allot::allot(array('demand_id' => $demand_rs['data'], 'admin_id' => $adminAccount['admin_id'],
                            'response_account_id' => $adminAccount['account_id']));
                    }
                }
            }
            $data = array(
                'username' => $demand['联系人'],
                'phone' => $demand['联系电话'],
                'city' => $demand['活动城市'],
//                'business' => $demand['业务类型'],
//                'sub_business' => $demand['业务子类'],
                'type' => 1,
                'create_time' => time(),
                'resolve_time' => time()+10,
                'account_id' => $account_id,
            );
            Data_Mysql_Table_Contact_Library::update($data);


            Data_Mysql_Table_Account_Log::insertAccountLog($account_id, $_SESSION['administrator']['id'], '创建需求', '创建需求', $demand_rs['data']);
            //提交到需求竞标    //提交至报价系统
            /**
             * 提交至报价系统
             */
            if (!empty($request['is_offer']) && $request['is_offer'] == 1) {
                if($request['department'] != '销售部'){
                    Func_Header::to('','http://'.Core::$urls['host'].Core::$urls['root'].Core::$urls['package'].'operation/demand_tender?act=demand_offer&demand_id='.$demand_rs['data']."&type=1");
                }else{
                    Func_Header::to('','http://'.Core::$urls['host'].Core::$urls['root'].Core::$urls['package'].'operation/demand_tender?act=demand_offer&demand_id='.$demand_rs['data']);
                }
//                Api_Demand_Tender_Create::create(array('demand_id' => $demand_rs['data']));
//                Data_Mysql_Table_Account_Log::insertAccountLog($account_id, $_SESSION['administrator']['id'], '创建需求竞标', '需求竞标', $demand_rs['data']);
            }
            Func_Header::to('  需求创建成功', Core::$urls['base_path'] . '?');
        }

        Func_Header::back('操作失败，请返回列表页重试', Core::$urls['base_path'] . '?action=list');
    }
//    static function handleDemandContactSubmit($department)
//    {
//        $requestData = Func_Input::filter(array(
//            '姓名' => 'string',
//            '城市' => 'string',
//            '手机号' => 'string',
//            '业务类型' => 'string',
//            '业务子类' => 'string',
//            '公司名称' => 'string',
//            '需求类型' => 'string',
//            '活动类型' => 'string',
//            '人数' => 'string',
//            '开始时间' => 'string',
//            '结束时间' => 'string',
//            '场地' => 'string',
//            '具体要求' => 'string',
//            'type' => 'int',
//            'customer_type' => 'int',
//        ), $_REQUEST['data']);
//        if (empty($requestData['手机号']) || empty($requestData['姓名'])) {
//            Func_Header::back('手机号和姓名必须正确填写!');
//        }
//        if (empty($requestData['业务类型']) || empty($requestData['城市'])) {
//            Func_Header::back('业务类型和城市必须填写！');
//        }
//        if (empty($requestData['具体要求'])) {
//            Func_Header::back('具体要求必须填写！');
//        }
//        if ($requestData['需求类型'] == '供应商加盟' && empty($requestData['公司名称'])) {
//            Func_Header::back('供应商加盟公司名称必须填写！');
//        }
//        //开始结束时间验证
//        $requestData['开始时间'] = strtotime($requestData['开始时间']);
//        $requestData['结束时间'] = strtotime($requestData['结束时间']);
//        if ($requestData['type'] == 21) {
//            $requestData['customer_type'] = 0;
//        }
//        $data_contact = array(
//            'username' => $requestData['姓名'],
//            'phone' => $requestData['手机号'],
//            'city' => $requestData['城市'],
//            'business' => $requestData['业务类型'],
//            'sub_business' => $requestData['业务子类'],
//            'company' => $requestData['公司名称'],
//            'status' => 1,
//            'admin_id' => $_SESSION['administrator']['id'],
//            'type' => $requestData['type'],
//            'customer_type' => $requestData['customer_type'],
//        );
//        $demand = array(
//            '联系电话' => $requestData['手机号'],
//            '联系人' => $requestData['姓名'],
//            '活动城市' => $requestData['城市'],
//            '具体要求' => $requestData['具体要求'],
//            '公司名称' => $requestData['公司名称'],
//            '活动类型' => $requestData['活动类型'],
//            '人数' => $requestData['人数'],
//            '开始时间' => Date('Y-m-d', $requestData['开始时间']),
//            '结束时间' => Date('Y-m-d', $requestData['结束时间']),
//            '场地' => $requestData['场地'],
//        );
//
//        $contact_rs = Data_Mysql_Table_Contact_Library::select('id,username,account_id', array('phone' => $data_contact['phone']));
//
//        //联系人库中已存在该联系人,更新联系人表中的需求时间
//        $data_demand_account_id = 0;
//        if (!empty($contact_rs[0]['id'])) {
//            $rs = Data_Mysql_Table_Contact_Library::update(array('phone' => $data_contact['phone']), array('new_demand_time' => time()));
//            if (empty($rs[0])) {
//                Func_Header::back('更新联系人需求时间失败！！');
//            }
//            if (!empty($contact_rs[0]['account_id'])) {
//                $data_demand_account_id = $contact_rs[0]['account_id'];
//            }
//            $msg = ' 联系人' . $contact_rs[0]['username'] . '已更新，';
//        } else {
//            $data_contact['new_demand_time'] = time();
//            $rs = Data_Mysql_Table_Contact_Library::insert($data_contact);
//            if (empty($rs[0])) {
//                Func_Header::back('添加联系人失败！！');
//            }
//            $msg = ' 新的联系人已创建，';
//        }
//        //销售部添加需求和创建联系人的时候。自动添加为自己的联系人
//        if (!empty($rs[0])) {
//            //如果是（销售部）创建我的联系人
//            if (isset($_REQUEST['is_my']) && !isset($_REQUEST['id'])) {
//                Data_Mysql_Table_Contact_Relation::insert(array(
//                    'contact_id' => $rs[0],
//                    'admin_id' => $_SESSION['administrator']['id'],
//                    'allocate_time' => time(),
//                ));
//            }
//        }
//        $account = Api_Account_GetBaseInfo::getBaseInfoByPhone(array('phone' => $demand['联系电话']));
//        $demand_rs = Api_Demand_Create::create(array('demand' => $demand,
//            'demand_type' => $requestData['需求类型'],
//            'phone' => $demand['联系电话'],
//            'account_id' => empty($account['id']) ? '' : $account['id'],
//        ));
//
//        if (!empty($demand_rs['status'])) {
//
//            //如果是 销售部 创建的
//            if ($department == "销售部") {
//                $admin_id = Api_Session::admin_id();
//                if (!$admin_id) {
//                    Func_Header::to('如果您是销售人员，请先登录');
//                }
//                Data_Mysql_Table_Demand::query("UPDATE {table} SET demand_status =? WHERE id =?", array(1, $demand_rs['data']), 1);
//                $adminAccount = Api_Administrator_GetBaseAccountInfo::getBastAccountInfo(array('admin_id' => $admin_id));
//
//                if (!empty($adminAccount)) {
//                    Api_Demand_Allot::allot(array('demand_id' => $demand_rs['data'], 'admin_id' => $adminAccount['admin_id'],
//                        'response_account_id' => $adminAccount['account_id']));
//                }
//            }
//            Data_Config_Demand_Notice::sendNotice($demand_rs['data'], '新需求');
//
//            Func_Header::to('  新需求已创建');
//        } else {
//            Func_Header::back($demand_rs['msg']);
//        }
//    }
}