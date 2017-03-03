<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    {include file="Web_Static::inc/head_meta.tpl"}
    {static "v4.0/common.css"}
    {static "about/about.css"}
    {static "baike.v1.0/news.css"}
    {static "baike.v1.0/news.js"}
</head>
<body>
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
            <h2>云SPACE官方新闻</h2>
        </div>

        {foreach $article['rows'] as $k=>$v}
            <div class="news_list clearfix" data-id="{$v['id']}">
                <div class="news_pic_one">
                    <a target="_blank" href="{$_home}article/{Func_NumEncode::e($v['id'])}.html">
                        {if $v['logo']}
                            <img src="{Page_Site_Global::displayMedia($v['logo'],"200","135")}" />
                        {else}
                            <img src="img/img_zu.jpg" />
                        {/if}
                    </a>
                </div>
                <div class="news_title_left">
                    <div class="news_title_outside1 clearfix">
                        <a target="_blank" href="{$_home}article/{Func_NumEncode::e($v['id'])}.html" class="news_title">{$v['title']}</a>
                        <p>
                            {$v['des']}
                        </p>
                    </div>
                    <div class="news_des">
                        <div class="news_gb">
                            <div class="news_bad clearfix">{$v['counter_view']}92</div>
                            <div class="news_good">{$v['counter_praise']}12</div>
                        </div>
                        <div class="user_time clearfix">
                            <span>{$v['author']|default:"云SPACE"}公关部</span>·<span>{Func_Time::format($v['create_time'])}七天前</span>
                        </div>
                    </div>
                </div>
            </div>
        {/foreach}

        {if $article['page']['dtp'] >1}
            <div class="pagers">
                {if $article['page']['dpll']}
                    <a href="{$article['page']['dup']}1" title="First">第一页</a>
                    <a href="{$article['page']['dup']}{$article['page']['dp']-1}"
                       title="Prev">上一页</a>
                {else}
                    <a href="" class="prev first gray"><span>&laquo;&nbsp;</span>第一页</a>
                    <a href="" class="prev gray">&lt;&nbsp;上一页</a>
                {/if}
                {for $i=$article['page']['dpl'] to $article['page']['dpr']}
                    <a href="{$article['page']['dup']}{$i}"{if $i==$article['page']['dp']} class="active"{/if}>{$i}</a>
                {/for}

                {if $article['page']['dprr']}
                    <a href="{$article['page']['dup']}{$article['page']['dp']+1}"
                       title="Next">下一页</a>
                    <a href="{$article['page']['dup']}{$article['page']['dtp']}"
                       title="Last">最后页</a>
                {else}
                    <a href="" class="next gray">下一页&nbsp;&gt;</a>
                    <a href="" class="next last gray">最后页<span>&nbsp;&raquo;</span></a>
                {/if}
            </div>
        {*{else}*}
            {*<div class=" fl clearfix" style="width:930px">*}
                {*{include file="Web::inc/service_list_fl_no_result.tpl"}*}
            {*</div>*}
        {/if}
        {* <a class="news-more" href="http://{Core::$urls['host']}/site/{Func_Url::str_urlencode("云SPACE")}">查看更多&gt;&gt;</a> *}

    </div><!--about-content-end-->
</div><!--wrapper-end-->
{include file="Web_Static::inc/html_footer.tpl"}
{include file="Web_Static::inc/public_space.tpl"}
</body>

</html>