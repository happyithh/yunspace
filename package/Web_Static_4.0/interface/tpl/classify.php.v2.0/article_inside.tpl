<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    {include file="Web_Static::v4.0/html_goto_mobile.tpl" url="m/article/{Func_NumEncode::e($page->id)}.html"}
    {include file="Web_Static::inc/head_meta.tpl"}
    {static "v4.0/common.css"}
    {static "classify.v2.0/classify.css"}
</head>
<body>
{include file="Web_Static::inc/header_1.tpl"}
<div class="container clearfix">
    {literal}
        <script>window._bd_share_config={"common":{"bdSnsKey":{},"bdText":"","bdMini":"2","bdMiniList":false,"bdPic":"","bdStyle":"2","bdSize":"16"},"share":{}};with(document)0[(getElementsByTagName('head')[0]||body).appendChild(createElement('script')).src='http://bdimg.share.baidu.com/static/api/js/share.js?v=89860593.js?cdnversion='+~(-new Date()/36e5)];</script>
    {/literal}
    {*左侧悬浮导航*}
    <ul class="article_left_guide bdsharebuttonbox article_left_guide_fixed">
        <li class=""><a href="?" class="weibo bds_qzone" data-cmd="qzone" title="分享到QQ空间"></a></li>
        <li class=""><a href="?" class="tencent bds_tsina" data-cmd="tsina" title="分享到新浪微博"></a></li>
        <li class=""><a href="?" class="bds_tqq" data-cmd="tqq" title="分享到腾讯微博"></a></li>
        <li class=""><a href="?" class="bds_renren" data-cmd="renren" title="分享到人人网"></a></li>
        <li class="weixin"><a href="?" class="bds_weixin" data-cmd="weixin" title="分享到微信"></a></li>
    </ul>
{*左侧*}
<div class="classify_fl1">
    <div id="article_all">
        {include file="Web_Static::classify.php.v2.0/inc/inc.article.tpl"}
    </div>
    {*左侧加载更多按钮*}
    <a class="article_load_more load_more" id="article_inside_load_more" data-src="{$_home}load/article_inside_load_more" data-id="{Func_NumEncode::e($page->id)}" data-category="{$_REQUEST['category']}">
        <img src="img/classify.v2.0/acticle_inside_load.gif">
        <span>加载更多</span>
    </a>
</div>
{*右侧*}
    {include file="Web_Static::classify.php.v2.0/inc.right.v2.2.tpl"}
</div>
<div style="display: none">
    <input type="hidden" class="token_part1" value="{$token_part1}">
    <input type="hidden" class="token_part2" value="{$token_part2}">
    <input type="hidden" class="token_part3" value="{$token_part3}">
</div>
{include file="Web_Static::inc/html_footer.tpl"}
{include file="Web_Static::inc/public_space.tpl"}
{static "classify.v2.0/classify.js"}
{static "classify.v2.0/classify_painter.js"}
{static "classify.v2.0/article_info.js"}
</body>

</html>