<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no,minimal-ui">
    <meta name="format-detection" content="telephone=no"/>
    <link type="text/css" rel="stylesheet" href="css/v1.0/style_public.css">
    <link type="text/css" rel="stylesheet" href="css/wechat.v3.0/booking_new.css">
    <title>{$event_info['title']}[云·Space 活动售票]</title>
</head>
<body>
<ul class="booking-nav clearfix">
    <li class="active" style="width: 85%"><a href="select_address?event_id={$event_id}" >选择收获地址</a></li>
    <li style="width:15%"><a href="ticket_list?event_id={$event_id}" style="border: none;">返回</a></li>
</ul>
<dl class="boki-adress margin-bottom-75">
    {foreach $address as $k=>$v}
    <dd class="clearfix">
        <a href="ticket_list?event_id={$event_id}&address_id={$v['id']}" class="clearfix">
            <div class="cont-text clearfix">
                <p class=""><span class="fl">{$v['name']}</span><span class="fr">{$v['phone']}</span></p>
                <p class="gray">{$v['address_content']}</p>
            </div>

       <span class="adress-fix" href="javascript:;">{if $v['id']==$_REQUEST['address_id']}<img src="img/wechat.v2.0/boki_icon-setadress1.png">{/if}</span>
        </a>
    </dd>
    {/foreach}
    <dd class="clearfix"style="width: auto;height: 40px;padding-top: 10px;">
        <a href="{$_home}event_ticket/create_address?url_back={$_home}event_ticket/select_address?event_id={$event_id}" class="clearfix" style="height: 30px;line-height: 30px;text-align: center;font-size: 16px;color: #00c3c3;">
              添加新收票地址 >>
        </a>
    </dd>
</dl>

<div class="boki-btn">
    <a href="manage_address" class="bg-green add-adress"></span>管理收货地址</a>
</div>
</body>
</html>