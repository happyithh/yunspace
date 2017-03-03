<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2015/12/1
 * Time: 14:12
 */
class OA_Denand_Tag
{
    static function handle()
    {
        $action = empty($_REQUEST['action']) ? 'list' : $_REQUEST['action'];
        switch ($action) {
            case 'list':
                self::tagList();
                break;
            case 'del':
                self::tagDelete();
                break;
            default:
                self::tagList();
        }

    }

    static function tagList()
    {
        $data = Api_Demand_Offer_Tag_List::getTagList($_REQUEST);
        if($data['status']==0){
            Func_Header::back($data['msg']);
        }else{
            Tpl_Smarty::assign('_data',$data['data']);
        }

      Tpl_Smarty::display('OA_Static::spacepedia/tag_list.tpl');
    }
    static function tagDelete(){
        $request=Func_Input::filter(array(
            'id'=>'int'
        ),$_REQUEST);
        $del = Data_Mysql_Table_Demand_Tag::delete(array('id'=>$request['id']));
//        q($del);
        if(!empty($del[0])){
            Func_Header::to('');
        }else{
            Func_Header::to('  删除失败！');
        }
    }
}