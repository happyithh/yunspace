<?php
/**
 * Created by PhpStorm.
 * User: bll
 * Date: 16/1/27
 * Time: 下午5:57
 */
switch (Core::$urls['action']) {
    case '':
        Tpl_Smarty::display('Saas_Static', 'metronic_rounded/index.html');
        break;
    default:
        //后台演示DEMO,可以关闭
        if (strpos(Core::$urls['action'], '.html')) {
            Tpl_Smarty::display('Saas_Static', 'metronic_rounded/' . Core::$urls['action']);
        } else {
            Func_Header::location('');
        }
        break;
}