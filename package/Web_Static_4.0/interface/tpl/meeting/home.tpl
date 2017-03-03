<!DOCTYPE html>
<html lang="en">
<head>
    {include file="Web_Static::meeting/meeting_header.tpl"}
</head>
<body>
{include file="Web_Static::inc/header_1.tpl"}
<style>
    body{
        overflow-x: hidden;
    }
</style>
<div class="banner-wrapper">
    <div class="homebanner">
        <img src="img/meeting/home-banner-01.jpg">
        <div class="banner-btnwrap">
            <a class="fl orderbtn" href="#onekeyorder">一键下单</a>
            <a class="fr orderbtn" href="{$_home}meeting/hot_list" target="_blank">年会套餐</a>
        </div>
    </div>
</div>

<!--首页专题入口-->
<ul class="topic-entrance clearfix">
    <li>
        <a href="/meeting/largesize" target="_blank">
            <div class="text">
                <h2>7000㎡+<br>超大年会空间</h2>
                <span class="icon-in"></span>
            </div>
        </a>
    </li>
    <li>
        <a href="/meeting/midsize" target="_blank">
            <div class="text">
                <h2>500-3000㎡<br>中型企业年会</h2>
                <span class="icon-in"></span>
            </div>
        </a>
    </li>
    <li>
        <a href="/meeting/creative" target="_blank">
            <div class="text">
                <h2>200-500㎡<br>创意年会空间</h2>
                <span class="icon-in"></span>
            </div>
        </a>
    </li>
    <li>
        <a href="/meeting/nationsize" target="_blank">
            <div class="text">
                <h2>更多城市<br>创意年会空间</h2>
                <span class="icon-in"></span>
            </div>
        </a>
    </li>
</ul>

<!--一键下单-->
{include file="Web_Static::meeting/form.tpl"}
{include file="Web_Static::meeting/meeting_footer.tpl"}
</body>
</html>
