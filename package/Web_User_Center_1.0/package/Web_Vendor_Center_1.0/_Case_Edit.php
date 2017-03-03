<?php

/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/3/24
 * Time: 10:22
 */
class Web_Vendor_Center_Case_Edit extends Base
{
    static function handle($type = 'product')
    {
        //检查是否有修改权限
        Web_Vendor_Center_Product_Edit::handleCheckProductAuth();
        switch (Core::$urls['action']) {
            case 'case_edit/event_name':
                self::handleEventTypeAhead();
                break;
            case 'case_edit/submit':
                self::handleCaseEditSubmit();
                break;
            case 'case_add':
                self::handleCaseAdd($type);
                break;
            default:
                self::handleCaseEdit($type);
                break;
        }
    }

    static function handleCaseAdd($type)
    {
        //获取当前产品信息
        if ($type == 'product') {
            $rs = Data_Mysql_Table_Product_Info::subTable('_update')->select('id, product_name as name, vendor_id', array('id' => $_REQUEST['product_id']));
        } elseif ($type == 'set') {
            $rs = Data_Mysql_Table_Product_Set::subTable('_update')->select('id, set_name as name, vendor_id', array('id' => $_REQUEST['set_id']));
        }
        if (empty($rs[0]['id'])) {
            Func_Header::back('参数错误! ');
        }
        Tpl_Smarty::assign('_product', $rs[0]);
        //获取活动类型和行业标签
        Tpl_Smarty::assign('_attrs', Data_Config_Vendor_Attr::get('attr'));
        Tpl_Smarty::display('case_edit.tpl');
        die;
    }

    /*
    * 案例信息展示
    */
    static function handleCaseEdit($type)
    {
        if ((empty($_REQUEST['product_id']) && empty($_REQUEST['set_id'])) || empty($_REQUEST['case_id'])) {
            Func_Header::back('参数错误! ');
        }
        if ($type == 'product') {
            //获取当前产品信息
            $product = Data_Mysql_Table_Product_Info::subTable('_update')->select('id, product_name as name, vendor_id', array('id' => $_REQUEST['product_id']));
        } elseif ($type == 'set') {
            //获取当前套餐信息
            $product = Data_Mysql_Table_Product_Set::subTable('_update')->select('id, set_name as name, vendor_id', array('id' => $_REQUEST['set_id']));
        }

        if (empty($product[0]['id'])) {
            Func_Header::back('参数错误! ');
        }
        Tpl_Smarty::assign('_product', $product[0]);
        //获取活动类型和行业标签
        Tpl_Smarty::assign('_attrs', Data_Config_Vendor_Attr::get('attr'));
        //获取旧的案例数据
        $case = Data_Mysql_Table_Event_Case::subTable('_update')->select('{table}.id,{prefix}event_info.update_time,{table}.status,{table}.case_name,{table}.des,{table}.media,{prefix}event_info.event_name,{prefix}event_info.attr,{prefix}event_info.id as event_id', array(
            'id' => $_REQUEST['case_id'],
        ), '', 1, '{table} LEFT JOIN {prefix}event_info ON {table}.event_id = {prefix}event_info.id');
        $case = $case[0];
        $case['media'] = json_decode($case['media'], 1);
        $case['event_name'] = '[' . $case['event_id'] . ']&nbsp;' . $case['event_name'];
        if (!empty($case['media'][0])) {
            $case['attr'] = $case['media'][0];
            $case['media'] = $case['media'][1];
        } else {
            $case['attr'] = json_decode($case['attr'], 1);
        }
        Tpl_Smarty::assign('_data', $case);
        Tpl_Smarty::display('case_edit.tpl');
        die();
    }

    static function handleCaseEditSubmit()
    {
        $request = Func_Input::filter(array(
            'product_id' => 'int',
            'set_id' => 'int',
            'case_id' => 'int',
            'vendor_id' => 'int',
            'data' => 'array',
        ));
        if (empty($request['product_id']) && empty($request['set_id'])) {
            Func_Header::back("参数错误！！");
        }
        if (empty($request['data']['event_name'])) {
            Func_Header::back("操作失败, 活动名称不能为空！");
        }

        $event_id = Func_String::strCut($request['data']['event_name'], '[', ']');
        if (empty($event_id)) {
            $attr = $request['data']['attr'];
            $attr['城市'] = $_COOKIE['city'];
            $event_data = array(
                'event_name' => $request['data']['event_name'],
                'attr' => $attr,
                'status' => 0,
                'create_time' => time(),
            );
            $event_rs = Data_Mysql_Table_Event_Info::insert($event_data);
            if (!empty($event_rs)) {
                $event_id = $event_rs[0];
                $request['data']['event_name'] = "[" . $event_id . "] " . $request['data']['event_name'];
                //创建操作日志
                Data_Mysql_Table_Account_Log::insertAccountLog($_SESSION['user']['id'], 0, '创建活动信息', '创建活动信息', $event_rs[0]);
            } else {
                Func_Header::back('添加活动失败！！');
            }
        }
        if (!empty($request['data']['media'])) {
            unset($request['data']['media']['$$']);
        }
        $data = array(
            'product_id' => $request['product_id'],
            'product_set_id' => $request['set_id'],
            'vendor_id' => $request['vendor_id'],
            'case_name' => empty($request['data']['case_name']) ? $request['data']['event_name'] : $request['data']['case_name'],
            'des' => $request['data']['des'],
            'media' => array($request['data']['attr'], array_values($request['data']['media'])),
            'event_id' => $event_id,
            'status' => 2,
        );
        if ($request['case_id']) {
            $r = Data_Mysql_Table_Event_Case::subTable('_update')->update(array('id' => $request['case_id']), $data);
            //创建操作日志
            Data_Mysql_Table_Account_Log::insertAccountLog($_SESSION['user']['id'], 0, '更新活动案例', '更新活动案例', $request['case_id']);
        } else {
            $r = Data_Mysql_Table_Event_Case::subTable('_update')->insert($data);
            //创建操作日志
            Data_Mysql_Table_Account_Log::insertAccountLog($_SESSION['user']['id'], 0, '添加活动案例', '添加活动案例', $r[0]);
        }
        //添加案例信息
        if (!empty($request['product_id'])) {
            $url_to = 'http://' . Core::$urls['host'] . '/' . Core::$urls['package'] . Core::$urls['route'] . 'product_edit/case?product_id=' . $request['product_id'];
        } elseif (!empty($request['set_id'])) {
            $url_to = 'http://' . Core::$urls['host'] . '/' . Core::$urls['package'] . Core::$urls['route'] . 'set_edit/case?set_id=' . $request['set_id'];
        }
        if ($r > 0) {
            //如果是加盟的供应商
            $status = Api_Vendor_Join_IsVendorJoinAccount::check(array('account_id' => Api_Session::user_id()));
            if (!$status) {
                //更改所属供应商的状态
                Data_Mysql_Table_Vendor_Info::subTable('_update')->update(array('id = ? and status != ?' => array($request['vendor_id'], 2)), array('status' => 4));
            }
            Func_Header::to(' 案例信息添加成功，正在审核!', $url_to);
        } else {
            Func_Header::back("执行失败, 可能是数据不唯一!");
        }
    }

    static function handleEventTypeAhead()
    {
        Core::output('');
        $request = Func_Input::filter(array('query' => 'string'));
        if ($request['query']) {
            $rs = Data_Mysql_Table_Event_Info::select('CONCAT( "[", id, "] ", event_name) as name', array("id like ? OR event_name like ?" => array($request['query'] . '%', $request['query'] . '%')), '', 5);
            echo json_encode($rs);
            die;
        }
    }

}
