<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/7/15
 * Time: 13:26
 * 需求详情页
 */
class OA_Demand_Detail
{
    static function  handleDemandInfo($department, $is_team, $is_all, $is_my)
    {
        $request = Func_Input::filter(array(
                'demand_id' => 'int',
            )
        );
        $demand_data = Data_Mysql_Table_Demand::select("*", array('id =?' => $request['demand_id']));
        $demand = Data_Mysql_Table_Demand::rowFormat($demand_data[0]);
        if ($demand['admin_id']) {
            $admin = Api_Administrator_getBaseInfo::getAdminInfo(array('admin_id' => $demand['admin_id']));
            Tpl_Smarty::assign('admin_info', $admin);
        }
        Tpl_Smarty::assign('_step_funnel', Data_Mysql_Table_Demand::$step_funnel);
        Tpl_Smarty::assign('_demand', $demand);

        $city = empty($_REQUEST['city']) ? '' : $_REQUEST['city'];
        if (empty($_REQUEST['city'])) {
            $getCity = Api_Administrator_Department_Normal_Api::getMemberInfo($department, $_SESSION['administrator']['id']);
            if (!empty($getCity['city'])) {
                $city = $getCity['city'];
            } else {
                $city = '上海';
            }
        }
        //组
        if (!empty($is_team)) {
            $getTeam = Api_Administrator_Department_Normal_Api::getMemberInfo($department, Api_Session::admin_id());
            if (!empty($getTeam['team_name'])) {
                $getResponse = OA_Demand_Lists::getTeamList($department, $getTeam['team_name'], $getTeam['city']);
                Tpl_Smarty::assign('admin', $getResponse);
            } else {
                die('请添加自身到部门管理员！！');
            }
        }
        //所有
        if (!empty($is_all)) {
            $getResponse = OA_Demand_Lists::getMemberList($department, '', $is_all);
            Tpl_Smarty::assign('admin', $getResponse);
        }
        if (empty($is_all) && empty($is_team)) {
            $getResponse = OA_Demand_Lists::getMemberList($department, $city, $is_all);
            Tpl_Smarty::assign('admin', $getResponse);
        }

        Tpl_Smarty::assign('demand_recommend',
            Api_Recommend_GetList::getDemandRecommend(array('demand_id' => $request['demand_id'], 'num' => 300)));

        //联系记录;
        Tpl_Smarty::assign('contactRecord',
            OA_Demand_Detail::getRecord(array('phone' => $demand['phone'])));


        //需求进度记录

        Tpl_Smarty::assign('stepRecord', Api_Demand_Admin_getStepRecord::getRecord(array('demand_id' => $request['demand_id'], 'num' => 100)));

        //需求报价
        $tender_info = Data_Mysql_Table_Demand_Tender::select('id',array('demand_id =?' => $request['demand_id']), '', 1);
        if(!empty($tender_info)&&isset($tender_info[0]['id'])){
            $tender = Data_Mysql_Table_Demand_Tender_Scheme::select('*', array('tender_id =?' => $tender_info[0]['id']), '', 999);
            if (!empty($tender)) {
                foreach ($tender as $key => $val) {
                    $product_id[] = $val['product_id'];
                    $tender[$key]['scheme'] = json_decode($val['scheme'], 1);
                }
                $product = Data_Mysql_Table_Product_Search::select('id,product_name,addr', array('id IN (' . implode(',', $product_id) . ')'));
                Tpl_Smarty::assign('product', $product);
            }
            Tpl_Smarty::assign('status', array(0 => '待确认', 1 => '已确认',-1 => '已取消',));
            Tpl_Smarty::assign('_data', $tender);
        }
        Tpl_Smarty::display("OA_Static::demands/demand_detail.tpl");
    }

    //增加一条联系记录
    static function handleAddContactRecord()
    {
        @session_start();
        $request = Func_Input::filter(array(
            'phone' => 'int',
            'demand_id' => 'int',
            'content' => 'text',
        ));
        if (empty($request['content'])) {
            Func_Header::back('联系记录内容不能为空！！');
        }
        $contact_people = Data_Mysql_Table_Contact_Library::select('id', array('phone =?' => $request['phone']));
        if (empty($contact_people[0])) {
            $demand_data = Data_Mysql_Table_Demand::select('*', array('phone=?' => $request['phone']));
            $demand = Data_Mysql_Table_Demand::rowFormat($demand_data[0]);
            $contact = array(
                'username' => $demand['demand']['联系人'],
                'phone' => $demand['phone'],
                'city' => $demand['city'],
//                'business' => $demand['demand']['业务类型'],
//                'sub_business' => $demand['demand']['业务子类'],
                'company' => @$demand['demand']['公司名称'],
                'type' => 1,
                'customer_type' => 1,
                'create_time' => time(),
                'account_id' => $demand['account_id'],
            );
            $status = Data_Mysql_Table_Contact_Library::update($contact);
            if ($status[0] > 0) {
                $contact_people[0]['id'] = $status[0];
            } else {
                Func_Header::back('联系人不存在！');
            }
        }
        $data['contact_id'] = $contact_people[0]['id'];
        $data['content'] = $request['content'];
        $data['admin_id'] = $_SESSION['administrator']['id'];
        $data['admin_name'] = $_SESSION['administrator']['username'];
        $data['time'] = time();
        $rs = Data_Mysql_Table_Contact_Record::insert($data);

        if ($rs[0] > 0) {
            Func_Header::to(' 联系记录添加成功', '?action=demand_info&demand_id=' . $request['demand_id']);
        }
        Func_Header::back('联系记录添加失败');

    }

    static function getRecord($args)
    {
        $request = Func_Input::filter(array(
            'phone' => 'int',
            'contact_id' => 'int',
        ), $args);

        if (empty($request['phone']) && empty($request['contact_id'])) {
            return false;
        }
//        q($request);
        $conditions = array();
        if (!empty($request['phone'])) {

            $contact_people = Data_Mysql_Table_Contact_Library::select('id', array('phone =?' => $request['phone']));
            if (!empty($contact_people[0]['id'])) {
                $request['contact_id'] = $contact_people[0]['id'];
            } else {
                return false;
            }
        }
        if (!empty($request['contact_id'])) {
            $conditions['contact_id =?'] = $request['contact_id'];
        }
        $record = Data_Mysql_Table_Contact_Record::page(0, 15, '*', $conditions, 'ORDER BY time DESC');
        foreach ($record['rows'] as $k => $v) {
            $record['rows'][$k]['time'] = date("Y-m-d H:i:s", $v['time']);
        }
        return $record;

    }

    //添加备注
    static function handleDemandCreateRemark()
    {
        Core::output('');
        $request = Func_Input::filter(array(
            'id' => 'int',
            'remark' => 'string',
        ));

        if (empty($request['id'])) {
            Func_Header::notFound();
        }
        $market = Data_Mysql_Table_Demand_Recommend::select('market_remark', array('id =?' => $request['id']));
        $remark = json_decode($market[0]['market_remark'], 1);
        $condition = array('id' => $_REQUEST['id']);
        $re = array('销售' => $_SESSION['administrator']['username'], '备注' => $request['remark'], '时间' => date("Y-m-d H:i:s", time()));

        if (!empty($remark)) {
            array_push($remark, $re);
        } else {
            $remark = array($re);
        }

        $data = array(
            'market_remark' => $remark);
        $rs = Data_Mysql_Table_Demand_Recommend::update($condition, $data);
        if ($rs[0] > 0) {
            Func_Output::json('success', '', '  备注添加成功');
        }
        Func_Output::json('error', '', '备注添加失败');

    }

    static function handleDemandSelectRemark()
    {
        Core::output('');
        $request = Func_Input::filter(array(
            'id' => 'int',
        ));
        $market = Data_Mysql_Table_Demand_Recommend::select('market_remark', array('id =?' => $request['id']));
        $remark = json_decode($market[0]['market_remark'], 1);
        Func_Output::json('success', $remark, '  备注查询成功');
    }

    static function  handleContactFrom()
    {
        $request = Func_Input::filter(array(
            'phone' => 'string'
        ), $_REQUEST);
        if (empty($request['phone'])) {
            Func_Header::back('没有关联的手机号！');
        }

        Tpl_Smarty::assign('data',
            self::getContactInfo($request['phone']));

        Tpl_Smarty::assign('categoryList', Data_Mysql_Table_Product_Category::getTreeCache());

        Tpl_Smarty::display('OA_Static::demands/contacts/contact_detail_edit.tpl');
    }

    static function getContactInfo($phone)
    {
        $rs = Data_Mysql_Table_Contact_Library::select('*', array('phone' => $phone));
        if (empty($rs[0])) {
            return false;
        }
        $data = $rs[0];
        $data['attr'] = json_decode($data['attr'], true);

        return $data;
    }

    static function handleContactFromSubmit()
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
//            '业务类型' => 'string',
//            '业务子类' => 'string',
            '公司名称' => 'string',
            '公司职位' => 'string',
            'attr' => 'array',
            'state' => 'int',
            'type' => 'int',
            'customer_type' => 'string',        //客户类型
        ), $request['data']);


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
        if ( !$requestData['城市']) {
            Func_Header::back('城市必须填写！');
        }
        $data = array(
            'username' => $requestData['姓名'],
            'phone' => $requestData['手机号'],
            'tel' => $requestData['公司电话'],
            'city' => $requestData['城市'],
//            'business' => $requestData['业务类型'],
//            'sub_business' => $requestData['业务子类'],
            'company' => $requestData['公司名称'],
            'position' => $requestData['公司职位'],
            'attr' => $requestData['attr'],
            'type' => $requestData['type'],
            'customer_type' => $requestData['customer_type'],
            'state' => $requestData['state'],
            'account_id' => $request['account_id'],
        );
        if (!empty($request['id'])) {
            $data['id'] = $request['id'];
        }
        $rs = Data_Mysql_Table_Contact_Library::update($data);
        if (!empty($rs[0])) {

            Func_Header::back(' 操作成功!');
        } else {
            Func_Header::back('操作失败，可能是联系人已存在!');
        }
    }

    //带看场地
    static function  handleTakeLook()
    {
        Core::output('');
        $request = Func_Input::filter(array(
            'recommend_id' => 'int',
            'look_time' => 'string',
            'look_remark' => 'string',
            'demand_id' => 'int',
        ), $_REQUEST);
        if (empty($request['demand_id']) || empty($request['recommend_id'])) {
            Func_Output::json('error', '', '请返回列表刷新重试');
        }
        if (Api_Session::admin_id() == false) {
            Func_Output::json('error', '', '请先登录');
        }
        $data = Api_Recommend_TakeLook::remark($request);
        echo json_encode($data);
        exit;
    }

}