<?php
/**
 * Created by PhpStorm.
 * User: pzl
 * Date: 15/9/21
 * Time: 上午9:17
 */
//q(Core::$urls['action']);
$category_id = intval(Core::$urls['action']);
if(empty($category_id)) {
    $category_id = 0;
}
$list = Api_Raiders_List::handle(array('category_id'=>$category_id));
$banner = Api_Raiders_Banner::handle(array('category_id'=>$category_id));
$category_name['category_name'] = '活动资讯，活动攻略，活动案例';
$allCategory = Data_Mysql_Table_Raiders_Info::$category_name;
foreach ($allCategory as $k => $v) {
    if ($v['id'] == $category_id) {
        $category_name['category_name'] = $v['name'];
    }
}
Data_Config_Site::seo('activity_strategy', $category_name);
$allCategory = Web_Activity_Raiders::allCategory();
if($category_id>0) {
    foreach ($allCategory as $k => $v) {
        if ($category_id == $v['id']) {
            $parent = $v['parent'];
        }
    }
    Tpl_Smarty::assign('parent',$parent);
}
Tpl_Smarty::assign('banner_list',$banner['data']);
Tpl_Smarty::assign('category_id',$category_id);
Tpl_Smarty::assign('allCategory',$allCategory);
Tpl_Smarty::assign('rows',$list['data']);
Tpl_Smarty::display("Web_Mobile_Static::activity_strategy.v2.0/activity_strategy.tpl");