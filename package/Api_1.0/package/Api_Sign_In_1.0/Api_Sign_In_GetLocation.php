<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/1/26
 * Time: 10:06
 * 获取外出签到用户的GPS
 *
 */
class Api_Sign_In_GetLocation extends Api{
    static function getLocation(){
        require_once __DIR__."/getLocation/jssdk.php";
        $jssdk = new JSSDK("wx43c2afd25cb11b58", "d8c122f7a0e17c636cc75162bc176ade");
        $signPackage = $jssdk->GetSignPackage();
        return $signPackage;
    }
}
