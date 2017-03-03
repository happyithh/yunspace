<?php

/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/4/20
 * Time: 10:03
 * bxy
 * 短信通知设置
 */
class OA_Sms_Notice_Config
{

    static function handle()
    {
        if (!empty($_REQUEST['submit'])) {
            $filter = array();
            foreach (Data_Config_Demand_Notice::getInstance()->all as $k => $v) {
                $filter[$k] = is_numeric($v) ? 'phone' : 'string';
            }
            $request = Func_Input::filter($filter, $_REQUEST['data']);
            foreach ($request as $k => $v) {
                if (!$v) {
                    Func_Header::back("{$k}格式不正确!");
                }
            }
            foreach ($filter as $k => $v) {
                Data_Config_Demand_Notice::set($k, $request[$k]);
            }
            Func_Header::to(" 修改成功!");
        }
        Tpl_Smarty::assign('_data2', Data_Config_Demand_Notice::all());
        Tpl_Smarty::display('OA', 'sms_notice.tpl');
    }
}