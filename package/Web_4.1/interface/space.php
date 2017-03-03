<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/6/16
 * Time: 15:50
 * 子空间搜索
 */

$item=Web_Search_Item_List::getInstance();
//q(Api_Search_Get_Conform_Item::handle($_REQUEST)['data']);
if(isset($_REQUEST['search_type']) && ($_REQUEST['search_type']=='project_library' || $_REQUEST['search_type']=='company_library' || $_REQUEST['search_type']=='paper_library')){
    $url = 'http://'.Core::$urls['host'].'/database?action=is_submit&search_type='.$_REQUEST['search_type'].'&keyword='.$_REQUEST['keyword2'];
//    q($url);
    Func_Header::to('',$url);
}
//$title['title'] = '上海';
//q($item->getUrls('activeType','wen'));
//q(Func_String::utf8(Core::$urls['uri']),Core::$urls['uri']);
//q($item->getScreenValue);
//q($item->dealCustomField);
//q($item->getItemSearchList);
//q($item->getUrls('price_range',''));
//Func_Console::logger('1','SSS');
Web_Search_Item_List::display("Web_Static::search/search_list_2.2.tpl");

