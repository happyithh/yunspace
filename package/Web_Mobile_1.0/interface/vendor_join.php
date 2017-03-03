<?php
Data_Config_Site::seo('homepage');
Tpl_Smarty::assign('vendorAttr', Web_HomePage::vendorAttr());
Tpl_Smarty::assign('vendorCategory', Data_Mysql_Table_Product_Category::getTreeCache());

Tpl_Smarty::assign('__user', @$_SESSION['user']);
Tpl_Smarty::assign('categoryList', Data_Mysql_Table_Product_Category::getTreeCache());
Tpl_Smarty::assign('menuType', Api_Site_Config_ProductMenu::getMenu());
$AllCity = Api_City_Auto_Complete::handle();
//  q($AllCity);
// $AllCity = Api_City_Auto_Complete::allCity(array('num' =>1));
Tpl_Smarty::assign('city', $AllCity['data']);
Tpl_Smarty::display("Web_Mobile_Static::vendor_join.v2.0/vendor_join.tpl");