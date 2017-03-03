<?php
/**
 * Created by PhpStorm.
 * User: liushengchun
 * Date: 15/4/23
 * Time: 09:51
 */
if (!empty($_REQUEST['df_city'])) {
    header("Cache-Control: no-cache, must-revalidate");
    header("Pragma: no-cache");
    setcookie('city', $_REQUEST['df_city'], time() + 60 * 60 * 24 * 30, '/');
    setcookie('js_city', 1, time() + 60 * 60 * 24 * 30, '/');
    Func_Header::to('', empty($_REQUEST['url_back']) ? Core::$urls['root'] : $_REQUEST['url_back']);
}