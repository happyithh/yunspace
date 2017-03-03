<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no,minimal-ui">
    <meta name="format-detection" content="telephone=no"/>
    <link type="text/css" rel="stylesheet" href="css/v1.0/style_public.css">
    <link type="text/css" rel="stylesheet" href="css/demand_off.v1.0/dmd_wechat.css">
    <script src="js/v1.0/jquery-1.11.1.min.js"></script>
    <title>需求管理-【云·SPACE】</title>
</head>
<body>
<div class="wt-demand-tit business-tit">
    <a href="?" class="fl alink {if $_REQUEST['status']==''}current{/if}">待报价</a>
    <span class="line fl"></span>
    <a href="?status=reported" class="fl alink  {if $_REQUEST['status']=='reported'}current{/if}">已报价</a>
    <span class="line fl"></span>
    <a href="?status=ok" class="fr alink  {if $_REQUEST['status']=='ok'}current{/if}">已接受</a>
</div>
<!--正在等待商家报价-->
{include "Web_Mobile_Static::demand_offer.v1.0/inc/inc.wechat_vendor_list.tpl"}

<div class="link-wrap">
    <a class="link" href="tel:400-056-0599">
        <span class="icon  icon-phone"></span>

        <p>客服电话</p>
    </a>
</div>

</body>
</html>




































