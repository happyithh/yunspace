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
    <script src="js/demand_tender.v1.0/demand_tender.js"></script>

    {static "core/yunspace.js"}
    {static 'demand_offer.v2.0/demand_offer_operation.js'}
</head>
<body>
{*<div class="quote-title clearfix">*}
{*<p class="fl state"><i class="fl icon-state icon-state-hv"></i><span class="fl">已报价，客户有意向（咨询）</span></p>*}
{*<p class="fl state"><i class="fl icon-state icon-state-no"></i><span class="fl">已报价，客户无意向（咨询）</span></p>*}
{*<p class="fl state"><i class="fl icon-state icon-state-ready"></i><span class="fl">已报价，待确认意向（咨询）</span></p>*}
{*</div>*}
{include "Web_Mobile_Static::demand_offer.v2.0/inc/inc.head_vendor_status.tpl"}
{include "Web_Mobile_Static::demand_offer.v2.0/inc/inc.head_demand_vendor.tpl"}
<!--我收到的报价-->
<div class="filling-tit" style="margin-top: 0px;">我的报价</div>

<!--报价详情-->
<ul class="quote-needs-details">
    <li>
        <div class="quote-needs-tit clearfix">
            <p class="fl quote-time">报价时间：<span>{$data['offer_time']}</span></p>
            {if $demand_offer['status'] ==0 && $data['change_phone_time']==-1}
                <p class="fr quote-edit"><a
                            href="?action=offer_edit&result_id={$result_id}&demand_id={$demand_offer['demand_id']}"
                            class="edit"><span></span>修改</a></p>
            {/if}
        </div>
        <div class="quote-needs-cont clearfix">
            <div class="img">
                <img src="{Page_Site_Global::displayMedia($item['logo'],200,200)}">
            </div>
            <div class="cont">
                <h2>{$item['item_name']}</h2>

                <p class="numbs">￥<span>{$data['offer_price']}/{$data['offer_unit']}</span></p>

                <p class="marks" style="overflow: hidden;height: 24px;">
                    {if $item['tags']}
                        {foreach $item['tags'] as $k =>$val}
                            <span class="bq">{$val}</span>
                        {/foreach}
                    {else}
                        场地还没有标签呢
                    {/if}
                </p>
            </div>
            <p class="remarks quote-p"><span class="tit">其他备注：</span><span
                        class="ct"> {$data['offer_info']['其他备注']}</span>
            </p>
        </div>
        <div class="contact-sj">
            <p class="numb">商家：<span>{$data['offer_info']['联系人']} {$data['offer_info']['联系电话']} </span></p>
        </div>
    </li>
</ul>
</body>
</html>








