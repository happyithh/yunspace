<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/5/3
 * Time: 15:37
 * 合作品牌管理
 */
class OA_Cooperation_Brand_Management {
    static function handle($type=1){
        $action = empty($_REQUEST['action'])?'list':$_REQUEST['action'];
        switch($action)
        {
            case 'list':
                self::brandList($type);
                break;
            case 'add':
                self::brandAdd($type);
                break;
            case 'edit':
                self::brandAdd($type);
                break;
            case 'submit':
                self::brandSubmit();
                break;
            case 'delete':
                self::brandDelete();
                break;
            case 'form_delete':
                self::formDelete();
                break;
            case 'brand_form':
                self::brandForm();
                break;
            case 'update':
                self::brandDelete(1);
                break;
            default:
                self::brandList();

        }
    }
    static function brandList($type=1){

        $data = Api_Cooperation_Brand_List::brandList($type);
        $tab = empty($_REQUEST['tab'])?'brand':$_REQUEST['tab'];
        Tpl_Smarty::assign('data',$data);
        Tpl_Smarty::assign('tab',$tab);
        if($type==2){
            Tpl_Smarty::display('OA_Static::brand/adm_list.tpl');
        }else{
            Tpl_Smarty::display('OA_Static::brand/list.tpl');
        }

    }
    static function brandAdd($type=1){
        if(!empty($_REQUEST['id'])){
            $data = Api_Cooperation_Brand_Detail::getBrandDetail($type);
            Tpl_Smarty::assign('data',$data[0]);
        }
        if($type==2){
            Tpl_Smarty::display('OA_Static::brand/adm_add.tpl');
        }else{
            Tpl_Smarty::display('OA_Static::brand/add.tpl');
        }

    }
    static function brandSubmit(){
        $res = Api_Cooperation_Brand_Submit::brandSubmit($_REQUEST);
        if(!empty($res[0])){
            Func_Header::to('  操作成功！','?action=list');
        }else{
            Func_Header::back('操作失败');
        }

    }
    static function brandDelete($type=0){
        $request = Func_Input::filter(array(
            'id'=>'int',
        ),$_REQUEST);
        if(empty($request['id'])){
           Func_Header::back('操作异常！');
        }
        if($type==1){
            $data['status'] = 1;
        }else{
            $data['status'] = -1;
        }
        $res = Data_Mysql_Table_Cooperation_Brand::update(array('id'=>$request['id']),$data);
        if(!empty($res[0])){
            Func_Header::to('  删除成功！',"?action=list");
        }else{
            Func_Header::back('操作失败！');
        }
    }
    static function formDelete(){
        $request = Func_Input::filter(array(
            'id'=>'int',
        ),$_REQUEST);
        if(empty($request['id'])){
            Func_Header::back('操作异常！');
        }
        $res = Data_Mysql_Table_Brand_Form::update(array('id'=>$request['id']),array('status'=>-1));
        if(!empty($res[0])){
            Func_Header::to('  删除成功！',"?action=brand_form");
        }else{
            Func_Header::back('操作失败！');
        }
    }
    static function brandForm(){
        $data = Api_Cooperation_Brand_Form_List::formList($_REQUEST);
        Tpl_Smarty::assign('data',$data);
        Tpl_Smarty::display('OA_Static::brand/list.tpl');
    }
}
