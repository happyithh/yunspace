<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 15-6-10
 * Time: 下午8:56
 */
class OA_Vendor_Change_Account_Check{
    static function handle(){
        $action=empty($_REQUEST['action'])?"list":$_REQUEST['action'];
        switch($action){
            case "pass":
                self::changePassCheck();
                break;
            case "refuse":
                self::refuseChangeCheck();
                break;
            default:
                self::getWaitingCheckAccount();
                break;
        }
    }
    /*
     *获取所有待审核的供应商变更账户信息
     */
    static function getWaitingCheckAccount(){
        $data=$conditions=array();
        $handle_type = empty($_REQUEST['handle_type']) ? 'waiting' : $_REQUEST['handle_type'];
        $page_name = '待审核';
        switch ($handle_type) {
            case "reject":
                $conditions['status'] = -1;
                $page_name = '已拒绝';
                break;
            case "waiting":
                $conditions['status'] = 0;
                $page_name = '待审核';
                break;
            case "pass":
                $conditions['status'] = 1;
                $page_name = '已审核';
                break;
        }
        if (!empty($_REQUEST['search'])) {
            $search=Func_Input::filter(array(
                'title'=>'string',
                'vendor_name'=>'string',
                'admin_id'=>'int',
                'start_time'=>'string',
                'end_time'=>'string',
            ),$_REQUEST['search']);
            //原账户名称/新账户名称筛选
            if(!empty($search['title'])){
                $conditions['({table}.old_account_name = ? OR {prefix}account.username= ?) '] = array($search['title'],$search['title']);
            }
            //供应商筛选
            if(!empty($search['vendor_name'])){
                $conditions['{prefix}vendor_info_update.vendor_name = ?'] = $search['vendor_name'];
            }
            //操作者筛选
            if(!empty($search['admin_id'])){
                $conditions['admin_id'] = $search['admin_id'];
            }
            //更新时间筛选
            if (!empty($search['start_time']) && !empty($search['end_time'])) {
                if (strtotime($search['start_time']) > strtotime($search['end_time'])) {
                    Func_Header::back('请正确选择时间范围！！');
                } else {
                    $conditions['{table}.update_time between ? and ?'] = array(strtotime($search['start_time']), strtotime($search['end_time']));
                }
            } elseif (!empty($search['start_time']) && empty($search['end_time'])) {
                $conditions['{table}.update_time > ?'] = strtotime($search['start_time']);
            } elseif (empty($search['start_time']) && !empty($search['end_time'])) {
                $conditions['{table}.update_time < ?'] = strtotime($search['end_time']);
            }

        }
        $cols=array('{table}.*,{prefix}account.username as new_account_name,{prefix}administrator.username as admin_name,{prefix}vendor_info_update.vendor_name');
        $table='{table} LEFT JOIN {prefix}account ON {table}.new_account_id = {prefix}account.id LEFT JOIN {prefix}administrator ON {table}.admin_id = {prefix}administrator.id LEFT JOIN {prefix}vendor_info_update ON {table}.vendor_id ={prefix}vendor_info_update.id';
//        Data_Mysql_Table_Vendor_Change_Account::debug(1);
        $data=Data_Mysql_Table_Vendor_Change_Account::page(0,20,$cols,$conditions,'ORDER BY {table}.create_time DESC',$table);
        //获取市场部所有管理员
        $adminInfo=array();
        $adminInfo = Api_Administrator_Department_Normal_Api::getMemberList('市场部', '', 1);
        Tpl_Smarty::assign('handle_type',$handle_type);
        Tpl_Smarty::assign('page_name',$page_name);
        Tpl_Smarty::assign('data',$data);
        Tpl_Smarty::assign('_adminInfo',$adminInfo);
        Tpl_Smarty::display('OA','check/vendor_change_account_list.tpl');
    }
    /*
     *供应商变更账户信息通过审核
     */
    static function changePassCheck(){
        if(empty($_REQUEST['id'])){
            Func_Header::back('参数错误！');
        }
        $change_account=Data_Mysql_Table_Vendor_Change_Account::select('vendor_id,old_account_id,new_account_id',array('id'=>$_REQUEST['id']));
        if(empty($change_account[0])){
            Func_Header::back('供应商变更账户的数据不存在！');
        }
        //获取供应商update表中数据
        $rs_update=Data_Mysql_Table_Vendor_Info::subTable('_update')->select('id,vendor_name',array('id'=>$change_account[0]['vendor_id']));
        if(!empty($rs_update[0])){
            $rs=Data_Mysql_Table_Vendor_Info::subTable('_update')->update(array('id'=>$change_account[0]['vendor_id']),array('vendor_account_id'=>$change_account[0]['new_account_id']));
        }
        //获取供应商表中数据
        $rs_info=Data_Mysql_Table_Vendor_Info::select('id,vendor_name',array('id'=>$change_account[0]['vendor_id']));
        if(!empty($rs_info[0])){
            $rs=Data_Mysql_Table_Vendor_Info::update(array('id'=>$change_account[0]['vendor_id']),array('vendor_account_id'=>$change_account[0]['new_account_id']));
        }
        //更新变更表的状态
        if(!empty($rs[0])){
            $rs_change=Data_Mysql_Table_Vendor_Change_Account::update(array('id'=>$_REQUEST['id']),array('status'=>1));
        }

        if(!empty($rs_change[0])){
            //创建账户的操作日志
            Data_Mysql_Table_Account_Log::insertAccountLog($change_account[0]['old_account_id'], $_SESSION['administrator']['id'], '供应商与此账户解除绑定', '供应商信息变更',$change_account[0]['vendor_id']);
            Data_Mysql_Table_Account_Log::insertAccountLog($change_account[0]['new_account_id'], $_SESSION['administrator']['id'], '供应商绑定此账户', '供应商信息变更',$change_account[0]['vendor_id']);
            Func_Header::to(' 供应商更新账户信息成功！','?');
        }else{
            Func_Header::back('供应商更新账户信息失败！');
        }

    }
    /*
    *账户更改信息未通过审核
    */
    static function refuseChangeCheck(){
        Core::output('');
        $request=Func_Input::filter(array(
            'id'=>'int',
            'refuse_reason'=>'string',
        ));
        if(empty($request['id'])){
            Func_Output::json('error','','参数错误！！');
        }
        if(empty($request['refuse_reason'])){
            Func_Output::json('error','','请输入拒绝原因！！');
        }
        $change_account=Data_Mysql_Table_Vendor_Change_Account::select('vendor_id,old_account_id,new_account_id',array('id'=>$request['id']));
        if(empty($change_account[0])){
            Func_Output::json('error','','供应商变更账户的数据不存在！！');
        }
        $data['demo']=$request['refuse_reason'];
        $data['status']=-1;
        $rs=Data_Mysql_Table_Vendor_Change_Account::update(array('id'=>$request['id']),$data);
        if(!empty($rs[0])){
            //创建账户的操作日志
            Data_Mysql_Table_Account_Log::insertAccountLog($change_account[0]['old_account_id'], $_SESSION['administrator']['id'], '供应商解除绑定审核未通过', '供应商信息更新',$change_account[0]['vendor_id']);
            Func_Output::json('success','',' 供应商变更账户请求已拒绝！！');
        }else{
            Func_Output::json('error','','操作失败！！');
        }

    }

}