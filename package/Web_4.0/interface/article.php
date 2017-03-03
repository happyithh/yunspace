<?php
/**
 * Created by PhpStorm.
 * User: yl
 * Date: 15-12-10
 * Time: 下午13:50
 * 文章内页
 */
$article=Web_Article_Info::getInstance();
//更新关联百科的浏览量
//$article->updateCountViewReletaBaike;
//更新文章浏览量
$article->updateRaidersCountView;
Web_Global::openCache(48);
if(1){
    Web_Article_Info::display( 'Web_Static::article/article_text_1.tpl');
}elseif($article->isRetail==true){
    Web_Article_Info::display("Web_Static::retail/information.tpl");
} else{
    Web_Article_Info::display( 'Web_Static::article/article_info.tpl');
}