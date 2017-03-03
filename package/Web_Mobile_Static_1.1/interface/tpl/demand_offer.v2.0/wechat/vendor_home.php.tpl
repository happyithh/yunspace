<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no,minimal-ui">
    <meta name="format-detection" content="telephone=no"/>
    <link type="text/css" rel="stylesheet" href="css/v1.0/style_public.css">
    <link type="text/css" rel="stylesheet" href="css/demand_off.v2.0/dmd_wechat.css">
    <script src="js/v1.0/jquery-1.11.1.min.js"></script>
    <script src="js/demand_tender.v2.0/demand_tender.js"></script>
</head>
<body style="position: relative">
<div class="wt-demand-tit business-tit">
    <a href="?" class="fl alink {if $_REQUEST['status']==''}current{/if}">待报价</a>
    <span class="line fl"></span>
    <a href="?status=reported"
       class="fl alink  {if  is_numeric(mb_strpos($_REQUEST['status'],'reported'))}current{/if}">已报价</a>
    <span class="line fl"></span>
    <a href="?status=no" class="fr alink  {if $_REQUEST['status']=='no'}current{/if}">接不了</a>
</div>
{include "Web_Mobile_Static::demand_offer.v2.0/inc/inc.search.tpl"}

{*{if  is_numeric(mb_strpos($_REQUEST['status'],'reported'))}*}
{*<div class="hvquote clearfix" style="margin: 0px;">*}
{*<a class="alink {if $_REQUEST['status']=='reported'}current{/if}" href="?status=reported">全部({$reported_count['sum']})</a>*}
{*<a class="alink {if $_REQUEST['status']=='reported-A'}current{/if}" href="?status=reported-A">有意向({$reported_count['A']})</a>*}
{*<a class="alink {if $_REQUEST['status']=='reported-B'}current{/if}" href="?status=reported-B">待确认({$reported_count['B']})</a>*}
{*</div>*}
{*{/if}*}
<!--正在等待商家报价-->
{include "Web_Mobile_Static::demand_offer.v2.0/inc/inc.wechat_vendor_list.tpl"}

</body>
</html>




































