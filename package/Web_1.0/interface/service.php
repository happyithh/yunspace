<?php
/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/2/26
 * Time: 15:14
 */
Tpl_Smarty::assign('nav_index', 2);
Page_Site_Global::urlToCity();
$cityKey = explode('-', Core::$urls['action']);
if (!empty($cityKey[1])) {    //以城市字母开头的子栏目
    Core::$urls['action'] = $cityKey[1];
}

Page_Site_Global::putTagsInRequest();   //把已选择标签，放入REQUEST
$url = urldecode(Core::$urls['path']);
//$url = Func_String::RemoveXSS($url);
Core::$urls['path'] = urlencode($url);
if (!empty($_REQUEST['request_devices']) && $_REQUEST['request_devices'] == 'mobile') {    //手机页面加载更多
    Web_Search_Space::display('inc/service_list_body.tpl');
} else {
    Web_Search_Space::display('service-list.v2.tpl');
}
