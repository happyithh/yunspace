<?php
/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/7/7
 * Time: 15:48
 */
$city_key = Func_String::utf8(urldecode(Core::$urls['action']));

if (!array_key_exists($city_key, $_REQUEST['cities'])) {
    Func_Header::notFound();
}
setcookie('city', $_REQUEST['cities'][$city_key], time() + 60 * 60 * 24 * 30, '/');
$_COOKIE['city'] = $_REQUEST['cities'][$city_key];

setcookie('city_key', $city_key, time() + 60 * 60 * 24 * 30, '/');
$_COOKIE['city_key'] = $city_key;
include dirname(__FILE__) . '/index.php';

