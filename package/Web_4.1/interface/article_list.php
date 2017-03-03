<?php
/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2016/5/31
 * Time: 17:47
 */
$token = md5(Core::$urls['host'].Core::$urls['path'].date('ymd').'5');
if ((!strpos(Core::$urls['action'], '.html') || substr(Core::$urls['action'], -5) !== '.html') && Core::$urls['action']!='') {
    Func_Header::notFound();
}
    if(!empty($_REQUEST['token'])&&$_REQUEST['token']==$token){
        if($_REQUEST['action']=='page_list_load_more'){
            Web_Article_Classify::display('Web_Static::classify.php.v2.0/list/list.tpl');
            die();
        }else{
            die();
        }

}else{
    Web_Global::openCache(2);
    Tpl_Smarty::assign('token_part1',substr($token,0,10));
    Tpl_Smarty::assign('token_part2',substr($token,10,10));
    Tpl_Smarty::assign('token_part3',substr($token,20,12));
    Web_Article_Classify::display('Web_Static::classify.php.v2.0/classify.tpl');
}
