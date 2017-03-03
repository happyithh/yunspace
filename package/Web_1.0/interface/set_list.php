<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/6/8
 * Time: 15:48
 */

Tpl_Smarty::assign('nav_index', 3);
Page_Site_Global::urlToCity();
$cityKey = explode('-', Core::$urls['action']);
if (!empty($cityKey[1])) {    //以城市字母开头的子栏目
    Core::$urls['action'] = $cityKey[1];
}
Web_Set_list::display('set_list.tpl');
