<?php
/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2016/5/16
 * Time: 14:21
 * 文章分类
 */
$token = md5(Core::$urls['host'] . date('ym') . '6');
$article = Web_Article_Classify_Info::getInstance();
//更新文章浏览量
$article->updateRaidersCountView;

if (!empty($_REQUEST['token']) && $_REQUEST['token'] == $token) {
    if (!empty($_REQUEST['action']) && $_REQUEST['action'] == 'page_content_load_more') {
        if ($article->topCategory['top_id'] == 12) {
            Web_Article_Classify_Info::display('Web_Static::classify.php.v2.0/inc/inc.wenku.tpl');
        } else {
            Web_Article_Classify_Info::display('Web_Static::classify.php.v2.0/inc/inc.article.tpl');
        }
        die();
    } else {
        die();
    }
} else {

    Web_Global::openCache(48);
    Tpl_Smarty::assign('token_part1', substr($token, 0, 10));
    Tpl_Smarty::assign('token_part2', substr($token, 10, 10));
    Tpl_Smarty::assign('token_part3', substr($token, 20, 12));
    if ($article->topCategory['top_id'] == 12) {
        Web_Article_Classify_Info::display('Web_Static::classify.php.v2.0/article_inside_wenku.tpl');
    } else {
        Web_Article_Classify_Info::display('Web_Static::classify.php.v2.0/article_inside.tpl');
    }
}
