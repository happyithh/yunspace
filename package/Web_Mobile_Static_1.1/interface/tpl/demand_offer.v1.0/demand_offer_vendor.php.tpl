<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no,minimal-ui">
    <meta name="format-detection" content="telephone=no"/>
    <link type="text/css" rel="stylesheet" href="css/v1.0/style_public.css">
    <link type="text/css" rel="stylesheet" href="css/demand_off.v1.0/quote.css">
    <script src="js/v1.0/jquery-1.11.1.min.js"></script>
    <title>活动推荐-【云·SPACE】</title>
</head>
<body>
<!--报价需求列表-->
{include "Web_Mobile_Static::demand_offer.v1.0/inc/inc.head_demand.tpl"}

<!--我收到的报价-->
<div class="filling-tit">我的报价</div>

<!--报价详情-->
{*<ul class="quote-needs-details">*}
    {*<li>*}
        {*<div class="quote-needs-tit clearfix">*}
            {*<h3 class="fl" style="padding-left: 16px;">已报价</h3>*}

            {*<p class="fr"><span>{$data['offer_time']}</span></p>*}
        {*</div>*}
        {*<div class="quote-needs-cont clearfix">*}
            {*<div class="img">*}
                {*<img src="{Page_Site_Global::displayMedia($item['logo'],200,200)}">*}

                {*<p><span>￥{$data['offer_price']}</span></p>*}
            {*</div>*}
            {*<div class="cont">*}
                {*<h2>{$item['item_name']}</h2>*}

                {*<p><img src="img/demand_tender.v1.0/icon_01.png">城市：{$item['city']}</p>*}

                {*<p><img src="img/demand_tender.v1.0/icon_02.png">地址：{$item['addr']}</p>*}

                {*<p><img src="img/demand_tender.v1.0/icon_03.png">面积：{$item['size']}㎡</p>*}
            {*</div>*}
            {*<p class="remarks quote-p"><span class="tit">其他备注：</span><span class="ct">*}
                    {*{$data['offer_info']['其他备注']}*}
            {*</span>*}
            {*</p>*}
        {*</div>*}
        {*<div class="contact-sj-btn">*}
        {*<input type="submit" value="点击获得商家联系方式">*}
        {*</div>*}
        {*<div class="contact-sj">*}
            {*<p class="numb">联系商家：<span>{$data['offer_info']['联系人']} - {$data['offer_info']['联系电话']}</span></p>*}
        {*</div>*}
    {*</li>*}
{*</ul>*}
<ul class="quote-needs-details">

            <li>
                <a href="{$_root}m/baike/{$item['space_name']}" target="_blank" style="overflow: auto;color: #000">
                <div class="quote-needs-cont clearfix">
                        <div class="time">报价时间：<span>{$data['offer_time']}</span></div>
                        <div class="img">
                            <img src="{Page_Site_Global::displayMedia($item['logo'],200,200)}">
                        </div>
                        <div class="cont">
                            <h2><a href="{$_root}m/baike/{$item['space_name']}">{$item['item_name']}</a></h2>

                            <p><img src="img/demand_tender.v1.0/icon_01.png">城市：{$item['city']}</p>

                            <p style="white-space: normal;overflow: hidden;text-overflow: ellipsis;"><img src="img/demand_tender.v1.0/icon_02.png">地址：{$item['addr']}</p>

                            <p><img src="img/demand_tender.v1.0/icon_03.png">面积：{$item['size']}㎡</p>

                            <p class="price">￥<span>{$data['offer_price']}</span></p>
                        </div>

                        <p class="remarks quote-p"><span class="tit">其他备注：</span><span class="ct">
                            {$data['offer_info']['其他备注']}
                    </span></p>
                    </div>
                    <div class="contact-sj">
                        <p class="numb">联系人：<span>{$data['offer_info']['联系人']}-{$data['offer_info']['联系电话']}</span>
                        </p>
                    </div>
                    </a>
            </li>

</ul>
{if $data['change_phone_time']}
    <!--客户已确认-->
    <div class="hv-confirmation contact-sj ">
        <p class="numb">客户已接受：<span>{$demand_offer['demand']['联系人']}-{$demand_offer['demand']['联系电话']} </span></p>
        <a class="icon-phone" href="tel:{$demand_offer['demand']['联系电话']}"><img
                    src="img/demand_tender.v1.0/icon-phone-org.png"></a>
    </div>
{else}
    <!--客户待确认-->
    <div class="wait-confirmation "><img src="img/demand_tender.v1.0/icon_quote_time.png">等待需求方确认</div>
{/if}
</body>
</html>