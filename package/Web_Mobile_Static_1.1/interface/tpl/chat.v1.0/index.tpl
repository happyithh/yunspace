<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="format-detection" content="telephone=no"/>
    <title>{$__seo['网页标题']}</title>
    <meta name="viewport" content="width=device-width,height=device-height, initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    {*<meta http-equiv="Content-Security-Policy" content="default-src *; style-src 'self' 'unsafe-inline'; script-src 'self' 'unsafe-inline' 'unsafe-eval'">*}
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <link href="plugins/ionicons-master/css/ionicons.min.css" rel="stylesheet">
    {static "v1.0/jquery-1.11.1.min.js"}
    {static "v1.0/global.css"}
    {static "chat.v1.0/chat_demand_tab.css"}
</head>
<body style="overflow: hidden">
<div class="tab-content" style="width:100%;" yun="livechat/tabs.js::init" yun-index="{$_REQUEST['index']}" yun-url="{$_REQUEST['url']}">
    <iframe frameborder="0" style="width: 100%; margin-bottom: 40px;"></iframe>
    <div class="tab">
        <ul class="tab-li">
            <li>
                <a href="javascript:;" class="tab-link" yun-url="chat_recent"><span class="ion-chatbox-working tab-icon"></span></a>
            </li>
            <li>
                <a href="javascript:;" class="tab-link" yun-url="chat_contacts"><span class="ion-person-stalker tab-icon"></span></a>
            </li>
            <li>
                <a href="javascript:;" class="tab-link" yun-url="chat_demand"><span class="ion-ios-paper tab-icon"></span></a>
            </li>
            <li>
                <a href="javascript:;" class="tab-link" yun-url="chat_collect"><span class="ion-heart tab-icon"></span></a>
            </li>
        </ul>
    </div>
</div>
{static "core/yunspace.js"}
</body>
</html>