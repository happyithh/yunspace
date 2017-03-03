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
<div class="container clearfix">
    {*左侧悬浮导航*}
    <ul class="classify_left_guide js-action classify_left_guide_fixed" >
        {foreach $page->getLeftMenuAndSeo as $key =>$val}
        <li class="{$val['icon']} {if $page->handleAction==$key} {$val['selected']}{/if}">
            <a href="{$_home}article_list/{if $key!=0}{$key}.html{/if}" {if $key!=0} data-value="{$key}"{/if}>
                    {$val['name']}
            </a>
        </li>
        {/foreach}
        {*<li class="classify_icon_space {if $page->handleAction==112} classify_icon_space_active{/if}">*}
            {*<a href="{$_home}article_list/112.html" data-value="112">*}
                    {*空间*}
            {*</a>*}
        {*</li>*}
        {*<li class="classify_icon_cultural {if $page->handleAction==200} classify_icon_cultural_active{/if}">*}
            {*<a href="{$_home}article_list/200.html" data-value="200">*}
                    {*文创*}
            {*</a>*}
        {*</li>*}
        {*<li class="classify_icon_retail {if $page->handleAction==400} classify_icon_retail_active{/if}">*}
            {*<a href="{$_home}article_list/400.html" data-value="400">*}
                    {*零售*}
            {*</a>*}
        {*</li>*}
        {*<li class="classify_icon_find {if $page->handleAction==300} classify_icon_find_active{/if}">*}
            {*<a href="{$_home}article_list/300.html" data-value="1">*}
                    {*发现*}
            {*</a>*}
        {*</li>*}
    </ul>
    {*左侧*}
    <div class="classify_fl">
        {*左侧顶部tab区域*}
        <ul class="tags_tab">
            <li>
                <div yun="page/search.js::request@click" yun-submit='1'
                     yun-page_body='#article_list_body' name="category" class="tags_tab_active classify_tab div_box"
                     data-value="{$page->handleAction}">全部
                </div>
            </li>
            {foreach $page->getArticleClass as $k=>$val}
                <li>
                    <div class="classify_tab classify_tag div_box">
                       <span yun="page/search.js::request@click" yun-page_body='#article_list_body' yun-submit="1"
                             name="category" value="{key($val)}">{reset($val)}</span>

                          <ul class=" classify_tab_ul">
                              <div class="classify_tab_div">
                            {foreach $val as $kk=>$vv}
                                <li yun="page/search.js::request@click" yun-submit='1'
                                    yun-page_body='#article_list_body' name="category" value="{$kk}">{$vv}
                                </li>
                                <a href="{Core::$urls['url']}" style="display: none;"></a>
                            {/foreach}
                                  </div>
                          </ul>

                    </div>
                </li>
            {/foreach}
            <li id="classify_article_more">
                <a href="#"> 更多>></a>
            </li>
        </ul>
        {*<a class="classify_more clearfix" href="javascript:;">更多>></a>*}

        <div class="clear"></div>
        {*左侧list列表*}
        <div class="classify_content_outside">
            <div id="article_list_body" yun-load="http://{Core::$urls['host']}{Core::$urls['path']}" yun-action="page_list_load_more"
                 yun-page="1" yun-page_max="{$page->getArticleList['page']['dtp']}"
                 yun-page_dt="{$page->getArticleList['page']['dt']}" yun-token="{$token_part1}{$token_part2}{$token_part3}">
                {include "Web_Static::classify.php.v2.0/list/list.tpl"}
            </div>
            {*左侧加载更多按钮*}
            {if $page->getArticleList['rows']}
                {*<a href="" >加载更多</a>*}
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
    {include file="Web_Static::classify.php.v2.0/inc.right.v2.1.tpl"}
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