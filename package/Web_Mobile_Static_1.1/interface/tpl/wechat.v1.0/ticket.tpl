<!DOCTYPE html>
<html>
<head lang="en">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no,minimal-ui">
<link type="text/css" rel="stylesheet" href="css/wechat.v1.0/ticket.css?t=2">
<link type="text/css" rel="stylesheet" href="css/v1.0/global.css">
    <title>{$event_info['title']}[云·Space 活动售票]</title>
</head>
<body>
<div class="ticket-container">
    <div class="ticket-title">
        <p><img src="{$headimgurl}" style="width: 50px;height: 50px;border-radius: 25px; "></p>
        <p style="font-size: 12px; line-height: 2.0em;text-align: center;width: 80%;margin: 20px auto;color: #666;"> 为方便查询票务,记得收藏本页面哦。您也可以到公众号『我的门票』中查看！</p>
        <p >
          您正在购买</p>
        <h1>{$event_info['title']}</h1>
    </div>
<form action="{$_home}ticket/createorder" method="post">
    <input type="hidden" value="{$event_info['id']}" name="event_id">
    <input type="hidden" value="{$conn_id}" name="conn_id">
    {if $event_info['ticketlist']}
    <ul class="ticket-list">

        {foreach $event_info['ticketlist'] as $k=>$v}
        <li class="clearfix">
            <p class="ticket-list-p"><span class="ticket-name">{$v['name']}：</span><span class="ticket-price fr">¥{$v['price']}</span></p>
            <div class="choose-amount">
                <a class="btn-rd-ad btn-reduce js-btn-reduce fl" href="javascript:;"  >-</a>
                <input class="buy-num js-buy-num fl"  name="ticket[{$v['id']}]" type="text" value="0" ticket-value='{$v['stock']}' data-value="{$v['price']}">
                <a class="btn-rd-ad btn-add js-btn-add fr" href="javascript:;" ">+</a>
            </div>
        </li>
        {/foreach}

    </ul>
    <div class="ticket-num">
        <p>您已经选购</p>
        <p>共计<span class="col-blue js-total-num">0</span>张票，共计￥<span class="col-magenta js-total-money">0</span>元</p>
    </div>

    <div class="ticket-btn-wrap clearfix">
        <button type="submit" value="submit" class="fl ticket-btn btn-col-blue" >立即购买</button>
        <a href="{$_home}ticket/orderlist?event_id={$_REQUEST['event_id']}" class="fr ticket-btn btn-col-magenta">我的门票</a>
    </div>
        {else}
        <div class="ticket-num">
            <p>本活动暂未设置票种</p>
        </div>
    {/if}
    </form>
</div>
<script src="js/v1.0/jquery-1.11.1.min.js"></script>
<script src="js/wechat.v1.0/ticket.js"></script>
</body>
</html>