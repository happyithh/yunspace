<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no,minimal-ui">
    <link type="text/css" rel="stylesheet" href="css/v1.0/style_public.css">
    <link type="text/css" rel="stylesheet" href="css/wechat.v2.0/booking.css">
    <title>{$order_info['event_info']['title']}[云·Space 活动售票]</title>
</head>
<script type="text/javascript">
    //调用微信JS api 支付
    function jsApiCall()
    {
        WeixinJSBridge.invoke(
                'getBrandWCPayRequest',
                {$jsApiParameters},
                function(res){
                    WeixinJSBridge.log(res.err_msg);
                    if(res.err_msg == "get_brand_wcpay_request:ok"){
                        window.location.href='{$loactionurl}';
                    }else{
                        //返回跳转到订单详情页面
                        alert('支付失败');
                        window.location.href='{$loactionurl}';
                    }
                    //alert(res.err_code+'|'+res.err_desc+'|'+res.err_msg);
                    //	console.log(res.err_code+res.err_desc+res.err_msg);
                }
        );
    }

    function callpay()
    {
        if (typeof WeixinJSBridge == "undefined"){
            if( document.addEventListener ){
                document.addEventListener('WeixinJSBridgeReady', jsApiCall, false);
            }else if (document.attachEvent){
                document.attachEvent('WeixinJSBridgeReady', jsApiCall);
                document.attachEvent('onWeixinJSBridgeReady', jsApiCall);
            }
        }else{
            jsApiCall();
        }
    }
</script>
<body>
<ul class="booking-nav clearfix">
    <li class="active"><a href="{$_home}event_ticket/event_list">正在售票</a></li>
    <li><a href="{$_home}event_ticket/order_list" style="border: none;">我的门票</a></li>
</ul>
<div class="boki-tobepay-banner boki-banner">
    <div class="boki-dtl-img">
        <img src="{$order_info['event_info']['event_logo']|default:'img/wechat.v2.0/tkt_img1.jpg'}">
    </div>
    <div class="boki-tobepay-title">
        <h2>{$order_info['event_info']['title']}</h2>
        <p>单价：{$order_info['ticket_info']['price']}元</p>
        <p>数量：{$order_info['order_info']['order_ticket_num']}张</p>
        <p>金额：{$order_info['order_info']['order_price']}元</p>
        <p>类型：{$ticket_type[$order_info['event_info']['ticket_type']]}</p>
    </div>
</div>

<!--时间/地点-->
<div class="boki-dtl-timeplace">
    <p>时间：{date("Y.m.d",$order_info['event_info']['activity_time'])}</p>
    <p style="border: none;">地点：{$order_info['event_info']['addr']}</p>
</div>

    <button class="bg-green booking-btn" onclick="callpay()" style="border: none">立即支付</button>
{*<a href="" class="bg-green booking-btn">立即支付</a>*}

</body>
</html>