<!DOCTYPE>
<html>
<head>
    {include "Web_Mobile_Static::v1.0/header_meta.tpl"}
    {include file="Web_Static::v4.0/html_goto_pc.tpl" url="article/{Func_NumEncode::e($page->id)}.html"}
    {include file="Web_Mobile_Static::inc/header_meta.tpl"}
    <meta name="full-screen" content="yes" />
    <meta name="x5-fullscreen" content="true" />
    {static "comment/comment.css"}
    {static "article/article.css"}
    {static "v4.0/font-awesome.min.css"}
    {static "v1.0/collect_article.js"}
    {static "articles/article_painters.js"}
</head>
<body class="article_body">
{include "Web_Mobile_Static::v1.0/inc.nav.tpl"}
<div class="article_content">
    <div class="article_content_title">
        {$page->info['title']}
    </div>
    <div class="article_content_des">
        <span class="article_author">{$page->info['author']|default:"云SPACE"}</span>
        <span class="article_time">{date('Y-m-d H:s',$page->info['create_time'])}</span>
    </div>
    <p>{$page->info['cont']}</p>
    <p style="margin-left: -10000px;height: 1px; overflow: hidden;"><img src="http://{Core::$urls['host']}/package/Web_Static_4.0/interface/assets/img/logo_0520.png"></p>
    {*<div class="article_content_zhan"></div>*}
    <ul class="article-zan-collect clearfix">
        <li class="zan-collect-btn fl article-zan zans">
            <a href="javascript:;" data-id="{$page->info['id']}">
                <i class="icon"></i>
                <span class="counter_praise" style="margin-left: 8px">{$page->info['counter_praise']}</span>
            </a>
        </li>
        <li class="collect js-favorite zan-collect-btn-collection fr article-collect" data-article_id="{Func_NumEncode::e($page->info['id'])}"
            data-article_counter_view="{$page->info['counter_view']}" data-article_logo="{$page->info['logo']}">
            <!--只做效果用-star-->
            <i class="js-star-move icon-star"></i>

            <i class="icon ion-android-star-outline"></i>
            <span>收藏</span>
        </li>
    </ul>
    <div class="share">
        <h5>分享到：</h5>
        <div class="share-list clearfix">
            <ul class="bdsharebuttonbox">
                <li>
                    <a href="#" class="bds_weixin" data-cmd="weixin" title="分享到微信"></a>
                    <span>朋友圈</span>
                </li>
                <li>
                    <a href="#" class="bds_tsina" data-cmd="tsina" title="分享到新浪微博"></a>
                    <span>新浪微博</span>
                </li>
                <li>
                    <a href="#" class="bds_sqq" data-cmd="sqq" title="分享到QQ好友"></a>
                    <span>QQ好友</span>
                </li>
                <li>
                    <a href="#" class="bds_qzone" data-cmd="qzone" title="分享到QQ空间"></a>
                    <span>QQ空间</span>
                </li>
            </ul>
            <script>
                window._bd_share_config={ "common":{ "bdSnsKey":{ },"bdText":"","bdMini":"2","bdMiniList":["qzone","bdysc","renren","bdxc","tqf","douban","sqq","ibaidu","mogujie","huaban","hx","youdao","qingbiji","xinhua","isohu","wealink","iguba","twi","h163","copy"],"bdPic":"","bdStyle":"1","bdSize":"32"},"share":{ },"image":{ "viewList":["weixin","tsina","sqq","qzone"],"viewText":"分享到：","viewSize":"32"},"selectShare":{ "bdContainerClass":null,"bdSelectMiniList":["weixin","tsina","sqq","qzone"]}};with(document)0[(getElementsByTagName('head')[0]||body).appendChild(createElement('script')).src='http://bdimg.share.baidu.com/static/api/js/share.js?v=89860593.js?cdnversion='+~(-new Date()/36e5)];
            </script>
        </div>

        {*<ul class="share-list clearfix">*}
        {*<li>*}
        {*<a href="javascript:;"><img src="img/service_info.v1.0/friends-world.png"><span>朋友圈</span></a>*}
        {*</li>*}
        {*<li>*}
        {*<a href="javascript:;"><img src="img/service_info.v1.0/friends-weixin.png"><span>微信好友</span></a>*}
        {*</li>*}
        {*<li>*}
        {*<a href="javascript:;"><img src="img/service_info.v1.0/sina.png"><span>新浪微博</span></a>*}
        {*</li>*}
        {*<li>*}
        {*<a href="javascript:;"><img src="img/service_info.v1.0/friends-qq.png"><span>QQ好友</span></a>*}
        {*</li>*}
        {*<li>*}
        {*<a href="javascript:;"><img src="img/service_info.v1.0/qq-space.png"><span>QQ空间</span></a>*}
        {*</li>*}
        {*</ul>*}
    </div>
</div>
<div class="article_content">
    <div class="article_content_title1">推荐阅读</div>
    <ul class="article_content_news">
        {foreach $page->relateArticle as $k=>$v}
            <li><a href="{$_home}article/{Func_NumEncode::e($v['id'])}.html">{$v['title']}</a></li>
        {/foreach}
    </ul>
</div>




{static "core/yunspace.js"}
{static "articles/article_painter.js"}

</body>
</html>
