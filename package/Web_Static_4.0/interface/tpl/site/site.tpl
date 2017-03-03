<!DOCTYPE html>
<html>
<head>
    {include file="Web_Static::v4.0/html_goto_mobile.tpl" url="m/site/{Func_Url::str_urlencode($page->info['space_name'])}-{Func_Url::str_urlencode($page->baikeAction)}"}
    {include file="Web_Static::inc/head_meta.tpl"}
    {static "v4.0/jquery-migrate-1.2.1.js"}
    {static "v4.0/common.css"}
    {static "baike.v1.0/baike_common.css"}
    {static "fancybox/fancybox.css"}
    {static "baike.v1.0/baike.css"}
    {static "baike.v1.0/banner.js"}

    {static "fancybox/jquery.fancybox-1.3.4.js"}
    {static "baike.v1.0/jquery.nav.js"}
    {static "baike.v1.0/baike.js"}

    {static "baike.v1.0/news.css"}
    {static "js/jquery-1.9.1.min.js"}
    {static "baike.v1.0/news.js"}
    {static "baike.v1.0/like_go.js"}


</head>
<body data-sid="{$page->info['id']}">
{if $page->info['logo']}
    {include file="Web_Static::inc/header_home.tpl"}
    {include file="Web_Static::site/inc/baike_banner.tpl"}
{else}
    {include file="Web_Static::inc/header_1.tpl"}
    {include file="Web_Static::site/inc/baike_no_banner.tpl"}
{/if}
<span class="media_all none">{$json_media}</span>
<div class="container">
        {if $page->baikeAction=="百科"}
            {if $page->info['category_id']==200}
                {include file="Web_Static::site/inc/site_baike_wenchuang.tpl"}
            {elseif $page->item_id}
                {include file="Web_Static::site/inc/site_item.tpl"}
            {else}
                {include file="Web_Static::site/inc/site_baike.tpl"}
            {/if}
        {elseif $page->baikeAction=="最新" || $page->baikeAction=="精华"}
            {include file="Web_Static::site/inc/site_new.tpl"}
        {elseif $page->baikeAction=="讨论组"}
            {include file="Web_Static::site/inc/site_comment.tpl"}
        {/if}
</div>

{*{include file="Web_Static::inc/share_weixin.tpl"}*}
{include file="Web_Static::site/inc/baike_pub.tpl"}
{include file="Web_Static::inc/public_space.tpl"}
{include file="Web_Static::inc/html_footer.tpl"}
{include file="Web_Static::inc/code.tpl"}
</body>

</html>
