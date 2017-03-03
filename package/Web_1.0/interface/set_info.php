<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/5/11
 * Time: 13:54
 */
Tpl_Smarty::assign('nav_index', 3);
$set = Web_Product_Set_Info::getInstance();
Data_Config_Site::seo('set_info', $set->info);
Data_Mysql_Table_Product_Set::footPrint($set->id);

//Web_Product_Set_Info::display($a->isV2 ? 'product_set_info.v2.tpl' : 'product_set_info.tpl');
Web_Product_Set_Info::display( 'product_set_info.v2.1.tpl');