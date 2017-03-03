<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 15-11-24
 * Time: 下午5:11
 */
class Account_Administrator
{
    static function handle()
    {
        if (!empty($_REQUEST['action']) && $_REQUEST['action']=="submit_admin") {
            self::submitAdminInfo();
        }
        Tpl_Smarty::assign("username", $_SESSION['administrator']['username']);
        Tpl_Smarty::assign("phone", $_SESSION['administrator']['phone']);
        Tpl_Smarty::assign("email", $_SESSION['administrator']['email']);
        Tpl_Smarty::display("OA_Static",'admin/personal.tpl');
    }

    static function submitAdminInfo(){
        $request=Func_Input::filter(array(
            'old_password'=>'string',
            'password'=>'string',
            'repassword'=>'string',
            'phone'=>'phone',
            'email'=>'email',
        ),$_REQUEST["admin"]);
        if(!empty($_REQUEST["admin"]['phone']) &&  empty($request['phone'])){
            Func_Header::back('请输入正确的手机号！');
        }
        if(!empty($_REQUEST["admin"]['email']) && empty($request['email'])){
            Func_Header::back('请输入正确的邮箱！');
        }
        //验证密码
        if(!empty($request['password']) || !empty($request['repassword'])){
            if(empty($request['old_password'])){
                Func_Header::back("请输入旧密码！！");
            }
            if($request['password'] !== $request['repassword']){
                Func_Header::back("两次输入的密码不一致！！");
            }
            $admin = Data_Mysql_Table_Administrator::select('password', $_SESSION['administrator']['id']);
            if ($admin[0]['password'] != Data_Mysql_Table_Administrator::makePassword($request['old_password'])) {
                 Func_Header::back('旧密码错误！！');
            }
        }
        $admin_data['phone']=$request['phone'];
        $admin_data['email']=$request['email'];
        if(!empty($request['password'])){
            $admin_data['password']=Data_Mysql_Table_Administrator::makePassword($request['password']);
        }
        $rs=Data_Mysql_Table_Administrator::update(array('id'=>$_SESSION['administrator']['id']),$admin_data);
        if(!empty($rs[0])){
            $_SESSION['administrator']['phone']=$admin_data['phone'];
            $_SESSION['administrator']['email']=$admin_data['email'];
            if(!empty($request['password'])){
                $_SESSION['administrator']['password']=$admin_data['password'];
            }
            Func_Header::to(" 个人信息修改成功!!", "?");
        }else{
            Func_Header::back("个人信息修改失败！！");
        }
    }
}