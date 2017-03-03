<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    {include file="Web_Static::inc/head_meta.tpl"}
    {static "v4.0/common.css"}
    {*{static "v4.0/re-common.css"}*}
    {static "v4.0/jquery-slide-fade.min.css"}
    {static "v4.0/swiper.3.1.2.min.css"}
    {static "retail/classify.css"}
    {static "retail/retail_information.css"}
    <title>Title</title>
</head>
<body>
{include file="Web_Static::inc/header_1.tpl"}
{include file="Web_Static::insurance/consult_pop.tpl"}
<div class="retail-information clearfix">
    <div class="main-content fl">
        <div class="bn">
            <img src="{Page_Site_Global::displayMedia($page->detail['logo'],796,210)}" alt="">

            <p class="title">{$page->detail['title']}</p>

            <p class="des">{$page->detail['attr']['营销标题']}</p>
            <button class="pop-show">合作咨询</button>
        </div>
        <div class="message">
            <div class="small-title">品牌信息</div>
            <div class="content-cate">
                <ul class="table-list clearfix">
                    {foreach $page->detail['attr'] as $k=>$v}
                        {if $k!='营销标题'}
                            <li><span class="p1">{$k}</span>&nbsp;&nbsp;-&nbsp;&nbsp;<span class="p2">{$v}</span></li>
                        {/if}
                    {/foreach}
                    <li style="width:100%;">
                        <span class="p1">品牌简介</span>&nbsp;-&nbsp;
                    <span class="p2">{$page->detail['des']}
                    </span>
                    </li>
                </ul>
            </div>
            <div class="small-title">品牌图片</div>
            <div class="content-cate">
                <div class="pinpai-img">
                    <ul class="clearfix">
                        {foreach $page->detail['brand_pic'] as $k=>$v}
                        <li><img src="{Page_Site_Global::displayMedia($v['path'],244,161)}" alt=""></li>
                        {/foreach}

                    </ul>
                </div>

            </div>
            <div class="small-title">品牌详情</div>
            <div class="content-cate">
                <div class="des des-content">
                   {$page->detail['content']}
                </div>

            </div>
            <div class="small-title">品牌案例</div>
            <div class="content-cate">
                <div class="case-list">
                    <ul class="clearfix">
                        {foreach $page->detail['brand_case'] as $k=>$v}
                        <li>
                            <img src="{Page_Site_Global::displayMedia($v['path'],244,207)}" alt="">
                            <p>{$v['case_name']}</p>
                        </li>
                        {/foreach}
                    </ul>
                </div>
            </div>
        </div>
        <div class="content-recommend">
            <div class="small-title">精心推荐</div>
            <div class="success-case">
                <ul class="clearfix">
                    {foreach $page->recommend as $k=>$v}
                        <li {if $k==1}class="special-width"{/if}>
                            <a href="{$_home}retail/brand/{Func_NumEncode::e($v['id'])}.html">
                                <img  alt="" data-original="{if $k!=1}{Page_Site_Global::displayMedia($v['logo'],265,248)}{else}{Page_Site_Global::displayMedia($v['logo'],532,248)}{/if}">                                <p>{$v['title']}</p>
                            </a>
                        </li>
                    {/foreach}
                </ul>
            </div>
        </div>
    </div>
    {include file="Web_Static::retail/inc.slide.tpl"}
</div>





{include file="Web_Static::inc/html_footer.tpl"}
{include file="Web_Static::inc/public_space.tpl"}
{static "core/yunspace.js"}
{static 'insurance/insurance.js'}
{static "v4.0/jquery.lazyload.min.js"}
<script>
    $(function() {
        $("img").lazyload({
            effect : "fadeIn"
        });
    });
</script>
</body>
</html>

