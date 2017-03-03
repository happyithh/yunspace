<?php
/**
 * Created by PhpStorm.
 * User: pzl
 * Date: 2015/6/16
 * Time: 9:58
 */
switch(Core::$urls['action']){
    case "test":
        Web_Mobile_WeChat_Code::handle();
        break;
    default:
        Web_Mobile_WeChat_Code::handle();
        break;
}

