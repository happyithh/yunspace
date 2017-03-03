<?php

/**
 * Created by PhpStorm.
 * User: zzc * Date: 15/5/4
 * @银联类库
 */
class Payment_UnionPay extends Base
{

    //cpeduinterface/OrderStdDelayShare.do      延时分账
    ///cpeduinterface/OrderStdStopShare.do      终止分账
    //cpedusetliq/ReconGet.do                   对账

    static $apiTest = 'http://bianmin-test.chinapay.com';
    static $apiProduct = 'http://apps.chinapay.com';

    static $apiBuy = '/cpeduinterface/OrderGet.do';            //支付

//    static  $apiSign = '/gau/UnifiedServlet';                 //签约
//    static $apiRegistMerchant = '/gar/entry.do';         //开户
//    static $apiLogin = '/gau/usr_login.do';                //登录
//    static $apiPaymentConfirm = '/gao/entry.do';      //结算
//    static $apiCash = '/extUrl/prTransHttp';               //结算

    static $apiRecon = '/cpedusetliq/ReconGet.do';           //对账
    static $apiRefund = '/cpeduinterface/RefGet.do';                     //退款
    static $apiQuery = '/cpeduinterface/QueryGet.do';                    //查询
    static $merId = '808080201309620';
    static $operId = '873012';

    static $curyId = '156';         //交易币种  固定值 人民币：156
    static $version = '20100401';    //版本号


    //	签名
    static function _chkValue($msgData)
    {
//        $ev = '';
//        include_once(dirname(__FILE__) . "/_Extends/netpay/netpayclient.php");
//        eval(substr($ev, 0, -17));//eval($OO00O00O0);
//        //eval($OO00O00O0);
//        eval(substr($OO00O00O0, 0, -17));//eval($OO00O00O0);
//        echo $OO00O00O0;
//        die();
//        q($ev);
        include_once(dirname(__FILE__) . "/_Extends/netpay/netpayclient_de.php");
        $merFile = dirname(__FILE__) . "/_Extends/netpay/MerPrk.key";
        $flag = buildKey($merFile);
        if (!$flag) {
            echo "导入私钥文件失败！";
            return false;
        }
        $Data = base64_encode($msgData);
        // 对一段字符串的签名函数
        return sign($Data);
    }

    //验证签名
    static function _veriSignValue($merid, $ordid, $amount, $curyid, $transdate, $transtype, $status, $checkvalue)
    {
        //验证签名
        include_once(dirname(__FILE__) . "/_Extends/netpay/netpayclient_de.php");
        $merFile = dirname(__FILE__) . "/_Extends/netpay/PgPubk.key";
        $flag = buildKey($merFile);
        if (!$flag) {
            echo "导入公钥文件失败！";
            return false;
        }

        $plain = $merid . $ordid . $amount . $curyid . $transdate . $transtype . $status . $checkvalue;
        //	验证交易应答函数
        //true 表示成功，即该交易应答为ChinaPay所发送，商户根据“交易状态”进行后续处理；否则表示失败，即无效应答，商户可忽略该应答。
        $flag = verifyTransResponse($merid, $ordid, $amount, $curyid, $transdate, $transtype, $status, $checkvalue);
        //对一段字符串的签名--验证--函数
        $flag = verify($plain, $checkvalue);
        q($flag);
        return $flag;
    }

}