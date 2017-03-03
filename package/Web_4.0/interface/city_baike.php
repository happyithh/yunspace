<?php
/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2016/2/1
 * Time: 16:41
 */
//获取城市  然后获取百科

$action = Func_Url::str_urldecode(Func_String::utf8(Core::$urls['action']));
$action = in_array($action,Web_Global::$city_name)?$action:"上海";
Tpl_Smarty::assign('action_city_name',$action);
//先判断城市百科是否存在


//获取城市百科信息  名称 说明（说明氛围介绍和地理位置介绍）  介绍图片。所有图片都显示（轮播）
//获取百科详情
$condition['{table}.status = ?'] = 1;
$spaceInfo = Api_Spacepedia_List_And_Info::getSpacepediaInfoByName($action, $condition, 1);
if (empty($spaceInfo)) {
    Func_Header::notFound();
}

$spaceInfo['seo_title'] = empty($spaceInfo['attr']['营销标题']) ? "" : $spaceInfo['attr']['营销标题'];
$spaceInfo['special_tags'] = empty($spaceInfo['attr']['特色标签']) ? "" : $spaceInfo['attr']['特色标签'];
$spaceInfo['special_tags'] = str_replace(',', " / ", $spaceInfo['special_tags']);
unset($spaceInfo['attr']['特色标签'], $spaceInfo['attr']['营销标题']);
////将百科的城市放入cookie中
//$city_key = array_search($spaceInfo['city'], $_REQUEST['cities']);
//$_COOKIE['city_key'] = empty($city_key) ? "sh" : $city_key;
Tpl_Smarty::assign('spaceInfo',$spaceInfo);
//获取百科下四篇文章
$condition = array(
    'space_ids'=>$spaceInfo['id'],
    'logo !=?'=>''
);
$article_list = Web_Baike_New::getArticles($condition,1,"ORDER BY counter_view DESC, create_time DESC",8);
Tpl_Smarty::assign('article_list',$article_list);
//获取该区域场地数据 缩放级别
//用ajax请求吧

//获取该地区的相关场地
//先默认显示多少条,然后再加载更多
$getLists = Api_Spacepedia_List::getMoreList(array("city"=>$spaceInfo['space_name']));
if($getLists['status']==1){
    $space_list = $getLists['data']['data'];
    Tpl_Smarty::assign('next_dp', $getLists['data']['next_dp']);
    Tpl_Smarty::assign('total_num', $getLists['data']['total_num']);
    Tpl_Smarty::assign('space_list',$space_list);
}else{
    Tpl_Smarty::assign('next_dp',0);
    Tpl_Smarty::assign('space_list','');
}

Web_Global::display('Web_Static::city_baike/city_baike_1.tpl');