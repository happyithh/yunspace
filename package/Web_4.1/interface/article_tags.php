<?php
/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2016/6/23
 * Time: 17:19
 */
$token = md5(Core::$urls['host'] . Core::$urls['path'] . date('ymd') . '5');
if (!empty($_REQUEST['token']) && $_REQUEST['token'] == $token) {
    if ($_REQUEST['action'] == 'page_list_load_more') {
        Web_Article_Classify_Tags::display('Web_Static::classify.php.v2.0/list/list.tpl');
        die();
    } else {
        die();
    }
} else {
    Tpl_Smarty::assign('token_part1', substr($token, 0, 10));
    Tpl_Smarty::assign('token_part2', substr($token, 10, 10));
    Tpl_Smarty::assign('token_part3', substr($token, 20, 12));
    Web_Article_Classify_Tags::display("Web_Static::classify.php.v2.0/related_article.tpl");
}

