<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/5/12
 * Time: 11:02
 * 更换负责人
 */
@session_start();

class Api_Winchance_New_Ip_Change_Admin extends Api
{
    static function handle()
    {
        if (empty($_SESSION['administrator']['id'])) {
            return false;
        } else {
            return self::changeAdmin();
        }

    }

    static function changeAdmin()
    {
        $request = Func_Input::filter(array(
            'id' => 'int',
            'admin' => 'int',
            'type' => 'string',
            'check_id' => 'int'
        ), $_REQUEST);
        if (empty($request['id']) && $request['type'] == 'winchance') {
            return self::request('error', '', '操作异常！');
        }
        if (empty($request['check_id']) && $request['type'] == 'check') {
            return self::request('error', '', '操作异常！');
        }
        if (empty($request['admin'])) {
            return self::request('error', '', '操作异常！');
        }
        if (!empty($request['id'])) {
            Data_Mysql_Table_Winchance_New::update(array('id' => $request['id']), array('admin_id' => $request['admin']));
            $res = Data_Mysql_Table_Winchance_Check::update(array('ip_id' => $request['id']), array('admin_id' => $request['admin']));
        }else{
            $res = Data_Mysql_Table_Winchance_Check::update(array('id' => $request['check_id']), array('admin_id' => $request['admin']));
        }
        if (!empty($res[0])) {
            return self::request('success', '', '操作成功！');
        } else {
            return self::request('error', '', '操作失败！');
        }

    }
}