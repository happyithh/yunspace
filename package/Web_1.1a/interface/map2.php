<?php

//$webConfig = Data_Config_Site::get('service_list');
//
//if (!empty($_REQUEST['getType']) && $_REQUEST['getType'] == 'ajax') {
//       $map =  Web_Search_Space::getInstance();
//       $list =  $map->getMapList;
//     echo json_encode($list,1);
//
//} else {
//    Web_Search_Space::display('map.tpl');
//}

//输出模板
Data_Config_Site::seo('space_map',array(
    'category_name' => ( '空间场地'),
));
Page_Site_Global::urlToCity();
$cityKey = explode('-', Core::$urls['action']);
if (!empty($cityKey[1])) {    //以城市字母开头的子栏目
    Core::$urls['action'] = $cityKey[1];
} else {
    Core::$urls['action'] = Page_Site_Global::$space_id;
}
if (empty(Core::$urls['action'])) {
    Core::$urls['action'] = Page_Site_Global::$space_id;
} elseif (Core::$urls['action'] === $_COOKIE['city_key']) {        //顶部城市列表切换
    Core::$urls['action'] = Page_Site_Global::$space_id;
}

Web_Map_Search::handle();