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
    <title>商品报价-【云·SPACE】</title>

</head>
<body>

<!--报价需求列表-->
{include "Web_Mobile_Static::demand_offer.v1.0/inc/inc.head_demand.tpl"}

{if $demand_offer['status'] < 0}
    <div class="fill-fot-btn clearfix" style="margin-top: 35px;">
        <button class="fr form-sbt bg-orange" style="background-color: #ccc;">报价已结束</button>
    </div>
{else}

    <!--填写报价-->
    <div class="filling-cont-wrap">
        <div class="filling-tit">填写我的报价</div>
        <div class="filling-cont">
            <div class="filling-select clearfix">
                <p class="icon icon-edt1"></p>
                <select name="product" onchange="operation.switchTags(this)">
                    {foreach $data as $val}
                        <option value="{$val['id']}" {if $val['selected']==1}selected{/if}>{$val['item_name']}</option>
                    {/foreach}
                </select>
            </div>
            <div class="filling-mkt clearfix">
                <p class="icon icon-edt2"></p>
                {foreach $data as $val}
                    <div class="mkt hide"
                         data-item-id="{$val['id']}" {if $val['selected']==1} style='display: block'{/if}>
                        {foreach $val['tags'] as $kk =>$vv}
                            <span>{$vv}</span>
                        {/foreach}
                    </div>
                    <a TARGET="_blank" class="icon-in "
                       href="?action=tags_edit&item_id={$val['id']}&result_id={$result_id}" {if $val['selected']==''} style='display: none'{/if}></a>
                {/foreach}
            </div>
            <div class="fill-ipt">
                <input type="hidden" name="demand_id" value="{$demand_offer['demand_id']}">
                <input type="hidden" name="offer_id" value="{$demand_offer['id']}">
                <input type="hidden" name="result_id" value="{$result_id}">

                <div class="ipt-wrp">
                    <p class="icon icon-edt3"></p>
                    <input type="text" name="contact" placeholder="请输入联系人名称"
                           value="{mb_substr($data[0]['contacts'],0,4,'utf-8')}">
                </div>
                <div class="ipt-wrp">
                    <p class="icon icon-edt4"></p>
                    <input type="number" name='contact_phone' placeholder="请输入联系手机" value="{$data[0]['phone']}">
                </div>
                <div class="ipt-wrp">
                    <p class="icon icon-edt5"></p>
                    <input type="number" name="quote"
                           placeholder="请输入商品报价"/>
                </div>
                <div class="ipt-wrp">
                    <p class="icon icon-edt6"></p>
                    <textarea placeholder="其他备注" name="remark"></textarea>
                </div>
            </div>
        </div>
    </div>
    <!--filling-cont-wrap-end-->
    <div class="fill-fot-btn clearfix">
        {*<a href="tel::400-056-0599" class="fl"><img src="img/demand_tender.v1.0/img_phone.png"></a>*}
        <button class="fr form-sbt bg-orange" onclick="operation.vendorBid()">提交报价</button>
    </div>
{/if}
<!--弹窗内容-->
{include "Web_Mobile_Static::demand_offer.v1.0/inc/inc.pop_judge.tpl"}
<script>
    //
    <!--当页面加载时弹出-->
    window.onload = (function () {

        $('.js-pop-mk').show().after('<div class="popup_bg"></div>');
        $(".js-pop-mk .p-mk-big").eq(0).show();

    });
</script>
{static 'core/yunspace.js'}
{static 'demand_offer.v1.0/demand_offer_operation.js'}
{static "demand_offer.v1.0/pop.js"}

</body>
</html>