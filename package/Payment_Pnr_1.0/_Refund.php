<?php

/**
 * Created by PhpStorm.
 * User: liushengchun
 * Date: 15/3/5
 * Time: 15:15
 */
class Payment_Pnr_Refund extends Base
{
    static $apiTest = 'http://test.chinapnr.com/gar/RecvMerchant.do';
    static $apiProduct = 'https://mas.chinapnr.com/gar/RecvMerchant.do';
    private static $_signInfo = array(
        'Version' => '10',
        'CmdId' => 'Buy',
        'MerId' => '873012', //商户号
        'OrdId' => '',//支付编号
        'OrdAmt' => '', //金额
        'CurCode' => 'RMB',
        'Pid' => '',//产品编号
        'RetUrl' => '',//同步返回地址
        'BgRetUrl' => '',  //后台返回地址
        'MerPriv' => 'iieo', //商户私有数据,    留空
        'GateId' => '', //网关号, 对应银行选择,    留空
        'UsrMp' => '', //用户手机号   留空
        'DivDetails' => '', //分账号   留空
        'PayUsrId' => '',  //付款人在汇付的几号,  留空
    );


    static function createMerchantData($orderId, $amount, $pid, $userMoblie, $returnUrl, $bgReturnUrl)
    {
        $merchant = self::$_signInfo;
        $merchant['OrdId'] = $orderId;
        $merchant['OrdAmt'] = $amount;
        $merchant['Pid'] = $pid;
        $merchant['UsrMp'] = $userMoblie;
        $merchant['RetUrl'] = $returnUrl;
        $merchant['BgRetUrl'] = $bgReturnUrl;
        $merchant['MerPriv'] = md5($orderId . '------y111s');
        $signObject = new COM("CHINAPNR.NetpayClient");
        $msgData = $merchant['Version'] . $merchant['CmdId'] . $merchant['MerId'] . $merchant['OrdId'] . $merchant['OrdAmt'] . $merchant['CurCode'] . $merchant['Pid'] . $merchant['RetUrl'] . $merchant['MerPriv'] . $merchant['GateId'] . $merchant['UsrMp'] . $merchant['DivDetails'] . $merchant['PayUsrId'] . $merchant['BgRetUrl'];
        $merFile = dirname(__FILE__) . "/_Extends/PNR/MerPrK{$merchant['MerId']}.key";
        $merchant['ChkValue'] = $signObject->SignMsg0($merchant['MerId'], $merFile, $msgData, strlen($msgData));
        return $merchant;
    }

    static function checkReturn()
    {
        $CmdId = $_POST['CmdId'];            //消息类型
        $MerId = $_POST['MerId'];            //商户号
        $RespCode = $_POST['RespCode'];    //应答返回码
        $TrxId = $_POST['TrxId'];            //钱管家交易唯一标识
        $OrdAmt = $_POST['OrdAmt'];        //金额
        $CurCode = $_POST['CurCode'];        //币种
        $Pid = $_POST['Pid'];                //商品编号
        $OrdId = $_POST['OrdId'];            //订单号
        $MerPriv = $_POST['MerPriv'];        //商户私有域
        $RetType = $_POST['RetType'];        //返回类型
        $DivDetails = $_POST['DivDetails']; //分账明细
        $GateId = $_POST['GateId'];        //银行ID
        $ChkValue = $_POST['ChkValue'];    //签名信息

        //验证签名
        $SignObject = new COM("CHINAPNR.NetpayClient");
        $MsgData = $CmdId . $MerId . $RespCode . $TrxId . $OrdAmt . $CurCode . $Pid . $OrdId . $MerPriv . $RetType . $DivDetails . $GateId;    //参数顺序不能错
        $merFile = dirname(__FILE__) . "/_Extends/PNR/PgPubk.key";
        $SignData = $SignObject->VeriSignMsg0($merFile, $MsgData, strlen($MsgData), $ChkValue);
        if ($SignData == "0") {
            if ($RespCode == "000000") {
                //交易成功
                //根据订单号 进行相应业务操作
                //在些插入代码
                return true;
            } else {
                //交易失败
                //根据订单号 进行相应业务操作
                //在些插入代码
                return false;
            }
        } else {
            //验签失败
            return false;
        }
    }

    static function checkNotify()
    {
        $CmdId = $_POST['CmdId'];            //消息类型
        $MerId = $_POST['MerId'];            //商户号
        $RespCode = $_POST['RespCode'];    //应答返回码
        $TrxId = $_POST['TrxId'];            //钱管家交易唯一标识
        $OrdAmt = $_POST['OrdAmt'];        //金额
        $CurCode = $_POST['CurCode'];        //币种
        $Pid = $_POST['Pid'];                //商品编号
        $OrdId = $_POST['OrdId'];            //订单号
        $MerPriv = $_POST['MerPriv'];        //商户私有域
        $RetType = $_POST['RetType'];        //返回类型
        $DivDetails = $_POST['DivDetails']; //分账明细
        $GateId = $_POST['GateId'];        //银行ID
        $ChkValue = $_POST['ChkValue'];    //签名信息

        //验证签名
        $SignObject = new COM("CHINAPNR.NetpayClient");
        $MsgData = $CmdId . $MerId . $RespCode . $TrxId . $OrdAmt . $CurCode . $Pid . $OrdId . $MerPriv . $RetType . $DivDetails . $GateId;    //参数顺序不能错
        $merFile = dirname(__FILE__) . "/_Extends/PNR/PgPubk.key";
        $SignData = $SignObject->VeriSignMsg0($MerFile, $MsgData, strlen($MsgData), $ChkValue);

        if ($SignData == "0") {
            echo "RECV_ORD_ID_" . $OrdId;
            if ($RespCode == "000000") {
                //交易成功
                //根据订单号 进行相应业务操作
                //在些插入代码
                return true;
            } else {
                //交易失败
                //根据订单号 进行相应业务操作
                //在些插入代码
                return false;
            }
        } else {
            //验签失败
//            echo "验签失败[" . $SignData . "]";
            return false;
        }
    }
}