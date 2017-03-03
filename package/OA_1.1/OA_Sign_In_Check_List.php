<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/1/25
 * Time: 15:04
 * 外出签到审核列表
 */
class OA_Sign_In_Check_List {
    static function handle(){
        $action = !empty($_REQUEST['action'])?$_REQUEST['action']:'list';
        switch($action){
            case 'list':
                self::signInCheckList();
                break;
            default:
                self::signInCheckList();
        }
    }
    static function signInCheckList(){
        $data = Api_Sign_In_Check_List::checkList($_REQUEST);
        Tpl_Smarty::assign('_data', $data);
        Tpl_Smarty::display('OA_Static::sign_in/sign_in_check_list.tpl');
    }
}