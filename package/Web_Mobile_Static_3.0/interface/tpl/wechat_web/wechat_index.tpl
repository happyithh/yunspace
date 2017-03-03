{*{var_dump($page->info)}*}
<!DOCTYPE>
<html>
<head>
    {*{include file="Web_Static::v4.0/html_goto_pc.tpl" url="m/wechat_article"}*}
    {include file="Web_Mobile_Static::inc/header_meta.tpl"}
    <meta name="viewport" content="width=device-width" />
    <!-- UC强制全屏 -->
    <meta name="full-screen" content="yes" />
    <!-- QQ强制全屏 -->
    <meta name="x5-fullscreen" content="true" />
    {static "wechat_web/wechat_web.css"}
</head>
<body>
<ul class="weweb_content">
    {foreach $data as $k=>$v}
    <li>
        <a href="{$home}wechat_web_article_list?category_id={$v['id']}"><p>{$v['category']}</p></a>
        <img src="{$v['big_picture']}" alt="{$v['category']}">
    </li>
    {/foreach}
    {*<li>*}
        {*<a href="javascript:;"><p>零售短租</p></a>*}
        {*<img src="img/wechat_web/img-act.jpg" alt="零售短租">*}
    {*</li>*}
    {*<li>*}
        {*<a href="javascript:;"><p>场地空间</p></a>*}
        {*<img src="img/wechat_web/img-act.jpg" alt="场地空间">*}
    {*</li>*}
    {*<li>*}
        {*<a href="javascript:;"><p>文创IP</p></a>*}
        {*<img src="img/wechat_web/img-act.jpg" alt="文创IP">*}
    {*</li>*}
    {*<li>*}
        {*<a href="javascript:;"><p>专家视点</p></a>*}
        {*<img src="img/wechat_web/img-act.jpg" alt="专家视点">*}
    {*</li>*}
</ul>
{include file="Web_Mobile_Static::inc/to_top.tpl"}
{static "core/yunspace.js"}
{static "wechat_web/wechat_web.js"}
</body>
</html>

