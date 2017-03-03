<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2016/5/19
 * Time: 9:40
 */
switch (Core::$urls['action']) {
    case "theme_list":
        $action=empty($_REQUEST['action'])?'list':$_REQUEST['action'];
        switch($action){
            case "list":
                $rs=OA_Theme_List::getInstance();
                OA_Theme_List::display("OA_Static::theme/theme_list.tpl");
                break;
            case 'detail':
                OA_Theme_Detail::display("OA_Static::theme/theme_edit.tpl");
                break;
            case 'create':
                OA_Theme_List::display("OA_Static::theme/theme_edit.tpl");
                break;
            case 'edit_submit':
                $rs=Api_Theme_Submit::themeInfoSubmit();
                if(empty($rs['status'])){
                    Func_Header::back($rs['msg']);
                }else{
                    Func_Header::to(" ".$rs['msg'],'?action=list');
                }
                break;
            default:
                Func_Header::notFound();
                break;
        }
        break;
    default:
        Func_Header::notFound();
        break;
}