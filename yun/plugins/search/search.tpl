<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="format-detection" content="telephone=no"/>
    <title>{$__seo['网页标题']}</title>
    <meta name="viewport" content="width=device-width,height=device-height, initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta http-equiv="Content-Security-Policy" content="default-src *; style-src 'self' 'unsafe-inline'; script-src 'self' 'unsafe-inline' 'unsafe-eval'">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <link href="plugins/ionicons-master/css/ionicons.min.css" rel="stylesheet">
</head>
<style>
    * {
        margin: 0px;  padding: 0px;
    }
    ul li{
        list-style:none;
    }
    .search{
        border:0px;border:1px solid #666666;border-radius: 5px;height:100px;margin: 0 auto;width:300px;line-height: 30px;box-sizing: border-box;padding:0px 5px;
    }
    .contents{
        margin:0 auto;position:relative;width:100%;
    }
    .result{
        width:300px;position:absolute;background: #f5f5f5;left: 0px;box-shadow: -1px 1px 10px #dddddd;display: none;
    }
    .result p:first-of-type{
        width:90%;color:#000000;line-height: 30px;font-size: 16px;border-bottom: 1px solid #dddddd;
        display: block;padding-left: 5%;padding-bottom: 10px;word-wrap: break-word;
    }
    .result-list li:first-of-type a span{
        font-size: 20px;
    }
    .question{
        color:#ff1493;
    }
    .result-link{
        width:90%;display:block;padding-left:5%;line-height: 30px;color:#666666;
    }
    a{
        text-decoration: none;
    }
    .hidden{
        display:none
    }
</style>
<body style=" overflow: auto;">
{*<div class="contents">*}
<input type="text" class="search" yun="search/js/search.js::getResult@keyup" yun-url="livechat/message/read.jsonp">
<div class="result">
    <p><span class="ion-ios-search-strong"></span>&nbsp;当前查找的是“<span class="question">前端</span>”</p>
    <ul class="result-list">
        <li class="hidden result-li">
            <a href="" class="result-link">前端，后台</a>
        </li>
    </ul>
</div>
{*</div>*}


{static "core/yunspace.js"}
</body>
</html>