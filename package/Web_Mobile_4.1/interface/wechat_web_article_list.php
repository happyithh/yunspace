<?php
/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2016/8/30
 * Time: 17:19
 */
$request = Func_Input::filter(array(
    'category_id'=>'string'
));

if(empty($request['category_id'])){
    Func_Header::notFound();
}
$category_id=substr(Func_NumEncode::d($request['category_id']),0,-4);
$rs = Data_Mysql_Table_Wechat_Web_Category::select('*',array('id=?'=>$category_id),'',1);
if(empty($rs)||($rs&&$rs[0]['status']==0)){
    Func_Header::notFound();
}
Tpl_Smarty::assign('seo', array(
    '网页标题' => $rs[0]['category'].'-【云SPACE】',
    '网页关键词' => $rs[0]['category'].'-【云SPACE】',
    '网页简介' => $rs[0]['category'].'-【云SPACE】'
));
//推荐字段
$hot_list = Data_Mysql_Table_Wechat_Web_Article::select('*',array('category_id=?'=>$category_id,'status=?'=>1,'is_recommend=?'=>1),'order by update_time desc',5);
$list = Data_Mysql_Table_Wechat_Web_Article::select('*',array('category_id=?'=>$category_id,'status=?'=>1),'order by update_time desc',5);
if($hot_list){
    foreach($hot_list as $k=>$v){
            $hot_list[$k]['id']=Func_NumEncode::e($v['id'].'9528');
    }
}
if($list){
    foreach($list as $k=>$v){
        $list[$k]['id']=Func_NumEncode::e($v['id'].'9528');
    }
}
Tpl_Smarty::assign('request',$request);
Tpl_Smarty::assign('hot_list',$hot_list);
Tpl_Smarty::assign('data',$list);
Tpl_Smarty::display('Web_Mobile_Static::wechat_web/wechat_article_list.tpl');