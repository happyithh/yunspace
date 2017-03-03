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
<form action="{$_home}event_ticket/update_address" method="post">
<ul class="fill-adress set-fill-adress">
    <li>
        <input type="text" name="name" value="{$address['name']}">
    </li>
    <li>
        <input type="phone" name="phone" value="{$address['phone']}">
    </li>
    <li>
        <textarea name="address_content">{$address['address_content']}</textarea>
    </li>
    <input type="hidden" class="is_default" name="is_default" value="{if isset($address['is_default'])}{$address['is_default']}{else}0{/if}">
    <input type="hidden" name="address_id" class="address_id" value="{$address['id']}">
</ul>

<!--设为默认地址-->
<div class="set-adress clearfix js-set-adress">
    <p class="fl">设为默认地址</p>
    <span class="fr icon-setadress {if $address['is_default']==0}icon-s-ads2{else}icon-s-ads1{/if}"></span>
</div>

<div class="boki-btn">
<b class="btn-dlt" >删除</b>
<button class="btn-kept bg-green">保存</button>
</div>
</form>
<script src="js/v1.0/jquery-1.11.1.min.js"></script>
<script src="js/wechat.v2.0/booking.js"></script>
{static "core/yunspace.js"}
</body>
</html>