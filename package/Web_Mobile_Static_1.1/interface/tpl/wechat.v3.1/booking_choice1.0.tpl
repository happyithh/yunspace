<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no,minimal-ui">
    <meta name="format-detection" content="telephone=no" >
    <link type="text/css" rel="stylesheet" href="css/v1.0/style_public.css">
    <link type="text/css" rel="stylesheet" href="css/wechat.v3.0/booking_new.css">
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
    <p class="bdt-p">
        {if $event_info['ticket_type']==1}
            <img src="img/wechat.v2.0/boki_icon-tk2.png"><i class="tk-purple">实体票</i>
        {else}
            <img src="img/wechat.v2.0/boki_icon-tk1.png"><i class="tk-orange">电子票</i>
        {/if}
    </p>
</div>
{if $event_info['ticket_type']==1 && !empty($ticketAddress)}
    {*{if !empty($ticketAddress)}*}
    <!--邮寄地址-->
    <dl class="boki-adress boki-adress-choice">
        <dd class="clearfix">
            <a href="{$_home}event_ticket/select_address?event_id={$event_info['id']}&address_id={$ticketAddress['id']}" class="clearfix">
                <div class="cont-text clearfix">
                    <p><span class="fl">{$ticketAddress['name']}</span><span class="fr">{$ticketAddress['phone']}</span>
                    </p>

                    <p class="gray">{$ticketAddress['address_content']}</p>
                </div>
                <span class="adress-fix" href="javascript:;"><img src="img/wechat.v2.0/boki_icon-in.png"></span>
            </a>
        </dd>
    </dl>
{elseif $event_info['ticket_type']==1 && empty($ticketAddress)}
    <!--新建收货地址-->
    <dl class="boki-adress boki-setnew-adress">
        <dd class="clearfix">
            <a href="{$_home}event_ticket/create_address" class="clearfix">
                <div class="cont-text clearfix">
                    <p><span>新建收货地址</span></p>

                    <p class="gray">您还没有设置收货地址，请点击这里设置！</p>
                </div>
            </a>
        </dd>
    </dl>
{/if}
<div class="tkt-choice-time choice-list">
    <div class="tit">选择时间</div>
    {if $event_info['is_showtime']==1}
        <div class="choice-time-one"><img
                    src="img/wechat.v2.0/boki_icon-date.png"><span>{date('Y.m.d',$event_info['activity_time'])}
                - {date('Y.m.d',$event_info['activity_end_time'])}</span></div>
    {else}
        <ul class="clearfix">
            {if $event_time}
                {foreach $event_time as $k=>$v}
                    <li {if $k==0}class="active"{/if}">{$v}</li>
                {/foreach}
            {/if}
        </ul>
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
        {if $new_ticket_list && $event_info['is_showtime']==0}
            {foreach $new_ticket_list[$event_time[0]] as $k=>$v}
                <li {if $v['active']==1}class="active"{/if} data_ticket_id="{$v['id']}" date-stock="{$v['stock']}"
                    date_price="{$v['price']}" {if $v['stock']<=0}class="hasno" disabled{/if}>{$v['name']}&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;{$v['price']}
                    &nbsp;{if $v['price_is_score']==1}积分{else}元{/if}
                </li>
            {/foreach}
        {else}
            {foreach $new_ticket_list as $k=>$v}
                {foreach $v as $kk=>$vv}
                    <li {if $v['active']==1}class="active"{/if} data_ticket_id="{$vv['id']}" date-stock="{$vv['stock']}"
                        date_price="{$vv['price']}" {if $vv['stock']<=0}class="hasno" disabled{/if}>{$vv['name']}&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;{$vv['price']}
                        &nbsp;{if $vv['price_is_score']==1}积分{else}元{/if}
                    </li>
                {/foreach}
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
        <input type="hidden" name="addressInfo[name]" value="{if isset($ticketAddress['name'])}{$ticketAddress['name']}{/if}">
        <input type="hidden" name="addressInfo[phone]" value="{if isset($ticketAddress['phone'])}{$ticketAddress['phone']}{/if}">
        <input type="hidden" name="addressInfo[address_content]" value="{if isset($ticketAddress['address_content'])}{$ticketAddress['address_content']}{/if}">
    </div>
</div>

    {if !empty($new_ticket_list_array_value['price_is_score'])&&
    $new_ticket_list_array_value['price_is_score']==1 || !empty($new_ticket_list_array_value[0]['price_is_score'])&&
    $new_ticket_list_array_value[0]['price_is_score']==1}<div class="tkt-total-money fl" style="float: left">您的余额：<span class="" id="total_score" style="color: #FF9900">{$integral}</span>积分</div>{/if}
<div class="tkt-total-money fr">
    总价：<span class="js-total-money" {if $new_ticket_list_array_value[0]['price_is_score']==1}style="color: #FF9900"{/if}>0</span>{if !empty($new_ticket_list_array_value['price_is_score'])&&
$new_ticket_list_array_value['price_is_score']==1 || !empty($new_ticket_list_array_value[0]['price_is_score'])&&
$new_ticket_list_array_value[0]['price_is_score']==1}积分{else}元{/if}
</div>

    <input type="hidden" value="{$event_info['id']}" name="event_id">
    <input type="hidden" value="{$conn_id}" name="conn_id">
    <input type="hidden" value="" name="ticket_id" class="ticket_id">
    <input type="hidden" value="{$ticketAddress['id']}" name="address_id">
    <input type="hidden" value="{$new_ticket_list_array_value[0]['price_is_score']}" name="price_is_score" id="price_is_score">
    {if !empty($new_ticket_list_array_value[0]['price_is_score'])&& $new_ticket_list_array_value[0]['price_is_score']==1}
    <input type="hidden" value="{$integral}" name="integral">

    {/if}
    <button type="button" value="quit" class="bg-green booking-btn quit" style="border: none;background:#666666;display: block;">积分余额不足</button>
<button type="submit" value="submit" class="bg-green booking-btn submit" style="border: none;display: block;">下一步</button>
</form>
<script type="text/javascript">
    var dataObject = {$new_ticket_lists};
</script>
<script src="js/v1.0/jquery-1.11.1.min.js"></script>
<script src="js/wechat.v2.0/ticket1.0.js"></script>
</body>
</html>