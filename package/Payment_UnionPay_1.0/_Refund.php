<?php
/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/5/5
 * Time: 14:39
 * @银联---退款
 *
 */
Class  Payment_UnionPay_Refund extends Payment_UnionPay{

    private static $_signInfo = array(
        'MerId' =>'',                   //商户号
        'BusiId' => '',                  //业务编号
        'OrdId' => '',              //原支付交易的订单号
        'MerRefId' => '',              //退款订单号
        'RefAmt' => '',              //退款金额
        'CuryId' => '156',           //交易币种  固定值 人民币：156
        'Version' => '20100401',    //版本号
        'BgRetUrl' => '',            //后台交易接收URL地址
        'PageRetUrl' => '',            //页面交易接收URL地址
        'Param1' => '',             //业务参数   非
        'Param2' => '',             //业务参数  非
        'Param3' => '',             //业务参数  非
        'Param4' => '',             //业务参数  非
        'Param5' => '',             //业务参数  非
        'Param6' => '',             //业务参数  非
        'Param7' => '',             //业务参数  非
        'Param8' => '',             //业务参数  非
        'Param9' => '',             //业务参数  非
        'Param10' => '',             //业务参数  非
        'RefDesc' => '',          //订单描述   非
        'ShareType'=>'0001',     //只能是 0001
        'ShareData' => '',       //商户分账数据
        'Priv1' => '',            //商户私有域，要求由商户自己定义内容，但是不能重复，为了避免退款的重复提交，因此会验证此域段内容是否有重复来确定退款是否已经提交过了，如果提交过则认为该笔退款已经接收不再处理。
        'ChkValue' =>'',          //签名数据
    );


    static  function  handle($OrdId,$MerRefId,$RefAmt,$BgRetUrl,$PageRetUrl,$ShareData,$RefDesc=''){
       $merchant = self::$_signInfo;
       $merchant['MerId'] =  '';    //商户号
       $merchant['BusiId'] =  '';                  //业务编号
       $merchant['OrdId'] =  $OrdId;              //原支付交易的订单号
       $merchant['MerRefId'] = $MerRefId;              //退款订单号
       $merchant['RefAmt'] = $RefAmt;              //退款金额
       $merchant['BgRetUrl'] = $BgRetUrl;            //后台交易接收URL地址
       $merchant['PageRetUrl']= $PageRetUrl;            //页面交易接收URL地址
       $merchant['ShareData'] = $ShareData;       //商户分账数据
       $merchant['RefDesc'] = $RefDesc;          //订单描述   非
       $merchant['Param1'] = '';             //业务参数   非
       $merchant['Priv1']  = md5($OrdId . '------y111s');     //商户私有域，要求由商户自己定义内容，但是不能重复，为了避免退款的重复提交，因此会验证此域段内容是否有重复来确定退款是否已经提交过了，如果提交过则认为该笔退款已经接收不再处理。
       //组装签名字段
       $msgData= $merchant['MerId'].$merchant['BusiId'].$merchant['OrdId'].$merchant['MerRefId']. $merchant['RefAmt'].$merchant['Version'].$merchant['BgRetUrl'];
       $msgData.=$merchant['PageRetUrl'].$merchant['Param1'].$merchant['Param2'].$merchant['Param3'].$merchant['Param4'].$merchant['Param5'].$merchant['Param6'];
       $msgData.=$merchant['Param7'].$merchant['Param8'].$merchant['Param9'].$merchant['Param10'].$merchant['ShareType'].$merchant['ShareData'].$merchant['Priv1'];

       $merchant['ChkValue'] =self::_chkValue($msgData);;          //签名数据

        Func_Header::post(Payment_UnionPay::$apiTest . self::$apiRefund, $merchant, 'UTF-8');
    }

    //接收退款数据的内容
    static  function  checkReturn(){

            $ResponseCode = $_REQUEST['ResponseCode'];      //应答码
            $MerId        = $_REQUEST['MerId'];                     //商户号
            $MerRefId     = $_REQUEST['MerRefId'];                  //退款订单号
            $RefStat      = $_REQUEST['RefStat'];                    //退款状态
            $RefTime      = $_REQUEST['RefTime'];                    //退款处理时间
            $Priv1        = $_REQUEST['Priv1'];                      //商户私有域
            $ChkValue     = $_REQUEST['ChkValue'];                   //签名数据

            $msgData = $MerId.$MerRefId.$RefStat.$RefTime.$Priv1;

            //通过ResponseCode可以判断退款是否成功。退款成功ResponseCode的值为0
            if($ResponseCode == 0){
                $verifyStatus = self::_veriSignValue($msgData,$ChkValue);
                if($verifyStatus){

                    return 'eduok';
                }

            }else{

            }

    }

}