<?php

/**
 * Created by PhpStorm.
 * User: adu
 * Date: 15/6/10
 * Time: 11:18
 */
@session_start();

class Web_Mobile_WeChat_Code extends Base
{



    /***
     * 测试方法
     */

    static  function handle(){

        $wxData = array(
            "body" => $_REQUEST['body'], //描述
            "out_trade_no" => $_REQUEST['out_trade_no'],  //支付节点
            "total_fee" => $_REQUEST['total_fee'], //价格
//            "notify_url"=>WxPayConf_pub::NOTIFY_URL,
        );
        self::wxPayNew($wxData);
        Tpl_Smarty::display("Web_Mobile_Static::wechat.v2.0/wechat_tobepay_code.tpl");
    }

    static function wxPayNew($wxData)
    {
        include_once(dirname(__FILE__) . "/WxPayPubHelper/WxPayPubHelper.php");


        //使用统一支付接口
        $unifiedOrder = new UnifiedOrder_pub();
        //设置统一支付接口参数
        //设置必填参数
        //appid已填,商户无需重复填写
        //mch_id已填,商户无需重复填写
        //noncestr已填,商户无需重复填写
        //spbill_create_ip已填,商户无需重复填写
        //sign已填,商户无需重复填写
        $body = $wxData["body"];
        $unifiedOrder->setParameter("body", "$body");//商品描述
        //自定义订单号，此处仅作举例
        $timeStamp = time();
        $out_trade_no = $wxData["out_trade_no"] . substr(time(), -6);
        $unifiedOrder->setParameter("out_trade_no", "$out_trade_no");//商户订单号
        $total_fee = $wxData["total_fee"] * 100;
        $unifiedOrder->setParameter("total_fee", "$total_fee");//总金额
        $unifiedOrder->setParameter("notify_url", WxPayConf_pub::NOTIFY_URL);//通知地址
        $unifiedOrder->setParameter("trade_type", "NATIVE");//交易类型
        //非必填参数，商户可根据实际情况选填
        //$unifiedOrder->setParameter("sub_mch_id","XXXX");//子商户号
        //$unifiedOrder->setParameter("device_info","XXXX");//设备号
        //$unifiedOrder->setParameter("attach","XXXX");//附加数据
        //$unifiedOrder->setParameter("time_start","XXXX");//交易起始时间
        //$unifiedOrder->setParameter("time_expire","XXXX");//交易结束时间
        //$unifiedOrder->setParameter("goods_tag","XXXX");//商品标记
        //$unifiedOrder->setParameter("openid","XXXX");//用户标识
        //$unifiedOrder->setParameter("product_id","XXXX");//商品ID

        //获取统一支付接口结果
        $unifiedOrderResult = $unifiedOrder->getResult();

        //商户根据实际情况设置相应的处理流程
        if ($unifiedOrderResult["return_code"] == "FAIL") {
            //商户自行增加处理流程
            //echo "通信出错：".$unifiedOrderResult['return_msg']."<br>";
        } elseif ($unifiedOrderResult["result_code"] == "FAIL") {
            //商户自行增加处理流程
            //echo "错误代码：".$unifiedOrderResult['err_code']."<br>";
            //echo "错误代码描述：".$unifiedOrderResult['err_code_des']."<br>";
        } elseif ($unifiedOrderResult["code_url"] != NULL) {
            //从统一支付接口获取到code_url
            $code_url = $unifiedOrderResult["code_url"];
            Tpl_Smarty::assign("code_url", $code_url);
            //商户自行增加处理流程
            //......
        }
    }
}