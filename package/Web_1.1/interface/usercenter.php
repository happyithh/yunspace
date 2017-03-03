<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/5/15
 * Time: 10:19
 */

Tpl_Smarty::assign('nav_index', 5);
switch (Core::$urls['action']) {
    case 'index':
        Tpl_Smarty::display('Web_User_Center','user_index.tpl');
        break;
    case 'step2':
        Tpl_Smarty::display('Web_Static','id_validate/validate_step2.tpl');
        break;
    case 'compy':
        Tpl_Smarty::display('Web_Static','id_validate/validate_compy.tpl');
        break;

    //报价机制手机端
    case 'quote_needs':
        Tpl_Smarty::display('Web_Mobile_Static','quote.v1.0/quote_needs.tpl');
        break;
}
