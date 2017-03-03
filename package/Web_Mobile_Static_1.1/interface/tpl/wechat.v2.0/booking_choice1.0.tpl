<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no,minimal-ui">
    <meta name="format-detection" content="telephone=no" >
    <link type="text/css" rel="stylesheet" href="css/v1.0/style_public.css">
    <link type="text/css" rel="stylesheet" href="css/wechat.v2.0/booking.css">
    <title>{$event_info['title']}[云·Space 活动售票]</title>
</head>
<body>
<ul class="booking-nav clearfix">
    <li class="active"><a href="{$_home}event_ticket/event_list">正在售票</a></li>
    <li><a href="{$_home}event_ticket/order_list" style="border: none;">我的门票</a></li>
</ul>
<div class="tkt-choice-title">
    <h2>{$event_info['title']}</h2>
    <p>{$event_info['addr']}</p>
</div>

<div class="tkt-choice-time choice-list">
    <div class="tit">选择时间</div>
    <ul class="clearfix">
        {if $event_time}
            {foreach $event_time as $k=>$v}
            <li {if $k==0}class="active"{/if}>{$v}</li>
            {/foreach}
        {/if}
        {*<li class="active">2015.08.03</li>*}
        {*<li>2015.08.03</li>*}
        {*<li>2015.08.03</li>*}
        {*<li>2015.08.03</li>*}
        {*<li>2015.08.03</li>*}
        {*<li>2015.08.03</li>*}
        {*<li class="hasno">2015.08.03</li>*}
        {*<li>2015.08.03</li>*}
        {*<li>2015.08.03</li>*}
    </ul>
</div>

<div class="tkt-choice-price choice-list">
    <div class="tit">选择票价</div>
    <ul class="clearfix">
        {*{var_dump($new_ticket_list)}*}
        {if $new_ticket_list}
            {foreach $new_ticket_list[$event_time[0]] as $k=>$v}
                <li {if $v['active']==1}class="active"{/if} data_ticket_id="{$v['id']}" date-stock="{$v['stock']}" date_price="{$v['price']}" {if $v['stock']<=0}class="hasno" disabled{/if}>{$v['name']}&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;{$v['price']}&nbsp;元</li>
            {/foreach}
        {/if}

        {*<li class="active" date-stock="20">198</li>*}
        {*<li>298</li>*}
        {*<li>398</li>*}
        {*<li class="hasno">598</li>*}
        {*<li>598</li>*}
    </ul>
</div>
<form action="{$_home}event_ticket/create_order" method="post">
<div class="tkt-choice-num clearfix">
    <h2>购票数量</h2>
    <div class="tkt-numb-count clearfix">
        <a class="fl btn-rd-ad btn-reduce js-btn-reduce" href="javascript:;"  >-</a>
        <input class="fl buy-num js-buy-num" type="text" name="ticket_num" value="0">
        <a class="fr btn-rd-ad btn-add js-btn-add" href="javascript:;" ">+</a>
    </div>
</div>

<div class="tkt-total-money fr">
    总价：<span class="js-total-money">0</span>元
</div>

    <input type="hidden" value="{$event_info['id']}" name="event_id">
    <input type="hidden" value="{$conn_id}" name="conn_id">
    <input type="hidden" value="" name="ticket_id" class="ticket_id">
<button type="submit" value="submit" class="bg-green booking-btn" style="border: none">下一步</button>
{*<a href="tobepay" class="bg-green booking-btn">下一步</a>*}
</form>
<script type="text/javascript">
    var dataObject = {$new_ticket_lists};
</script>
<script src="js/v1.0/jquery-1.11.1.min.js"></script>
<script src="js/wechat.v2.0/ticket1.0.js"></script>
</body>
</html>