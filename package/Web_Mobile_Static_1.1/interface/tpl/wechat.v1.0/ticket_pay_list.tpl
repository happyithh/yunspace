<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no,minimal-ui">
    <link type="text/css" rel="stylesheet" href="css/wechat.v1.0/ticket.css">
    <link type="text/css" rel="stylesheet" href="css/v1.0/global.css">
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
<div class="ticket-pdg15-container">
    <div class="ticket-pay-title">
        <h2>您已经选购:{$order_info['event_title']}</h2>
    </div>
    <ul class="ticket-pay-list clearfix">
        {foreach $order_info['order_detail'] as $k=>$v}
        <li class="clearfix">
            <p class="ticket-list-p"><span class="ticket-name">{$v['ticket_name']}：</span><span class="ticket-price fr">¥{$v['ticket_price']}</span></p>

            <p class="fr">x{$v['ticket_num']}</p>
        </li>
        {/foreach}
    </ul>
    <div class="ticket-pay-num clearfix">
        <p class="fl">价格总计</p>
        <p class="fr col-magenta">￥{$order_info['order_price']}</p>
    </div>
    <div class="pay-btn-wrap">
        <button class="ticket-btn-pay btn-col-magenta" onclick="callpay()">立即支付</button>
    </div>
</div>
</body>
</html>