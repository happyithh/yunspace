<!DOCTYPE html>
<html>
<head lang="en">
    {include "Web_Mobile_Static::chat.v1.0/inc.chat_head.tpl"}
</head>
<body>
<div class="sculpture">
    <div class="sculpture-body">
        <div class="head-sculpture">
            <img src="" alt=""/>
        </div>
        <p class="sculpture-text block"></p>
    </div>
</div>
<ul class="person-message">
    <li class="relative">
        <a href="" class="person-li">
            <p class="block fl person-message-icon"><span class="ion-edit" style="font-size: 20px;"></span></p>
            <p class="block fl person-message-text">订单记录</p>
            <div class="clear" style="clear:both"></div>
            <p class="link-right absolute"><span class="ion-chevron-right"></span></p>
        </a>
    </li>
</ul>
<ul class="person-message">
    <li class="relative">
        <a href="javascript:;" class="person-li">
            <p class="block fl person-message-icon"><span class="ion-chatbox-working" style="font-size: 20px;"></span></p>
            <p class="block fl person-message-text">消息免扰</p>
            <div class="clear" style="clear:both"></div>
        </a>
        <div class="item-input absolute person-message-checkbox">
            <label class="label-switch">
                <input type="checkbox" id="disturb" >
                <div class="checkbox"></div>
            </label>
        </div>
    </li>
    <li class="relative">
        <a href="javascript:;" class="person-li">
            <p class="block fl person-message-icon"><span class="ion-eye-disabled" style="font-size: 20px;"></span></p>
            <p class="block fl person-message-text">加入黑名单</p>
            <div class="clear" style="clear:both"></div>
        </a>
        <div class="item-input absolute person-message-checkbox">
            <label class="label-switch">
                <input type="checkbox" id="blacklist">
                <div class="checkbox"></div>
            </label>
        </div>
    </li>
    <li class="relative">
        <a href="" class="person-li">
            <p class="block fl person-message-icon"><span class="ion-ios-bolt" style="font-size: 20px;"></span></p>
            <p class="block fl person-message-text">投诉举报</p>
            <div class="clear" style="clear:both"></div>
            <p class="link-right absolute"><span class="ion-chevron-right"></span></p>
        </a>
    </li>
</ul>

{*未注册*}
{*<div class="footer-block fixed footer-color1">*}
{*<span class="ion-ios-telephone"></span>&nbsp;&nbsp;*}
{*电话呼叫*}
{*</div>*}
{*已注册*}
<a href="" class="footer-block fixed js-send-message footer-color1 block"  style="text-align: center">
    <span class="ion-ios-telephone" style="font-size: 20px;"></span>&nbsp;&nbsp;
    发消息
</a>
<script type="text/javascript" src="js/chat.v1.0/chatter_message.js"></script>
{static "core/yunspace.js"}
</body>
</html>