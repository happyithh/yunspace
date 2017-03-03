<!DOCTYPE>
<html>
<head>
    {include file="Web_Static::v4.0/html_goto_pc.tpl" url="article/{Func_NumEncode::e($page->id)}.html"}
    {include file="Web_Mobile_Static::inc/header_meta.tpl"}
    <meta name="full-screen" content="yes" />
    <meta name="x5-fullscreen" content="true" />
    {static "comment/comment.css"}
    {static "article/article.css"}
    {static "v4.0/font-awesome.min.css"}
    {static "articles/article.js"}
</head>
<body class="article_body">
<div class="article_content">
    <div class="article_content_title">
        {$page->detail['title']}
    </div>
    <div class="article_content_des">
        <span class="article_author">{$page->detail['author']|default:"云SPACE"}</span>
        <span class="article_time">{date('Y-m-d H:s',$page->detail['create_time'])}</span>
    </div>
    <p>{$page->detail['content']}</p>
    {*<div class="article_content_zhan"></div>*}
</div>
<div class="article_content">
    <div class="article_content_title1">最新文章</div>
    <ul class="article_content_news">
        {foreach $page->newInformation as $k=>$v}
            <li><a href="{$_home}article/{Func_NumEncode::e($v['id'])}.html">{$v['title']}</a></li>
        {/foreach}
    </ul>
</div>




{static "core/yunspace.js"}
</body>
</html>
