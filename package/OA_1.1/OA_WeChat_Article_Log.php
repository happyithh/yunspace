<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/1/28
 * Time: 13:26
 * 文章采集日志列表
 */
class OA_WeChat_Article_Log {
    static function handle(){
        $action = !empty($_REQUEST['action'])?$_REQUEST['action']:'list';
        switch($action){
            case 'list':
                $data = Api_Wechat_Article_Log::getArticleLog($_REQUEST);
                break;
        }
        Tpl_Smarty::assign('_data',$data);
        Tpl_Smarty::display('OA_Static::public_number/wechat_article/article_log_list.tpl');
    }

}