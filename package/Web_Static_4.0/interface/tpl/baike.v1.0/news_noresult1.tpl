<!DOCTYPE html>
<html>
<head>
    {include file="Web_Static::inc/head_meta.tpl"}
    {static "baike.v1.0/baike_common.css"}
    {static "baike.v1.0/news.css"}
    {static "baike.v1.0/noresult.css"}
    {static "baike.v1.0/banner.js"}
    {static "baike.v1.0/news.js"}
</head>
<body>
{include file="Web_Static::inc/header2.tpl"}
{include file="Web_Static::baike.v1.0/inc/baike_banner.tpl"}

<div class="container">
    <div class="news-content news-noresult">
        {include file="Web_Static::baike.v1.0/inc/collection_title.tpl"}
        <div class="news-noresult-cont news-noresult-cont1">
            <p class="prompt"><i></i><span>暂无相关内容</span></p>
        </div>
        <div class="news-noresult-code">
            <img src="img/baike.v1.0/code_sjh.jpg">
            <p>扫描二维码</p>
            <p class="join">加入<span>“奢居会空间派对会所”</span>讨论组，<br>
                一起来分享你的心得吧~</p>
        </div>
    </div>
    <div class="news_content_right">
        {include file="Web_Static::baike.v1.0/inc/person_side.tpl"}
    </div>
    <div class="clear"></div>

</div>
{include file="Web_Static::inc/public_space.tpl"}
{include file="Web_Static::inc/html_footer.tpl"}
{static "core/yunspace.js"}
</body>
</html>