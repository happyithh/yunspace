<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no,minimal-ui">
    <meta name="format-detection" content="telephone=no"/>
    <link type="text/css" rel="stylesheet" href="css/v1.0/style_public.css">
    <link type="text/css" rel="stylesheet" href="css/wechat.v3.0/booking_new.css">
    <title>{$event_info['title']}[云·Space 活动售票]</title>
</head>
<body>
<div class="boki-ck-banner boki-banner clearfix">
    <div class="boki-dtl-img">
        <img src="img/wechat.v2.0/tkt_img1.jpg">
    </div>
    <div class="boki-tobepay-title">
        <h2>小王子文化艺术展小王子文化艺术展</h2>
        <p>单价：198.00元</p>
        <p>数量：1张</p>
        <p>金额：198.00元</p>
        <p>类型：实体票</p>
    </div>
</div>

<!--时间/地点-->
<div class="ck-timeplace">
    <p>时间：2014.12.05</p>
    <p style="border: none;">地点：上海大悦城3楼</p>
</div>

<!--收货信息-->
<div class="ck-part">
    <div class="tit">收货信息</div>
    <div class="ck-part-tkt ck-receiv-msg">
        <p><span>姓名：</span>12345678</p>
        <p><span>电话：</span>13788989606</p>
        <p><span>地址：</span>上海市长宁区淮海中路红坊创意园F211
            近民生美术馆</p>
        <p class="logistic-state hide"><span>物流状态：</span><span class="magenta">未寄出</span></p>

        <p class="logistic-state"><span>物流状态：</span><span class="magenta">已寄出</span></p>
        <p><span>物流来源：</span>中通快递</p>
        <p class="p-hvcopy"><span>物流单号：</span>25654646545565<button class="js-btn-copy" onclick="showhide()">点击复制</button></p>
    </div>
</div>

<!--订单信息-->
<div class="ck-part">
    <div class="tit">订单信息</div>
    <div class="ck-part-tkt">
        <p>订单编号：12345678</p>
        <p>下单时间：2015-08-05  12:00</p>
        <p>订单状态：<span class="magenta">已取消</span></p>
    </div>
</div>

<div class="popup-copy">
    <p>复制成功</p>
</div>
<script src="js/v1.0/jquery-1.11.1.min.js"></script>
<script src="js/wechat.v2.0/booking.js"></script>
</body>
</html>