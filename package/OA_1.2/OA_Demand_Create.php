<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 15-12-31
 * Time: 上午9:57
 */
class OA_Demand_Create
{
    static function handle($department = '运营部')
    {
        $action = empty($_REQUEST['action']) ? 'show' : $_REQUEST['action'];
        switch ($action) {
            case 'show':
                self::handleDemandCreate($department);
                break;
            case 'demand_edit_submit':
                self::handleDemandCreateSubmit($department);
                break;
            case 'ajaxSelectRecentDemand':
                OA_Demand_getRecent::getRecentDemand();
                break;
        }
    }

    static function handleDemandCreate($department)
    {
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
        Tpl_Smarty::assign('demand_options', Data_Demand_Option_Config::all());
        Tpl_Smarty::assign('department', $department);
        Tpl_Smarty::display('OA_Static::Demand.v2.0/demand_edit.tpl');
    }

    static function  handleDemandCreateSubmit($department)
    {
        @session_start();
        $request = Func_Input::filter(array(
            'notice_city' => 'string',
            'demand_name' => 'string',
            'data' => 'array',
            'price_up' => 'int',
            'price_down' => 'int',
            'is_offer' => 'int',
            'department' => 'string',
            'is_phone' =>'int',
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
            '活动城市' => 'string',
        ), $request['data']);

        foreach ($demand as $k => $v) {
            if ($v == '') {
                unset($demand[$k]);
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
        $demand['price_up'] = $request['price_up'];
        $demand['price_down'] = $request['price_down'];
        if ($department == "销售部") {

            $admin_id = Api_Session::admin_id();
            if (!$admin_id) {
                Func_Header::to('如果您是销售人员，请先登录');
            }
            $adminAccount = Api_Administrator_GetBaseAccountInfo::getBastAccountInfo(array('admin_id' => $admin_id));

            $check = Data_Mysql_Table_Grab_Order::select('step,status', array(
                'customer_phone=? AND sale_phone=? ' => array(
                    $demand['联系电话'],
                    $adminAccount['phone']
                )));

            if (!empty($check[0])) {
                if ($check[0]['step'] != 100 && $check[0]['step'] > 0) {
                    Func_Header::to('您已经有一个手机号相同的订单正在进行中了~，不能重复创建');
                }
            }
        }

        //创建需求
        $demand_rs = Api_Demand_Create::create(array('demand' => $demand,
            'demand_type' => $demand['需求类型'],
            'phone' => $demand['联系电话'],
            'account_id' => $account_id,
            'demand_name' => $request['demand_name'],
            'demand_status' => 1,
            'admin_id' => $_SESSION['administrator']['id'],
            'resolve_time' => time() + 10,
            'price_up' => $request['price_up'],
            'price_down' => $request['price_down'],
            'notice_city' => $request['notice_city'],
            'is_phone' => $request['is_phone'],
        ));
        if (!empty($demand_rs['data'])) {
            //如果是 销售部 创建的
            if ($department == "销售部") {
                $isOK = Api_Grab_Order_Create::create(array('demand_id' => $demand_rs['data']));
                Data_Mysql_Table_Grab_Order::update(array('id=?' => $demand_rs['data']), array('sale_phone' => $adminAccount['phone'],'status'=>1));

                Api_Demand_Notice_V2::saleOfferNoticeCreateSuccess(array('sale_phone' => $adminAccount['phone']));

            } else {

                //进入抢单系统
                $isOK = Api_Demand_Handle::getIntoGrabOrder(array(
                    'city' => $request['notice_city'],
                    'phone' => $demand['联系电话'],
                    'demand_id' => $demand_rs['data'],
                    'demand' => $demand
                ));
            }

            $data = array(
                'username' => $demand['联系人'],
                'phone' => $demand['联系电话'],
                'city' => $demand['城市'],
//                'business' => $demand['业务类型'],
//                'sub_business' => $demand['业务子类'],
                'type' => 1,
                'create_time' => time(),
                'resolve_time' => time() + 10,
                'account_id' => $account_id,
            );
            Data_Mysql_Table_Contact_Library::update($data);

            Data_Mysql_Table_Account_Log::insertAccountLog($account_id, $_SESSION['administrator']['id'], '创建需求', '创建需求', $demand_rs['data']);
            if ($isOK['status'] == 1) {
                Func_Header::to('  需求创建成功', Core::$urls['base_path'] . '?');
            }
        }

        Func_Header::back('操作失败，请返回列表页重试', Core::$urls['base_path'] . '?action=list');
    }

}