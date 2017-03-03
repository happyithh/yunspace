<?php
/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2016/3/30
 * Time: 13:42
 */
@session_start();
class Web_Wechat_Login {

    static function isLogin(){
        if(empty($_SESSION['user']['id'])){
            return false;
        }else{
            return true;
        }
    }
} 