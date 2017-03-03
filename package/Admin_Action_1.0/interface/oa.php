<?php
/**
 * Created by PhpStorm.
 * User: liushengchun
 * Date: 15/2/4
 * Time: 11:59
 */

//Api接口的请求映射到 Api_Class 上
if (!Core::$urls['action']) {
    die('001');
}
//接口请求解析
$pathInfo = pathinfo(Core::$urls['action']);
$apiInfo = array(
    'class' => 'OA_' . strtr(ucwords(strtr($pathInfo['dirname'] . '/' . $pathInfo['filename'], '/', ' ')), ' ', '_'),
    'output' => 'handle',
);

//判断接口类是否存在
if (!Core::class_exists($apiInfo['class'])) {
    if (Core::$debugToken || $apiInfo['class'] == 'Api_Reset_Class_Cache') {
        Core::autoload('Api_Reset_Class_Cache');
    }
    if (!Core::class_exists($apiInfo['class'])) {
        q($apiInfo);
        die('002');
    }
}
if (!is_callable("{$apiInfo['class']}::{$apiInfo['output']}")) {
    die('003');
}
$apiReturn = call_user_func("{$apiInfo['class']}::{$apiInfo['output']}", $_REQUEST);