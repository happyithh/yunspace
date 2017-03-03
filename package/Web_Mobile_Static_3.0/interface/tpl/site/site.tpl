{*{var_dump($page->info)}*}
<!DOCTYPE>
<html>
<head>
    {include file="Web_Static::v4.0/html_goto_pc.tpl" url="site/{Func_Url::str_urlencode($page->info['space_name'])}-{Func_Url::str_urlencode($page->baikeAction)}"}
    {include file="Web_Mobile_Static::inc/header_meta.tpl"}
    <meta name="full-screen" content="yes" />
    <meta name="x5-fullscreen" content="true" />
    {static "consultation/consultation.css"}
    {static "v4.0/font-awesome.min.css"}
    {static "encyclopedia/encyclopedia.css"}
    {static "sites/like_go.js"}
    {static "encyclopedias/encyclopedias.js"}
</head>
<body yun="site_article_m/site_article.js::init" yun-type="{if $page->baikeAction=='精华'}fine{/if}">
{include "Web_Mobile_Static::v1.0/inc.nav.tpl"}
<div class="content">
    <header class="con-header">
        <div class="con-img">
            <div class="img">
            {if !empty($page->info['mobile_logo'])}
            <img src="{Page_Site_Global::displayMedia($page->info['mobile_logo'],'1024','')}" alt="">
            {elseif !empty($page->info['logo'])}
                <img src="{Page_Site_Global::displayMedia($page->info['logo'],'1024','')}" alt="">
            {else}
                <img src="{Page_Site_Global::displayMedia($page->info['media'][0]['path'],'1024','')}" alt="">
            {/if}
            </div>
        </div>
        <div class="con-header-body">
            {include file="Web_Mobile_Static::site/inc/nav.tpl"}
            <div class="con-title" id="con-title" data-id="{$page->info['id']}">
                <span>{$page->info['space_name']}</span>
            </div>
            <div class="con-des">
                <span>{$page->info['special_tags']}</span>
            </div>
            <div class="con-data">
                <p class="con-date-look fl">
                    <span class="fa fa-eye"></span>
                    <span>{$count_num['sum']}</span>
                </p>

                <p class="con-date-person fl">
                    <span class="fa fa-user"></span>
                    {*<span>{$count_num['sum']}</span>*}
                    <span>{$count_num['is_love']+$count_num['is_go']}</span>
                </p>
            </div>
        </div>
        <a href="{$_home}site/{$page->info['space_name']}-百科-图片" class="con-pic">
            <span>{count($page->spaceMedia)}张</span>
        </a>
    </header>

    <div class="page-title">
        <span class="line"></span>
        {*{var_dump({$page->baikeActive})}*}
        <span>{$page->baikeAction}</span>
    </div>

    <div class="article-list" id="article-list">
        <!-- 只有一张图片的时候加padding-right -->
        {include file="Web_Mobile_Static::site/inc/site_new.tpl"}
    </div>
        <footer class="load-more-article" id="load-more-article">
            {if count($article_list)<10}
            已加载全部
            {else}
            <span class="more_data">点击加载..</span>
            {/if}
            <div class="loading none">
                {include file="Web_Mobile_Static::inc/loading.tpl"}
            </div>
        </footer>
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

</div>
{*{include file="Web_Mobile_Static::inc/to_top.tpl"}*}
{static "core/yunspace.js"}
</body>
</html>
