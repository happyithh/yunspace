<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/7/29
 * Time: 10:23
 */

//添加案例
switch (Core::$urls['action']) {
    case  "caseadd":
        Web_case_add::handle();
        break;
}
//Web_case_add::handleGetListForMobile();
//Web_case_add::display('Web_Mobile_Static::case/case_add.tpl');
