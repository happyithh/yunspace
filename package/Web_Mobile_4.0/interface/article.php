<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2015/12/14
 * Time: 20:14
 *
 * 移动版文章详情页
 */
$article=Web_Article_Info::getInstance();
//更新关联百科的浏览量
$article->updateCountViewReletaBaike;
//更新文章浏览量
$article->updateRaidersCountView;

Web_Article_Info::display( 'Web_Mobile_Static::articles/article.tpl');