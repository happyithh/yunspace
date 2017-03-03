<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2015/8/19
 * Time: 14:28
 * 后台爆料奖励
 */
class OA_Broke_Reward
{
    static function handle()
    {
        $action = empty($_REQUEST['action']) ? 'list' : $_REQUEST['action'];
        switch ($action) {
            case 'list':
                self::rewardList();
                break;
            case 'export':
                self::exportDate();
                break;
            case 'detail':
                self::getDetail();
                break;
            case 'detailStatus':
                self::detailStatus();
                break;
            case 'receive':
                self::demandReceive();
                break;
            case 'receive_from_submit':
                self::submitDemandReceive();
                break;
            case 'abandon':
                self::demandAbandon();
                break;
            default:
                self::rewardList();

        }
        self::rewardList();
    }

    static function rewardList()
    {
        if(!empty($_REQUEST['search'])){
            $request = Func_Input::filter(
                array(
                    'type'=>'string'
                ),$_REQUEST['search']);
            if(empty($request['type'])){
                $request['type']='done';
            }
            Tpl_Smarty::assign('type',$request['type']);
        }
        $data = Api_Broke_Reward_List::rewardList($_REQUEST);
        if (!empty($data['data']) && $data['status'] == 1) {
            Tpl_Smarty::assign('data', $data['data']);
        }
        Tpl_Smarty::display('OA_Static::broke_reward/broke_reward.tpl');
        die();
    }

    // 导出数据
    static function exportDate()
    {
        $data = Api_Broke_Reward_List::exportData($_REQUEST);

        if (!empty($data) && $data['status'] == 0) {
            Func_Header::back('没有要导出的数据哦');
        }
    }

    //爆料人所有爆料信息详情
    static function getDetail()
    {
        $request=Func_Input::filter(
            array(
               'account_id'=>'int',
                'broke_time'=>'string',
                'type'=>'string'
            ),$_REQUEST);
        $data = Api_Broke_GetDetail::getDetail($request);
        if (!empty($data['data']) && $data['status'] == 1) {
            Tpl_Smarty::assign('data', $data['data']);
        }
        Tpl_Smarty::assign('otherData',$request);
        Tpl_Smarty::display('OA_Static::broke_reward/broke_detail.tpl');
        die();
    }

    // 跳转到需求的详情页面
    static function detailStatus()
    {
        $request = Func_Input::filter(
            array(
                'id' => 'int'
            ), $_REQUEST);
        if (empty($request['id'])) {
            Func_Header::notFound();
        }
        $demandInfo = Data_Mysql_Table_Demand::select('*', array('id' => $request['id']));
        $demand = OA_Demand_Operate::changeArr($demandInfo);
        Tpl_Smarty::assign('recent_demand', Api_Demand_Admin_Recent::getRecent(array('phone' => $demand[0]['phone'], 'demand_id' => $_REQUEST['id'])));
        Tpl_Smarty::assign('_demand', $demand[0]);
        Tpl_Smarty::display('OA_Static::demands/operational_demand_detail.tpl');
        die();
    }
    //接受用户需求 编辑需求信息
    static function demandReceive(){
        $request = Func_Input::filter(array(
            'demand_id' => 'int',
        ), $_REQUEST);
        $demandInfo = Data_Mysql_Table_Demand::select('*', array('id' => $request['demand_id']));
        $dataDemand = OA_Demand_Operate::changeArr($demandInfo);

        Tpl_Smarty::assign('_demand', $dataDemand[0]);
        Tpl_Smarty::assign('_demandType', Data_Mysql_Table_Demand::$_demandType);
        Tpl_Smarty::assign('categoryList', Data_Mysql_Table_Product_Category::getTreeCache());
        $tags = Data_Config_Vendor_Attr::get('attr');
        if (!empty($tags['活动类型'])) {
            Tpl_Smarty::assign('tags', $tags['活动类型']);
        }
        Tpl_Smarty::display('OA_Static::demands/demand_edit.tpl');
        die();
    }
    //编辑后提交需求
    static function submitDemandReceive(){
        OA_Demand_Operate::handleDemandReceiveFromSubmit();
    }
    //放弃需求
    static function demandAbandon(){
        OA_Demand_Operate::demandAbandon();
    }
}