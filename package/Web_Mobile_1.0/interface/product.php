<?php
/**
 * Created by PhpStorm.
 * User: bll
 * Date: 15/10/21
 * Time: 下午3:07
 */
switch(Core::$urls['action']){
    case "":
        Tpl_Smarty::display('Web_Mobile_Static::product.v2.0/product.tpl');
        break;
    case "enquiry":
        Tpl_Smarty::display('Web_Mobile_Static::product.v2.0/product_enquiry.tpl');
        break;
}
