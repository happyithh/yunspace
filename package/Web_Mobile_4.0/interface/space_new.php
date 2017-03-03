<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/7/4
 * Time: 13:22
 * 移动端搜索
 */
$item = Web_Mobile_Search_Item_List::getInstance();

//q($item->getItemList['data']['rows']);
//q($item->getUrls('size_range','100'));
//q($item->getActiveName);
//q($item->getScreenValue);
//q(123);
if (Core::$urls['action'] == 'search') {
//    q(4);
//    q($item->getItemList,$item->getActiveName,$item->getCategory);
    Web_Mobile_Search_Item_List::display('Web_Mobile_Static::search_about/search_location.tpl');
    die();
} elseif (Core::$urls['action'] == 'consult') {
    Web_Mobile_Search_Item_List::display('Web_Mobile_Static::search_about/consult.tpl');
    die();

}
Web_Mobile_Search_Item_List::display('Web_Mobile_Static::search.v2.0/search_list_1.0.tpl');

