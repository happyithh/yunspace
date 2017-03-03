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
</head>
<body>

<!--报价需求列表-->
{include "Web_Mobile_Static::demand_tender.v1.0/inc/inc.head_demand.tpl"}

{if $demand_tender['status'] < 0}
    <div class="fill-fot-btn clearfix" style="margin-top: 35px;">
        <button class="fr form-sbt bg-orange" style="background-color: #ccc;">报价已结束</button>
    </div>
{else}

    <!--填写报价-->
    <div class="filling-tit">立即报价</div>
    <div class="filling-cont-wrap">
        <div class="filling-cont">
            <div class="filling-select">
                <select name="product">
                    <option value="">请选择报价商品</option>
                    {foreach $product as $val}
                        <option value="{$val['id']}" {if 1==count($product)}selected{/if}
                                data-type="{$val['type']}">{$val['product_name']}</option>
                    {/foreach}
                </select>
            </div>
            <div class="fill-ipt">
                <input type="hidden" name="tender_id" value="{$demand_tender['id']}">

                <div class="ipt-wrp">
                    <p>联系人名称：</p>
                    <input type="text" name="contact" placeholder="请输入联系人名称"
                           value="{mb_substr($__user['username'],0,4,'utf-8')}">
                </div>
                <div class="ipt-wrp">
                    <p>联系人手机：</p>
                    <input type="number" name='contact_phone' placeholder="请输入联系手机" value="{$__user['phone']}">
                </div>
                <div class="ipt-wrp">
                    <p>场地报价：</p>
                    <span style="  float: left; line-height: 50px;">￥</span><input type="number" name="quote"
                                                                                   placeholder="请输入商品报价"/>
                </div>
                <div class="ipt-wrp">
                    <p>其他备注：</p>
                    <textarea placeholder="其他备注" name="remark"></textarea>
                </div>
            </div>
        </div>
    </div>
    <!--filling-cont-wrap-end-->
    <div class="fill-fot-btn clearfix">
        {*<a href="tel::400-056-0599" class="fl"><img src="img/demand_tender.v1.0/img_phone.png"></a>*}
        <button class="fr form-sbt bg-orange" onclick="vendorBid()">提交报价</button>
    </div>
{/if}
{static 'core/yunspace.js'}
{static 'demand_tender.v1.0/demand_tender.js'}
</body>
</html>