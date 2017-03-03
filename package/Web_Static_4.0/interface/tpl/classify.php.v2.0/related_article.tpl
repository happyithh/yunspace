<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/html">
<head lang="en">
    <meta charset="UTF-8">
    {include file="Web_Static::v4.0/html_goto_mobile.tpl"}
    {include file="Web_Static::inc/head_meta.tpl"}
    {static "v4.0/common.css"}
    {static "classify.v2.0/classify.css"}
</head>
<body>
{include file="Web_Static::inc/header_1.tpl"}
<div class="related_head">
    <div class="related_head_content">
        <p class="ralated_title_line1">
            <span class="related_title1">“{$page->request}”</span>
            <span class="related_title2">相关文章</span>
        </p>

        <p class="ralated_title_line2">
            <span class="related_title3">热门标签推荐：</span>
            <span class="related_title3">
            {foreach $page->getNewTags as $key=>$val}
                <a href="{$_home}article_tags?tags={$key}" style="color: #FFffff;padding-right: 10px;">{$key}</a>
            {/foreach}
            </span>
            {*<span class="related_title3">悬浮   更美   无秘</span>*}
        </p>
    </div>
</div>
<div class="container clearfix">
    <div class="classify_back">
        <a href="javascript:history.go(-1)"> < 返回上级</a>
    </div>

    {*左侧*}
    <div class="classify_fl" style="margin-left: 170px;">
        {*左侧顶部tab区域*}
        <ul class="tags_tab">
            <li>
                <div class="tags_tab_active classify_tab " style="color:#222!important;">相关文章
                </div>
            </li>
        </ul>
        <div class="clear"></div>
        {*左侧list列表*}
        <div class="classify_content_outside">
            <div id="article_list_body" yun-load="http://{Core::$urls['host']}{Core::$urls['path']}"
                 yun-action="page_list_load_more"
                 yun-page="1" yun-page_max="{$page->getArticleList['page']['dtp']}"
                 yun-page_dt="{$page->getArticleList['page']['dt']}"
                 yun-token="{$token_part1}{$token_part2}{$token_part3}">
                {include "Web_Static::classify.php.v2.0/list/list.tpl"}
            </div>
            {*左侧加载更多按钮*}
            {if $page->getArticleList['rows']}
                <a class="classify_load_more load_more" data-page_body="#article_list_body">加载更多</a>
            {/if}
        </div>
        <div class="pagers" style="overflow: hidden;width: 0px;height: 0px;">
            {if $page->getArticleList['page']['dpll']}
                <a href="{$page->getArticleList['page']['dup']}1" title="First">第一页</a>
                <a href="{$page->getArticleList['page']['dup']}{$page->getArticleList['page']['dp']-1}"
                   title="Prev">上一页</a>
            {else}
                <a href="" class="prev first gray"><span>&laquo;&nbsp;</span>第一页</a>
                <a href="" class="prev gray">&lt;&nbsp;上一页</a>
            {/if}
            {for $i=$page->getArticleList['page']['dpl'] to $page->getArticleList['page']['dpr']}
                <a href="{$page->getArticleList['page']['dup']}{$i}"{if $i==$page->getArticleList['page']['dp']} class="active"{/if}>{$i}</a>
            {/for}
            {if $page->getArticleList['page']['dprr']}
                <a href="{$page->getArticleList['page']['dup']}{$page->getArticleList['page']['dp']+1}"
                   title="Next">下一页</a>
                <a href="{$page->getArticleList['page']['dup']}{$page->getArticleList['page']['dtp']}"
                   title="Last">最后页</a>
            {else}
                <a href="" class="next gray">下一页&nbsp;&gt;</a>
                <a href="" class="next last gray">最后页<span>&nbsp;&raquo;</span></a>
            {/if}
        </div>
    </div>
    <div style="display: none">
        <input type="hidden" class="token_part1" value="{$token_part1}">
        <input type="hidden" class="token_part2" value="{$token_part2}">
        <input type="hidden" class="token_part3" value="{$token_part3}">
    </div>

</div>
<script>
    window.onload = function () {
        $(window).scrollTop(0);
    }
</script>
{include file="Web_Static::inc/html_footer.tpl"}
{include file="Web_Static::inc/public_space.tpl"}
{static "classify.v2.0/classify.js"}
{static "core/yunspace.js"}
{static "classify.v2.0/classify_painter.js"}
</body>

</html>