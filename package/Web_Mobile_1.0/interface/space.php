<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/5/28
 * Time: 11:07
 */
if (!empty($_REQUEST['df_city'])) {
    header("Cache-Control: no-cache, must-revalidate");
    header("Pragma: no-cache");
    setcookie('city', $_REQUEST['df_city'], time() + 60 * 60 * 24 * 30, '/');
    setcookie('js_city', 1, time() + 60 * 60 * 24 * 30, '/');
    $_COOKIE['city'] = $_REQUEST['df_city'];
}
if (empty($_COOKIE['city'])) {
    $getCityApi = 'http://api.map.baidu.com/location/ip?ak=aaNCRRcGGai6klHMOGZ8yBbP&ip=' . Func_Input::ip() . '&coor=bd09ll';
    $cityJson = file_get_contents($getCityApi);
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
Tpl_Smarty::assign('nav_index', 1);
if (empty(Core::$urls['action'])) {
    Core::$urls['action'] = Page_Site_Global::$space_id;
}
if(!empty(Core::$urls['action']) && Core::$urls['action']=="get_list_for_mobile" ){
    if(empty($_REQUEST['category_id'])){
        $_REQUEST['category_id'] = Core::$urls['action'] = Page_Site_Global::$space_id;
    }
   Web_Search_Space::handleGetListForMobile();
    die();
}
Web_Search_Space::display('Web_Mobile_Static::space.v2.0/space.tpl');