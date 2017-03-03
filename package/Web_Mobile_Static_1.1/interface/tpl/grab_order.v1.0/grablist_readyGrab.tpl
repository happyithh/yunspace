<!DOCTYPE html>
<html>
<head lang="en">
    {include "Web_Mobile_Static::v1.0/head_meta.tpl"}
    {static "v1.0/global.css"}
    {static "grab_order.v1.0/grab.css"}
</head>
<body>
<div class="wrapper padding-bottom-68">
    <div class="grab-tab">
        <a class="fl alink current" href="ready">
            <span class="icon1 icon-grablist"></span>
            <p>待抢单</p>
        </a>
        <a class="fr alink" href="hv">
            <span class="icon2 icon-grablist"></span>
            <p>已接单</p>
        </a>
    </div>

    <div class="grab-comn clearfix">
        <div class="grab-comn-title clearfix">
            <div class="co-t clearfix">
                <p class="fl">等待抢单</p>
                <p class="fr time"><i class="icon_time"></i><span id="countdown1"></span></p>
            </div>
            <div class="co-b clearfix">
                <p class="fl">NO.123456</p>
                <div class="fr progress"></div>
            </div>
        </div>
        <a href="" class="grab-comn-cont clearfix">
            <div class="fl text clearfix">
                <p>活动人数：50人以下</p>
                <p>活动档期：1天,2015.07.01-2015.08.31</p>
                <p>活动预算：¥5000-¥20000</p>
            </div>
            <div class="fr btn-in clearfix"></div>
        </a>
    </div>
    <div class="grab-comn clearfix">
        <div class="grab-comn-title clearfix">
            <div class="co-t clearfix">
                <p class="fl">等待抢单</p>
                <p class="fr time"><i class="icon_time"></i><span>还剩19分30秒</span></p>
            </div>
            <div class="co-b clearfix">
                <p class="fl">NO.123456</p>
                <div class="fr state">已读</div>
            </div>
        </div>
        <a href="" class="grab-comn-cont clearfix">
            <div class="fl text clearfix">
                <p>活动人数：50人以下</p>
                <p>活动档期：1天,2015.07.01-2015.08.31</p>
                <p>活动预算：¥5000-¥20000</p>
            </div>
            <div class="fr btn-in"></div>
        </a>
    </div>

    <!--底部导航-->
    <div class="grab-menu">
        <a class="fl alink current" href="ready">
            <span class="icon1 icon-grabmenu"></span>
            <p>抢单</p>
        </a>
        <a class="fl alink" href="creat">
            <span class="icon2 icon-grabmenu"></span>
            <p>新建</p>
        </a>
        <a class="fl alink" href="credit">
            <span class="icon3 icon-grabmenu"></span>
            <p>积分</p>
        </a>
        <a class="fr alink" href="notice">
            <span class="icon4 icon-grabmenu"></span>
            <p>公告</p>
        </a>
    </div>

    <!--回到顶部按钮-->
    <div class="upward js-upward"></div>

    <!--置顶公告-->
    {*<div class="top-notice">1条新的公告</div>*}


</div><!--wrapper-end-->
{static "v1.0/jquery-1.11.1.min.js"}
{static "grab_order.v1.0/grab.js"}
{static "grab_order.v1.0/operation.js"}
<script>
    setInterval(operation.GetRTime,1000);
</script>
</body>
</html>