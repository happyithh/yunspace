<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no,minimal-ui">
    <meta name="format-detection" content="telephone=no" />
    <link type="text/css" rel="stylesheet" href="css/v1.0/style_public.css">
    <link type="text/css" rel="stylesheet" href="css/demand_off.v1.0/quote.css">
    <script src="js/v1.0/jquery-1.11.1.min.js"></script>
    <script src="js/demand_tender.v1.0/pop.js"></script>
    {*<script>*}
        {*<!--当页面加载时弹出-->*}
        {*window.onload=(function(){*}
        {*$('.js-pop-judge').show().after('<div class="popup_bg"></div>');*}
        {*});*}
    {*</script>*}
</head>
<body>
<!--报价需求列表-->
<div class="quote-needs-list bd-tpbm quote-p clearfix">
    <div class="demand-tit">
        <div class="numb clearfix">
            <h5>No.1118698</h5>
            <a href="" class="edit"><span></span>编辑</a>
        </div>
        <h3>(Z**,手机号：131****8798)</h3>
        <p>提交时间：2015.07.28 17:08:02</p>
    </div>
    <p><span class="tit">活动城市：</span><span class="ct">上海</span></p>
    <p><span class="tit">活动类型：</span><span class="ct">发布会</span></p>
    <p><span class="tit">活动档期：</span><span class="ct">一个，2015.07.28-2015.07.31</span></p>
    <p><span class="tit">活动人数：</span><span class="ct">50-100人</span></p>
    <p><span class="tit">活动预算：</span><span class="ct">￥50000-￥50000</span></p>
    <p><span class="tit">活动标签：</span>
        <span class="ct">
            <span class="bq">文化娱乐</span>
            <span class="bq">露天广场</span>
            <span class="bq">文化娱乐</span>
            <span class="bq">露天广场</span>
            <span class="bq">文化娱乐</span>
            <span class="bq">露天广场</span>
        </span>
    </p>
    <!--报价数量-->
    <div class="quote-numbs">
        <p>
            <img src="img/demand_tender.v1.0/icon_quote_numbs.png">
            <span>您已收到1份场地报价</span>
        </p>
    </div>
</div>

<!--报价详情-->
<ul class="quote-needs-details">
    <div class="quote-needs-tit">
        <h1>我收到的场地报价</h1>
    </div>
    <li>
        <div class="quote-needs-cont clearfix">
            <div class="time">报价时间：<span>2015.07.29 13:00</span></div>
            <div class="img">
                <img src="">
            </div>
            <div class="cont">
                <h2><a href="">奢居会-8楼露台</a></h2>
                <p><img src="img/demand_tender.v1.0/icon_01.png">城市：上海-长宁区</p>
                <p><img src="img/demand_tender.v1.0/icon_02.png">地址：淮海西路8888号</p>
                <p><img src="img/demand_tender.v1.0/icon_03.png">面积：300㎡</p>
                <p class="price">￥<span>5,888</span></p>
            </div>
            <p class="remarks quote-p"><span class="tit">其他备注：</span><span class="ct">水电费反反复复凤飞飞凤飞飞凤飞飞凤飞飞凤飞飞凤飞飞凤飞飞凤飞飞凤飞飞凤飞飞dddddddddddddddv</span></p>
            <p class="remarks quote-p">
                <span class="tit">该场地不符合：</span>
                <span class="bq">ssdgaskg</span>
                <span class="bq">标签标签</span>
                <span class="bq">标签标签</span>
                <span class="bq">ssdgaskg</span>
                <span class="bq">标签标签</span>
                <span class="bq">标签标签</span>
            </p>
        </div>
        <div class="contact-sj-btn">
            <input class="js-getnumb" type="submit" value="点击获得商家联系方式">
        </div>
    </li>

    <li>
        <div class="quote-needs-cont clearfix">
            <div class="time">报价时间：<span>2015.07.29 13:00</span></div>
            <div class="img">
                <img src="">
            </div>
            <div class="cont">
                <h2><a href="">奢居会-8楼露台</a></h2>
                <p><img src="img/demand_tender.v1.0/icon_01.png">城市：上海-长宁区</p>
                <p><img src="img/demand_tender.v1.0/icon_02.png">地址：淮海西路8888号</p>
                <p><img src="img/demand_tender.v1.0/icon_03.png">面积：300㎡</p>
                <p class="price">￥<span>5,888</span></p>
            </div>
            <p class="remarks quote-p"><span class="tit">其他备注：</span><span class="ct">水电费反反复复凤飞飞凤飞飞凤飞飞凤飞飞凤飞飞凤飞飞凤飞飞凤飞飞凤飞飞凤飞飞dddddddddddddddv</span></p>
        </div>
        <div class="contact-sj">
            <p class="numb">联系商家：<span>颜颜 13788989606</span></p>
            <a class="icon-phone" href=""><img src="img/demand_tender.v1.0/icon-phone-org.png"></a>
        </div>
    </li>
</ul>

<div class="quote-btn">
    <a href="javascript:;" class="end-quote clearfix">
        <span class="fl phone">客服电话</span>
        <span class="fr icon-right"></span>
    </a>
</div>

<!--确认并获取商家联系方式-->
<div class="demand-popup js-pop-cont hide">
    <div class="popup-exchange-ph popup-btn">
        <p class="quote-bg-wrt">云·SPACE为您快速匹配到合适的场地并提供报价，请双方自行洽谈合作事宜。云·SPACE对双方沟通结果不予负责</p>
        <input class="quote-bg-wrt js-confirm confirm" type="submit" value="确认并获取商家联系方式">
        <a class="quote-bg-wrt js-cancel cancel" href="javascript:;">取消</a>
    </div>
</div>

{*<!--温馨提示按钮-->*}
{*<div class="reminder-btn js-rem ">*}
    {*<span class="icon icon-rem"></span>*}
    {*<p>温馨提示</p>*}
{*</div>*}

<!--已关闭按钮-->
{*<div class="reminder-btn js-icon-close">*}
    {*<span class="icon icon-close"></span>*}
    {*<p>已关闭</p>*}
{*</div>*}

<!--询价中按钮-->
<div class="reminder-btn js-inq">
    <span class="icon icon-inq"></span>
    <p>询价中</p>
</div>

<!--弹窗内容-->
{include "Web_Mobile_Static::demand_off.v1.0/inc/inc.pop_judge.tpl"}
</body>
</html>