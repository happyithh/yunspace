<?php
/**
 * Created by PhpStorm.
 * User: bll
 * Date: 16/3/30
 * Time: 下午3:31
 */
switch (Core::$urls['action']) {
    case  "one":
        Tpl_Smarty::display('Web_Static::wechat_ticket/list_one.tpl');
        break;
    case  "two":
        Tpl_Smarty::display('Web_Static::wechat_ticket/form_list.tpl');
        break;
}