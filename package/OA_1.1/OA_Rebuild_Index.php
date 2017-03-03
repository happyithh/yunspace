<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 15-12-24
 * Time: 下午5:56
 */
class OA_Rebuild_Index{
    static function handle(){
        if(!empty($_REQUEST['table_name'])){
            call_user_func("Data_Mysql_Table_".$_REQUEST['table_name']."::rebuildIndex");
        }
        Tpl_Smarty::display('OA_Static',"cron/rebuild_index.tpl");
    }
}