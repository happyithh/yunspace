<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2015/6/24
 * Time: 11:39
 */

$request = Func_Input::filter(array(
    'form_type' => 'int', // 判断提交方式
    'auth_code' => 'int',
    'phone' => 'phone',
    'id' => 'int',
), $_REQUEST);
if (!empty($request['auth_code'])) {

    $status = Api_Common_Check_Auth_Code::checkAuthCode();
    if ($status['status'] == 0) {
        Func_Output::json('error','',$status['msg']);
    }
}

if (!empty($request['form_type']) && $request['form_type'] == 1) {

    OA_Form_Management::submitUserAjaxForm();
} else {
    OA_Form_Management::submitUserForm();
}

if (Core::$urls['action'] == 'test_form') {
    Tpl_Smarty::display('Web::test/form-test.tpl');
}

