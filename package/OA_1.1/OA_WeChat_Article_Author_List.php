<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/1/20
 * Time: 17:52
 *
 * 微信公众号列表
 */
class OA_WeChat_Article_Author_List {
    static function handle(){
        $action = empty($_REQUEST['action'])?'list':$_REQUEST['action'];
        switch($action){
            case 'list':
                self::getAuthorList();
                break;
            case 'updateStatus':
                self::updateStatus();
                break;
            default:
                self::getAuthorList();
        }
    }
    static function getAuthorList(){
        $_REQUEST['type']=empty($_REQUEST['type'])?"all":$_REQUEST['type'];
        $data =  Api_Wechat_Article_Author_List::authorList($_REQUEST);
        Tpl_Smarty::assign('data',$data);
        Tpl_Smarty::assign('type',$_REQUEST['type']);
        Tpl_Smarty::display('OA_Static::public_number/wechat_article/wechat_author_list.tpl');
    }
    static function updateStatus(){
        Core::output('');
        $data = Api_Wechat_Author_Update_Status::updateStatus($_REQUEST);
        if($data['status']==1){
            Func_Output::json('success','','  '.$data['msg']);
        }else{
            Func_Output::json('error','',$data['msg']);
        }

    }
}