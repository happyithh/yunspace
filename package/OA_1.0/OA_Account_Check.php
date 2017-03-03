<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 15-6-10
 * Time: 下午8:56
 */
class OA_Account_Check{
    static function handle(){
        $action=empty($_REQUEST['action'])?"list":$_REQUEST['action'];
        switch($action){
            case "detail":
                self::getUpdateAccountDetail();
                break;
            case "pass":
                self::accountPassCheck();
                break;
            case "refuse":
                self::refuseAccountCheck();
                break;
            default:
                self::getWaitingCheckAccount();
                break;
        }
    }
    /*
     *获取所有待审核的账户信息
     */
    static function getWaitingCheckAccount(){
        $data=$conditions=array();
        $handle_type = empty($_REQUEST['handle_type']) ? 'waiting' : $_REQUEST['handle_type'];
        $page_name = '待审核';
        switch ($handle_type) {
            case "reject":
                $conditions['status'] = 3;
                $page_name = '已拒绝';
                break;
            case "waiting":
                $conditions['status'] = 2;
                $page_name = '待审核';
                break;
        }
        if (!empty($_REQUEST['search'])) {
            $search=Func_Input::filter(array(
                'title'=>'string',
                'phone'=>'string',
                'email'=>'string',
                'start_time'=>'string',
                'end_time'=>'string',
            ),$_REQUEST['search']);
            //id或名称筛选
            if(!empty($search['title'])){
                if (is_numeric($search['title'])) {
                    $conditions['id'] = $search['title'];
                } else {
                    $conditions['username'] = $search['title'];
                }
            }
            //手机号筛选
            if(!empty($search['phone'])){
                $conditions['phone'] = $search['phone'];
            }
            //邮箱筛选
            if(!empty($search['email'])){
                $conditions['email'] = $search['email'];
            }
            //更新时间筛选
            if (!empty($search['start_time']) && !empty($search['end_time'])) {
                if (strtotime($search['start_time']) > strtotime($search['end_time'])) {
                    Func_Header::back('请正确选择时间范围！！');
                } else {
                    $conditions['{table}.register_time between ? and ?'] = array(strtotime($search['start_time']), strtotime($search['end_time']));
                }
            } elseif (!empty($search['start_time']) && empty($search['end_time'])) {
                $conditions['{table}.register_time > ?'] = strtotime($search['start_time']);
            } elseif (empty($search['start_time']) && !empty($search['end_time'])) {
                $conditions['{table}.register_time < ?'] = strtotime($search['end_time']);
            }

        }
        $data=Data_Mysql_Table_Account::subTable('_update')->page(0,20,'id,username,email,phone,register_time,status,attr',$conditions,'ORDER BY register_time DESC');
        if(!empty($data['rows'])){
            foreach($data['rows'] as $k=>$v){
                $data['rows'][$k]['attr']=json_decode($v['attr'],1);
            }
        }
        Tpl_Smarty::assign('handle_type',$handle_type);
        Tpl_Smarty::assign('page_name',$page_name);
        Tpl_Smarty::assign('data',$data);
        Tpl_Smarty::display('OA','check/account_check_list.tpl');
    }
    /*
     *获取待审核的账户的信息
     */
    static function getUpdateAccountDetail(){
        if(empty($_REQUEST['id'])){
            Func_Header::back('参数错误！');
        }
        $check_account=Data_Mysql_Table_Account::subTable('_update')->select('id,username,phone,email,password,password2',$_REQUEST['id']);
        if(empty($check_account[0])){
            Func_Header::back('账户更新的数据不存在！');
        }
        $old_account=Data_Mysql_Table_Account::select('id,username,phone,email,password',$_REQUEST['id']);
        if(empty($old_account[0])){
            Func_Header::back('此账户不存在！');
        }
        $reason = array(
            '证件不全','资历不够','其他原因'
        );
        Tpl_Smarty::assign('rejectreason', $reason);
        Tpl_Smarty::assign('old_data',$old_account[0]);
        Tpl_Smarty::assign('new_data',$check_account[0]);
        Tpl_Smarty::display('OA','check/account_check_detail.tpl');
    }
    /*
     *账户更改信息通过审核
     */
    static function accountPassCheck(){
        if(empty($_REQUEST['id'])){
            Func_Header::back('参数错误！');
        }
        $check_account=Data_Mysql_Table_Account::subTable('_update')->select('id,username,phone,email,password,password2',$_REQUEST['id']);
        if(empty($check_account[0])){
            Func_Header::back('账户更新的数据不存在！');
        }
        $old_account=Data_Mysql_Table_Account::select('id,username,phone,email,password',$_REQUEST['id']);
        if(empty($old_account[0])){
            Func_Header::back('此账户不存在！');
        }
        $update_data=array();
        if($check_account[0]['username'] != $old_account[0]['username']){
            $update_data['username']=$check_account[0]['username'];
        }
        if($check_account[0]['phone'] != $old_account[0]['phone']){
            $update_data['phone']=$check_account[0]['phone'];
        }
        if($check_account[0]['email'] != $old_account[0]['email']){
            $update_data['email']=$check_account[0]['email'];
        }
        if(!empty($check_account[0]['password'] )){
            $update_data['password']=$check_account[0]['password'];
        }
        if(!empty($check_account[0]['password2'] )){
            $update_data['password2']=$check_account[0]['password2'];
        }
        //创建账户更改的历史记录
        $history_data=array('object_id'=>$old_account[0]['id'],'admin_id'=>$_SESSION['administrator']['id'],'operate_type'=>1,'data_backup'=>$old_account[0]);
        Data_Mysql_Table_History::subTable('_account_'.date('Ym'))->insert($history_data);
        //更新账户信息
        $rs=Data_Mysql_Table_Account::update($old_account[0]['id'],$update_data);
        if(!empty($rs[0])){
            //创建账户的操作日志
            Data_Mysql_Table_Account_Log::insertAccountLog($old_account[0]['id'], $_SESSION['administrator']['id'], '重置账户信息--通过审核', '更新');
            //删除更新的信息
            Data_Mysql_Table_Account::subTable('_update')->delete($old_account[0]['id']);
            Func_Header::to(' 账户信息更新成功！','?');
        }else{
            Func_Header::back('账户信息更新失败！');
        }

    }
    /*
    *账户更改信息未通过审核
    */
    static function refuseAccountCheck(){
        $request=Func_Input::filter(array(
            'id'=>'int',
            'refuse_reason'=>'string',
        ));
        if(empty($request['id'])){
            Func_Header::back('参数错误！');
        }
        if(empty($request['refuse_reason'])){
            Func_Header::back('请输入拒绝原因！');
        }
        $data['attr']=array('refuse_reason'=>$request['refuse_reason']);
        $data['status']=3;
        $rs=Data_Mysql_Table_Account::subTable('_update')->update($request['id'],$data);
        if(!empty($rs[0])){
            //发送邮件给供应商账户
            //self::refuseMailtoAccount($request['id'],$request['refuse_reason']);
            //创建账户的操作日志
            Data_Mysql_Table_Account_Log::insertAccountLog($request['id'], $_SESSION['administrator']['id'], '重置账户信息--审核未通过', '更新');
            Func_Header::to(' 账户更新信息已拒绝！','?handle_type=reject');
        }else{
            Func_Header::back('操作失败！');
        }

    }


    //审核拒绝发送邮件通知给负责人
    static function refuseMailtoAdmin($admin_name,$reason,$vendor_name,$sort,$info_id,$info_name)
    {
            $r = Data_Mysql_Table_Administrator::select('email',array('fullname' => $admin_name));
            $email = $r[0]['email'];
            $title = "【云space】审核不通过通知";
            $msg = "<dl>";
            $msg .= "<dt>很抱歉的告诉您:{$admin_name}<br>\n</dt><dd>";
            $msg .= "</dd><dt>您负责的供应商{$vendor_name}下属的{$sort}信息:暂未通过审核，详情如下:</dt><dd>";
            $msg .= "ID：{$info_id}<br>\n";
            $msg .= "{$sort}名称：{$info_name}<br>\n";
            $msg .= "拒绝原因：{$reason}<br>\n";
            $msg .= '</dd>';
            if (!empty($email)) {
             Func_Mail::send($email,$title,$msg);
            }
    }

    //审核拒绝发送邮件通知给供应商账户
    static function refuseMailtoAccount($id,$reason,$vendor_name,$sort,$info_id,$info_name,$href)
    {
        $r = Data_Mysql_Table_Account::select('username,email',array('id' => $id));
        $email = $r[0]['email'];
        $account_name = $r[0]['username'];

        $title = "【云space】审核不通过通知";
        $msg = "<dl>";
        $msg .= "<dt>很抱歉的告诉您:{$account_name}<br>\n</dt><dd>";
        $msg .= "</dd><dt>您的供应商{$vendor_name}下属的{$sort}信息:暂未通过审核，详情如下:</dt><dd>";
        $msg .= "ID：{$info_id}<br>\n";
        $msg .= "{$sort}名称：{$info_name}<br>\n";
        $msg .= "拒绝原因：{$reason}<br>\n";
        $msg .= "详细信息：{$href}<br>\n";
        $msg .= '</dd>';

        if ($email) {
            Func_Mail::send($email,$title,$msg);
        }
    }
}