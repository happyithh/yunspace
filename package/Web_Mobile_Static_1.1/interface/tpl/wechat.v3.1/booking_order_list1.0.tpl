<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no,minimal-ui">
    <link type="text/css" rel="stylesheet" href="css/v1.0/style_public.css">
    <link type="text/css" rel="stylesheet" href="css/wechat.v2.0/booking.css">
    <link type="text/css" rel="stylesheet" href="css/wechat.v3.0/booking_new.css">
    <title>{$order_info['event_info']['title']}[云·Space 活动售票]</title>
</head>
<body>
<div class="boki-ck-banner boki-banner clearfix">
    <div class="boki-dtl-img">
        <img src="{$order_info['event_info']['event_logo']|default:'img/wechat.v2.0/tkt_img1.jpg'}">
    </div>
    <div class="boki-tobepay-title">
        <h2>{$order_info['event_info']['title']}</h2>
        <p>票名：{$order_info['ticket_info']['name']}</p>
        <p>单价：{$order_info['ticket_info']['price']}{if $price_is_score==1}积分{else}元{/if}</p>
        <p>数量：{$order_info['order_info']['order_ticket_num']}张</p>
        <p>金额：{$order_info['order_info']['order_price']}{if $price_is_score==1}积分{else}元{/if}</p>
        <p>类型：{$ticket_type[$order_info['event_info']['ticket_type']]}</p>
    </div>
</div>
<!--时间/地点-->
<div class="ck-timeplace">
    <p>门票使用时间：{date("Y.m.d",$order_info['ticket_list'][0]['use_time'])}</p>
    <p style="border: none;">地点：{$order_info['event_info']['addr']}</p>
</div>

<!--收货信息-->
{if $order_info['event_info']['ticket_type']==1 }
<div class="ck-part">
    <div class="tit">收货信息</div>
    <div class="ck-part-tkt ck-receiv-msg">
        <p><span>姓名：</span>{$order_info['order_info']['addressInfo']['name']}</p>
        <p><span>电话：</span>{$order_info['order_info']['addressInfo']['phone']}</p>
        <p><span>地址：</span>{$order_info['order_info']['addressInfo']['address_content']}</p>
        <!-- 物流信息 -->
        {if !empty($order_info['order_info']['logisticsInfo'])}
        {*<p class="logistic-state hide"><span>物流状态：</span><span class="magenta">{$order_info['order_info']['logisticsInfo']['status']}</span></p>*}

        <p class="logistic-state"><span>物流状态：</span><span class="magenta">{if $order_info['order_info']['logisticsInfo']['status']==1}已寄出{else}未寄出{/if}</span></p>
        <p><span>物流来源：</span>{$order_info['order_info']['logisticsInfo']['name']}</p>
        <p class="p-hvcopy"><span>物流单号：</span>{$order_info['order_info']['logisticsInfo']['order_no']}
            {*<button class="js-btn-copy" onclick="showhide(this)">点击复制</button>*}
        </p>
        {else}
            <p class="logistic-state"><span>物流状态：</span><span class="magenta">未寄出（正在处理中^_^）</span></p>
       {/if}
    </div>
</div>
    {*<div class="popup-copy">*}
        {*<p>复制成功</p>*}
    {*</div>*}
{/if}

<!--电子票信息-->
{if $order_info['event_info']['ticket_type']==0}
<div class="ck-part">
    <div class="tit">电子票信息</div>
    {if $order_info['event_info']['id']==30}<p>本活动需要填写报名信息，<a href="{$_home}event_ticket/show_lupao_form" style="padding-left: 5px;" >点击填写报名表</a></p>{/if}
    {foreach $order_info['ticket_list'] as $k=>$v}
    <div class="ck-part-tkt ck_ticket_code">
        <p class="clearfix"><span class="fl">门票编号：{$v['ticket_num']}</span><span class="fr state">{if $v['status']==0}未使用{else}已使用{/if}</span></p>
        <input type="hidden" name="codeurl"
               value="http://{Core::$urls['host']}{$_home}ticket/checkticket?action=tickeinfo&type=code&ticket_num={$v['ticket_num']}">
        <div class="p-code" style="margin-top: 10px;"><span style="float: left;">电子二维码：</span>
            {*<span class="qr-code">*}
                {*<div id="qrcode{$k+1}">*}
                {*</div>*}
                {*<img src="img/wechat.v2.0/tkt_code.png" >*}
            {*</span>*}
                <div class="code-img">
                    <div id="qrcode{$k+1}">
                    </div>
                </div>
        </div>
        {*<div class="code-img">*}
            {*<div id="qrcode{$k+1}">*}
            {*</div>*}
        {*</div>*}
    </div>
    {/foreach}
    {*<div class="ck-part-tkt">*}
        {*<p class="clearfix"><span class="fl">订单编号：12345678</span><span class="fr state">未使用</span></p>*}
        {*<p>电子二维码：<span class="qr-code"><img src="img/wechat.v2.0/tkt_code.png" ></span></p>*}
    {*</div>*}
    {*<div class="ck-part-tkt">*}
        {*<p class="clearfix"><span class="fl">订单编号：12345678</span><span class="fr state">未使用</span></p>*}
        {*<p>电子二维码：<span class="qr-code"><img src="img/wechat.v2.0/tkt_code.png" ></span></p>*}
    {*</div>*}
</div>
{/if}
<!--订单信息-->
<div class="ck-part">
    <div class="tit">订单信息</div>
    <div class="ck-part-tkt">
        <p>订单编号：{$order_info['order_info']['order_no']}</p>
        <p>下单时间：{date("Y-m-d H:i:s",$order_info['order_info']['create_time'])}</p>
        <p>订单状态：<span class="magenta">
                {if $order_info['order_info']['order_status']==1 && $order_info['event_info']['ticket_type']==1 }
                   已付款
                    {/if}
                {if $order_info['order_info']['order_status']==2}
                    未使用
                {/if}
                {if $order_info['order_info']['order_status']==3}
                    已使用
                {/if}
                {if $order_info['order_info']['order_status']==-1}
                    已取消
                {/if}
        </span></p>
    </div>
</div>
<script src="js/v1.0/jquery-1.11.1.min.js"></script>
<script src="js/wechat.v2.0/booking.js"></script>
<script src="js/v1.0/ZeroClipboard.js"></script>
<script type="text/javascript" src="js/wechat.v1.0/Jquery.qrcode.js"></script>
<script type="text/javascript">
    $(document).ready(function () {
        $("div.ck_ticket_code").each(function () {
            var codeurl = $(this).find('input').val();
            var codeid = $(this).find('div.code-img').find('div').attr('id');
            createQrCode(codeurl, codeid);
        });
    });
    function createQrCode(text, codeid) {
        var qrsize = $('#' + codeid);
        console.log(text, codeid, $('#' + codeid + ' canvas').length);
        if ($('#' + codeid + ' canvas').length > 0) {
            return false;
        }
        //生成二维码
        qrsize.qrcode({
            // logoSrc		: '{$_assets}images/up.png',			//水印图片A
            //logoBgProp	: 0.2,				//水印大小 按图片比例
            text: text,		//扫描出的名称
            //	url			:"";
            width: 120,	//二维码宽度
            height: 120,	//二维码高度
            correctLevel: QRErrorCorrectLevel.M,
            background: "#ffffff",		//二维码第一种颜色
            foreground: "#000000"			//二维码第二种颜色
        });
        qrsize.children().css({
            'background': '#fff'
        });	//设置阴影
    }




</script>

</body>
</html>