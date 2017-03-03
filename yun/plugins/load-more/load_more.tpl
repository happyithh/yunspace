<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,height=device-height, initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    {*<link rel="stylesheet" href="{$_root}yun/plugins/load-more/css/load-more.css">*}
    <title></title>
</head>
<style>
    *{
        margin:0px;padding:0px
    }
    .content{
        width:100%;overflow: auto;background: #f5f5f5;
    }
    .content p{
        display: block;line-height:50px;border-bottom:1px solid #eeeeee;
    }
    .load-more{
        margin-top:10px;width:100%;background: #fff;display: block;line-height: 50px;text-align:center;cursor: pointer;
    }
</style>
<body>
<ul class="content">
    <li class="content-li">123456789</li>
    <li class="content-li">123456789</li>
    <li class="content-li">123456789</li>
    <li class="content-li">123456789</li>
</ul>
<a class="load-more" yun="load-more/js/load-more.js::insertNode@click" yun-insert=".content-li" yun-last_id="10"
   yun-url="livechat/message/send.jsonp" yun-item="username:123,age:18,sex:man">加载更多</a>
{static "core/yunspace.js"}
</body>
</html>