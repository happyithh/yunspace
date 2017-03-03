<?php
/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2016/6/20
 * Time: 15:48
 */
$city_key = Func_String::utf8(urldecode(Core::$urls['action']));
$city_all =Web_Global::$city_name;

if (!array_key_exists($city_key, $city_all)) {
    Func_Header::notFound();
}
setcookie('city', $city_all[$city_key], time() + 60 * 60 * 24 * 30, '/');
$_COOKIE['city'] = $city_all[$city_key];
setcookie('city_key', $city_key, time() + 60 * 60 * 24 * 30, '/');
$_COOKIE['city_key'] = $city_key;
include dirname(__FILE__) . '/space_library.php';

