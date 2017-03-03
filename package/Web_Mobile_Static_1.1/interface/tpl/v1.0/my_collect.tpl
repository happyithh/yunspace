<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no,minimal-ui">
    <meta name="format-detection" content="telephone=no"/>
    <title>我的收藏</title>
    {*<meta name="keywords" content="{$__seo['网页关键词']}"/>*}
    {*<meta name="description" content="{$__seo['网页简介']}"/>*}
    <meta http-equiv="x-dns-prefetch-control" content="on" />
    <link rel="dns-prefetch" href="{$_home}" />
    {static "v1.0/jquery-1.11.1.min.js"}
    {static "v1.0/nav.css"}
    {static "index.v3.0/index.v2.0.js"}
    <link rel="stylesheet" href="plugins/ionicons-master/css/ionicons.min.css">
    <script yun="hide-app/hide-app.js::isApp" src=""></script>
    {static "v1.0/global.css"}
    {static "v4.0/font-awesome.min.css"}
    {static "v1.0/my_collect.css"}
</head>
<body>
{include "Web_Mobile_Static::v1.0/inc.nav.tpl"}

<div class="topline">
    <a class="topline-back" href="javascript:history.go(-1);"><img src="img/v1.0/list_02.png"></a>
    <div class="topline-center">我的收藏</div>
</div>

<div class="collect-wrapper">
    <!--文章-->
    <div id="article-list">
    </div>

    <!--场地-->
    <div class="list-item" id="list_item">
        <ul class="clearfix">

        </ul>
    </div>
<!--场地下的子空间-->
    <div class="list-item" id="space-item">
        <ul class="clearfix">

        </ul>
    </div>

    <!--无收藏时候-->
    <div class="nocollect hidden">
        <div class="img-wp">
            <img src="img/v1.0/nocollect-sm.png">
        </div>
        <h5>您当前还没有任何收藏呢</h5>
        <p>快去收藏喜欢的场地和文章吧~</p>
        <a class="backindex" href="{$_home}">返回首页</a>
    </div>

    <img src="img/v1.0/vendor.jpg" alt="logo" class="hidden img-logo"/>
</div>


<div class="dayer"></div>
{include "Web_Static::v2.0/html_tj.tpl"}
{static "v1.0/collect_new.js"}
</body>
</html>