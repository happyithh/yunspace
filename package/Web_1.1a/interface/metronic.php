<?php
/**
 * Created by PhpStorm.
 * User: bll
 * Date: 16/1/27
 * Time: 下午5:35
 */
switch (Core::$urls['action']) {
    case '':
        Tpl_Smarty::display('Saas_Static', 'metronic/index.html');
        break;
    default:
        //后台演示DEMO,可以关闭
        if (strpos(Core::$urls['action'], '.html')) {
            Tpl_Smarty::display('Saas_Static', 'metronic/' . Core::$urls['action']);
        } else {
            Func_Header::location('');
        }
        break;
}