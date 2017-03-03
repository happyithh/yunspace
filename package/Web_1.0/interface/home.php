<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/6/8
 * Time: 15:48
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


$allCategory = Data_Mysql_Table_Product_Category::getTreeCache();
Tpl_Smarty::assign('spaceCategory', $allCategory[112]);
Tpl_Smarty::assign('product_size', Data_Mysql_Table_Product_Search::$product_size);

//开始绑定数据，渲染页面
Data_Config_Site::seo('homepage');
//Tpl_Smarty::assign('banner', Web_HomePage::banner());
//Tpl_Smarty::assign('hotSet', 1);
Tpl_Smarty::assign('recommend_space', Web_HomePage::loadHotContent('热门空间'));
Tpl_Smarty::assign('recommend_service', Web_HomePage::loadHotContent('热门场地搭建'));
Tpl_Smarty::display('Web_Static::home.v2.0/home.php.tpl');
