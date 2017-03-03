<!DOCTYPE html>
<html>
<head lang="en">
    {include "Web_Mobile_Static::chat.v1.0/inc.chat_head.tpl"}
</head>
<body style="background: #fafafa;">
<div class="top" style="background:#eee">
    <div class="top_left">
        <a href="chat_recent">
            <i class="ion-ios-arrow-back"></i>
        </a>
    </div>
    <div class="top-title">最新消息</div>
</div>
<div class="cover fixed"></div>
<div class="message-content js-message-content relative" id="message_list"
     style="background: #fafafa; padding-top: 42px;">

    {*接收信息*}
    <div class="receive relative" id="get-message-text">
        <div class="receive-person-img absolute">
            <img src="{$_root}user_center/avatar/{$v['from_account_id']}.jpg">
        </div>
        <div class="message-body-l relative">
            <div class="Triangle-1 fl absolute"></div>
            <div class="fl received-message">
                &nbsp;
            </div>
            <div class="clear"></div>
        </div>
    </div>
    {*接收连接*}
    <div class="receive relative" id="get-message-url">
        <div class="receive-person-img absolute">
            <img src="img/chat.v1.0/icon.png" alt=""/>
        </div>
        <div class="message-body-l relative">
            <div class="Triangle-1 fl absolute"></div>
            <div class=" received-message">
                <a href="" class="share-link" target="_blank">
                    <div class="share-title">
                        &nbsp;
                    </div>
                    <div class="share-img">
                        <img src="img/chat.v1.0/f5.jpg" alt=""/>
                    </div>
                    <div class="share-des">
                        &nbsp;
                    </div>
                    <div class="clear"></div>
                </a>
            </div>
            <div class="clear"></div>
        </div>
    </div>

    {*发送信息*}
    <div class="send relative" id="send-message-text">
        <div class="send-person-img absolute">
            <img src="img/chat.v1.0/icon.png" alt=""/>
        </div>
        <div class="message-body-r relative ">
            <div class="Triangle-2 fr absolute"></div>
            <div class="fr sended-message">
                &nbsp;
            </div>
            <div class="clear"></div>
        </div>
    </div>

    {*发送连接*}
    <div class="send relative" id="send-message-url">
        <div class="send-person-img absolute">
            <img src="img/chat.v1.0/icon.png" alt=""/>
        </div>
        <div class="message-body-r relative">
            <div class="Triangle-2 fl absolute"></div>
            <div class="sended-message">
                <a href="" class="share-link" target="_blank">
                    <div class="share-title">
                        &nbsp; &nbsp;
                    </div>
                    <div class="share-img">
                        <img src="img/chat.v1.0/f5.jpg" alt=""/>
                    </div>
                    <div class="share-des">
                        &nbsp; &nbsp;
                    </div>
                    <div class="clear"></div>
                </a>
            </div>
            <div class="clear"></div>
        </div>
    </div>

</div>

{*未注册*}
{*<!-- Bottom Toolbar-->*}
{*<div class="footer-block fixed "  style="text-align: center">*}
{*<span class="ion-ios-telephone"  style="font-size: 20px;"></span>&nbsp;&nbsp;*}
{*电话呼叫*}
{*</div>*}

{*已注册*}
<div class="footer-block fixed">
    <a href="javascript:;" class="send-phone js-message-more">
        <p class="message-icon">
            <span class="ion-plus-circled js-message-icon"></span>
        </p>
    </a>
    <a href="javascript:;" class="write-message send_message">
        <p class="message-icon">
            发送</p>
    </a>

    <div class="send-input">
        <input type="text" class="message_content"/>
    </div>

</div>

<div class="message-body-more fixed js-message-body-more">
    <div class="message-body-more-list relative">
        <ul class="message-body-more-list-li ">
            <li>
                <a href="javascript:;" class="message-more-choose block js-recommend" data-id="set">推荐套餐</a>
            </li>
            <li>
                <a href="javascript:;" class="message-more-choose block js-recommend " data-id="room">推荐场地</a>
            </li>
            <li>
                <a href="javascript:;" class="message-more-choose block js-recommend" data-id="service">推荐配套服务</a>
            </li>
            <li>
                <div class="clear"></div>
            </li>
        </ul>
        <div class="Triangle-3 absolute"></div>
    </div>
</div>

<div class="recommend-search fixed js-recommend-search" id="recommend-search">
    <p style="margin:0px;" class="search-recommend-title block js-search-recommend-title ">
        请搜索推荐服务</p>

    <div class="search-recommend ">
        <input type="text" class="search-input js-search-input"/>
    </div>
    <ul class="search-result js-search-result ">
        {*<li><p class="result-title">-</p><a href="javascript:;" class="recommend-submit js-recommend-submit">推荐</a><div class="clear"></div></li>*}
    </ul>
    <p class="block absolute close-reset js-close">
        <span class="icon ion-close-round"></span></p>
</div>
{static "chat.v1.0/chat_body.js"}
{static "core/yunspace.js"}
</body>
</html>