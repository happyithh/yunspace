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
    <title>客户--【云·SPACE】</title>
</head>
<body>

<div class="wt-demand-tit">
    <a href="?" class="fl alink {if $_REQUEST['status']==''} current {/if} ">询价中</a>
    <span class="line fl"></span>
    <a href="?status=close" class="fr alink {if $_REQUEST['status']=='close'} current{/if} ">已关闭</a>
</div>
{include "Web_Mobile_Static::demand_offer.v2.0/inc/inc.wechat_customer_list.tpl"}
</body>
</html>




































