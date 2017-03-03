<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no,minimal-ui">
    <meta name="format-detection" content="telephone=no"/>
    <link type="text/css" rel="stylesheet" href="css/v1.0/style_public.css">
    <link type="text/css" rel="stylesheet" href="css/demand_tender.v1.0/quote.css">
    <script src="js/v1.0/jquery-1.11.1.min.js"></script>
    <script src="js/demand_tender.v1.0/demand_tender.js"></script>
</head>
<body>

<!--报价需求列表-->
{include "Web_Mobile_Static::demand_tender.v1.0/inc/inc.head_demand.tpl"}

<!--我收到的报价-->
<div class="filling-tit">我的报价</div>

<!--报价详情-->
<ul class="quote-needs-details">
    <li>
        <div class="quote-needs-tit clearfix">
            <h3 class="fl">已报价</h3>

            <p class="fr">报价时间：<span>{$scheme['create_time']}</span></p>
        </div>

        <div class="quote-needs-cont clearfix">
            <div class="img">
                <img src="{Page_Site_Global::displayMedia($scheme['product_logo'],200,200)}">

                <p><span>￥{$scheme['quote']}</span></p>
            </div>
            <div class="cont">
                <h2> {$scheme['product_name']}</h2>

                <p><img src="img/demand_tender.v1.0/icon_01.png">城市：{$scheme['attr_index'][46]}</p>

                <p><img src="img/demand_tender.v1.0/icon_02.png">地址：{$scheme['product_addr']}</p>

                {if $scheme['product_size']}
                    <p><img src="img/demand_tender.v1.0/icon_03.png">面积：{$scheme['product_size']}m²</p>
                {/if}
            </div>
            {if $scheme['scheme']['其他备注']}
                <p class="remarks quote-p">
                    <span class="tit">其他备注：</span><span class="ct">
                           {$scheme['scheme']['其他备注']}
                        </span></p>
            {/if}
        </div>
        <div class="contact-sj">
            <p class="numb">联系人：<span>{$scheme['scheme']['联系人']} {$scheme['scheme']['联系电话']}</span></p>
        </div>
    </li>
</ul>
{if $scheme['status'] <0 }
    <!--客户待确认-->
    <div class="wait-confirmation">需求方已结束</div>
{elseif $scheme['status']==0}
    <!--客户待确认-->
    <div class="wait-confirmation"><img src="img/demand_tender.v1.0/icon_quote_time.png">等待需求方确认</div>
{else}
    <!--客户已确认-->
    <div class="hv-confirmation contact-sj">
        <p class="numb">客户已接受：<span>{$demand_tender['demand']['联系人']} {$demand_tender['demand']['联系电话']}</span></p>
        <a class="icon-phone js-call-phone" href="javascript:void(0)" data-type="1" data-tel="{$demand_tender['demand']['联系电话']}">
            <img src="img/demand_tender.v1.0/icon-phone-org.png"></a>
    </div>
{/if}

{static 'core/yunspace.js'}
</body>
</html>