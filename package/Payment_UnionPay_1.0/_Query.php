<?php
/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/5/5
 * Time: 15:35
 * @银联 --查询
 */
Class Payment_UnionPay_Query extends Payment_UnionPay
{

    private  static  $_signInfo = array(

        'MerId'=>'',            //商户号
        'BusiId'=>'',           //原始订单的业务编号
        'OrdId'=>'',            //原始交易订单号
        'Param1'=>'',           //业务参数
        'Param2'=>'',
        'Param3'=>'',
        'Param4'=>'',
        'Param5'=>'',
        'Param6'=>'',
        'Param7'=>'',
        'Param8'=>'',
        'Param9'=>'',
        'Param10'=>'',
        'ChkValue'=>'',         //签名数据

    );

 static  function  handle($BusiId,$OrdId)
 {

     $merchant = self::$_signInfo;
     $merchant['MerId'] = '';           //商户号
     $merchant['BusiId'] = $BusiId;          //原始订单的业务编号
     $merchant['OrdId'] = $OrdId;           //原始交易订单号
     $merchant['Param1'] = '';


     $msgData = $merchant['MerId'] . $merchant['BusiId'] . $merchant['OrdId'] . $merchant['Param1'] . $merchant['Param2'] . $merchant['Param3'];
     $msgData .= $merchant['Param4'] . $merchant['Param5'] . $merchant['Param6'] . $merchant['Param7'] . $merchant['Param8'] . $merchant['Param9'] . $merchant['Param10'];

     $merchant['ChkValue'] = self::_chkValue($msgData);      //签名数据

     Func_Header::post(Payment_UnionPay::$apiTest . self::$apiQuery, $merchant, 'UTF-8');

 }

    //
    static  function  checkReturn(){

        $ResponseCode = $_REQUEST['ResponseCode'];      //应答码
        $MerId      = $_REQUEST['MerId'];                     //商户号
        $BusiId     = $_REQUEST['BusiId'];                     //
        $OrdId      = $_REQUEST['OrdId'];                  //退款订单号
        $Param1      = $_REQUEST['Param1'];                  //
        $Param2      = $_REQUEST['Param2'];                  //
        $Param3      = $_REQUEST['Param3'];                  //
        $Param4      = $_REQUEST['Param4'];                  //
        $Param5      = $_REQUEST['Param5'];                  //
        $Param6      = $_REQUEST['Param6'];                  //
        $Param7      = $_REQUEST['Param7'];                  //
        $Param8      = $_REQUEST['Param8'];                  //
        $Param9      = $_REQUEST['Param9'];                  //
        $Param10      = $_REQUEST['Param10'];               //
        $OrdAmt     = $_REQUEST['OrdAmt'];                 //订单金额
        $CuryId     = $_REQUEST['CuryId'];                 //货币代号
        $Version    = $_REQUEST['Version'];                 //版本号
        $GateId     = $_REQUEST['GateId'];                  //交易网关号
        $OrdDesc    = $_REQUEST['OrdDesc'];                 //交易描述
        $ShareType  = $_REQUEST['ShareType'];               //分账类型
        $ShareData  = $_REQUEST['ShareData'];               //订单分账数据
        $Priv1      = $_REQUEST['Priv1'];                   //订单私有域
        $PayStat    = $_REQUEST['PayStat'];                 //1111未支付，1001支付成功，其余失败，（4位数字）
        $PayTime    = $_REQUEST['PayTime'];                 //支付完成时间
        $RefNum     = $_REQUEST['RefNum'];                   //退款次数
        $RefAmt     = $_REQUEST['RefAmt'];                  //退款金额
        $RefTime    = $_REQUEST['RefTime'];                 //退款时间
        $ChkValue   = $_REQUEST['ChkValue'];                //签名

        if($ResponseCode==0){

            $msgData = $MerId.$BusiId.$OrdId.$Param1.$Param2.$Param3.$Param4.$Param5.$Param6.$Param7.$Param8.$Param9.$Param10.$OrdAmt.$CuryId.$Version.$GateId;

            $verifyStatus =self::_veriSignValue($msgData,$ChkValue);
            if($verifyStatus){
                    return 'eduok';
            }
        }else{


        }




    }





}