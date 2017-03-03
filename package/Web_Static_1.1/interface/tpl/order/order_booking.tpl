<!DOCTYPE html>
<html>
<head>
    {include file="Web_Static::v2.0/html_head.tpl"}
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no,minimal-ui">
    <link rel="stylesheet" type="text/css" href="css/v2.0/style_public.css">
    <link rel="stylesheet" type="text/css" href="css/order_user/order_user.css">
    <link rel="stylesheet" type="text/css" href="css/order_user/popup.css">
    <link rel="stylesheet" type="text/css" href="css/order_user/data-picker.css">
    <!--以下是媒体查询的ie8兼容处理-->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->
</head>
<body data-url="order/not/available/days.jsonp" data-id="{$_REQUEST['id']}" data-type ="{$_REQUEST['type']}">
{include file="Web_Static::v2.0/html_header.tpl"}
<div class="container">
    <div class="site_location">
        <a href="/">{$smarty.cookies.city}</a><span>&gt;</span>
        <a href="javascript:;">预订详情</a><span>&gt;</span>
        <p class="inbk">
            {if $booking_type==1}
                {$data['product_name']}
            {else}
                {$data['set_name']}
            {/if}
        </p>
    </div>

    <!--订单导航-->
    <ul class="order_booking clearfix">
        <li class="active"><span>1-</span>预定下单</li>
        <li><span>2-</span>订单确认</li>
        <li><span>3-</span>订单签约</li>
        <li><span>4-</span>订单支付</li>
        <li><span>5-</span>订单评价</li>
    </ul>

    <!--预定详情-开始-->
        <div class="booking-details">
            <div class="booking-title">
                <p>供应商：{$vendor['vendor_name']}</p>
                <a href="javascript:;"  onclick="yun('chatBar/index.js::openTab', { index:0, url:'{$_root}m/chat/chat_body?to_account_id={$vendor['vendor_account_id']}'});"><span class="icon_sdmsg"></span>发消息</a>
            </div>
            {if $booking_type==1}
                <div class="booking-cont clearfix">
                    <div class="booking-cont-img fl">
                        <a target="_blank" href="{$_root}service_info/{$_REQUEST['id']}.html"><img src="{Page_Site_Global::displayMedia($data['logo'],768,0,1)}"> </a>
                    </div>
                    <div class="booking-cont-txt fl">
                        <h3>{$data['product_name']}</h3>
                        <p class="p-txt gray">
                            <span class="id-tm">地址：{$data['addr']}</span>
                            <span class="id-tm">类别：{$data['category_name']}</span>
                            <span class="id-tm">服务标签：
                                {foreach explode(',',$data['attr_new'][Page_Site_Global::tagsName('适合活动类型')]) as $ak=>$av}
                                    {$av}
                                {/foreach}
                            </span>
                        </p>
                        <p class="p-money magenta ticket-price">
                            {if $data['price'] >0}
                                <strong>
                                    ¥ {$data['price']}
                                    {if $data['attr_new']['起价']}
                                        <span style="font-size: 13px;color:#666 ">起</span>
                                    {/if}
                                    {if $data['attr_new']['计价单位']}
                                        /{$data['attr_new']['计价单位']}
                                    {/if}
                                </strong>
                            {else}
                                面议
                            {/if}
                        </p>
                    </div>
                </div>
            {else}
                <div class="booking-cont clearfix">
                    <div class="booking-cont-img fl">
                        <a target="_blank" href="{$_root}set_info/{$_REQUEST['id']}.html"><img src="{Page_Site_Global::displayMedia($data['logo'],768,0,1)}"> </a>
                    </div>
                    <div class="booking-cont-txt fl">
                        <h3>{$data['set_name']}</h3>
                        <p class="p-txt gray">
                            <span class="id-tm">地址：{$data['addr']}</span>
                            <span>类别：{$data['category_name']}</span>
                            <span>人数：{$data['attr_index']['人数']|default:'不限'}</span>
                            <span>天数：{$data['attr_index']['天数']|default:'待定'}</span>
                            <span class="id-tm">有效期
                                {if $data['attr_index']['开始时间']}
                                    {$data['attr_index']['开始时间']} 至 {$data['attr_index']['结束时间']}
                                {else}
                                    待定
                                {/if}
                            </span>
                        </p>
                        <p class="p-money magenta">
                            ¥ {$data['set_price']}
                            {if $data['detail']['计价单位']}
                                /{$data['detail']['计价单位']}
                            {/if}
                        </p>
                    </div>
                </div>
            {/if}
        </div><!--booking-details-end-->


    <!--预定详情-结束-->

    <!--下单需求 start-->
    <!--下单需求-->
    <div class="order-needs">
        <div class="order-title">下单需求</div>
        <input type="hidden" name="action" value="{if $booking_type==1}product{else}set{/if}">
        <input type="hidden" name="id" value="{$_REQUEST['id']}">
        <input type="hidden" name="demand_id" value="{$_REQUEST['demand_id']}">
        {*<div class="choice-date clearfix">*}
            {*<p class="date-tit">选择档期：</p>*}
            {*<div class="time startime">*}
                {*<span>开始日期</span>*}
                {*<p>*}
                    {*<input class="ipt-txt" type="text" name="start_date">*}
                    {*<input class="ipt-sbt" type="submit" value="×">*}
                {*</p>*}
                {*<select name="start_hours">*}
                    {*{foreach $hours as $k=>$v}*}
                        {*<option {if $_REQUEST['start_hours'] == $v}selected {/if}>{$v}</option>*}
                    {*{/foreach}*}
                {*</select>*}
            {*</div>*}
            {*<div class="time endtime">*}
                {*<span>结束日期</span>*}
                {*<p>*}
                    {*<input class="ipt-txt" type="text" name="end_date">*}
                    {*<input class="ipt-sbt" type="submit" value="×">*}
                {*</p>*}
                {*<select name="end_hours">*}
                    {*{foreach $hours as $k=>$v}*}
                        {*{if $v=="00:00"}*}
                            {*<option {if $_REQUEST['end_hours'] == "00:00"}selected {/if}>23:59</option>*}
                        {*{else}*}
                            {*<option {if $_REQUEST['end_hours'] == $v}selected {/if}>{$v}</option>*}
                        {*{/if}*}
                    {*{/foreach}*}
                {*</select>*}
            {*</div>*}
        {*</div><!--choice-date-end-->*}
        <!--日历部分-开始-->
        <div class="order-date">
            <p class="date-tit-h">选择档期</p>
            <div class="ajaxUrl" yun="data-picker/js/data-picker.js::initPlugin" {if $data['attr_index'] && !$data['attr_index']['节假日可选']}yun-invalid="0,6"{elseif $data['attr_index'] && !$data['attr_index']['工作日可选']}yun-invalid="1,2,3,4,5" {/if} data-url="/static/api/order/not/available/days.jsonp" data-id="{$_REQUEST['id']}" data-type ="{$_REQUEST['booking_type']}"> </div>
            <div class="unusual-txt booking_warning">
                <span class="pop-icon"></span>
                <span class="schedule_warning"></span>
                <span class="close num-tip-close">×</span>
            </div>
        </div><!--order-date-end-->
        <!--日历部分-结束-->
        <!--选择数量-->
        <div class="numb-choice clearfix">
            {if $booking_type==1 && $data['attr_new']['计价单位']}
                <p class="date-tit">选择数量：</p>
                <div class="numb-count clearfix">
                    <a class="btn-rd-ad btn-reduce js-btn-reduce fl" href="javascript:;"  >-</a>
                    <input class="buy-num js-buy-num fl" type="text" value="{if $data['attr_new']['计价下限']}{$data['attr_new']['计价下限']}{else}1{/if}" data-max-value="{$data['attr_new']['计价上限']}" data-min-value="{$data['attr_new']['计价下限']}" name="order_number">
                    <a class="btn-rd-ad btn-add js-btn-add fr" href="javascript:;">+</a>
                </div>
                <p class="p-rt fl">单价:￥{$data['price']}/{$data['attr_new']['计价单位']}</p>
                <p class="p-rt fl p-rt-m">总计：
                    <input type="hidden" class="unit_price" name="price" value="{if $booking_type==1}{$data['price']}{else}{$data['set_price']}{/if}">
                    <strong class="magenta">￥<span class="js-total-money">{$data['price']}</span></strong>
                </p>
                {if $data['attr_new']['计价上限']}
                    <p class="p-rt-z">
                        (可预订数量范围：{$data['attr_new']['计价下限']} ~ {$data['attr_new']['计价上限']})
                    </p>
                {/if}
            {elseif $booking_type==2 && $data['detail']['计价单位']}
                <p class="date-tit">选择数量：</p>
                <div class="numb-count clearfix">
                    <a class="btn-rd-ad btn-reduce js-btn-reduce fl" href="javascript:;">-</a>
                    <input class="buy-num js-buy-num fl" type="text" value="{if $data['detail']['计价下限']}{$data['detail']['计价下限']}{else}1{/if}" data-max-value="{$data['detail']['计价上限']}" data-min-value="{$data['detail']['计价下限']}" name="order_number">
                    <a class="btn-rd-ad btn-add js-btn-add fr" href="javascript:;">+</a>
                </div>

                <p class="p-rt fl">单价:￥{$data['set_price']}/{$data['detail']['计价单位']}</p>
                <p class="p-rt fl p-rt-m">总计：
                    <input type="hidden" class="unit_price" name="price" value="{if $booking_type==1}{$data['price']}{else}{$data['set_price']}{/if}">
                    <strong class="magenta">￥<span class="js-total-money">{$data['price']}</span></strong>
                </p>
                {if $data['detail']['计价上限']}
                    <p class="p-rt-z">
                        (可预订数量范围：{$data['detail']['计价下限']}{$data['detail']['计价单位']} ~ {$data['detail']['计价上限']}{$data['detail']['计价单位']})
                    </p>
                {/if}
            {else}
                <p class="date-tit">预订数量：</p>
                <div class="numb-count clearfix disabled">
                    <span class="btn-rd-ad btn-reduce fl" href="javascript:;"  >-</span>
                    <input class="buy-num js-buy-num fl" type="text" value="1" name="order_number">
                    <span class="btn-rd-ad btn-add fr" href="javascript:;">+</span>
                </div>
                <p class="p-rt fl">单价:￥{if $booking_type==1}{$data['price']}{else}{$data['set_price']}{/if}</p>
                <p class="p-rt fl p-rt-m">总计：
                    <input type="hidden" class="unit_price" name="price" value="{if $booking_type==1}{$data['price']}{else}{$data['set_price']}{/if}">
                    <strong class="magenta">￥<span class="js-total-money">{$data['price']}</span></strong>
                </p>
                <p class="p-rt-z">（一口价，数量不可选）</p>
            {/if}

        </div><!--numb-choice-end-->

        <div class="deal-remarks">
            <p class="date-tit">交易备注：</p>
            <div class="ipt-txt-wrp">
                <input class="ipt-txt js-ipt-errorwarn" type="text" name="memo" placeholder="选填：对订单交易的说明（建议填写已经和商家达成一致的说明）">
                <div class="unusual-txt">
                    <span class="pop-icon"></span>
                        预订数量不在有效范围，默认为临界值
                    <span class="close num-tip-close">×</span>
                </div>
            </div>
        </div><!--deal-remarks-end-->

        <div class="order-submit">
            <input type="button" class="bg-magenta booking_submit" value="提交订单">
        </div>
    </div><!--order-needs-end-->
    <!--下单需求 end-->
</div>
<!--container-end-->
{include file="Web_Static::v2.0/html_footer.tpl"}
{include file="Web_Static::order/inc/popup.tpl"}
{static "order/popup.js"}
{static "order/order_operate.js"}
{static "order/order_user.js"}
</body>
</html>