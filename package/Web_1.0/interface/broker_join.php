<?php
/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/4/7
 * @ 经纪人
 */
session_start();
if (!empty($_REQUEST['submit'])) {

    Web_Account::handleIsLogin();

    $request = Func_Input::filter(array(
        'username' => 'string',
        'phone' => 'phone',
        'city' => 'string',
        'company' => 'string',
    ), $_REQUEST['data']);
    if (empty($request['phone']) || empty($request['username'])) {
        Func_Header::back('姓名和手机号不能为空！');
    }
    $data =$request;
    $data['account_id'] = $_SESSION['user']['id'];
    $data['broker_info'] = array(
        '姓名' => $request['username'],
        '联系方式' => $request['phone'],
        '公司名称' => $request['company'],
        '城市' => $request['city'],
    );
    $r = Data_Mysql_Table_Account_Broker::insert($data);
    if ($r > 0) {
        Func_Header::to('提交成功，等待审核。。');
    } else {
        Func_Header::to('提交失败。。');
    }
} else {
    if(!empty($_SESSION['user'])) {

        Tpl_Smarty::assign('__user', $_SESSION['user']);
    }
    Tpl_Smarty::display('Web', 'broker_join.tpl');

}