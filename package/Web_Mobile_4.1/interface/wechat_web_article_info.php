<?php
/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2016/8/30
 * Time: 17:40
 */
$request = Func_Input::filter(array(
    'id'=>'string'
));

if(empty($request['id'])){
    Func_Header::notFound();
}
$article_id=substr(Func_NumEncode::d($request['id']),0,-4);
$rs = Data_Mysql_Table_Wechat_Web_Article::select('*',array('id=?'=>$article_id),'',1);
if(empty($rs)||($rs&&$rs[0]['status']==0)){
    Func_Header::notFound();
}
Tpl_Smarty::assign('seo', array(
    '网页标题' => $rs[0]['title'].'-【云SPACE】',
    '网页关键词' => $rs[0]['introduction'].'-【云SPACE】',
    '网页简介' => $rs[0]['introduction'].'-【云SPACE】'
));
//Q($rs);
Tpl_Smarty::assign('data',$rs[0]);
Tpl_Smarty::display('Web_Mobile_Static::wechat_web/wechat_article_detail.tpl');