<?php

/**
 * Created by PhpStorm.
 * User: liushengchun
 * Date: 15/3/5
 * Time: 15:15
 */
class Payment_Pnr_Sign extends Payment_Pnr
{

    private static $_signInfo2 = array(
        'Version' => '10',
        'CmdId' => 'Sign',
        'MerId' => '', //商户号
        'UsrId' => '',//
        'UsrPwd' => '', //
        'UsrName' => '',//
        'UsrNameShort' => '',//
        'UsrEmail' => '',//
        'UsrTel' => '',//
        'UsrMp' => '',//
        'PwdQues' => '',
        'PwdAns' => '',
        'UsrType' => '',
        'ChkValue' => '',//
    );


    private static $_signInfo = array(
        'Version' => '10',
        'CmdId' => 'Sign',
        'MerId' => '', //商户号
        'UsrId' => '',//
        'OperId' => '', //
        'MerDate' => '',
        'MerTime' => '',//
        'BgRetUrl' => '',  //后台返回地址
        'ChkValue' => '',//
    );
    static function handle($usrId, $bgReturnUrl)
    {
        $merchant = self::$_signInfo;
        $merchant['MerId'] = self::$merId;
        $merchant['UsrId'] = $usrId;
        $merchant['OperId'] = self::$operId;
        $merchant['MerDate'] = date('Ymd');
        $merchant['MerTime'] = date('His');
        $merchant['BgRetUrl'] = $bgReturnUrl;
        $msgData = $merchant['Version'] . $merchant['CmdId'] . $merchant['MerId'] . $merchant['UsrId'] . $merchant['MerDate'] . $merchant['MerTime'] . $merchant['BgRetUrl'];
        $merchant['ChkValue'] = self::_chkValue($msgData);
        Func_Header::post(Payment_Pnr::$apiProduct . self::$apiSign, $merchant, 'gb2312');
    }

    static function checkNotify()
    {
        $CmdId = $_POST['CmdId'];            //消息类型
        $MerId = $_POST['MerId'];            //商户号
        $UsrId = $_POST['UsrId'];            //
        $RespCode = $_POST['RespCode'];    //应答返回码
        $OperId = $_POST['OperId'];        //
        $ErrMsg = $_POST['ErrMsg'];        //
        $ChkValue = $_POST['ChkValue'];    //签名信息

        //验证签名
        $MsgData = $CmdId . $MerId . $UsrId . $RespCode . $OperId . $ErrMsg;    //参数顺序不能错
        $SignData = self::_veriSignValue($MsgData);
        if ($SignData == "0") {
            echo "RECV_ORD_ID_" . $UsrId;
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