<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no,minimal-ui">
    <link type="text/css" rel="stylesheet" href="css/v1.0/style_public.css">
    <link type="text/css" rel="stylesheet" href="css/wechat.v2.0/booking.css">
    <title>{$event_info['title']}[云·Space 活动售票]</title>
</head>
<body>
<div class="tkt-choice-title">
    <h2>小王子文化艺术展</h2>
    <p>上海大悦城3楼</p>
</div>

<div class="tkt-choice-time choice-list">
    <div class="tit">选择时间</div>
    <ul class="clearfix">
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