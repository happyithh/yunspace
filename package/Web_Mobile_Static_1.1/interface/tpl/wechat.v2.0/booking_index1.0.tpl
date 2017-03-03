<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no,minimal-ui">
    <link type="text/css" rel="stylesheet" href="css/v1.0/style_public.css">
    <link type="text/css" rel="stylesheet" href="css/wechat.v2.0/booking.css">
    <title>{$event_info['title']}[云·Space 活动售票]</title>
</head>
<body>
<ul class="booking-nav clearfix">
    <li class="active"><a href="{$_home}event_ticket/event_list">正在售票</a></li>
    <li><a href="{$_home}event_ticket/order_list" style="border: none;">我的门票</a></li>
</ul>
<div class="booking-list">
    {if $event_list}
    {foreach $event_list as $k=>$v}
    <a href="{$_home}event_ticket/event_info?event_id={$v['id']}" class="clearfix">
        <div class="boki-img"><img src="{$v['event_logo']|default:'img/wechat.v2.0/tkt_img1.jpg'}"></div>
        <div class="boki-details">
            <h2>{$v['title']}</h2>
            <p>时间：{date("Y.m.d",$v['activity_time'])}-{date("Y.m.d",$v['activity_end_time'])}</p>
            <p>地点：{$v['addr']}</p>
            <p>类型：{$ticket_type[$v['ticket_type']]}</p>
            <div class="ticket-price">
                {if $v['price_is_score']==1}
                积分:<strong style="color: #FF9900;margin-left: 5px;">{$v['low_price']}</strong>起
                {else}
                <span>￥</span><strong>{$v['low_price']}</strong>起
                {/if}
            </div>
        </div>
    </a>
    {/foreach}
    {/if}
</div>
</body>
</html>