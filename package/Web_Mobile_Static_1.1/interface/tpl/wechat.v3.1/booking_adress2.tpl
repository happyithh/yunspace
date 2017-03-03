<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no,minimal-ui">
    <meta name="format-detection" content="telephone=no"/>
    <link type="text/css" rel="stylesheet" href="css/v1.0/style_public.css">
    <link type="text/css" rel="stylesheet" href="css/wechat.v3.0/booking_new.css">
    <title>{$event_info['title']}[云·Space 活动售票]</title>
</head>
<body>
<ul class="booking-nav clearfix">
    <li class="active" ><a href="{$_home}event_ticket/manage_address" >管理收获地址</a></li>
    <li><a href="{$_home}event_ticket/order_list" style="border: none;">我的门票</a></li>
</ul>
{foreach $address as $k=>$v}
    {if $v['is_default']==1}
        <dl class="boki-adress default">
            <dt>默认地址</dt>
            <dd class="clearfix">
                <div class="cont-text clearfix">
                    <p><span class="fl">{$v['name']}</span><span class="fr">{$v['phone']}</span></p>

                    <p class="gray">{$v['address_content']}</p>
                </div>
                <a class="adress-fix"
                   href="{$_home}event_ticket/edit_address?address_id={$v['id']}"><img
                            src="img/wechat.v2.0/boki_icon-fix.png"></a>
            </dd>
        </dl>
    {/if}
{/foreach}
{if empty($hideStyle)}
<dl class="boki-adress margin-bottom-75">
    <dt>其他地址</dt>
    {/if}
    {foreach $address as $k=>$v}
        {if $v['is_default']==0}
            <dd class="clearfix">
                <div class="cont-text clearfix">
                    <p class=""><span class="fl">{$v['name']}</span><span class="fr">{$v['phone']}</span></p>

                    <p class="gray">{$v['address_content']}</p>
                </div>
                <a class="adress-fix"
                   href="{$_home}event_ticket/edit_address?address_id={$v['id']}"><img
                            src="img/wechat.v2.0/boki_icon-fix.png"></a>
            </dd>
        {/if}
    {/foreach}
</dl>


<div class="boki-btn">
    <a href="create_address">
        <button class="bg-green add-adress"><span class="boki_icon-add"></span>添加新地址</button>
    </a>
</div>
</body>
</html>
