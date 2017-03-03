<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 15-7-1
 * Time: 上午10:33
 */
class OA_Account_Change_Vendor {
    static function handle(){
        $action=empty($_REQUEST['action'])?'list':$_REQUEST['action'];
        switch($action){
            case 'detail':
                self::getChangeDetail();
                break;
            case 'vendor_auto_complete':
                Admin_Data_Table_Product_Info::handleVendorAutoComplete();
                break;
            case 'refuse':
                self::refuseAccountChangeVendor();
                break;
            case 'add_new':
                self::addNewVendorForAccount();
                break;
            case 'bind_old':
                self::bindOldVendor();
                break;
            default:
                self::getAllChangeList();
                break;
        }
    }
    /*
     *获取所有要变更供应商的账户信息
     */
    static function getAllChangeList(){
        $conditions=$data=array();
        //筛选条件
        if (!empty($_REQUEST['search'])) {
            $search = Func_Input::filter(array(
                'title' => 'string',
                'end_time' => 'string',
                'start_time' => 'string',
            ), $_REQUEST['search']);
            //账户名称或ID筛选
            if (!empty($search['title'])) {
                if (is_numeric($_REQUEST['search']['title'])) {
                    $conditions['account_id'] = $search['title'];
                } else {
                    $conditions['{prefix}account.username = ?'] = $search['title'];
                }
            }
            //更新时间
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
        }
        $data = Data_Mysql_Table_Vendor_Account::page(0, 0, '{table}.*,{prefix}account.username,{prefix}account.account_type', $conditions, 'ORDER BY {table}.create_time DESC', '
        {table} LEFT JOIN {prefix}account ON {table}.account_id={prefix}account.id');
        Tpl_Smarty::assign('_data',$data);
        Tpl_Smarty::assign('handle_type',$handle_type);
        Tpl_Smarty::assign('page_name',$page_name);
        Tpl_Smarty::display('OA','change_vendor/change_vendor_list.tpl');
    }
    /*
     *账户变更的供应商详情
     */
     static function getChangeDetail(){
        if(empty($_REQUEST['id'])){
            Func_Header::back('参数错误！！');
        }
        $data = Data_Mysql_Table_Vendor_Account::select('{table}.*,{prefix}account.username,{prefix}account.account_type', array('id'=>$_REQUEST['id']), '',1, '
        {table} LEFT JOIN {prefix}account ON {table}.account_id={prefix}account.id');
         if(empty($data[0])){
             Func_Header::back('数据不存在！！');
         }
         $change=$data[0];
         if(!empty($change['attr'])){
             $change['attr']=json_decode($change['attr'],1);
         }
         if(!empty($change['base_info'])){
             $change['base_info']=json_decode($change['base_info'],1);
         }
         $vendor=array();
         if(!empty($change['old_vendor_id'])){
            $vendors=Data_Mysql_Table_Vendor_Info::select('id,vendor_name,attr,base_info,logo,des',array('id'=>$change['old_vendor_id']));
            if(empty($vendors[0])){
                Func_Header::back('原供应商数据不存在！');
            }
             $vendor=$vendors[0];
         }
         if(!empty($vendor['attr'])){
             $vendor['attr']=json_decode($vendor['attr'],1);
         }
         if(!empty($vendor['base_info'])){
             $vendor['base_info']=json_decode($vendor['base_info'],1);
         }
         Tpl_Smarty::assign('change',$change);
         Tpl_Smarty::assign('vendor',$vendor);
         Tpl_Smarty::assign('_categories',Data_Mysql_Table_Product_Category::getTreeCache());
         Tpl_Smarty::display('OA','change_vendor/change_vendor_detail.tpl');
     }
    /*
     *拒绝账户变更供应商
     */
    static function refuseAccountChangeVendor(){
        $request=Func_Input::filter(array(
            'change_id'=>'int',
            'refuse_reason'=>'string',
        ));
        if(empty($request['change_id'])){
            Func_Header::back('参数错误！');
        }
        if(empty($request['refuse_reason'])){
            Func_Header::back('请输入拒绝原因！');
        }
        $change=Data_Mysql_Table_Vendor_Account::select('id,account_id',array('id'=>$request['change_id']));
        if(empty($change[0])){
            Func_Header::back('数据不存在！');
        }
        $data['demo']=$request['refuse_reason'];
        $data['status']=-1;
        $rs=Data_Mysql_Table_Vendor_Account::update(array('id'=>$request['change_id']),$data);
        if(!empty($rs[0])){
            //创建账户的操作日志
            Data_Mysql_Table_Account_Log::insertAccountLog($change[0]['account_id'], $_SESSION['administrator']['id'], '账户变更供应商信息审核未通过', '账户变更');
            Func_Header::to(' 账户变更供应商信息已拒绝！','?handle_type=reject');
        }else{
            Func_Header::back('操作失败！');
        }
    }
    /*
     *创建新的供应商
     */
    static function addNewVendorForAccount(){
        if(empty($_REQUEST['change_id'])){
            Func_Header::back('参数错误！！');
        }
        if(empty($_REQUEST['categories_id'])){
            Func_Header::back('请先选择服务分类！！');
        }
        //获取新添加的供应商信息
        $change=Data_Mysql_Table_Vendor_Account::select('*',array('id'=>$_REQUEST['change_id']));
        if(empty($change[0])){
            Func_Header::back('数据不存在！！');
        }
        $insert_data['vendor_name']=$change[0]['vendor_name'];
        $insert_data['des']=$change[0]['des'];
        $insert_data['logo']=$change[0]['logo'];
        $insert_data['attr']=json_decode($change[0]['attr'],1);
        $insert_data['city']=empty($insert_data['attr']['城市'])?"上海":$insert_data['attr']['城市'];
        $insert_data['base_info']=json_decode($change[0]['base_info'],1);
        $insert_data['vendor_account_id']=$change[0]['account_id'];
        $insert_data['status']=1;
        $insert_data['categories_id']=implode(',',$_REQUEST['categories_id']);
        $rs_update=Data_Mysql_Table_Vendor_Info::subTable('_update')->insert($insert_data);
        if(!empty($rs_update[0])){
            $insert_data['id']=$rs_update[0];
            $rs_info=Data_Mysql_Table_Vendor_Info::insert($insert_data);
        }else{
            Func_Header::back('创建新的供应商失败！');
        }
        //更新原供应商的绑定账户
        if(!empty($change[0]['old_vendor_id'])){
            $old_rs_update=Data_Mysql_Table_Vendor_Info::subTable('_update')->update(array('id'=>$change[0]['old_vendor_id']),array('vendor_account_id'=>0));
            $old_rs=Data_Mysql_Table_Vendor_Info::update(array('id'=>$change[0]['old_vendor_id']),array('vendor_account_id'=>0));
        }
        //更新账户变更供应商表
        $rs_change=Data_Mysql_Table_Vendor_Account::update(array('id'=>$_REQUEST['change_id']),array('status'=>2));
        if(!empty($rs_change[0])){
            //创建账户的操作日志
            Data_Mysql_Table_Account_Log::insertAccountLog($change[0]['account_id'], $_SESSION['administrator']['id'], '账户变更供应商', '账户创建新的供应商',$rs_update[0]);
            if(!empty($change[0]['old_vendor_id'])){
                Data_Mysql_Table_Account_Log::insertAccountLog($change[0]['account_id'], $_SESSION['administrator']['id'], '供应商变更绑定账户', '供应商变更绑定账户',$change[0]['old_vendor_id']);
            }
            Func_Header::to(' 创建新的供应商成功，账户更新供应商信息成功！','?');
        }else{
            Func_Header::back('账户更新供应商信息失败！');
        }

    }
    /*
     *绑定到原有供应商
     */
    static function bindOldVendor(){
        if(empty($_REQUEST['vendor_id']) || empty($_REQUEST['change_id']) || empty($_REQUEST['account_id'])){
            Func_Header::back('参数错误！！');
        }
        //更改选择的供应商的绑定账户
        //获取供应商update表中数据
        $rs_update=Data_Mysql_Table_Vendor_Info::subTable('_update')->select('id,vendor_name',array('id'=>$_REQUEST['vendor_id']));
        if(!empty($rs_update[0])){
            $rs=Data_Mysql_Table_Vendor_Info::subTable('_update')->update(array('id'=>$_REQUEST['vendor_id']),array('vendor_account_id'=>$_REQUEST['account_id']));
        }
        //获取供应商表中数据
        $rs_info=Data_Mysql_Table_Vendor_Info::select('id,vendor_name',array('id'=>$_REQUEST['vendor_id']));
        if(!empty($rs_info[0])){
            $rs=Data_Mysql_Table_Vendor_Info::update(array('id'=>$_REQUEST['vendor_id']),array('vendor_account_id'=>$_REQUEST['account_id']));
        }
        //更改原供应商的绑定账户为0
        if(!empty($_REQUEST['old_vendor_id'])){
            $old_rs_update=Data_Mysql_Table_Vendor_Info::subTable('_update')->update(array('id'=>$_REQUEST['old_vendor_id']),array('vendor_account_id'=>0));
            $old_rs=Data_Mysql_Table_Vendor_Info::update(array('id'=>$_REQUEST['old_vendor_id']),array('vendor_account_id'=>0));
        }

        //更新账户变更供应商表
        $rs_change=Data_Mysql_Table_Vendor_Account::update(array('id'=>$_REQUEST['change_id']),array('status'=>1));
        if(!empty($rs_change[0])){
            //创建账户的操作日志
            Data_Mysql_Table_Account_Log::insertAccountLog($_REQUEST['account_id'], $_SESSION['administrator']['id'], '账户变更供应商', '账户变更绑定的供应商',$_REQUEST['vendor_id']);
            if(!empty($_REQUEST['old_vendor_id'])){
                Data_Mysql_Table_Account_Log::insertAccountLog($_REQUEST['account_id'], $_SESSION['administrator']['id'], '供应商变更绑定账户', '供应商变更绑定账户',$_REQUEST['old_vendor_id']);
            }
            Func_Header::to(' 账户更新供应商信息成功！','?');
        }else{
            Func_Header::back('账户更新供应商信息失败！');
        }
    }
}