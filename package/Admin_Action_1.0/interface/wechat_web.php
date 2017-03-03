<?php
/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2016/8/26
 * Time: 10:25
 */

switch(Core::$urls['action']){
    case 'category':
        OA_Wechat_Web_Category::handle();
        break;
    case 'article':
        OA_Wechat_Web_Article::handle();
        break;
    default:
        break;
}