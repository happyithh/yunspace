<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no,minimal-ui">
    <meta name="format-detection" content="telephone=no"/>
    <link type="text/css" rel="stylesheet" href="css/v1.0/style_public.css">
    <link type="text/css" rel="stylesheet" href="css/demand_off.v2.0/quote.css">
    <script src="js/v1.0/jquery-1.11.1.min.js"></script>
    <title>商品报价-【云·SPACE】</title>

</head>
<body>
<!--填写报价-->
<div class="filling-tit">修改报价</div>
{include "Web_Mobile_Static::demand_offer.v2.0/inc/inc.offer_edit_vendor.tpl"}
</div>
<!--filling-cont-wrap-end-->
<div class="fill-fot-btn clearfix">
    <button class="fr form-sbt bg-orange " onclick="operation.offerEditSubmit(this)" demand-id="{Func_NumEncode::e($_REQUEST['demand_id'])}">提交
    </button>
</div>
<!--弹窗内容-->
{include "Web_Mobile_Static::demand_offer.v2.0/inc/inc.pop_judge.tpl"}
{static 'core/yunspace.js'}
{static 'demand_offer.v2.0/demand_offer_operation.js'}
{static 'demand_offer.v2.0/localStorage.js'}
{static "demand_offer.v2.0/pop.js"}

</body>
</html>