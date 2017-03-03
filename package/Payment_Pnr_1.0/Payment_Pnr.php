<?php

/**
 * Created by PhpStorm.
 * User: liushengchun
 * Date: 15/3/5
 * Time: 15:15
 */
class Payment_Pnr extends Base
{
    static $apiTest = 'http://test.chinapnr.com';
    static $apiProduct = 'https://mas.chinapnr.com';
    static $apiBuy = '/gar/RecvMerchant.do';            //支付
    static $apiSign = '/gau/UnifiedServlet';                 //签约
    static $apiRegistMerchant = '/gar/entry.do';         //开户
    static $apiLogin = '/gau/usr_login.do';                //登录
    static $apiPaymentConfirm = '/gao/entry.do';      //结算
    static $apiCash = '/extUrl/prTransHttp';               //结算
    static $apiRefund = '/gao/entry.do';                     //退款
    static $apiQuery = '/gaq/entry.do';                       //查询
    static $merId = '873012';
    static $operId = '873012';

    static function _chkValue($msgData)
    {
        $signObject = new COM("CHINAPNR.NetpayClient");
        $merFile = dirname(__FILE__) . "/_Extends/PNR/MerPrK" . self::$merId . ".key";
        return $signObject->SignMsg0(self::$merId, $merFile, $msgData, strlen($msgData));
    }

    static function _cashChkValue($msgData)
    {
        $signObject = new COM("CHINAPNR.NetpayClient");
        $merFile = dirname(__FILE__) . "/_Extends/PNR/MerPrK" . self::$merId . ".key";
        return $signObject->SignMsg0(self::$merId, $merFile, $msgData, strlen($msgData));
    }

    static function _veriSignValue($msgData)
    {
        //验证签名
        $SignObject = new COM("CHINAPNR.NetpayClient");
        $merFile = dirname(__FILE__) . "/_Extends/PNR/PgPubk.key";
        return $SignObject->VeriSignMsg0($merFile, $msgData, strlen($msgData), $_POST['ChkValue']);
    }


    static function handle($orderId, $amount, $pid, $userMoblie, $returnUrl, $bgReturnUrl)
    {
    }

    static function handleReturn()
    {

    }

    static function handleNotify()
    {

    }

}