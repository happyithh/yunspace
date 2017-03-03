<?php
/**
 * Created by PhpStorm.
 * User: yl
 * Date: 15-10-22
 * Time: 上午9:41
 * 场地百科内页
 */

//验证tooken  5分钟内有效
if(empty($_REQUEST['token'])){
    Func_Header::notFound();
}
$visit_time=Func_String::decrypt($_REQUEST['token'],'reg_create_space');
if(($visit_time+5*60) < time()){
    Func_Header::notFound();
}

//获取百科的名称和操作
$baike = Web_History_Baike_Info::getInstance();

Web_History_Baike_Info::display( 'Web_Static::site/site_history.tpl');