<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no,minimal-ui">
    <meta name="format-detection" content="telephone=no" />
    <link type="text/css" rel="stylesheet" href="css/v1.0/style_public.css">
    <link type="text/css" rel="stylesheet" href="css/demand_off.v3.0/quote.css">
    <script src="js/v1.0/jquery-1.11.1.min.js"></script>
    <script src="js/demand_offer.v3.0/pop.js"></script>
    <script src="js/demand_tender.v1.0/demand_tender.js"></script>
</head>
<body>
<!--报价需求列表-->
<div class="quote-title clearfix">
    <p class="fl state"><i class="fl icon-c icon-xjz"></i><span class="fl">询价中（咨询）</span></p>
    <a class="fr end-quote js-endquote" href="JavaScript:;">结束报价</a>
</div>
<div class="quote-needs-list bd-tpbm quote-p clearfix">
    <div class="demand-tit clearfix">
        <p class="fl time">提交时间：2015.07.28 17:08:02</p>
        <p class="fr code">NO.123456</p>
    </div>
    <p><span class="tit">活动档期：</span><span class="ct">2015.07.28-2015.07.31</span></p>
    <p><span class="tit">具体要求：</span><span class="ct">大方大方大方大方大方大方大方大方大方大方大方大方大方大方大方大方大方大方大方大方大方大方大方大方大方大方大方大方大方大方</span></p>
</div>

<!--报价详情-->
<div class="quote-needs-tit">
    <h2>咨询的场地</h2>
</div>
<ul class="quote-needs-details">
    <li>
        <div class="quote-needs-cont clearfix">
            <div class="li-tit clearfix">
                <div class="fl time">报价时间：<span>2015.07.29 13:00</span></div>
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
        </div>
        <div class="contact-yijia">
            <h6 class="chaoshi-hint">商家无法接单</h6>
            <p class="clearfix">拒绝原因：档期已被其他人预定了，不好意思。</p>
        </div>
    </li>
</ul>

<div class="filling-tit">推荐的场地</div>
<div class="quote-needs-cont inquiry-xjz quote-cust clearfix">
    <div class="img">
        <img src="">
    </div>
    <div class="cont">
        <h2><a href="">奢居会-8楼露台</a></h2>
        <p><img src="img/demand_tender.v1.0/icon_01.png">城市：上海-长宁区</p>
        <p><img src="img/demand_tender.v1.0/icon_02.png">地址：淮海西路8888号</p>
        <p><img src="img/demand_tender.v1.0/icon_03.png">面积：300㎡</p>
    </div>
    <p class="remarks quote-p"><span class="tit">其他备注：</span><span class="ct">水电费反反复复凤飞飞凤飞飞凤飞飞凤飞飞凤飞飞凤飞飞凤飞飞凤飞飞凤飞飞凤飞飞dddddddddddddddv</span></p>
</div>

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
{*<div class="reminder-btn js-inq">*}
    {*<span class="icon icon-inq"></span>*}
    {*<p>询价中</p>*}
{*</div>*}

<!--弹窗内容-->
{include "Web_Mobile_Static::demand_off.v3.0/inc/inc.pop_judge.tpl"}
{include "Web_Mobile_Static::demand_offer.v3.0/inc/inc.customer_pop.tpl"}
</body>
</html>