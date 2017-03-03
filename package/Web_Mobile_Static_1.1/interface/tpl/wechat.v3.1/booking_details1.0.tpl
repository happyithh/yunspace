<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no,minimal-ui">
    <meta name="format-detection" content="telephone=no"/>
    <link type="text/css" rel="stylesheet" href="css/v1.0/style_public.css">
    <link type="text/css" rel="stylesheet" href="css/wechat.v3.0/booking_new_1.css">
    <title>{$event_info['title']}[云·Space 活动售票]</title>
</head>
<body>
<ul class="booking-nav clearfix">
    <li class="active"><a href="{$_home}event_ticket/event_list">正在售票</a></li>
    <li><a href="{$_home}event_ticket/order_list" style="border: none;">我的门票</a></li>
</ul>
<div class="boki-dtl-banner boki-banner clearfix">
    <div class="boki-dtl-img">
        <img src="{$event_info['event_logo']|default:'img/wechat.v2.0/tkt_img1.jpg'}">
    </div>
    <div class="boki-dtl-title">
        <h2>{$event_info['title']}</h2>
        <p class="bdt-p"> {if $event_info['ticket_type']==1}<img src="img/wechat.v2.0/boki_icon-tk2.png"><i class="tk-purple">实体票</i>{else}<img src="img/wechat.v2.0/boki_icon-tk1.png"><i class="tk-orange">电子票</i>{/if}
        </p>

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
    <p>{$event_info['content']}{if $event_info['id']==30}<a href="{$_home}event_ticket/show_lupao_form" style="padding-left: 5px;" >点击填写报名表</a>{/if}</p>
    <!--<div class="remarks">*}
        <p>a)此票种为实体票；</p>
        <p>b)演出详情进攻参考，具体信息以现场为准；</p>
        <p>b)儿童需持票入场。</p>
    </div> -->
</div>

<a href="ticket_list?event_id={$event_info['id']}" class="bg-green booking-btn">立即购票</a>

</body>
</html>