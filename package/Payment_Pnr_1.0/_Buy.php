<?php

/**
 * Created by PhpStorm.
 * User: liushengchun
 * Date: 15/3/5
 * Time: 15:15
 */
class Payment_Pnr_Buy extends Payment_Pnr
{

    private static $_signInfo = array(
        'Version' => '10',
        'CmdId' => 'Buy',
        'MerId' => '', //商户号
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
        'ChkValue' => '',
    );

    static function handle($orderId, $amount, $pid, $userMoblie, $returnUrl, $bgReturnUrl, $divDetail = '', $bankId = '')
    {
        $merchant = self::$_signInfo;
        $merchant['MerId'] = self::$merId;
        $merchant['OrdId'] = $orderId;
        $merchant['OrdAmt'] = $amount;
        $merchant['Pid'] = $pid;
        $merchant['UsrMp'] = $userMoblie;
        $merchant['RetUrl'] = $returnUrl;
        $merchant['BgRetUrl'] = $bgReturnUrl;
        $merchant['DivDetails'] = $divDetail;
        $merchant['GateId'] = $bankId;
        $merchant['MerPriv'] = md5($orderId . '------y111s');
        if (Func_Input::isLocal()) {
            Func_Header::post($merchant['RetUrl'], $merchant, 'gb2312');
        }
        $msgData = $merchant['Version'] . $merchant['CmdId'] . $merchant['MerId'] . $merchant['OrdId'] . $merchant['OrdAmt'] . $merchant['CurCode'] . $merchant['Pid'] . $merchant['RetUrl'] . $merchant['MerPriv'] . $merchant['GateId'] . $merchant['UsrMp'] . $merchant['DivDetails'] . $merchant['PayUsrId'] . $merchant['BgRetUrl'];
        $merchant['ChkValue'] = self::_chkValue($msgData);
        Func_Header::post(Payment_Pnr::$apiProduct . self::$apiBuy, $merchant, 'gb2312');
    }

    static function checkReturn()
    {
        if (Func_Input::isLocal()) {
            return true;
        }
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
        $MsgData = $CmdId . $MerId . $RespCode . $TrxId . $OrdAmt . $CurCode . $Pid . $OrdId . $MerPriv . $RetType . $DivDetails . $GateId;    //参数顺序不能错
        $SignData = self::_veriSignValue($MsgData);
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
        if (Core::$urls['host'] == 'yun.cc' || Core::$urls['host'] == 'test.iyunspace.com.cn') {
            return true;
        }
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
        $MsgData = $CmdId . $MerId . $RespCode . $TrxId . $OrdAmt . $CurCode . $Pid . $OrdId . $MerPriv . $RetType . $DivDetails . $GateId;    //参数顺序不能错
        $SignData = self::_veriSignValue($MsgData);
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