<?php

/**
 * Created by PhpStorm.
 * User: liushengchun
 * Date: 15/3/5
 * Time: 15:15
 */
class Payment_Pnr_Cash extends Payment_Pnr
{
    static $apiTest = 'http://test.chinapnr.com/buser';
    static $apiProduct = 'https://lab.chinapnr.com/buser';

    private static $_signInfo = array(
        'Version' => '10',
        'CmdId' => 'prTrans',
        'CustId' => '000007858936', //商户号
        'OrdId' => '',//支付编号
        'OrdAmt' => '', //金额
        'MerPriv' => 'iieo', //商户私有数据,    留空
        'AcctName' => '',
        'BankId' => '',
        'AcctId' => '',
        'UserMp' => '', //用户手机号
        'PrType' => '',
        'RetUrl' => '',//同步返回地址
        'Charset' => '', //
        'ChkType' => '',
        'ChkValue' => '',
    );

    static function handle($orderId, $amount, $accountName, $bankId, $accountId, $mobile, $prType, $retUrl)
    {
        //Charset   ChkType    ChkValue
        $merchant = self::$_signInfo;
        $merchant['OrdId'] = $orderId;
        $merchant['OrdAmt'] = $amount;
        $merchant['AcctName'] = $accountName;
        $merchant['BankId'] = $bankId;
        $merchant['AcctId'] = $accountId;
        $merchant['UserMp'] = $mobile;
        $merchant['PrType'] = $prType ? $prType : 'C';
        $merchant['RetUrl'] = $retUrl;
        $merchant['Charset'] = 'UTF8';
        $merchant['ChkType'] = 'R';  //M   /  R
        $merchant['MerPriv'] = md5($orderId . '------y111s');
        $msgData = $merchant['Version'] . $merchant['CmdId'] . $merchant['CustId'] . $merchant['OrdId'] . $merchant['OrdAmt'] . $merchant['MerPriv']
            . $merchant['AcctName'] . $merchant['BankId'] . $merchant['AcctId'] . $merchant['PrType']
            . $merchant['RetUrl'] . $merchant['Charset'] . $merchant['ChkType'];
        $merchant['ChkValue'] = self::_cashChkValue($msgData);
        $r = Func_Header::post(self::$apiProduct . self::$apiCash, $merchant);
    }

    static function checkReturn()
    {
        //TransStat
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
}