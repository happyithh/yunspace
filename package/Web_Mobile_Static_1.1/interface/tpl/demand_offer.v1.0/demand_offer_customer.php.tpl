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
    <title>活动报价-【云·SPACE】</title>

</head>
<body>
<!--报价需求列表-->
{include "Web_Mobile_Static::demand_offer.v1.0/inc/inc.head_demand.tpl"}

<!--报价列表-->
{include "Web_Mobile_Static::demand_offer.v1.0/inc/inc.scheme_list.tpl"}

<div class="quote-btn">
    <a href="tel:400-056-0599" class="end-quote clearfix">
        <span class="fl phone">客服电话</span>
        <span class="fr icon-right"></span>
    </a>
</div>



{*<!--温馨提示按钮-->*}
{*<div class="reminder-btn js-rem ">*}
{*<span class="icon icon-rem"></span>*}
{*<p>温馨提示</p>*}
{*</div>*}
{if !$demand_offer['isThirty']}

    {if $demand_offer['status'] < 0}
        <!--已关闭按钮-->
        <div class="reminder-btn js-icon-close">
            <span class="icon icon-close"></span>

            <p>已关闭</p>
        </div>
    {/if}
    {if $demand_offer['status']>=0}
        <!--询价中按钮-->
        <div class="reminder-btn js-inq">
            <span class="icon icon-inq"></span>
            <p>询价中</p>
        </div>
    {/if}
{/if}
<!--是否等待商家报价弹窗-->
{include "Web_Mobile_Static::demand_offer.v1.0/inc/inc.pop_judge.tpl"}
{include "Web_Mobile_Static::demand_offer.v1.0/inc/inc.customer_pop.tpl"}
{static "core/yunspace.js"}
{static 'demand_offer.v1.0/demand_offer_operation.js'}
{static "demand_offer.v1.0/pop.js"}
</body>
</html>