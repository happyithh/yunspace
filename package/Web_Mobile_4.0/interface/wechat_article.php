<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/1/14
 * Time: 15:21
 * 微信公众号文章
 */
$article = Api_WeChat_Article_Mobile_list::articleList();
Tpl_Smarty::assign('type','wechat_article');
Tpl_Smarty::assign('data',$article['rows']);
Tpl_Smarty::display('Web_Mobile_Static::wechat/wechat_article.tpl');
