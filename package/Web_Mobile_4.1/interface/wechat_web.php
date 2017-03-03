<?php
/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2016/8/30
 * Time: 16:48
 */
Tpl_Smarty::assign('seo', array(
    '网页标题' => '微官网-【云SPACE】',
    '网页关键词' => '云space 微官网',
    '网页简介' => '云space 微官网'
));
$list = Data_Mysql_Table_Wechat_Web_Category::select('*',array('status=?'=>1,'is_show=?'=>1),'',20);
if($list){
    foreach($list as $k=>$v){
        $list[$k]['id']=Func_NumEncode::e($v['id'].'9527');
    }
}
Tpl_Smarty::assign('data',$list);
Tpl_Smarty::display('Web_Mobile_Static::wechat_web/wechat_index.tpl');