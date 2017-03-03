<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/5/27
 * Time: 13:21
 *
 * 子空间搜索
 */
$action = empty($_REQUEST['action'])?'search':$_REQUEST['action'];
$space=Web_Mobile_Search_Space_Item::getInstance();
//q($action);
//if (empty($_REQUEST['action'])) {
//    $_REQUEST['action'] = Page_Site_Global::$space_id;
//}
//q($space->getSearchResult);
switch($action){
    case 'search':
        Web_Mobile_Search_Space_Item::display('Web_Mobile_Static::search/search_space.tpl');
        break;

    default:
        Web_Mobile_Search_Space_Item::display('Web_Mobile_Static::search/space.v2.0/search_result.tpl');
}