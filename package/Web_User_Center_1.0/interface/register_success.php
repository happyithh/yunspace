<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/2/27
 * Time: 15:32
 */
if (!empty($_SESSION['url_back'])) {
    Tpl_Smarty::assign('url_back', $_SESSION['url_back']);
}
Tpl_Smarty::display('Web_User_Center', 'register_success.tpl');