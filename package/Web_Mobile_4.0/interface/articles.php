<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/2/3
 * Time: 16:39
 *
 * 文章列表（获取最新文章）
 */


$articles=Web_Article_All_List::getInstance();
//q($articles->articleList());
Web_Article_All_List::display('Web_Mobile_Static::articles/article_list_1.tpl');