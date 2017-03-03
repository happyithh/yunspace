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
<div class="boki-dtl-banner boki-banner">
    <div class="boki-dtl-img">
        <img src="{$event_info['event_logo']|default:'img/wechat.v2.0/tkt_img1.jpg'}">
    </div>
    <div class="boki-dtl-title">
        <p>{$ticket_type[$event_info['ticket_type']]}</p>
        <p>{$event_info['title']}</p>
    </div>
</div>

<!--时间/地点-->
<div class="boki-dtl-timeplace">
    <p>时间：{date("Y.m.d",$event_info['activity_time'])}-{date("Y.m.d",$event_info['activity_end_time'])}</p>
    <p style="border: none;">地点：{$event_info['addr']}</p>
</div>

<!--活动简介-->
<div class="boki-act-profile">
    <div class="tit">活动简介</div>
    <p>{$event_info['content']}</p>
   <!-- <div class="remarks">
        <p>a)此票种为电子票；</p>
        <p>b)演出详情进攻参考，具体信息以现场为准；</p>
        <p>b)儿童需持票入场。</p>
    </div>-->
</div>

<a href="ticket_list?event_id={$event_info['id']}" class="bg-green booking-btn">立即购票</a>

</body>
</html>