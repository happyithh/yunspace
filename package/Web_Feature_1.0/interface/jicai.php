<?php
/**
 * Created by PhpStorm.
 * User: bll
 * Date: 15/10/12
 * Time: 上午10:08
 */
Data_Config_Site::cityShow();
switch (Core::$urls['action']) {
    case "":
        Tpl_Smarty::assign('nav_index', 5);
        Tpl_Smarty::display('Web_Feature_Static::jicai/jicai.tpl');
        break;
    case "form":
        Tpl_Smarty::assign('nav_index', 5);
        Tpl_Smarty::display('Web_Feature_Static::jicai/jicai_form.tpl');
        break;
}
