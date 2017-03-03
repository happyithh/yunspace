<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no,minimal-ui">
    <meta name="format-detection" content="telephone=no"/>
    <link type="text/css" rel="stylesheet" href="css/v1.0/style_public.css">
    <link type="text/css" rel="stylesheet" href="css/demand_off.v3.0/dmd_wechat.css">
    <link type="text/css" rel="stylesheet" href="css/demand_off.v3.0/quote.css">
    <script src="js/v1.0/jquery-1.11.1.min.js"></script>

    <title>报价详情-【云·SPACE】</title>
</head>
<body>

{include "Web_Mobile_Static::demand_offer.v3.0/inc/inc.head_demand.tpl"}

{include "Web_Mobile_Static::demand_offer.v3.0/inc/inc.scheme_list.tpl"}
{include "Web_Mobile_Static::demand_offer.v3.0/inc/inc.customer_pop.tpl"}

<div class="quote-btn">
    <div class="fl head-name">{$demand_offer['admin_name']}（客服）</div>
    <a href="tel:{if $demand_offer['admin_phone']}{$demand_offer['admin_phone']}{else}400-056-0599{/if}" class="fr contact">联系他</a>
</div>
{static "core/yunspace.js"}
{static 'demand_offer.v3.0/demand_offer_operation.js'}
{static "demand_tender.v1.0/demand_tender.js"}
{static "demand_offer.v3.0/pop.js"}
</body>
</html>




































