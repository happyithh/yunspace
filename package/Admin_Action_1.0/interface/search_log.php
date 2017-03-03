<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/5/7
 * Time: 19:39
 */
switch (Core::$urls['action']){
    case 'search':
       Action_search::search();
        break;
    default:
        Func_Header::notFound();
        break;
}
class Action_Search {
    static function search(){
        $group=' GROUP BY search_title';
        if(!empty($_REQUEST['search']['title'])){
            $conditions['search_title']=$_REQUEST['search']['title'];
            $log= Data_Mysql_Table_Search_Log::page(0,15,'*',$conditions,$group);
        }else{
            $log= Data_Mysql_Table_Search_Log::page(0,15,'*','',$group);
        }
        Tpl_Smarty::assign('_data',$log);
        Tpl_Smarty::display('OA','search_list.tpl');
    }
}
