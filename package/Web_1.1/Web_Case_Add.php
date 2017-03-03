<?php

/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/7/29
 * Time: 11:08
 */
class Web_Case_Add
{
    static function  handle()
    {
        $action = empty($_REQUEST['action']) ? 'home' : $_REQUEST['action'];
        switch ($action) {
            case'home':
                self::handleCaseAdd();
                break;
            case'submit':
                self::handleCaseAddSubmit();
                break;
        }
    }

    static function handleCaseAdd()
    {
        Tpl_Smarty::assign('categoryList', Data_Mysql_Table_Product_Category::getTreeCache());
        Tpl_Smarty::assign('_attrs', Data_Config_Vendor_Attr::get('attr'));
        Tpl_Smarty::display('Web_Mobile_Static::case/case_add.tpl');
    }

    static function handleCaseAddSubmit()
    {
        Core::output("");
        $request = Func_Input::filter(array(
            'data' => 'array',
        ));

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
                Data_Mysql_Table_Account_Log::insertAccountLog(0, 0, '创建活动信息', '创建活动信息', $event_rs[0]);
            } else {
                Func_Header::back('添加活动失败！！');
            }
        }
        if (!empty($request['data']['media'])) {
            unset($request['data']['media']['$$']);
        }

        if (mb_substr($request['data']['name'], 0, 2, 'utf-8') == '套餐') {
            $set['product_set_id'] = empty($request['data']['product_id']) ? 0 : $request['data']['product_id'];
            $product['product_id'] = 0;
        }
        if (mb_substr($request['data']['name'], 0, 2, 'utf-8') == '服务') {
            $product['product_id'] = empty($request['data']['product_id']) ? 0 : $request['data']['product_id'];
            $set['product_set_id'] = 0;
        }

        $data = array(
            'product_id' => $product['product_id'],
            'product_set_id' => $set['product_set_id'],
            'vendor_id' => 0,
            'case_name' => empty($request['data']['case_name']) ? $request['data']['event_name'] : $request['data']['case_name'],
            'des' => $request['data']['des'],
            'media' => array($request['data']['attr'], array_values($request['data']['media'])),
            'event_id' => $event_id,
            'status' => 2,
        );
        $r = Data_Mysql_Table_Event_Case::subTable('_update')->insert($data);
        Data_Mysql_Table_Account_Log::insertAccountLog(0, 0, '添加活动案例', '添加活动案例', $r[0]);
        $url_to='http://' . Core::$urls['host'] . '/' . Core::$urls['package'] . Core::$urls['route'] . 'caseadd?action=home';
        if ($r > 0) {
            Func_Header::to(' 案例信息添加成功，正在审核!', $url_to);
        } else {
            Func_Header::back("执行失败, 可能是数据不唯一!");
        }

    }
}