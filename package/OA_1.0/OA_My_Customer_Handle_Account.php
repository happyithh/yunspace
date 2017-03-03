<?php
/**
 * Created by PhpStorm.
 * User: yl
 * Date: 15-6-29
 * Time: 上午10:23
 * 账户变更，供应商更改账户
 */
class OA_My_Customer_Handle_Account{

    //账户修改
    static function handleUpdateVendorAccount()
    {
        $request = Func_Input::filter(array(
            'username' => 'string',
            'email' => 'email',
            'phone' => 'phone',
            'password' => 'string',
            'passwordr' => 'string',
            'password2' => 'string',
            'password2r' => 'string',
            'id' => 'int',
            'vendor_id'=>'int'
        ));
        if (empty($request['id'])) {
            Func_Header::back('缺少参数！');
        }
        if (empty($_SESSION['administrator']['id'])) {
            Func_Header::back('请先登录！');
        }
        if (empty($request['username'])) {
            Func_Header::back('用户名不能为空！');
        }
        if (strpos($request['username'], '@')) {
            Func_Header::back('用户名不能包含@字符！');
        }
        if (strpos($request['username'], ' ')) {
            Func_Header::back('用户名不能包含空格！');
        }
        if (strlen($request['username']) > 50) {
            Func_Header::back('用户名不能太长！');
        }
        if (strlen($request['username']) < 3) {
            Func_Header::back('用户名不能太短！');
        }
        if ($_REQUEST['username'] != $request['username']) {
            Func_Header::back('用户名不能包含html特殊字符！');
        }
        //验证是否已存在相同的名字
        $name_same = Data_Mysql_Table_Account::select('username,id', array('username = ? and id != ?' => array($request['username'], $request['id'])));
        if (!empty($name_same[0])) {
            Func_Header::back('已存在相同名称的账户，请更换账户名！');
        }
        if (!empty($_REQUEST['email']) && !$request['email']) {
            Func_Header::back('请输入正确的邮箱！');
        }
        if (empty($request['phone'])) {
            preg_match_all('/^(0(10|21|22|23|[1-9][0-9]{2})(-|))?[0-9]{7,8}$/', $_REQUEST['phone'], $tel);
            if (!empty($tel[0][0])) {
                $request['phone'] = $tel[0][0];
            } else {
                Func_Header::back('请正确输入手机号/固定电话！');
            }
        }
        //验证是否已存在相同的手机号
        $phone_same = Data_Mysql_Table_Account::select('phone,id', array('phone = ? and id != ?' => array($request['phone'], $request['id'])));
        if (!empty($phone_same[0])) {
            Func_Header::back('已存在相同的手机号/固定电话，请更换手机号/固定电话！');
        }

        if (!empty($request['password'])) {
            if (empty($request['passwordr']) || $request['password'] !== $request['passwordr']) {
                Func_Header::back('两次输入密码不一致！');
            }
            if (strlen($request['password']) < 8) {
                Func_Header::back('密码长度不能小于8位！');
            }

        }

        if (!empty($request['password2'])) {
            if (empty($request['password2r']) || $request['password2'] !== $request['password2r']) {
                Func_Header::back('两次输入的交易密码不一致！');
            }
        }

        $update_data['username'] = $request['username'];
        $update_data['email'] = $request['email'];
        $update_data['phone'] = $request['phone'];
        $update_data['register_time'] = time();
        $update_data['status'] = 2;
        $update_data['attr'] = array();

        if (!empty($request['password'])) {
            $update_data['password'] = Data_Mysql_Table_Account::makePassword($request['password']);
        }
        if (!empty($request['password2'])) {
            $update_data['password2'] = Data_Mysql_Table_Account::makePassword($request['password2']);
        }

        $update_data['id'] = $request['id'];
        $rs = Data_Mysql_Table_Account::subTable('_update')->update($update_data);
        if ($rs[0] > 0) {
            //创建该账户的操作日志
            Data_Mysql_Table_Account_Log::insertAccountLog($request['id'], $_SESSION['administrator']['id'], '重置账户信息--提交审核', '更新');
            Func_Header::to(' 重置信息已提交审核！',Core::$urls['path'].'?action='.$_REQUEST['action'].'&tab=info&vendor_id='.$request['vendor_id']);
        }
        Func_Header::back('重置信息失败！');

    }

    static function handleChangeAccount(){
        $request=Func_Input::filter(array(
            'id'=>'int',
            'new_account_id'=>'int',
            'action'=>'string',
            'vendor_id'=>'int',
            'username'=>'string',
        ));
        if(empty($request['new_account_id']) || empty($request['id']) || empty($request['vendor_id'])){
            Func_Header::back('参数错误！');
        }
        if($request['new_account_id']==$request['id']){
            Func_Header::back('未做任何更改！！');
        }
        //判断所选择的账户是否已绑定其他供应商
        $account=Data_Mysql_Table_Vendor_Info::select('id,vendor_name,vendor_account_id',array('vendor_account_id = ? AND id != ?'=>array($request['new_account_id'],$request['vendor_id'])));
        if(!empty($account[0])){
            Func_Header::back('该账户已绑定供应商【'.$account[0]['vendor_name'].'】');
        }
        $data=array(
            'vendor_id' => $request['vendor_id'],
            'old_account_id' => $request['id'],
            'old_account_name' => $request['username'],
            'new_account_id' => $request['new_account_id'],
            'status' =>0,
            'admin_id' => $_SESSION['administrator']['id'],
            'create_time'=>time(),
        );
        $rs=Data_Mysql_Table_Vendor_Change_Account::update($data);
        if(!empty($rs[0])){
            Func_Header::to(' 更新绑定账户信息已提交审核！',Core::$urls['path'].'?action='.$_REQUEST['action'].'&tab=info&vendor_id='.$request['vendor_id']);
        }else{
            Func_Header::back('更新绑定账户提交失败，请重试！');
        }
    }

    //供应商和联系人解除绑定
    static function handleUnbindAccount(){
        $request=Func_Input::filter(array(
            'action'=>'string',
            'vendor_id'=>'int',
        ));
        if(empty($request['vendor_id'])){
            Func_Header::back('参数错误！');
        }

        $rs=Data_Mysql_Table_Vendor_Info::update(array("id"=>$request['vendor_id']),array('vendor_account_id'=>0));
        $rs_update=Data_Mysql_Table_Vendor_Info::subTable("_update")->update(array("id"=>$request['vendor_id']),array('vendor_account_id'=>0));
        if(!empty($rs[0]) || !empty($rs_update[0])){
            Func_Header::to(' 解除绑定成功！',Core::$urls['path'].'?action='.$_REQUEST['action'].'&tab=info&vendor_id='.$request['vendor_id']);
        }else{
            Func_Header::back('解除绑定失败，请重试！');
        }
    }

}