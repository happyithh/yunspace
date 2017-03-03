<?php
/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/4/7
 * @供应商加盟
 */
Data_Config_Site::seo('供应商加盟');
Tpl_Smarty::assign('categoryList', Data_Mysql_Table_Product_Category::getTreeCache());
Tpl_Smarty::display('Web', 'vendor_join.tpl');