<?php
/**
 * Created by PhpStorm.
 * User: Jim
 * Date: 2015/2/26
 * Time: 15:22
 */
Data_Config_Site::seo('办活动整体解决方案');
Tpl_Smarty::assign('attr', Data_Config_Vendor_Attr::get('attr'));
Tpl_Smarty::assign('nav_index', 5);
Tpl_Smarty::display('Web', 'solution.tpl');