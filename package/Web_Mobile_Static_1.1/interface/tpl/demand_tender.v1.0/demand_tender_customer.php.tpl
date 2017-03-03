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
<div class="filling-tit">我收到的场地报价</div>
<!--报价详情-->
<ul class="quote-needs-details quote-nd-bt">

    {include 'Web_Mobile_Static::demand_tender.v1.0/inc/inc.scheme_list.tpl'}
</ul>
{if count($schemeList)==20}
    <a onclick="loadMore()" class="quote-more">显示更多</a>
{/if}
<div class="contact-sj hotline">
    <p class="numb">服务热线400-056-0599</p>
    <a class="icon-phone" href="tel::400-056-0599">
        <img src="img/demand_tender.v1.0/icon-phone-org.png"></a>
</div>
{if $demand_tender['status'] < 0}
    <div class="quote-btn">
        <a href="javascript:;" class="end-quote">报价已结束</a>
    </div>
{else}
    <div class="quote-btn">
        <a href="javascript:;" class="end-quote js-end-quote" data-tender-id="{$demand_tender['id']}">结束报价</a>
    </div>
{/if}

<div class="demand-popup">
    <!--交换电话弹窗-->
    <div class="popup-exchange-ph popup-btn hide">
        <input class="quote-bg-wrt js-confirm confirm" type="button" onclick="exchangePhone()" value="确认交换电话">
        <a class="quote-bg-wrt js-cancel cancel" href="javascript:;">取消</a>
    </div>

    <!--结束报价弹窗-->
    <div class="popup-end-quote popup-btn hide">
        <input class="quote-bg-wrt js-end-q" type="submit" onclick="endDemandTender()" value="确认结束报价">
        <a class="quote-bg-wrt js-cancel cancel" href="javascript:;">取消</a>
    </div>
</div>


<div class="reminder-btn js-reminder-btn ">
    <p>温馨提示</p>
</div>
<div style="display: none" class="js-reminder-box">
    <!--温馨提示弹窗-->
    <div class="popup_bg"></div>
    <div class="reminder">
        <h1>温馨提示</h1>

        <p>由于移动运营商短信限制，您的这个活动需求只能收到一次短信报价提醒，我们还提供了微信服务号报价提醒功能，关注云·SPACE服务号后您可以实时的收到每个报价的提醒，您保存如下二维码在微信里识别，或者在微信里搜索【<span
                    class="orange">yunspacefwh</span>】进行关注。</p>

        <div class="code-copy clearfix">
            <div class="qr-code"><img src="img/demand_tender.v1.0/qr_code.jpg"></div>
            <div class="text"><img src="img/demand_tender.v1.0/img_text.jpg"></div>
        </div>
        <a class="w-close js-cancel" href="javascript:;"></a>
    </div>
</div>
<script>

    {if $_COOKIE['is_one']==1}
    $(function(){
    //弹出温馨提示
    $('.js-reminder-btn').click();
    document.cookie='is_one=2';
    });
    {/if}
</script>
{static 'core/yunspace.js'}
</body>
</html>