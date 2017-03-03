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
    <div class="filling-cont-wrap">
        <div class="filling-cont">
            <div class="filling-select clearfix">
                <p class="icon icon-edt1"></p>
                <select name="product" onchange="operation.switchTags(this)">
                    {foreach $data as $val}
                        <option value="{$val['id']}" {if $val['selected']==1}selected{/if}>{$val['item_name']}</option>
                    {/foreach}
                </select>
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
                           placeholder="请输入需求报价"/>
                </div>
                <div class="filling-mkt clearfix">
                    <p class="icon icon-edt2"></p>
                    <div class="mkt" style='display: block;overflow:hidden;height:24px;'>
                        <span>文体娱乐</span>
                        <span>秀场展馆</span>
                        <span>文体娱乐</span>
                        <span>秀场展馆</span>
                        <span>文体娱乐</span>
                        <span>秀场展馆</span>
                        {*<p>为场地打个特色标签吧</p>*}
                    </div>
                    <p class="ellipsis">…</p>
                    <a class="icon-in" href=""></a>
                </div>
                <div class="ipt-wrp">
                    <p class="icon icon-edt6"></p>
                    <textarea placeholder="备注如餐饮价格" name="remark"></textarea>
                </div>
            </div>
        </div>
    </div>
    <!--filling-cont-wrap-end-->
    <div class="fill-fot-btn clearfix">
        <button class="fr form-sbt bg-orange form-sbt-revise">提交</button>
    </div>
<!--弹窗内容-->
{include "Web_Mobile_Static::demand_offer.v2.0/inc/inc.pop_judge.tpl"}
{static 'core/yunspace.js'}
{static 'demand_offer.v2.0/demand_offer_operation.js'}
{static "demand_offer.v2.0/pop.js"}

</body>
</html>