<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no,minimal-ui">
    <meta name="format-detection" content="telephone=no" />
    <link type="text/css" rel="stylesheet" href="css/v1.0/style_public.css">
    <link type="text/css" rel="stylesheet" href="css/demand_off.v3.0/quote.css">
    <script src="js/v1.0/jquery-1.11.1.min.js"></script>
    <script src="js/demand_tender.v1.0/demand_tender.js"></script>
</head>
<body>
<div class="quote-title clearfix">
    {*<p class="fl state">已报价，待需求方确认</p>*}
    <p class="fl state">客户有意向：余小姐&nbsp;13888888888</p>
    <a class="fr phone" href="tel:13888888888"><img src="img/demand_tender.v1.0/icon-phone-org.png" ></a>
</div>

<!--报价需求列表-->
<div class="quote-needs-list bd-tpbm quote-p clearfix js-data-offer" data-demand-id="{$demand_offer['demand_id']}"
     data-result-id="{$result_id}" data-offer-id="{$demand_offer['id']}" style="margin-bottom: 0">
    <div class="demand-tit clearfix">
        <div class="numb-phone clearfix">
            <h2 class="fl">zzc,15995959595</h2>
            <a href="javascript:;" class="fr contact js-phone">联系他</a>
        </div>
        <p class="fl time">提交时间：2015.07.28 17:08:02</p>
        <p class="fr code">NO.123456</p>
    </div>
    <a href="" class="edit hide"><span></span>编辑</a>
    <p><span class="tit">活动人数：</span><span class="ct">50-100人</span></p>
    <p><span class="tit">活动档期：</span><span class="ct">2015.07.28-2015.07.31</span></p>
    <p><span class="tit">活动预算：</span><span class="ct">￥50000-￥50000</span></p>
    <div class="list-hide">
        <p><span class="tit">活动城市：</span><span class="ct">上海</span></p>
        <p><span class="tit">活动类型：</span><span class="ct">发布会</span></p>
        <p><span class="tit">活动标签：</span>
            <span class="ct">
                <span class="bq">文化娱乐</span>
                <span class="bq">露天广场</span>
                <span class="bq">文化娱乐</span>
                <span class="bq">露天广场</span>
                <span class="bq">文化娱乐</span>
                <span class="bq">露天广场</span>
            </span>
        </p>
        <p><span class="tit">具体要求：</span><span class="ct">大方大方大方大方大方大方大方大方大方大方大方大方大方大方大方大方大方大方大方大方大方大方大方大方大方大方大方大方大方大方</span></p>
    </div>
</div>

<!--我收到的报价-->
<div class="filling-tit">我的报价</div>

<!--报价详情-->
<ul class="quote-needs-details">
    <li>
        <div class="quote-needs-tit clearfix">
            <p class="fl quote-time">报价时间：<span>2015.07.29 13:00</span></p>
            <p class="fr quote-edit"><a href="bid1" class="edit"><span></span>修改</a></p>
        </div>
        <div class="quote-needs-cont clearfix">
            <div class="img">
                <img src="">
            </div>
            <div class="cont">
                <h2>奢居会-8楼露台</h2>
                <p class="numbs">￥<span>5,888</span></p>
                <p class="marks">
                    <span class="bq">文化娱乐</span>
                    <span class="bq">露天广场</span>
                    {*场地还没有标签呢*}
                </p>
            </div>
            <p class="remarks quote-p"><span class="tit">其他备注：</span><span class="ct">水电费反反复复凤飞飞凤飞飞凤飞飞凤飞飞凤飞飞凤飞飞凤飞飞凤飞飞凤飞飞凤飞飞dddddddddddddddv</span></p>
        </div>
        {*<div class="contact-sj-btn">*}
            {*<input type="submit" value="点击获得商家联系方式">*}
        {*</div>*}
        <div class="contact-sj">
            <p class="numb">联系商家：<span>颜颜 13788989606</span></p>
        </div>
    </li>
</ul>

{*<!--客户待确认-->*}
{*<div class="wait-confirmation"><img src="img/demand_tender.v1.0/icon_quote_time.png">等待需求方确认</div>*}

<!--客户已确认-->
<div class="hv-confirmation contact-sj hide">
    <p class="numb">客户已接受：<span>余小姐 13788989606</span></p>
    <a class="icon-phone" href=""><img src="img/demand_tender.v1.0/icon-phone-org.png"></a>
</div>

</body>
</html>








