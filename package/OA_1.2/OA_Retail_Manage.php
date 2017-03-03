<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2016/5/26
 * Time: 10:33
 * 表单单独管理，可以分别传值不同的表单id
 * 零售是16
 * 城市合伙人是14
 */
class OA_Retail_Manage{
    static function handle($form_id=16){
        $action = empty($_REQUEST['action']) ? 'detail' : $_REQUEST['action'];
        switch ($action) {
            case 'detail':
                $_REQUEST['id']=$form_id;
                OA_Form_Management::formTypeUser();
                break;
            case 'check':
                OA_Form_Management::formUserCheck();
                break;
            default:
                $_REQUEST['id']=$form_id;
                OA_Form_Management::formTypeUser();
                break;
        }
    }
}