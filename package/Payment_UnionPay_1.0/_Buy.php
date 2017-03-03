<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 15/5/4
 * @银联---    接入
 */
class Payment_UnionPay_Buy extends Payment_UnionPay
{

    private static $_signInfo = array(
        'MerId' => '',                   //商户号
        'BusiId' => '',                  //业务编号
        'OrdId' => '',                //交易订单号  非
        'OrdAmt' => '',              //订单交易金额   非
        'CuryId' => '156',           //交易币种  固定值 人民币：156
        'Version' => '20100401',    //版本号
        'BgRetUrl' => '',            //后台交易接收URL地址
        'PageRetUrl' => '',            //页面交易接收URL地址
        'GateId' => '',              //支付网关号 非
        'Param1' => '',             //业务参数   非
        'Param2' => '',             //业务参数  非
        'Param3' => '',             //业务参数  非
        'Param4' => '',
        'Param5' => '',
        'Param6' => '',
        'Param7' => '',
        'Param8' => '',
        'Param9' => '',
        'Param10' => '',
        'OrdDesc' => '',          //订单描述   非
        'ShareType' => '0001',     //分账类型 /默认0001， 0001 为即时分帐 0002为延时分帐
        'ShareData' => '',       //商户分账数据    /   A^10;B^20;C^30
        'Priv1' => '',            //商户私有域  非
        'CustomIp' => '',          //用户提交订单的IP地址  非
        'ChkValue' => '',          //签名数据
    );

    static function handle($ordId, $ordAmt, $pid, $userMoblie, $pageRetUrl, $bgRetUrl, $shareData = '', $gateId = '', $OrdDesc = '')
    {
        if (empty($shareData) || !is_array($shareData)) {
            $shareData = array('00188480' => 0);
        }

        foreach ($shareData as $k => $v) {
            if ($v == 0) {
                $v = $ordAmt;
            }
            $shareData[$k] = "{$k}^" . ($v * 100);
        }
        $merchant = self::$_signInfo;
        $merchant['MerId'] = self::$merId;
        $merchant['BusiId'] = '';                   //业务编号
        $merchant['OrdId'] = $ordId;                //交易订单号
        $merchant['OrdAmt'] = $ordAmt * 100;               //订单交易金额
        $merchant['BgRetUrl'] = $bgRetUrl;          //后台交易接收URL地址
        $merchant['PageRetUrl'] = $pageRetUrl;      //交易 后 跳转URL地址
        $merchant['ShareType'] = '0001';        //分账类型
        $merchant['ShareData'] = implode(';', $shareData);        //商户分账数据
        $merchant['GateId'] = $gateId;
        $merchant['Param1'] = $pid;
        $merchant['Param2'] = $userMoblie;
        $merchant['OrdDesc'] = $OrdDesc;            //订单描述   非

        //组装签名数据
        $msgData = $merchant['MerId'] . $merchant['BusiId'] . $merchant['OrdId'] . $merchant['OrdAmt'] . $merchant['CuryId'] . $merchant['Version'];
        $msgData .= $merchant['BgRetUrl'] . $merchant['PageRetUrl'] . $merchant['GateId'] . $merchant['Param1'] . $merchant['Param2'] . $merchant['Param3'];
        $msgData .= $merchant['Param4'] . $merchant['Param5'] . $merchant['Param6'] . $merchant['Param7'] . $merchant['Param8'] . $merchant['Param9'] . $merchant['Param10'] . $merchant['ShareType'] . $merchant['ShareData'] . $merchant['Priv1'] . $merchant['CustomIp'];

        $merchant['ChkValue'] = self::_chkValue($msgData);      //签名数据

//        if (Core::$urls['host'] == 'yun.cc') {
//            $merchant['PayStat'] = '0001';
//            $merchant['PayTime'] = time();
//            Func_Header::post($merchant['PageRetUrl'], $merchant, 'UTF-8');
//        }
//        q($merchant);
//        Func_Header::post(Payment_UnionPay::$apiTest. self::$apiBuy, $merchant, 'UTF-8');
        file_put_contents('temp/' . time() . '.check_buy.txt', var_export($_REQUEST, 1));
        Func_Header::post(Payment_UnionPay::$apiProduct . self::$apiBuy, $merchant, 'UTF-8');

    }


    //交易接收数据的内容
    static function checkReturn()
    {
        file_put_contents('temp/' . time() . '.check_return.txt', var_export($_REQUEST, 1));
        $MerId = $_REQUEST['MerId'];
        $BusiId = $_REQUEST['BusiId'];
        $OrdId = $_REQUEST['OrdId'];
        $OrdAmt = $_REQUEST['OrdAmt'];
        $CuryId = $_REQUEST['CuryId'];
        $Version = $_REQUEST['Version'];
        $GateId = $_REQUEST['GateId'];
        $Param1 = $_REQUEST['Param1'];
        $Param2 = $_REQUEST['Param2'];
        $Param3 = $_REQUEST['Param3'];
        $Param4 = $_REQUEST['Param4'];
        $Param5 = $_REQUEST['Param5'];
        $Param6 = $_REQUEST['Param6'];
        $Param7 = $_REQUEST['Param7'];
        $Param8 = $_REQUEST['Param8'];
        $Param9 = $_REQUEST['Param9'];
        $Param10 = $_REQUEST['Param10'];
//        $OrdDesc = $_REQUEST['OrdDesc'];
        $ShareType = $_REQUEST['ShareType'];
        $ShareData = $_REQUEST['ShareData'];
        $Priv1 = $_REQUEST['Priv1'];
        $CustomIp = $_REQUEST['CustomIp'];
        $PayStat = $_REQUEST['PayStat'];
        $PayTime = $_REQUEST['PayTime'];
        $ChkValue = $_REQUEST['ChkValue'];

        $msgData = $MerId . $BusiId . $OrdId . $OrdAmt . $CuryId . $Version . $GateId . $Param1 . $Param2 . $Param3 . $Param4 . $Param5 . $Param6 . $Param7 . $Param8 . $Param9 . $Param10;
        $msgData .= $ShareType . $ShareData . $Priv1 . $CustomIp . $PayStat . $PayTime;
        //验证签名($merid, $ordid, $amount, $curyid, $transdate, $transtype, $status, $checkvalue)
        //$status,  0001 支付,   0002退款
        $verifyStatus = self::_veriSignValue($MerId, $OrdId, $OrdAmt, $CuryId, date('Ymd', $PayTime), '0001', $PayStat, $ChkValue);
        if (!empty($verifyStatus)) {
            return 'eduok';
        } else {
            return false;
        }

    }

    static function checkNotify()
    {
        error_reporting(0);
        $return = self::checkReturn();
        if ($return) {
            echo $return;
        }
        return $return;
    }
}