<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/10/8
 * Time: 14:57
 */

$action = explode('/',Core::$urls['action']);
switch ($action[0]) {
    case  "list":
        Tpl_Smarty::assign('nav', "winchance");
        $winchance_seo['title'] = 'IP展_文创_IP合作_IP活动_艺术展_动漫展_最聚购物中心客流【云SPACE】';
        $winchance_seo['des'] = '超级IP,大IP,强品牌IP,原创IP,文创产品,ip授权,商场活动,商场人气';
        $winchance_seo['keywords'] = '云SPACE是国内首家"购物中心+IP"跨界合作平台,整合IP资源,帮助购物中心引导人流,将IP美陈与建筑结合、内容与所具备的情感结合，将IP变成一种情感纽带，从而更好的带动整体客流.';
        Data_Config_Site::seo('winchance', $winchance_seo);
        $list = Web_Winchance_List::getInstance();
        $category = Data_Mysql_Table_Winchance::$category;
        Tpl_Smarty::assign('category', $category);
        if(!empty($action[1])) {
            Tpl_Smarty::assign('action1',$action[1]);
        }
        $area_array = Data_Mysql_Table_Winchance::$area_array;
        Tpl_Smarty::assign('area_array', $area_array);
        Web_Winchance_List::display('Web_Static::winchance/act_list.php.tpl');
        break;
    default :
        Tpl_Smarty::assign('nav', "winchance");
        $winchance_seo['title'] = 'IP展_文创_IP合作_IP活动_艺术展_动漫展_最聚购物中心客流【云SPACE】';
        $winchance_seo['des'] = '超级IP,大IP,强品牌IP,原创IP,文创产品,ip授权,商场活动,商场人气';
        $winchance_seo['keywords'] = '云SPACE是国内首家"购物中心+IP"跨界合作平台,整合IP资源,帮助购物中心引导人流,将IP美陈与建筑结合、内容与所具备的情感结合，将IP变成一种情感纽带，从而更好的带动整体客流.';
        Data_Config_Site::seo('winchance', $winchance_seo);
        $category = Data_Mysql_Table_Winchance::$category;
        Tpl_Smarty::assign('category', $category);
        $area_array = Data_Mysql_Table_Winchance::$area_array;
        Tpl_Smarty::assign('area_array', $area_array);
        Web_Winchance_Win::display('Web_Static::winchance/winchance.php.tpl');
        break;

}