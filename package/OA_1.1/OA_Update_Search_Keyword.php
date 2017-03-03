<?php
/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2016/1/4
 * Time: 11:54
 */
class OA_Update_Search_Keyword {
    static function handle(){
        $action = empty($_REQUEST['action']) ? '' : $_REQUEST['action'];
        switch($action){
            case 'update_keyword':
                self::updateKeyword();
                break;
            case 'update_frequency':
                self::updateFrequency();
                break;
            default:
                Tpl_Smarty::display('OA_Static',"cron/update_search_keyword.tpl");
        }
    }

    static function updateKeyword(){
        Data_Mysql_Table_Search_Keyword_Lib::select(1);
//        Data_Mysql_Table_Search_Keyword_Lib::debug(1);
        Data_Mysql_Table_Search_Keyword_Lib::query("INSERT INTO {table} (id,s_key) SELECT id,space_name FROM {prefix}spacepedia",'');
        Func_Header::back("  更新成功  ");
    }
    static function updateFrequency(){
        //搜索日志记录更新
        Tpl_Smarty::display('OA_Static',"cron/update_search_keyword.tpl");
    }
}