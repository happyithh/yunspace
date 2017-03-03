<!DOCTYPE html>
<html>
<head>
    {include file="Web_Static::v2.0/html_head.tpl"}
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no,minimal-ui">
    <link rel="stylesheet" type="text/css" href="css/v2.0/common.css">
    <link rel="stylesheet" type="text/css" href="css/v2.0/style_public.css">
    <link rel="stylesheet" type="text/css" href="css/order_user/order_user.css">
    <link rel="stylesheet" type="text/css" href="css/order_user/popup.css">
</head>
<body data-url="order/not/available/days.jsonp" data-id="{$_REQUEST['id']}" data-type ="{$_REQUEST['type']}">
{include file="Web_Static::v2.0/html_header.tpl"}
<div class="container">
    <div class="site_location">
        <a href="/">{$smarty.cookies.city}</a><span>&gt;</span>
        <a href="javascript:;">订单详情</a><span>&gt;</span>
        <p class="inbk">
            {if $orderinfo['product_id']}
                {$info['product_name']}
            {else}
                {$info['set_name']}
            {/if}
        </p>
    </div>

    <!--订单导航-->
    {if $orderinfo['is_buyer']}
        <ul class="order_booking clearfix">
            <li><span>1-</span>预定下单</li>
            <li  {if $_REQUEST['tab']==1} class="active"{/if}><span>2-</span>订单确认</li>
            <li {if $_REQUEST['tab']==2} class="active" {/if}><span>3-</span>订单签约</li>
            <li {if $_REQUEST['tab']==3} class="active" {/if}><span>4-</span>订单支付</li>
            <li {if $_REQUEST['tab']==4} class="active" {/if}><span>5-</span>订单评价</li>
        </ul>
    {else}
        <ul class="order_booking order_booking_m clearfix">
            <li {if $_REQUEST['tab']==1} class="active"{/if}><a href="?tab=1"><span>1-</span>订单确认</a></li>
            <li {if $_REQUEST['tab']==2} class="active" {/if}><span>2-</span>确认签约</li>
            <li {if $_REQUEST['tab']==3} class="active" {/if}><span>3-</span>订单支付</li>
            <li {if $_REQUEST['tab']==4} class="active" {/if}><span>4-</span>订单完成</li>
        </ul>
    {/if}


    <!--预定详情-开始-->
    <div class="booking-details">
        <div class="booking-title">
            {if $orderinfo['is_buyer']}
                <p>供应商：{$orderinfo['vendor_name']}</p>
                <a href="javascript:;"  onclick="yun('chatBar/index.js::openTab', { index:0, url:'{$_root}m/chat/chat_body?to_account_id={$orderinfo['vendor_account_id']}'});"><span class="icon_sdmsg"></span>发消息</a>
            {elseif $orderinfo['is_vendor']}
                <p>采购者：{$orderinfo['order_detail']['buyer_name']}</p>
                <a href="javascript:;"  onclick="yun('chatBar/index.js::openTab', { index:0, url:'{$_root}m/chat/chat_body?to_account_id={$orderinfo['buyer_account_id']}'});"><span class="icon_sdmsg"></span>发消息</a>
            {/if}
        </div>
        {if $orderinfo['product_id']}
            <div class="booking-cont clearfix">
                <div class="booking-cont-img fl">
                    <a target="_blank" href="{$_root}service_info/{$info['id']}.html"><img src="{Page_Site_Global::displayMedia($info['logo'],768,0,1)}"> </a>
                </div>
                <div class="booking-cont-txt fl">
                    <h3>{$info['product_name']}</h3>
                    <p class="p-txt gray">
                        <span class="id-tm">地址：{$info['addr']}</span>
                        <span class="id-tm">类别：{$info['category_name']}</span>
                            <span class="id-tm">服务标签：
                                {foreach explode(',',$info['attr_new'][Page_Site_Global::tagsName('适合活动类型')]) as $ak=>$av}
                                    {$av}
                                {/foreach}
                            </span>
                    </p>
                    <p class="p-money magenta">
                        {if $info['price'] >0}
                            <strong>
                                ¥ {$info['price']}
                                {if $info['attr_new']['起价']}
                                    <span style="font-size: 13px;color:#666 ">起</span>
                                {/if}
                                {if $info['attr_new']['计价单位']}
                                    /{$info['attr_new']['计价单位']}
                                {/if}
                            </strong>
                        {else}
                            面议
                        {/if}
                    </p>
                </div>
            </div>
        {elseif $orderinfo['product_set_id']}
            <div class="booking-cont clearfix">
                <div class="booking-cont-img fl">
                    <a target="_blank" href="{$_root}set_info/{$info['id']}.html"><img src="{Page_Site_Global::displayMedia($info['logo'],768,0,1)}"> </a>
                </div>
                <div class="booking-cont-txt fl">
                    <h3>{$info['set_name']}</h3>
                    <p class="p-txt gray">
                        <span class="id-tm">地址：{$info['addr']}</span>
                        <span>类别：{$info['category_name']}</span>
                        <span>人数：{$info['attr_index']['人数']|default:'不限'}</span>
                        <span>天数：{$info['attr_index']['天数']|default:'待定'}</span>
                            <span class="id-tm">有效期：
                                {if $info['attr_index']['开始时间']}
                                    {$info['attr_index']['开始时间']} 至 {$info['attr_index']['结束时间']}
                                {else}
                                    待定
                                {/if}
                            </span>
                    </p>
                    <p class="p-money magenta ticket-price">
                        <strong>
                        ¥ {$info['detail']['套餐价']}
                        {if $info['detail']['计价单位']}
                            /{$info['detail']['计价单位']}
                        {/if}
                        </strong>
                    </p>
                </div>
            </div>
        {/if}
    </div><!--booking-details-end-->

    <!--预定详情-结束-->

    <!--订单详情-开始-->
    <div class="order-details">
        <div class="order-title">订单详情</div>
        <input type="hidden" name="order_no" class="order_no_input" value="{$orderinfo['order_no']}">
        <ul class="order-cont">
            <li class="clearfix">
                <p class="p1"><span class="tit">订单号：</span>{$orderinfo['order_no']}</p>
                <p class="p2"><span class="tit">预定数量：</span>{$orderinfo['order_detail']['order_number']}
                    {if $info['detail']['计价单位']}
                        {$info['detail']['计价单位']}
                    {elseif $info['attr_new']['计价单位']}
                        {$info['attr_new']['计价单位']}
                    {/if}
                </p>
                <p class="p3"><span class="tit">订单金额：</span>￥{$orderinfo['order_price']}</p>
            </li>
            <li class="clearfix">
                <p class="p1"><span class="tit">采购方：</span>{$orderinfo['order_detail']['buyer_name']}</p>
                <p class="p2"><span class="tit">创建时间：</span>{date('Y-m-d H:i:s',$orderinfo['create_time'])}</p>
            </li>
            <li class="clearfix">
                <p><span class="tit">预订档期：</span>{date('Y 年 m 月 d 日 H:i',$orderinfo['start_time'])} —— {date('Y 年 m 月 d 日 H:i',$orderinfo['end_time'])}
                </p>
            </li>
            {if $orderinfo['remark']}
                <li class="clearfix"><span class="tit">交易备注：</span>{$orderinfo['remark']}</li>
            {/if}
        </ul>
    </div>
    <!--订单详情-结束-->
    <!--下单需求-->
    {if $orderinfo['order_status'] < 0  || $orderinfo['order_close_info']['buyer_cancel_time'] || $orderinfo['order_close_info']['vendor_cancel_time']}
        {include "Web_Static::order/inc/order_close.tpl"}
    {else}
        {if $_REQUEST['tab']==1}
            {*预订详情*}
            {include "Web_Static::order/inc/order_info_tab1.tpl"}
        {elseif $_REQUEST['tab']==2}
            {*上传合同*}
            {include "Web_Static::order/inc/order_info_tab2.tpl"}
        {elseif $_REQUEST['tab']==3}
            {include "Web_Static::order/inc/order_info_tab3.tpl"}
        {elseif $_REQUEST['tab']==4}
            {*订单评价*}
            {include "Web_Static::order/inc/order_info_tab4.tpl"}
        {elseif $_REQUEST['tab']==5}
            {*订单跟踪*}
            {include "Web_Static::order/inc/order_info_tab5.tpl"}
        {elseif $_REQUEST['tab']==6}
            {*订单支付银行页*}
            {include "Web_Static::order/inc/order_info_bank.tpl"}
        {elseif $_REQUEST['tab']==7}
            {*订单追踪*}
            {include "Web_Static::order/inc/order_info_tracking.tpl"}
        {/if}
    {/if}

</div>
<!--container-end-->
{include file="Web_Static::v2.0/html_footer.tpl"}
{include file="Web_Static::order/inc/popup.tpl"}
{static "order/popup.js"}
{static "order/order_operate.js"}
{static "order/order_user.js"}
</body>
</html>