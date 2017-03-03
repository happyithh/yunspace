<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/8/24
 * Time: 13:18
 * 注册一个账户
 */
class Api_Vendor_Join_CheckAccount extends Api
{

    static function  CheckAccountByPhone($args)
    {
        $request = Func_Input::filter(array(
            'phone' => 'phone',
            'auth_code' => 'int',
            'username' => 'string',
        ), $args);
        $check_code = Api_Common_Check_Auth_Code::checkAuthCode($request);
        if ($check_code['status'] == 1) {
            //注册账户，发送短息
            $password = rand(1111, 9999) . rand(9999, 1111);
            $account = Api_Account_Register::quickRegister(array('phone' => $request['phone'],
                'password' => $password,
                'username' => $request['username']
            ));
//             Data_Mysql_Table_Vendor_Info::subTable('_update')->select('id as vendor_id,vendor_name', array('vendor_account_id' => $account['data']['id']));

            //发送密码到 这个手机号
            if ($account['status'] == 1) {
                Func_Message::sendSMS($request['phone'], array($request['phone'], $password), 23705);
            }
            return Api::request('success', $account['data'], '成功');
        }
        return $check_code;
    }

}