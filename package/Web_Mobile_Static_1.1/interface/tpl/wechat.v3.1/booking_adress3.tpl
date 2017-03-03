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
<body style="background: #fff">
<ul class="booking-nav clearfix">
    <li class="active" style="width: 85%"><a href="{$_home}event_ticket/create_address" >添加新地址</a></li>
    <li style="width:15%"><a href="{Core::$urls['referer']}" style="border: none;">返回</a></li>
</ul>
<form action="{$_home}event_ticket/submit_address" method="post">
        <ul class="fill-adress">
            <li>
                <p>姓名：</p>
                <input type="text" name="name" value="" placeholder="请输入收货人姓名">
            </li>
            <li>
                <p>电话：</p>
                <input type="phone" name="phone" value="" placeholder="请输入收货人手机号码">
            </li>
            <li>
                <p>地址：</p>
                <textarea name="address_content" placeholder="请输入收货人详细信息"></textarea>
            </li>
            <input type="hidden" class="is_default" name="is_default" value="">
            <input type="hidden" name="url_back" value="{$url_back}">
        </ul>


        <!--设为默认地址-->
        <div class="set-adress clearfix js-set-adress" onclick="is_default(this)">
            <p class="fl">设为默认地址</p>
            <span class="fr icon-setadress {if $address['is_default']==1}icon-s-ads1{else}icon-s-ads2{/if}"
                  ></span>
        </div>

            <div class="boki-btn">
                <button class="bg-green add-adress">保存地址</button>
            </div>

    </form>
</body>
</html>
<script>
    function is_default(e) {

        if ($('.icon-setadress').hasClass('icon-s-ads2')) {
            $('.is_default').val(1);
        }
        if ($('.icon-setadress').hasClass('icon-s-ads1')) {

            $('.is_default').val(0);
        }
    }
</script>
<script src="js/v1.0/jquery-1.11.1.min.js"></script>
<script src="js/wechat.v2.0/ticket1.0.js"></script>
<script src="js/wechat.v2.0/booking.js"></script>
