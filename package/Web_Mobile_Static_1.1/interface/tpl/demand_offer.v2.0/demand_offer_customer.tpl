<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no,minimal-ui">
    <meta name="format-detection" content="telephone=no" />
    <link type="text/css" rel="stylesheet" href="css/v1.0/style_public.css">
    <link type="text/css" rel="stylesheet" href="css/demand_off.v2.0/quote.css">
    <script src="js/v1.0/jquery-1.11.1.min.js"></script>
    <script src="js/demand_offer.v2.0/pop.js"></script>
    <script src="js/demand_tender.v1.0/demand_tender.js"></script>
    {*<script>*}
        {*<!--当页面加载时弹出-->*}
        {*window.onload=(function(){*}
        {*$('.js-pop-judge').show().after('<div class="popup_bg"></div>');*}
        {*});*}
    {*</script>*}
</head>
<body>
<!--报价需求列表-->
<div class="quote-title clearfix">
    <p class="fl state">询价中</p>
    {*<p class="fl state">报价已结束</p>*}
    <a class="fr end-quote js-endquote" href="JavaScript:;">结束报价</a>
</div>
<div class="quote-needs-list bd-tpbm quote-p clearfix">
    <div class="demand-tit clearfix">
        <p class="fl time">提交时间：2015.07.28 17:08:02</p>
        <p class="fr code">NO.123456</p>
    </div>
    <a href="my" class="edit hide"><span></span>修改</a>
    <p><span class="tit">活动人数：</span><span class="ct">50-100人</span></p>
    <p><span class="tit">活动档期：</span><span class="ct">2015.07.28-2015.07.31</span></p>
    <p><span class="tit">活动预算：</span><span class="ct">￥50000-￥50000</span></p>
    <div class="list-hide hide">
        <p><span class="tit">活动城市：</span><span class="ct">上海</span></p>
        <p><span class="tit">活动类型：</span><span class="ct">发布会</span></p>
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
        <p><span class="tit">具体要求：</span><span class="ct">大方大方大方大方大方大方大方大方大方大方大方大方大方大方大方大方大方大方大方大方大方大方大方大方大方大方大方大方大方大方</span></p>
    </div>
    <div class="slide-onoff js-slide-onoff">展开</div>
</div>

<!--报价详情-->
<div class="quote-needs-tit">
    <h1>我收到的场地报价(共2份)</h1>
</div>
<ul class="quote-needs-details quote-cust">
    <li>
        <div class="quote-needs-cont clearfix">
            <div class="li-tit clearfix">
                <div class="fl index">第<span>1</span>份</div>
                <div class="fr time">报价时间：<span>2015.07.29 13:00</span></div>
            </div>

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
        <div class="contact-sj-btn">
            <input class="js-getnumb" type="submit" value="点击获得商家联系方式">
        </div>
    </li>

    <li>
        <div class="quote-needs-cont clearfix">
            <div class="li-tit clearfix">
                <div class="fl index">第<span>2</span>份</div>
                <div class="fr time">报价时间：<span>2015.07.29 13:00</span></div>
            </div>
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
    <div class="fl head-name">郭安（客服）</div>
    <a href="javascript:;" class="fr contact js-phone">联系他</a>
</div>

<!--确认并获取商家联系方式-->
<div class="demand-popup js-pop-cont hide">
    <div class="popup-exchange-ph popup-btn">
        <p class="quote-bg-wrt">合作事宜请与商家联系，<br>
            云·space不参与具体沟通。</p>
        <input class="quote-bg-wrt js-confirm confirm" type="submit" value="确认获取联系方式">
        <a class="quote-bg-wrt js-cancel cancel" href="javascript:;">取消</a>
    </div>
    <div class="end-quote">

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
{include "Web_Mobile_Static::demand_off.v2.0/inc/inc.pop_judge.tpl"}
{include "Web_Mobile_Static::demand_offer.v2.0/inc/inc.customer_pop.tpl"}
</body>
</html>