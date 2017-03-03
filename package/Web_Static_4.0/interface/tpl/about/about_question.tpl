<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    {include file="Web_Static::inc/head_meta.tpl"}
    {static "v4.0/common.css"}
    {static "about/about.css"}
</head>
<body yun="about/about.js::aboutBox">
{include file="Web_Static::inc/header_1.tpl"}
<div class="about-location">
    <div class="wrapper">
        <div class="crumb">
            <a href="{$_home}">首页</a>&gt;<a href="{$_root}about" class="active">关于我们</a>
        </div>
    </div>
</div>
<div class="about_banner"></div>
<div class="wrapper about-wrapper clearfix">
    {include file="Web_Static::about/inc/left_nav.tpl"}

    <div class="about-content fr">
        <div class="about-title">
            <h2>常见问题</h2>
        </div>

        <h5>●&nbsp;退款流程说明</h5>
        <ul class="aboutBox">
            <li>
                <a href="javascript:;" class="box-title clearfix">
                    <span class="fl">Q：云·space”是啥意思？网站是什么定位？</span>
                    <span class="fr updown orange">+</span>
                </a>

                <p>A：云SPACE（www.yunspace.com.cn）隶属于上海星期网络科技有限公司（以下简称“云SPACE”或“平台”），于2012年3月诞生于上海，被誉为中国首家商业地产空间Airbnb。平台集线上空间展示、管理、预订为一体，配合线下顾问一对一服务，帮助活动方快速找到特色场地举办活动，提升活动品质与品牌形象，同时帮助场地方提高闲置空间的使用率，利用短租降低商业地产库存，盘活资产。</p>
            </li>
            <li class="height30">
                <a href="javascript:;" class="box-title clearfix">
                    <span class="fl">Q：营业模式</span>
                    <span class="fr updown">+</span>
                </a>

                <p>Q：营业模式Q：营业模式Q：营业模式Q：营业模式Q：营业模式Q：营业模式Q：营业模式Q：营业模式Q：营业模式Q：营业模式Q：营业模式Q：营业模式Q：营业模式Q：营业模式Q：营业模式Q：营业模式Q：营业模式Q：营业模式Q：营业模式Q：营业模式</p>
            </li>
            <li class="height30">
                <a href="javascript:;" class="box-title clearfix">
                    <span class="fl">Q：企业前景如何勘测？</span>
                    <span class="fr updown">+</span>
                </a>

                <p>7、责任心强、能承受一定的工作压力。</p>
            </li>
            <li class="height30">
                <a href="javascript:;" class="box-title clearfix">
                    <span class="fl">Q：对于最近的社会活动有什么看法或意见？</span>
                    <span class="fr updown">+</span>
                </a>

                <p>7、责任心强、能承受一定的工作压力。</p>
            </li>
        </ul>

        <a class="q-loading-more" href="javascript:;">加载更多...</a>

    </div><!--about-content-end-->
</div><!--wrapper-end-->
{include file="Web_Static::inc/html_footer.tpl"}
{include file="Web_Static::inc/public_space.tpl"}
</body>

</html>