<?php

/**
 * Created by PhpStorm.
 * User: liushengchun
 * Date: 15/3/5
 * Time: 15:15
 */
class Payment_Pnr_Account extends Payment_Pnr
{


    private static $_registerInfo = array(
        'Version' => '10',
        'CmdId' => 'RegistMerchant',
        'MerId' => '', //商户号
        'UsrId' => '',//
        'UsrPwd' => '', //
        'UsrName' => '',//
        'UsrNameShort' => '',//
        'UsrEmail' => '',//
        'UsrTel' => '',
        'UsrMp' => '',//
        'PwdQues' => '',
        'PwdAns' => '',
        'UsrType' => '',
        'ChkValue' => '',//
    );

    static function handleRegister($usrId, $usrPwd, $usrName, $usrNameShort, $usrEmail, $usrMp)
    {
        $merchant = self::$_registerInfo;
        $merchant['MerId'] = self::$merId;
        $merchant['UsrId'] = $usrId;
        $merchant['UsrPwd'] = md5($usrPwd);
        $merchant['UsrName'] = substr(mb_convert_encoding($usrName, 'gbk', 'utf-8'), 0, 50);
        $merchant['UsrNameShort'] = substr(mb_convert_encoding($usrNameShort, 'gbk', 'utf-8'), 0, 16);
        $merchant['UsrEmail'] = $usrEmail;
        $merchant['UsrMp'] = $usrMp;
        $msgData = $merchant['Version'] . $merchant['CmdId'] . $merchant['MerId'] .
            $merchant['UsrId'] . $merchant['UsrPwd'] . $merchant['UsrName'] . $merchant['UsrNameShort'] . $merchant['UsrEmail'] . $merchant['UsrMp'];
        $merchant['ChkValue'] = self::_chkValue($msgData);
        $r = Func_Http::post(self::$apiProduct . self::$apiRegistMerchant, $merchant);
        $r = mb_convert_encoding($r, 'utf-8', 'gbk');
        if (strpos($r, '手机号已存在')) {
            Func_Header::back('您绑定的手机号已开通过收款账户，请变更后再尝试。');
        }
        //RespCode=000000     ErrMsg=成功
        //RespCode=220001    ErrMsg=用户注册失败：用户名已存在
        //RespCode=220001    ErrMsg=用户注册失败：手机号已存在
    }

    private static $_loginInfo = array(
        'Version' => '10',
        'CmdId' => 'Login',
        'MerId' => '', //商户号
        'MerUsrId' => '',//
        'MerDate' => '', //
        'ChkValue' => '',//
    );

    static function handleLogin($usrId)
    {
        $merchant = self::$_loginInfo;
        $merchant['MerId'] = self::$merId;
        $merchant['MerUsrId'] = $usrId;
        $merchant['MerDate'] = date('Ymd');
        $msgData = $merchant['Version'] . $merchant['CmdId'] . $merchant['MerId'] .
            $merchant['MerUsrId'] . $merchant['MerDate'];
        $merchant['ChkValue'] = self::_chkValue($msgData);
        $r = Func_Http::post(self::$apiProduct . self::$apiLogin, $merchant);
        $r = mb_convert_encoding($r, 'utf-8', 'gbk');
        Func_Header::post(self::$apiProduct . self::$apiLogin, $merchant);
    }


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

    static function handleSign($usrId, $bgReturnUrl)
    {
        $merchant = self::$_signInfo;
        $merchant['MerId'] = self::$merId;
        $merchant['UsrId'] = $usrId;
//        $merchant['OperId'] = self::$operId;
        $merchant['MerDate'] = date('Ymd');
        $merchant['MerTime'] = date('His');
        $merchant['BgRetUrl'] = $bgReturnUrl;
        $msgData = $merchant['Version'] . $merchant['CmdId'] . $merchant['MerId'] . $merchant['UsrId'] . $merchant['MerDate'] . $merchant['MerTime'] . $merchant['BgRetUrl'];
        $merchant['ChkValue'] = self::_chkValue($msgData);
//        q($merchant);
        Func_Header::post(Payment_Pnr::$apiProduct . self::$apiSign, $merchant, 'gb2312');
    }

    static function checkNotify()
    {
        $CmdId = $_POST['CmdId'];            //消息类型
        $MerId = $_POST['MerId'];            //商户号
        $UsrId = $_POST['UsrId'];            //
        $OperId = $_POST['OperId'];        //
        $RespCode = $_POST['RespCode'];    //应答返回码
        $ErrMsg = $_POST['ErrMsg'];        //
        $ChkValue = $_POST['ChkValue'];    //签名信息

        //验证签名
        $MsgData = $CmdId . $MerId . $UsrId . $OperId . $RespCode . $ErrMsg;    //参数顺序不能错
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