<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    {include file="Web_Static::inc/head_meta.tpl"}
    {static "v4.0/common.css"}
    {static "special/space_special.css"}
    <link href="http://vjs.zencdn.net/5.10.4/video-js.css" rel="stylesheet">
    <!-- If you'd like to support IE8 -->
    <script src="http://vjs.zencdn.net/ie8/1.1.2/videojs-ie8.min.js"></script>
</head>
<body>
{include file="Web_Static::inc/header_1.tpl"}
<div class="about-location">
    <div class="wrapper">
        <div class="crumb">
            <a href="{$_home}">首页</a>&gt;<a href="{$_home}topic_list" class="active">专题</a>
        </div>
    </div>
</div>

<div class="baike-banner">
    <span class="carousel-control left"></span>

    <div class="baike-banner-img yun-slider" id="bannerBaike">
        <div class="wrap clearfix">
            {*<div class="item"><img src="img/home/banner.jpg"></div>*}
            <div class="item">
                <a href="javascript:;">
                    <img src="img/special/market.png"> 
                </a>
            </div>
            <div class="item">
                <a href="javascript:;">
                    <img src="img/special/hot_market.jpg"> 
                </a>
            </div>
            <div class="item">
                <a href="javascript:;">
                    <img src="img/special/terrace.jpg"> 
                </a>
            </div>
            <div class="item">
                <a href="javascript:;">
                    <img src="img/special/show.jpg"> 
                </a>
            </div>
        </div>

    </div>
    <span class="carousel-control right"></span>
    <ul class="banner-btn" id="bannerNav">
    </ul>
</div>
<!--baike-banner-end-->


<div class="wrapper special-wrapper clearfix">
    {* <div class="special-title clearfix">
        <a class="active" href="javascript:;">全部专题</a>
        <a href="javascript:;">推荐专题</a>
    </div> *}
    <div class="special-cont">

        <ul class="home-recommend-list clearfix">
            {foreach $page->topicList['rows'] as $k=>$v}
                <li>
                    <a href="{$_home}topic/{$v['topic_url']}">
                        <div class="coverr"></div>
                        <div class="home-recommend-img">
                            {if $v['small_logo']}
                                <img src="{Page_Site_Global::displayMedia($v['small_logo'],280,280)}" alt="{$v['topic_name']}"/>
                            {else}
                                <img src="{Page_Site_Global::displayMedia($v['big_logo'],280,280)}" alt="{$v['topic_name']}"/>
                            {/if}
                        </div>
                        <div class="home-recommend-text">
                            <div class="body">
                                <p class="home_tab_text1">
                                    {if $v['home_title']}
                                        {$v['home_title']}
                                    {else}
                                        {$v['topic_title']}
                                    {/if}
                                </p>

                                <p class="home_tab_text2">——
                                    {if $v['home_summary']}
                                        {$v['home_summary']}
                                    {else}
                                        {$v['topic_des']}
                                    {/if}
                                </p>
                            </div>
                            <div class="body_mask"></div>
                        </div>
                    </a>
                </li>
            {/foreach}
        </ul>

        <!--页码部分-->
        {if $page->topicList['page']['dtp'] !=0 && $page->topicList['rows']}
            <div class="pagers">
                {if $page->topicList['page']['dpll']}
                    <a href="{$page->topicList['page']['dup']}1" title="First">第一页</a>
                    <a href="{$page->topicList['page']['dup']}{$page->topicList['page']['dp']-1}"
                       title="Prev">上一页</a>
                {else}
                    <a href="" class="prev first gray"><span>&laquo;&nbsp;</span>第一页</a>
                    <a href="" class="prev gray">&lt;&nbsp;上一页</a>
                {/if}
                {for $i=$page->topicList['page']['dpl'] to $page->topicList['page']['dpr']}
                    <a href="{$page->topicList['page']['dup']}{$i}"{if $i==$page->topicList['page']['dp']} class="active"{/if}>{$i}</a>
                {/for}

                {if $page->topicList['page']['dprr']}
                    <a href="{$page->topicList['page']['dup']}{$page->topicList['page']['dp']+1}"
                       title="Next">下一页&nbsp;&gt;</a>
                    <a href="{$page->topicList['page']['dup']}{$page->topicList['page']['dtp']}"
                       title="Last">最后页&nbsp;&raquo;</a>
                {else}
                    <a href="" class="next gray">下一页&nbsp;&gt;</a>
                    <a href="" class="next last gray">最后页<span>&nbsp;&raquo;</span></a>
                {/if}
            </div>
        {/if}
    </div><!--special-cont-end-->
</div><!--wrapper-end-->
{include file="Web_Static::inc/html_footer.tpl"}
{include file="Web_Static::inc/public_space.tpl"}

<script>
    $('#bannerBaike').YunSlide({
        delay: 5000,
        nav: '#bannerNav',
        next: '.carousel-control.right',
        prev: '.carousel-control.left'
    });
    document.onreadystatechange = function () {
        if (document.readyState == 'complete') { //当页面加载状态
            $(".wrap").find('.item').each(function (k, d) {
                var $d = $(d);
                if ($d.find('img').attr('_src')) {
                    $d.find('img').attr('src', $d.find('img').attr('_src'));
                }
            })
        }
    }
</script>
</body>
</html>