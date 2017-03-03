<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/7/15
 * Time: 13:26
 * 需求编辑
 */
class OA_Demand_Edit
{

    static function handleDemandEditTpl()
    {
        $request = Func_Input::filter(array(
            'demand_id' => 'int',
        ), $_REQUEST);
        $demandInfo = Data_Mysql_Table_Demand::select('*', array('id' => $request['demand_id']));
        $dataDemand = OA_Demand_Operate::changeArr($demandInfo);

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
        Tpl_Smarty::display('OA_Static::Demand.v2.0/demand_edit.tpl');
    }

    static function handleDemandEditFrom()
    {
        $request = Func_Input::filter(array(
            'demand_id' => 'int',
            'demand_name' => 'string',
            'notice_city' => 'string',
            'data' => 'array',
            'price_up' => 'int',
            'price_down' => 'int',
        ), $_REQUEST);
        $demand = Func_Input::filter(array(
            '联系电话' => 'phone',
            '联系人' => 'string',
            '公司名称' => 'string',
            '场地类型' => 'string',
            '活动类型' => 'string',
            '活动城市' => 'string',
            '活动人数' => 'string',
            '开始时间' => 'string',
            '结束时间' => 'string',
            '需求场地' => 'string',
            '具体要求' => 'string',
        ), $request['data']);

        $demand['price_up'] = $request['price_up'];
        $demand['price_down'] = $request['price_down'];

        $oldDemand = Data_Mysql_Table_Demand::select('demand_type,city,account_id,phone,demand,create_time,delay_time', array('id =?' => $request['demand_id']));
        if (empty($oldDemand[0]['demand'])) {
            Func_Header::back('该需求不存在，请返回列表页重试');
        }

        foreach ($demand as $k => $v) {
            if ($v == '') {
                unset($demand[$k]);
            }
        }
        $old_demand = json_decode($oldDemand[0]['demand'], true);
        $newDemand = array_merge($old_demand, $demand);
        $demand['account_id'] = $oldDemand[0]['account_id'];
        $newData = array(
            'demand_id' => $request['demand_id'],
            'demand_name' => $request['demand_name'],
            'demand_status' => 1,
            'city' => $demand['活动城市'],
            'resolve_time' => time(),
            'price_up' => $request['price_up'],          //价格上限
            'price_down' => $request['price_down'],
            'demand' => $newDemand,
            'notice_city' => $request['notice_city'],
        );
        $status = Api_Demand_Edit::demandEdit($newData);
        if ($status) {
            Data_Mysql_Table_Account_Log::insertAccountLog($oldDemand[0]['account_id'], $_SESSION['administrator']['id'], '修改需求', '修改需求', $request['demand_id']);
            if (!empty($request['is_num'])) {
                Func_Header::to('  需求修改成功', '/admin/action/operation/demand_tender?act=demand_offer&action=list_show&demand_id=' . $request['demand_id'] . '&offer_id=' . $request['offer_id'] . '&type=1');

            }
            Func_Header::to('  需求修改成功', Core::$urls['base_path'] . '?action=demand_info&demand_id=' . $request['demand_id']);

        }
        Func_Header::back('需求未能修改成功！');
    }


}