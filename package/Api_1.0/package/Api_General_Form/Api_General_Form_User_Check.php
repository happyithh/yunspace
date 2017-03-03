<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2015/9/23
 * Time: 17:28
 *
 * 通用表单 用户审核
 */
class Api_General_Form_User_Check extends Api
{
    static function handle(){
        return self::userCheckList($_REQUEST);
    }
    static function userCheckList($args)
    {
        $request = Func_Input::filter(array(
            'id' => 'int',
            "status" => 'int',
        ), $args);

        if (!empty($request['id'])) {
            $data['status'] = $request['status'];
            $data['check_time'] = time();
            $res = Data_Mysql_Table_Form_Data::update(array('id' => $request['id']), $data);
            if ($res[0] > 0) {
                @session_start();
                //创建操作日志
                $account_id = Api_Administrator_GetBaseAccountInfo::getBastAccountInfo(array('admin_id'=>$_SESSION['administrator']['id']));

                Data_Mysql_Table_Account_Log::insertAccountLog($account_id['account_id'],$_SESSION['administrator']['id'],'用户表单信息审核','表单管理',$request['id']);
                return self::request('success','','操作成功！');

            } else {
                return self::request('error','','操作失败，请重试！');
                Func_Header::back('操作失败！');
            }

        }
    }
}