{*{var_dump($page->info)}*}
<!DOCTYPE>
<html>
<head>
    {*{include file="Web_Static::v4.0/html_goto_pc.tpl" url="m/wechat_article"}*}
    {include file="Web_Mobile_Static::inc/header_meta.tpl"}
    <meta name="full-screen" content="yes" />
    <meta name="x5-fullscreen" content="true" />
    {static "consultation/consultation.css"}
    {static "v4.0/font-awesome.min.css"}
    {static "wechat/wechat.css"}
</head>
<body>
<div class="content">
    <div class="article-list" id="article-list">
        <!-- 只有一张图片的时候加padding-right -->
        {foreach $data as $k=>$v}
            <div class="article-li padding-right">
                {*<a  href="{if $v['status']==1 || $v['status']==2}{$v['article_url']} {else}http://weixin.sogou.com/weixin?type=2&query={Func_Url::str_urldecode($v['title'])}&ie=utf8{/if}>*}
                <a data-author="{$v['author']}" data-title="{$v['title']}" data-url="{$v['article_url']}"  href="javascript:;">
                    <header class="article-li-header">
                        {$v['title']}
                    </header>
                    <!-- 图片为主的文章 -->
                    <!-- 只有一张图片 -->
                    {if !empty($v['img'])}
                    <div class="article-li-body-two">
                        <!-- 图片为主的文章 -->
                        <div class="article-li-body-only">
                            <img src="{$v['img']}" alt="">
                        </div>
                    </div>
                    {/if}
                </a>
                <footer class="article-li-footer">
                    <p>{$v['author']|default:"云SPACE"}</p>
                    <p><span class="fa zan fa-thumbs-o-up " data-author="{$v['author']}" data-id="{$v['id']}"></span>&nbsp;<span>{$v['is_good']}</span></p>
                    <p><span class="fa fail fa-thumbs-o-down " data-author="{$v['author']}" data-id="{$v['id']}"></span>&nbsp;<span>{$v['is_bad']}</span></p>
                </footer>

            </div>
        {/foreach}
    </div>
    <footer class="load-more-article" id="load-more-article">
        {if count($data)<10}
            已加载全部
        {else}
            <span class="more_data">加载更多...</span>
        {/if}
        <div class="loading none">
            {include file="Web_Mobile_Static::inc/loading.tpl"}
        </div>

    </footer>
    <div id="clone-one" class="none">
        <div class="article-li padding-right">
            <a href="javascript:;" target="_blank">
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

                <p><span class="fa zan fa-thumbs-o-up " data-id=""></span>&nbsp;<span></span></p>
                <p><span class="fa fail fa-thumbs-o-down " data-id=""></span>&nbsp;<span></span></p>

            </footer>
        </div>
    </div>
    <div id="clone-two" class="none">
        <div class="article-li">
            <a href="javascript:;" target="_blank">
                <header class="article-li-header">
                </header>
            </a>
            <footer class="article-li-footer">
                <p></p>

                <p><span class="fa zan fa-thumbs-o-up"></span>&nbsp;<span></span></p>

                <p><span class="fa fail fa-thumbs-o-up"></span>&nbsp;<span></span></p>
            </footer>

        </div>
    </div>

</div>
{include file="Web_Mobile_Static::inc/to_top.tpl"}
{static "core/yunspace.js"}
{static "wechat/wechat.js"}
</body>
</html>

