<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2015/12/28
 * Time: 17:50
 *
 * 资讯文章列表
 */
Web_Global::openCache(48);
$article = Web_Article_List::getInstance();
Web_Article_List::display('Web_Static::article/article_list.tpl');