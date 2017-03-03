<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no,minimal-ui">
    <link type="text/css" rel="stylesheet" href="css/v1.0/style_public.css">
    <link type="text/css" rel="stylesheet" href="css/wechat.v2.0/booking.css">
    <title>{$order_info['event_info']['title']}[云·Space 活动售票]</title>
</head>
<script>

    function scorepay()
    {
        $.ajax({
            type:'post',
            url:"{$_root}static/api/wechat/ticket/score/pay.json",
            data:{
                ticket_id:{$order_info['order_info']['order_detail'][0]['ticket_id']},
                ticket_num:{$order_info['order_info']['order_detail'][0]['ticket_num']},
                order_no:'{$order_info['order_info']['order_no']}',
                order_price:{$order_info['order_info']['order_price']},
                event_title:'{$order_info['order_info']['event_title']}',
                ticket_name:'{$order_info['ticket_info']['name']}',
                event_time:{$order_info['event_info']['activity_time']}
            },
            success:function(data){
                if(data.status==1){
//                    alert('购票成功');
//                    $(".score_pay").fadeIn().after('<div class="popup_bg"></div>');
                    $(".score_pay").fadeIn()

                }else{
                    alert(data.msg);
                    window.history.go(-1);
                }
            },
            error:function(data){
                alert("请求失败，请重试！");
                window.history.go(-1);
            },
            dataType:'json'

        });
    }

    function yincang()
    {
//        $(".score_pay").remove();
//        $(".popup_bg").fadeOut();
        $(".score_pay").fadeOut();
        window.location.href = "{$_home}event_ticket/order_list";
    }


</script>
<body>
<ul class="booking-nav clearfix">
    <li class="active"><a href="{$_home}event_ticket/event_list">正在售票</a></li>
    <li><a href="{$_home}event_ticket/order_list" style="border: none;">我的门票</a></li>
</ul>
<div class="boki-tobepay-banner boki-banner  clearfix">
    <div class="boki-dtl-img">
        <img src="{$order_info['event_info']['event_logo']|default:'img/wechat.v2.0/tkt_img1.jpg'}">
    </div>
    <div class="boki-tobepay-title">
        <h2>{$order_info['event_info']['title']}</h2>
        <p>单价：{$order_info['ticket_info']['price']}{if $price_is_score==1}积分{else}元{/if}</p>
        <p>数量：{$order_info['order_info']['order_ticket_num']}张</p>
        <p>金额：{$order_info['order_info']['order_price']}{if $price_is_score==1}积分{else}元{/if}</p>
        <p>类型：{$ticket_type[$order_info['event_info']['ticket_type']]}</p>
    </div>
</div>

<!--时间/地点-->
<div class="boki-dtl-timeplace">
    <p>门票使用时间：
        {if $order_info['ticket_info']['event_time']}
            {date("Y.m.d",$order_info['ticket_info']['event_time'])}
        {else}
            {date("Y.m.d",$order_info['event_info']['activity_time'])}--{date("Y.m.d",$order_info['event_info']['activity_end_time'])}
        {/if}
    </p>
    <p style="border: none;">地点：{$order_info['event_info']['addr']}</p>
</div>
<div align="center" id="qrcode">
</div>

{if $price_is_score==1}
    <button class="bg-green booking-btn" onclick="scorepay()" style="border: none">确认购票</button>
{/if}


<!--积分购票成功之后弹出成功购票的弹窗界面-->
<div class="score_pay cover" style="display: none;">
    <div class="score_body">
        <div class="score_body_main">
            <div class="score_body_text">
                <div class="score_title">购票成功</div>
                <p>{$order_info['order_info']['event_title']}</p>
                <p>票名：{$order_info['ticket_info']['name']}</p>
                <p>时间：{date('Y-m-d',$order_info['event_info']['activity_time'])}</p>
                <p>{$order_info['order_info']['order_detail'][0]['ticket_num']}张|总价：{$order_info['order_info']['order_price']}积分</p>
                <p>积分剩余：<span style="color:#FF6633">{$integral-$order_info['order_info']['order_price']}</span>积分</p>
            </div>
            <button class="submit score_submit" onclick="yincang()">确定</button>
        </div>

    </div>
</div>
{*<div class="show"></div>*}
<!--积分购票成功之后弹出成功购票的弹窗界面-->


{*<a href="" class="bg-green booking-btn">立即支付</a>*}
<script src="js/wechat.v2.0/qrcode.js"></script>
<script src="js/v1.0/jquery-1.11.1.min.js"></script>
<script>
    $(document).ready(function () {
        $.ajax({
            type:'post',
            url:"{$_root}static/api/wechat/ticket/get/ticket/stock.json",
            data:{
                ticket_id:{$order_info['order_info']['order_detail'][0]['ticket_id']},
                ticket_num:{$order_info['order_info']['order_detail'][0]['ticket_num']}
            },
            success:function(data){
                if(data.status==1){
                    if('{$code_url}')
                    {
                        var url = '{$code_url}';
                        //参数1表示图像大小，取值范围1-10；参数2表示质量，取值范围'L','M','Q','H'
                        var qr = qrcode(10, 'M');
                        qr.addData(url);
                        qr.make();
                        var wording=document.createElement('p');
                        {if $agent_type =='android'}
                        wording.innerHTML = "请截屏保存二维码，并在微信中打开付款";
                        {else}
                        wording.innerHTML = "长按图片[识别二维码]付款";
                        {/if}
                        var code=document.createElement('DIV');
                        code.innerHTML = qr.createImgTag();
                        var element=document.getElementById("qrcode");
                        element.appendChild(wording);
                        element.appendChild(code);
                    }
                }else{
                    alert(data.msg);
                    window.history.go(-1);
                }
            },
            error:function(data){
//                alert(data.msg);
                alert("请求失败，请重试！");
                window.history.go(-1);
            },
            dataType:'json'
        });
    });
</script>
</body>
</html>