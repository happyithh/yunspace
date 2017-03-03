<!DOCTYPE html>
<html>
<head lang="en">
    {include "Web_Mobile_Static::v1.0/head_meta.tpl"}
    {static "v1.0/global.css"}
    {static "grab_order.v1.0/grab.css"}
    {static "v1.0/jquery-1.11.1.min.js"}
</head>
<body>
<div class="wrapper">
    <div class="grab-title">
        <h2 class="state">等待抢单</h2>
    </div>
    {include "Web_Mobile_Static::grab_order.php.v1.0/inc/demand_detail.tpl"}


    {if $myIntegral >= $data['integral']}
        <!--待抢单-->
        <div class="grab-order">
            <div class="count-credit clearfix">

                <p class="fl">需扣减<span>{intval($data['integral'])}</span>积分</p>

                <p class="fr balance">积分余额：{$myIntegral}</p>
            </div>
            <div class="count-down">
                你还有<span id="grabOutTime" data-time="{$data['end_time']}"></span>抢单时间
            </div>
            <a href="javascript:;" class="btn-grab js-btn-grab" onclick="operation.grabSingle(this)"
               data-id="{$data['id']}">抢单</a>
        </div>
    {else}
        <!--待抢单不能抢单-->
        <div class="grab-order">
            <div class="count-credit count-credit-no clearfix">
                <p>需扣减<span>{intval($data['integral'])}</span>积分</p>

                <p class="balance">积分余额：{$myIntegral}</p>
            </div>
            <a href="javascript:;" class="btn-grab btn-grab-no">积分不足</a>
        </div>
    {/if}


</div>
<!--wrapper-end-->
{static "core/yunspace.js"}
{static "grab_order.v1.0/operation.js"}
{static "grab_order.v1.0/grab.js"}
<script>
    //处理抢单倒计时按钮
    $(function () {
        var _time = $("#grabOutTime").attr('data-time');
          addTimer('grabOutTime', _time);
    });
</script>
</body>
</html>


