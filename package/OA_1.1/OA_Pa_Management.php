<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2015/10/21
 * Time: 17:16
 */
@session_start();
class OA_Pa_Management
{
    static function handle()
    {
        $action = empty($_REQUEST['action']) ? 'list' : $_REQUEST['action'];
        switch ($action) {
            case 'list':
                self::paManagement();
                break;
            case 'site_list':
                self::paSiteManagement();
                break;
            case 'siteAdd':
                self::paSiteAdd();
                break;
            case 'site_edit':
                self::paSiteEdit();
                break;
            case 'adver_edit':
                self::paEdit();
                break;
            case 'siteAddSubmit':
                self::paSiteAddSubmit();
                break;
            case 'paAdd':
                self::paAdd();
                break;
            case 'paAddSubmit':
                self::paAddSubmit();
                break;
            case 'ajaxGetSize':
                self::GetPaSize();
                break;
            case 'close':
                self::CloseSite();
                break;
            case 'restore':
                self::RestoreSite();
                break;
            case 'adver_statistics':
                self::paStatistics();
                break;
            default:
                self::paManagement();
        }

    }

    //广告位列表
    static function paSiteManagement()
    {
        $request = Func_Input::filter(array(
            'type'=>'string',
        ),$_REQUEST);
        $request['type']=empty($request['type'])?'normal':$request['type'];
        Tpl_Smarty::assign('type',$request['type']);
        $res = Api_Pa_Site_List::paSiteList($_REQUEST);
        if (!empty($res)) {
            Tpl_Smarty::assign('data', $res);
        }

        Tpl_Smarty::display('OA_Static::pa/pa_site_list.tpl');
    }

    // 广告位添加
    static function paSiteAdd()
    {
        Tpl_Smarty::display('OA_Static::pa/site_add.tpl');
    }

    // 广告位编辑
    static function paSiteEdit()
    {
        $request = Func_Input::filter(array(
            'id' => 'int'
        ),$_REQUEST);
        if (empty($request['id'])) {
            Func_Header::back('  参数传递错误!');
        }
        $res = Api_Pa_Site_Detail::getSiteDetail($_REQUEST);
        if (empty($res[0])) {
            Func_Header::back('  数据不存在!');
        } else {
            Tpl_Smarty::assign('data', $res);
        }
        Tpl_Smarty::display('OA_Static::pa/site_add.tpl');
    }

    // 广告位提交
    static function paSiteAddSubmit()
    {
        $res = Api_Pa_Site_Add::siteAdd($_REQUEST);
        if ($res['status'] == 1) {
            Func_Header::to('  ' . $res['msg'], '?action=site_list');
        } else {
            Func_Header::back($res['msg']);
        }
    }
    // 广告列表
    static function paManagement()
    {
        $res = Api_Pa_Get_List::paList($_REQUEST);
        if (!empty($res)) {
            Tpl_Smarty::assign('data', $res);
        }
        $site = Data_Mysql_Table_Pa::getSize($_REQUEST);
        Tpl_Smarty::assign('site', $site);
        Tpl_Smarty::display('OA_Static::pa/pa_list.tpl');
    }

    // 广告添加
    static function paAdd()
    {
        $res = Data_Mysql_Table_Pa::getSize($_REQUEST);
        Tpl_Smarty::assign('site', $res);
        Tpl_Smarty::display('OA_Static::pa/pa_add.tpl');
    }
    // 广告提交
    static function paAddSubmit()
    {
        $res = Api_Pa_Add::paSubmit($_REQUEST);
        if ($res['status'] == 1) {
            Func_Header::to('  ' . $res['msg'], '?');
        } else {
            Func_Header::back($res['msg']);
        }
    }
    //广告编辑
    static function paEdit(){
        $request = Func_Input::filter(array(
            'id' => 'int'
        ),$_REQUEST);
        if (empty($request['id'])) {
            Func_Header::back('  参数传递错误!');
        }
        $res = Api_Pa_Detail::paDetail($_REQUEST);
        if (empty($res[0])) {
            Func_Header::back('  数据不存在!');
        } else {
            Tpl_Smarty::assign('_data', $res);
        }
        $res = Data_Mysql_Table_Pa::getSize($_REQUEST);
        Tpl_Smarty::assign('site', $res);
        Tpl_Smarty::display('OA_Static::pa/pa_add.tpl');
    }
    // 获取 广告位信息
    static function GetPaSize()
    {
        Core::output('');
        $res = Api_Pa_Get_Limit_Size::limitSize($_REQUEST);
        Func_Output::json('success', $res, '');
    }
    // 关闭 广告位
    static function CloseSite(){
        $request=Func_Input::filter(array(
            'id'=>'int',
        ),$_REQUEST);
        if(empty($request['id'])){
            Func_Header::back('请求异常！');
        }
        $res = Data_Mysql_Table_Pa_Site::update(array('id'=>$request['id']),array('status'=>-1));
        if(!empty($res[0])){
            //创建操作日志
            $account_id = Api_Administrator_GetBaseAccountInfo::getBastAccountInfo(array('admin_id'=>$_SESSION['administrator']['id']));
            Data_Mysql_Table_Account_Log::insertAccountLog($account_id['account_id'],$_SESSION['administrator']['id'],'广告位修改--关闭','广告位管理',$request['id']);
            Func_Header::to('  关闭成功！');
        }else{
            Func_Header::back('关闭失败！');
        }
    }
    // 恢复 广告位
    static function RestoreSite(){
        $request=Func_Input::filter(array(
            'id'=>'int',
        ),$_REQUEST);
        if(empty($request['id'])){
            Func_Header::back('请求异常！');
        }
        $res = Data_Mysql_Table_Pa_Site::update(array('id'=>$request['id']),array('status'=>0));
        if(!empty($res[0])){
            //创建操作日志
            $account_id = Api_Administrator_GetBaseAccountInfo::getBastAccountInfo(array('admin_id'=>$_SESSION['administrator']['id']));
            Data_Mysql_Table_Account_Log::insertAccountLog($account_id['account_id'],$_SESSION['administrator']['id'],'广告位修改--恢复','广告位管理',$request['id']);

            Func_Header::to('  恢复成功！');
        }else{
            Func_Header::back('恢复失败！');
        }
    }
    // 广告统计信息
    static function paStatistics(){
        $pa_name = Data_Mysql_Table_Pa::select('id,advertising_title,site_id', '', 'ORDER BY rank ASC', 999);
        if(!empty($pa_name)){
            foreach($pa_name as $k=>$v){
                $pa_name[$k]['pa'] = $v['site_id'].','.$v['id'];
                unset($v['site_id']);
                unset($v['id']);
            }
        }
        Tpl_Smarty::assign('pa_title',$pa_name);
        if(empty($_REQUEST['search'])){
            $_REQUEST['search']['pa'] = $pa_name[0]['pa'];
        }
        $res=Api_Pa_Statistics::statistics($_REQUEST);
        if(!empty($res)){
            Tpl_Smarty::assign('data',$res);
        }
        Tpl_Smarty::assign('type',empty($_REQUEST['type'])?'day':$_REQUEST['type']);
        Tpl_Smarty::display('OA_Static::pa/pa_statistics.tpl');
    }
    static function getPaName(){

    }
}