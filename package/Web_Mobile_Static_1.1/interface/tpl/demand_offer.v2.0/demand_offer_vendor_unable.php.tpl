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
    <title>【云·SPACE】</title>
    <script src="js/demand_tender.v1.0/demand_tender.js"></script>
</head>
<body>
<!--报价需求列表-->
<div class="quote-title clearfix">
    <p class="fl state"><i class="fl icon-c icon-unable"></i><span class="fl">接不了（{$demand_offer['demand_type']}）</span>
    </p>
</div>
<div class="quote-title" style="margin-top: -15px;"><span>原因：</span>{$data['vendor_close_mark']}</div>

<!--报价需求列表-->
{include "Web_Mobile_Static::demand_offer.v2.0/inc/inc.head_demand_vendor.tpl"}


</body>
</html>