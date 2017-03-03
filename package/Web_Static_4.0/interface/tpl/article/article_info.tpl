<!DOCTYPE html>
<html lang="en">
<head>
    {include file="Web_Static::v4.0/html_goto_mobile.tpl" url="m/article/{Func_NumEncode::e($page->id)}.html"}
    {include file="Web_Static::inc/head_meta.tpl"}
    {static "articles/article.css"}
    {static "v4.0/pop-list.css"}
    {static "v4.0/recommend.css"}
    {static "baike.v1.0/news.css"}

</head>
<body data-sid="{$page->baikeInfo['id']}">
{include file="Web_Static::inc/header_1.tpl"}
<div class="wrapper">
    <div class="crumb">
        <a href="{$_home}">首页</a>{if $page->baikeInfo['space_name']}> <a href="{$_home}site/{Func_Url::str_urlencode($page->baikeInfo['space_name'])}">{$page->baikeInfo['space_name']}{/if}</a> > <a href="" class="active">{$page->info['title']}</a>
    </div>
    <div class="clearfix">
        <div class="article-content">
        <h1>{$page->info['title']}</h1>
        <div class="des">
            <span>{$page->info['author']|default:"云SPACE"}</span>
            <span>{date('Y-m-d',$page->info['create_time'])}</span>
            <span>浏览量 {$page->info['counter_view']}</span>
            {*<span>评论</span>*}
        </div>
        <div class="content-a">
           <p>{$page->info['cont']}</p>
        </div>
        <div class="zan" data-id={$page->info['id']} id="zan">
            <span class="zan-i"></span><span class="num">{$page->info['counter_praise']}</span>
            <span class="cai-i"></span><span class="num">{$page->info['counter_tread']}</span>
        </div>
            {if $page->relateArticle}
            <div class="recommend-title clearfix">
                <i class="icon-rmd"></i><span>推荐阅读</span>
            </div>
            <div class="re-article-new clearfix">
                {foreach $page->relateArticle as $k=>$v}
                <div class="re-piece-new">
                    <a class="title" href="{$_home}article/{Func_NumEncode::e($v['id'])}.html">{$v['title']}</a>
                    <p class="des">
                        {mb_substr(strip_tags($v['des']),0,100,'utf-8')}
                    </p>
                </div>
                {/foreach}
            </div>
            {/if}
        <div class="tag clearfix">
            {foreach $page->info['tags_info'] as $k=>$v}
                <a href="{$_home}database?action=is_submit&search_type=project_library&keyword={Func_Url::str_urlencode($v)}&search_tag=1" target="_blank">{$v}</a>
            {/foreach}
        </div>
        <div class="share clearfix">
            <span>分享到:</span>
            <span>
            <div class="bdsharebuttonbox"><a href="#" class="bds_more" data-cmd="more"></a><a href="#" class="bds_qzone" data-cmd="qzone" title="分享到QQ空间"></a><a href="#" class="bds_tsina" data-cmd="tsina" title="分享到新浪微博"></a><a href="#" class="bds_tqq" data-cmd="tqq" title="分享到腾讯微博"></a><a href="#" class="bds_renren" data-cmd="renren" title="分享到人人网"></a><a href="#" class="bds_weixin" data-cmd="weixin" title="分享到微信"></a></div>
            <script>window._bd_share_config= { "common": { "bdSnsKey": { } ,"bdText":"","bdMini":"2","bdMiniList":false,"bdPic":"","bdStyle":"0","bdSize":"24" } ,"share": { } } ;with(document)0[(getElementsByTagName('head')[0]||body).appendChild(createElement('script')).src='http://bdimg.share.baidu.com/static/api/js/share.js?v=89860593.js?cdnversion='+~(-new Date()/36e5)];</script>
            </span>
        </div>
        {*<div class="collection-title clearfix">*}
            {*<div class="fl title-list">*}
                {*<a href="javascript:;" class="current">发表评论</a>*}
            {*</div>*}
        {*</div>*}

        {*<div class="comment-a">*}
            {*<p><a href="">登录 </a> 后参与评论</p>*}
        {*</div>*}

        {*<div class="">*}
            {*<button class="comment-btn">发表</button>*}
        {*</div>*}
        {*{if $page->relateArticle}*}
            {*<div class="collection-title clearfix">*}
                {*<div class="fl title-list">*}
                    {*<a href="javascript:;" class="current">相关文章</a>*}
                {*</div>*}
            {*</div>*}
            {*<div class="re-article clearfix">*}
                {*{foreach $page->relateArticle as $k=>$v}*}
                    {*<a class="re-piece" href="#">*}
                        {*<img src="{Page_Site_Global::displayMedia($v['logo'],"252","212")}" alt=""/>*}
                        {*<span class="mask"></span>*}
                        {*<div class="re-w">*}
                            {*<div class="re-vm">*}
                                {*<span class="title">{$v['title']}</span>*}
                                {*<span class="sub-title">{mb_substr(strip_tags($v['des']),0,40,'utf-8')}...</span>*}
                            {*</div>*}
                        {*</div>*}
                    {*</a>*}
                {*{/foreach}*}
            {*</div>*}
        {*{/if}*}
    </div>
        <div class="art-aside">
            {*相关百科*}
            {if $page->baikeInfo['space_name']}
            <div class="aside-top top-img-wrap">
                <a href="{$_home}site/{$page->baikeInfo['space_name']}{if $page->baikeInfo['level']==4}-百科{/if}" class="list-a">
                    <img src="{Page_Site_Global::displayMedia($page->baikeInfo['logo'],322,195)}" alt="">
                    <span class="mask"></span>
                    <span class="title">{$page->baikeInfo['space_name']}</span>
                    {*<div class="line"></div>*}
                    <span class="sub-title">{$page->baikeInfo['addr']}</span>
                    <div class="numb">
                        <div class="numb-in">
                            <p class="fr numb-right">{$page->baikeInfo['sum']}</p>
                            <p class="fl numb-left">{$page->baikeInfo['click']}</p>
                        </div>
                    </div>
                </a>
            </div>
            {/if}
            {*精品推荐*}
            <div class="recomend">
                <div class="recomend-title"><span>精选推荐</span></div>
                <div class="recomend-list">
                    {foreach $page->isGoodArticle as $k=>$v}
                        <a href="{$_home}article/{Func_NumEncode::e($v['id'])}.html" target="_blank">
                            <div class="recomend-list-li clearfix">
                                <div class="recomend-li-left fl">
                                    <div class="recomend-p"><span>{$v['title']}</span></div>
                                    <div class="recomend-time">
                                        <div class="news_des">
                                            <div class="news_gb">
                                                <div class="news_bad clearfix">{$v['counter_view']}</div>
                                                <div class="news_good">{$v['counter_praise']}</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="recomend-li-right fr">
                                    <img src="{Page_Site_Global::displayMedia($v['logo'],"80","57")}" alt="">
                                </div>
                            </div>
                        </a>
                    {/foreach}
                </div>
            </div>
            <div class="aside-tags">
                {if $page->baikeTags}
                    {foreach $page->baikeTags as $k=>$v}
                <a href="{$_home}site/{$page->baikeInfo['space_name']}-最新-{$k}-tags/{$v}" target="_blank">{$v}</a>
                    {/foreach}
                {/if}
            </div>
            {*最新文章*}
            <div class="fixed-wrap">
                <div class="fixed-piece" id="fixedPiece">
                    <div class="recomend-title mb20"><span>最新文章</span></div>
                    <ul class="consult-list">
                        {foreach $page->isNewArticle as $k=>$v}
                            <li>
                                <h3>
                                    <a href="{$_home}article/{Func_NumEncode::e($v['id'])}.html" class="consult-li" target="_blank">
                                        <div class="circle"></div>
                                        <div class="title"><span>{$v['title']}</span></div>
                                        <div class="time"><span>{Func_Time::Format($v['create_time'])}</span></div>
                                    </a>
                                </h3>
                            </li>
                        {/foreach}
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>
{include file="Web_Static::inc/public_space.tpl"}
{include file="Web_Static::inc/html_footer.tpl"}
{static "article/article.js"}
{static "core/yunspace.js"}
</body>
</html>