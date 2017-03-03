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
    <title>标签修改-【云·SPACE】</title>

</head>
<body>
<!--编辑标签-->
<div class="dmd-tend-my">
    <div class="edit-wrap clearfix">
        <a href="javascript:;" class="edit-btn js-edit-btn">编辑</a>
    </div>
    <ul class="mk-edit clearfix">
        {foreach $data['tags'] as $k =>$val}
            <li data-value="{$k}">{$val}</li>
        {/foreach}
    </ul>
</div>

<div class="fill-fot-btn clearfix hide dmd-delt-btn">
    <button class="form-sbt bg-orange js-edit-submit" onclick="operation.deleteAlert()">删除我的适配条件</button>
</div>

<!--确认删除弹窗-->
<div class="demand-popup js-pop-cont hide pop-dmd-delt">
    <div class="popup-exchange-ph popup-btn">
        <input class="quote-bg-wrt confirm" type="button"
               onclick="operation.mkSubmit(this)" item-id="{$data['id']}" result-id="{$_REQUEST['result_id']}"
               value="确认并修改">
        <a class="quote-bg-wrt js-cancel cancel" href="javascript:;">取消</a>
    </div>
</div>
</body>
{static "core/yunspace.js"}
{static 'demand_offer.v1.0/demand_offer_operation.js'}
{static "demand_offer.v1.0/pop.js"}

</html>