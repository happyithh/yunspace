<!DOCTYPE>
<html>
<head>
    {include file="Web_Mobile_Static::inc/header_meta.tpl"}
    <meta name="full-screen" content="yes" />
    <meta name="x5-fullscreen" content="true" />
    {static "comment/comment.css"}
    {static "consultation/consultation.css"}
    {static "v4.0/font-awesome.min.css"}
    {static "v1.0/jquery-1.11.1.min.js"}
    {static "articles/article_list.js"}
    <!--{static "articles/article.js"}-->
</head>
<body class="article_body">
{include "Web_Mobile_Static::v1.0/inc.nav.tpl"}
<header class="header">
    <a href="{$_root}m/" class="back"><span class="fa fa-chevron-left"></span></a>
    <div class="title">{$page->seo['网页标题']}</div>
</header>
<div id="article-list" style="margin-top:44px;">
    {foreach $page->articleList as $k=>$v}
    {if empty($v['logo'])}
    <div class="article-li">
        <a href="{$_home}article/{$v['id']}.html">
            <header class="article-li-header">
                {$v['title']}
            </header>
        </a>
        <footer class="article-li-footer">
            <p>{$v['author']|default:"云SPACE"}</p>

            <p><span class="fa fa-thumbs-o-up"></span>&nbsp;<span>{$v['counter_praise']}</span></p>

            <p><span class="fa fa-eye"></span>&nbsp;<span>{$v['counter_view']}</span></p>
        </footer>

    </div>
    {else}
    <div class="article-li padding-right">
        <a href="{$_home}article/{$v['id']}.html">
            <header class="article-li-header">
                {$v['title']}
            </header>
            <!-- 只有一张图片 -->
            <div class="article-li-body-two">
                <!-- 图片为主的文章 -->
                <div class="article-li-body-only">
                    <img src="{$v['logo']}" alt="">
                </div>
            </div>
        </a>
        <footer class="article-li-footer">
            <p>{$v['author']|default:"云SPACE"}</p>

            <p><span class="fa fa-thumbs-o-up"></span>&nbsp;<span>{$v['counter_praise']}</span></p>

            <p><span class="fa fa-eye"></span>&nbsp;<span>{$v['counter_view']}</span></p>
        </footer>

    </div>
    {/if}
    {/foreach}
</div>
<div id="clone-one" class="none">
    <div class="article-li padding-right">
        <a href="{$_home}article/">
            <header class="article-li-header">
                {$v['title']}
            </header>
            <!-- 只有一张图片 -->
            <div class="article-li-body-two">
                <!-- 图片为主的文章 -->
                <div class="article-li-body-only">
                    <img src="" alt="">
                </div>
            </div>
        </a>
        <footer class="article-li-footer">
            <p></p>

            <p><span class="fa fa-thumbs-o-up"></span>&nbsp;<span></span></p>

            <p><span class="fa fa-eye"></span>&nbsp;<span></span></p>
        </footer>
    </div>
</div>
<div id="clone-two" class="none">
    <div class="article-li">
        <a href="{$_home}article/">
            <header class="article-li-header">
            </header>
        </a>
        <footer class="article-li-footer">
            <p></p>

            <p><span class="fa fa-thumbs-o-up"></span>&nbsp;<span></span></p>

            <p><span class="fa fa-eye"></span>&nbsp;<span></span></p>
        </footer>

    </div>
</div>
<footer class="load-more-article" id="load-more-article">

    {if count($page->articleList)<10}
        已加载全部
    {else}
    <div class="loading">
        {include file="Web_Mobile_Static::inc/loading.tpl"}
    </div>
    {/if}
</footer>
{*{include file="Web_Mobile_Static::inc/to_top.tpl"}*}
{static "core/yunspace.js"}
</body>
</html>
