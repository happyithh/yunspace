<?php
/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2015/6/15
 * Time: 13:19
 */
Header("HTTP/1.1 301 Moved Permanently");
Header("Location: http://www.yunspace.com.cn/article_list/");
die;
Tpl_Smarty::assign('nav_index', 4);
$getlist = Web_Activity_Raiders::getInstance();
$category_name['category_name'] = '云发现';
foreach ($getlist->allCategory as $k => $v) {
    if ($v['id'] == $getlist->category_id) {
        $category_name['category_name'] = $v['name'];
    }
    foreach ($getlist->getaccessory['rows'] as $key => $val) {
        if ($val['category_id'] == $v['id']) {
            $getlist->getaccessory['rows'][$key]['category_name'] = $v['name'];
        }
    }
}
//q(Core::$urls['action']);
//$action_arr = explode('/', Core::$urls['action']);
//q($action_arr[1]);
//q($getlist->getRaidersList);
//if ($getlist->category_id== 12 || $getlist->topCategory_id['top_id'] == 12) {
//
//    foreach ($getlist->getaccessory['rows'] as $key => $val) {
//
//        preg_match_all('/\.(.*)/', $val['accessory']['name'], $match);
//        $getlist->getaccessory['rows'][$key]['match'] = $match;
//    }
//    Data_Config_Site::seo('raiders', $category_name);
//    Web_Activity_Raiders::display("Web_Static::/raiders/library-list.tpl");
//}else{
//    Data_Config_Site::seo('raiders', $category_name);
//    Web_Activity_Raiders::display("Web_Static::/raiders/raiders-list.php.tpl");
//}
//q($getlist->category_id);
//Tpl_Smarty::assign('category_id',$getlist->category_id);
//Tpl_Smarty::assign('topcategory_id',$getlist->topCategory_id['top_id']);
if ($getlist->category_id== 12 || $getlist->topCategory_id['top_id'] == 12) {

    foreach ($getlist->getaccessory['rows'] as $key => $val) {

        preg_match_all('/\.(.*)/', $val['accessory']['name'], $match);
        $getlist->getaccessory['rows'][$key]['match'] = $match;
    }
    Data_Config_Site::seo('raiders', $category_name);
    Tpl_Smarty::assign('action',Core::$urls['action']);
    Tpl_Smarty::assign('category_id',$getlist->category_id);
    Tpl_Smarty::assign('topcategory_id',$getlist->topCategory_id['top_id']);
    Web_Activity_Raiders::display("Web_Static::/find.v3.0/find_library_list.php.tpl");
}else{
    if(!empty($_REQUEST['keyword'])) {
        Tpl_Smarty::assign('keyword',$_REQUEST['keyword']);
    }
    Data_Config_Site::seo('raiders', $category_name);
    Tpl_Smarty::assign('action',Core::$urls['action']);
    Web_Activity_Raiders::display("Web_Static::/find.v3.0/find_list.php.tpl");
}


//Tpl_Smarty::display("Web_Static::/find.v3.0/find_list.tpl");
//Web_Activity_Raiders::display("Web_Static::/find.v3.0/find_list.php.tpl");
