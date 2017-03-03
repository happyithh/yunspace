<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no,minimal-ui">
    <link rel="stylesheet" href="css/v1.0/global.css">
    <link rel="stylesheet" href="css/broke_the_news.v1.0/broke_the_news.css">
    <link rel="stylesheet" href="plugins/ionicons-master/css/ionicons.css"/>
    <title>{$event_info['title']}[我要爆料]</title>
</head>
<body style="background-color: #fff">
<div class="broke-news-wrapper">
    <div class="broke-news-logo"></div>
    <div class="broke-news-text-content">
        <p>您还没有爆料过活动哦，</p>

        <p>赶紧点击下方进行爆料！</p>
    </div>
    <a href="{$_home}broke_news" class="broke-news-button">
        我要爆料
    </a>
    <a href="javascript:;" class="broke-news-href-to-broke js-show-broke-info">什么是活动爆料?</a>
</div>
<div class="mask-layer"></div>
{include "Web_Mobile_Static::broke_the_news.v1.0/inc.broke_the_news_rule.tpl"}
<script src="js/v1.0/jquery-1.11.1.min.js"></script>
<script src="js/broke_the_news.v1.0/broke_the_news.js"></script>
</body>
</html>