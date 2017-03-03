<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/4/8
 * @账号管理
 */


$_REQUEST['action'] = empty($_REQUEST['action']) ? 'reset_password' : $_REQUEST['action'];
switch ($_REQUEST['action']) {
    case 'reset_password_submit':
        OA_Account_Manage::resetPasswordSendEmail();
        break;

}

Class OA_Account_Manage
{


    //重置密码列表页
    static function resetPassword()
    {
        $cols = 'id,phone,username,fullname,email,account_type,register_time,login_times,status';
        $conditicons[] = 1;
        if (!empty($_REQUEST['search']['fullname'])) {
            $conditicons[] = "fullname ='" . $_REQUEST['search']['fullname'] . "'";
        }
        $rs = Data_Mysql_Table_Account::page(0, 15, $cols, $conditicons);
        Tpl_Smarty::assign('tpl_account_type', Data_Mysql_Table_Account::$tpl_account_type);
        Tpl_Smarty::assign('_data', $rs);
        Tpl_Smarty::display('OA', 'account_manage_reset.tpl');
    }

    //发送重置密码到邮箱
    static function  resetPasswordSendEmail()
    {
        $request = Func_Input::filter(array(
            'email' => 'string',
            'id' => 'int'
        ), $_REQUEST);
        if (empty($request['id']) || empty($request['email'])) {
            Func_Header::back('重置失败');
        }
        //'455976391@qq.com';
        $pwd = rand(1000, 9999) . date('s') . rand(10, 99);
        $md5Paw = Data_Mysql_Table_Account::makePassword($pwd);
        $status = Data_Mysql_Table_Account::update(array('id =?' => $_REQUEST['id']), array('password' => $md5Paw));
        if ($status) {
            Web_Message::resetPasswordEmail($request['email'], $pwd);
            //创建该账户的操作日志
            Data_Mysql_Table_Account_Log::insertAccountLog($_REQUEST['id'], $_SESSION['administrator']['id'], '重置密码', '更新');
            Func_Header::to('  新密码已经发送！', '?');
        } else {
            Func_Header::to('重置失败！', '?');
        }
    }

}