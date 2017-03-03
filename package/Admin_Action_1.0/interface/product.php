<?php
/**
 * Created by PhpStorm.
 * User: liushengchun
 * Date: 15/2/4
 * Time: 11:59
 */
switch (Core::$urls['action']) {
    case 'category':
        Admin_Data_Table_Product_Category::handle();
        break;
    case 'tags':
        Admin_Data_Table::quick(Data_Mysql_Table_Tags::subTable('_product'));
        break;
//    case 'list':
//        if (!empty($_REQUEST['category_attr'])) {
//            Core::output('');
//            $request = Func_Input::filter(array('category_id' => 'int', 'jsoncallback' => 'string'));
//            $json = json_encode(Data_Mysql_Table_Product_Category::getCategoryAttr($request['category_id']));
//            echo "{$request['jsoncallback']}({$json})";
//        } else if (!empty($_REQUEST['vendor_auto_complete'])) {
//            Admin_Data_Table_Product_Info::handleVendorAutoComplete();
//        } else {
//            Admin_Data_Table_Product_Info::handle();
//        }
//        break;
    case 'history':
        Admin_Data_Table::quick(Data_Mysql_Table_History::subTable('_product' . date("_Ym")));
        break;
//    case 'promotion':
//        die("Coming soon!");
//        break;
//    case 'search':
//        die("Coming soon!");
//        break;
//    case 'static':
//        Admin_Data_Table::quick(Data_Mysql_Table_Static::subTable('_product' . date("_Ym")));
//        break;
//    case 'service':
//        Tpl_Smarty::display("B2B_Admin", 'product_info_edit2.tpl');
//        break;
//    case 'case_add':
//        Tpl_Smarty::display("B2B_Admin", 'product_case_add.tpl');
//        break;
//    case 'state':
//        Tpl_Smarty::display("B2B_Admin", 'product_state.tpl');
//        break;
    default:
        Func_Header::notFound();
        break;
}