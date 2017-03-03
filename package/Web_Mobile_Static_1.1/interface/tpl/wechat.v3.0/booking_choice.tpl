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
<div class="tkt-choice-title">
    <h2>小王子文化艺术展</h2>
    <div>上海大悦城3楼</div>
    <p class="bdt-p"><img src="img/wechat.v2.0/boki_icon-tk.png">实体票</p>
</div>

<!--邮寄地址-->
<dl class="boki-adress boki-adress-choice hide">
    <dd class="clearfix">
        <a href="adress4" class="clearfix">
            <div class="cont-text clearfix">
                <p><span class="fl">颜颜</span><span class="fr">13788545625</span></p>
                <p class="gray">上海上海市长宁区虹桥街道淮海西
                    路570号红坊创意园F211（近民生美术...</p>
            </div>
            <span class="adress-fix" href="javascript:;"><img src="img/wechat.v2.0/boki_icon-in.png"></span>
        </a>
    </dd>
</dl>
<!--新建收货地址-->
<dl class="boki-adress boki-setnew-adress">
    <dd class="clearfix">
        <a href="adress3" class="clearfix">
            <div class="cont-text clearfix">
                <p><span>新建收货地址</span></p>
                <p class="gray">您还没有设置收货地址，请点击这里设置！</p>
            </div>
        </a>
    </dd>
</dl>

<div class="tkt-choice-time choice-list">
    <div class="tit">选择时间</div>
    <div class="choice-time-one"><img src="img/wechat.v2.0/boki_icon-date.png"><span>2015.08.03 - 2015.10.09</span></div>
    <ul class="clearfix hide">
        <li class="active">2015.08.03</li>
        <li>2015.08.03</li>
        <li>2015.08.03</li>
        <li>2015.08.03</li>
        <li>2015.08.03</li>
        <li>2015.08.03</li>
        <li class="hasno">2015.08.03</li>
        <li>2015.08.03</li>
        <li>2015.08.03</li>
    </ul>
</div>

<div class="tkt-choice-price choice-list">
    <div class="tit">选择票价</div>
    <ul class="clearfix">
        <li class="active" date-stock="20">198</li>
        <li>298</li>
        <li>398</li>
        <li class="hasno">598</li>
        <li>598</li>
    </ul>
</div>

<div class="tkt-choice-num clearfix">
    <h2>购票数量</h2>
    <div class="tkt-numb-count clearfix">
        <a class="fl btn-rd-ad btn-reduce js-btn-reduce" href="javascript:;"  >-</a>
        <input class="fl buy-num js-buy-num" type="text" value="0" data-value="198">
        <a class="fr btn-rd-ad btn-add js-btn-add" href="javascript:;" ">+</a>
    </div>
</div>

<div class="tkt-total-money fr">
    总价：<span class="js-total-money">0</span>元
</div>

<a href="tobepay" class="bg-green booking-btn">下一步</a>

<script src="js/v1.0/jquery-1.11.1.min.js"></script>
<script src="js/wechat.v2.0/ticket.js"></script>
</body>
</html>