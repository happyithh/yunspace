<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/2/27
 * Time: 15:23
 */
if (empty($_POST['register'])) {
    Tpl_Smarty::assign('_category_tree', Data_Mysql_Table_Product_Category::getTreeCache());
    Tpl_Smarty::display('Web_User_Center', 'vendor_register.tpl');
    die();
} else {
    $_REQUEST['account_type'] = $_POST['account_type'] = 21;
    include dirname(__FILE__) . '/register.php';
}