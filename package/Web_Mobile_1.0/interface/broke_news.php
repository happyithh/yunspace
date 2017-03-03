<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2015/8/13
 * Time: 18:34
 */
$action = empty($_REQUEST['action'])?'broke_form':$_REQUEST['action'];
switch ($action) {
    case 'broke_the_news_mine':
        Web_Mobile_Broke_News::broke_the_news_mine();
        break;
    case 'broke_validate':
        Web_Mobile_Broke_News::broke_validate();
        break;
    case 'broke_form':
        Web_Mobile_Broke_News::broke_the_news_form();
    default:
        Web_Mobile_Broke_News::broke_the_news_form();
}