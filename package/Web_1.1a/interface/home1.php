<?php
/**
 * Created by PhpStorm.
 * User: adu
 * Date: 15/9/8
 * Time: 上午11:17
 */

if (Core::$urls['host'] == 'yunspace.com.cn') {
    Func_Header::location('http://www.yunspace.com.cn');
}
if (!empty($_REQUEST['df_city'])) {
    header("Cache-Control: no-cache, must-revalidate");
    header("Pragma: no-cache");
    setcookie('city', $_REQUEST['df_city'], time() + 60 * 60 * 24 * 30, '/');
    setcookie('js_city', 1, time() + 60 * 60 * 24 * 30, '/');
    Func_Header::to('', empty($_REQUEST['url_back']) ? Core::$urls['root'] : $_REQUEST['url_back']);
}
if (substr(Core::$urls['path'], 0, 2) == '/u') {
    Data_Mysql_Table_Dwz_Record::analysis(substr(Core::$urls['path'], 2));
}
if (substr(Core::$urls['path'], 0, 2) == '/l') {
    Api_Analysis_Login_DWZ::analysisLoginLink(substr(Core::$urls['path'], 2));
}
if (empty($_COOKIE['city'])) {
    $getCityApi = 'http://api.map.baidu.com/location/ip?ak=aaNCRRcGGai6klHMOGZ8yBbP&ip=' . Func_Input::ip() . '&coor=bd09ll';
    $cityJson = @file_get_contents($getCityApi);
    $cityData = json_decode($cityJson, 1);
    if (!empty($cityData['content']['address_detail']['city'])) {
        $string = $cityData['content']['address_detail']['city'];
        $end = strpos($string, '市');
        $city = substr($string, 0, $end);
        if (array_search($city, $_REQUEST['cities'])) {
            setcookie('city', $city, time() + 60 * 60 * 24 * 30, '/');
        } else {
            setcookie('city', '上海', time() + 60 * 60 * 24 * 30, '/');
        }
    } else {
        setcookie('city', '上海', time() + 60 * 60 * 24 * 30, '/');
    }
}

//开始绑定数据，渲染页面
Data_Config_Site::seo('homepage');
//首页banner (暂时用固定的)
//Tpl_Smarty::assign('banner', Web_HomePage_V2::banner());

//特别推荐
$specialRecommend = Web_HomePage_V2::specialRecommend();
Tpl_Smarty::assign('recommend', $specialRecommend);
//Q($specialRecommend);


//热门套餐
Tpl_Smarty::assign('hotSet', Web_HomePage_V2::loadHotSet());

////秀场展馆
Tpl_Smarty::assign('show_exhibition_hall', Web_HomePage_V2::loadHotContent('秀场展馆'));
////商业广场
Tpl_Smarty::assign('commercial_plaza', Web_HomePage_V2::loadHotContent('商业广场'));
////高端会所
Tpl_Smarty::assign('high_end_club', Web_HomePage_V2::loadHotContent('高端会所'));
////配套服务
Tpl_Smarty::assign('recommend_service', Web_HomePage_V2::loadHotContent('配套服务'));



//活动攻略
Tpl_Smarty::assign('strategy_1', Web_HomePage_V2::activityStrategy('活动方案'));
Tpl_Smarty::assign('strategy_2', Web_HomePage_V2::activityStrategy('经典案例'));
Tpl_Smarty::assign('strategy_3', Web_HomePage_V2::activityStrategy('经验分享'));
Tpl_Smarty::assign('strategy_4', Web_HomePage_V2::activityStrategy('精选专题'));

$_REQUEST['cities'] = array(
    'sh' => '上海',
    'bj' => '北京',
    'gz' => '广州',
    'sz' => '深圳',
//    'cd' => '成都',
//    'hz' => '杭州'
);
$cityArray= array(
        'cd' => '成都',
        'hz' => '杭州'
);
$city_key = Core::$urls['action'] ?Core::$urls['action'] :"sh";
if(!isset($_REQUEST['cities'][Core::$urls['action']]) && Core::$urls['action']){
    $_REQUEST['cities'][Core::$urls['action']] = $cityArray[Core::$urls['action']];
}
Tpl_Smarty::display('Web_Static', 'home.v3.0/home3.0.tpl');