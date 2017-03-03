<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/1/25
 * Time: 14:16
 * 外出签到列表
 */
class OA_Sign_In_Management
{
    static function handle()
    {
        $action = !empty($_REQUEST['action']) ? $_REQUEST['action'] : 'list';
        switch ($action) {
            case 'list':
                self::signInList();
                break;
            default:
                self::signInList();
        }
    }
    static function signInList()
    {
        $status = empty($_REQUEST['status']) ? 'all' : $_REQUEST['status'];
        $_REQUEST['search']['status'] = $status;
        $data = Api_Sign_In_Manage_List::signInList($_REQUEST);
        Tpl_Smarty::assign('status', $status);
        Tpl_Smarty::assign('_data', $data);
        Tpl_Smarty::display('OA_Static::sign_in/sign_in_list.tpl');
    }
}