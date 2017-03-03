<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no,minimal-ui">
    <meta name="format-detection" content="telephone=no"/>
    <link type="text/css" rel="stylesheet" href="css/v1.0/style_public.css">
    <link type="text/css" rel="stylesheet" href="css/demand_off.v3.0/quote.css">
    <script src="js/v1.0/jquery-1.11.1.min.js"></script>
    <title>商品报价-【云·SPACE】</title>
    <script src="js/demand_tender.v1.0/demand_tender.js"></script>
</head>
<body>

<!--报价需求列表-->
{include "Web_Mobile_Static::demand_offer.v3.0/inc/inc.head_demand_vendor.tpl"}

{if $demand_offer['status'] < 0}
    <div class="fill-fot-btn clearfix" style="margin-top: 35px;">
        <button class="fr form-sbt bg-orange" style="background-color: #ccc;">报价已结束</button>
    </div>
    <div class="img_quote_end">
        <img src="img/demand_tender.v1.0/img_quote_end.png">
        <p>报价已结束</p>
    </div>
{else}
    <!--填写报价-->
    <div class="filling-tit mg-15">我要报价</div>
    {include "Web_Mobile_Static::demand_offer.v3.0/inc/inc.offer_edit_vendor.tpl"}
    </div>
    <!--filling-cont-wrap-end-->
    {*<div class="fill-fot-btn clearfix">*}
        {*<button class="fr form-sbt bg-orange" onclick="operation.vendorBid()">提交报价</button>*}
    {*</div>*}
    <!--我接受不了/提交报价按钮-->
    <div class="fill-botm-btn clearfix">
    <button class="fl form-btn bg-yellow js-noaccept">我接受不了</button>
    <button class="fr form-btn bg-orange" onclick="operation.vendorBid()">提交报价</button>
    </div>
{/if}
<!--弹窗内容-->
{include "Web_Mobile_Static::demand_offer.v3.0/inc/inc.pop_judge.tpl"}
{*<script>*}
    {*//*}
{*//    <!--当页面加载时弹出-->*}
{*//    window.onload = (function () {*}
{*//*}
{*////        $('.js-pop-mk').show().after('<div class="popup_bg"></div>');*}
{*////        $(".js-pop-mk .p-mk-big").eq(0).show();*}
{*//*}
{*//    });*}
{*</script>*}
{static 'core/yunspace.js'}
{static 'demand_offer.v3.0/demand_offer_operation.js'}
{static 'demand_offer.v3.0/localStorage.js'}
{static "demand_offer.v3.0/pop.js"}


</body>
</html>