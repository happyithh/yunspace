<!DOCTYPE html>
<html>
<head>
    {include file="Web_Static::inc/head_meta.tpl"}
    {static "baike.v1.0/baike_common.css"}
    {static "baike.v1.0/news.css"}
    {static "baike.v1.0/banner.js"}
    {static "baike.v1.0/news.js"}
</head>
<body>
{include file="Web_Static::inc/header2.tpl"}
{include file="Web_Static::baike.v1.0/inc/baike_banner.tpl"}

<div class="container">
    <div class="news-content news-noresult">
        {include file="Web_Static::baike.v1.0/inc/collection_title.tpl"}
        <div class="news-noresult-cont">
            <p class="prompt"><i></i><span>暂无相关内容</span></p>
        </div>
        <div class="news-noresult-recommend">
            <div class="recommend-title clearfix">
                <i class="icon-rmd"></i><span>推荐阅读</span>
            </div>
            <ul class="recommend-list clearfix">
                <li>
                    <a class="img" href=""><img src="img/baike.v1.0/img_remd.jpg"></a>
                    <a class="txt" href="">替其前任Neil Hardwick，后者在同年8月</a>
                </li>
                <li>
                    <a class="img" href=""><img src="img/baike.v1.0/img_remd.jpg"></a>
                    <a class="txt" href="">替其前任Neil Hardwick，后者在同年8月</a>
                </li>
                <li>
                    <a class="img" href=""><img src="img/baike.v1.0/img_remd.jpg"></a>
                    <a class="txt" href="">替其前任Neil Hardwick，后者在同年8月</a>
                </li>
                <li>
                    <a class="img" href=""><img src="img/baike.v1.0/img_remd.jpg"></a>
                    <a class="txt" href="">替其前任Neil Hardwick，后者在同年8月</a>
                </li>
            </ul>
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