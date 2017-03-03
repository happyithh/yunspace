{*{var_dump($page->getArticleList)}*}
{static "baike.v1.0/news.css"}
{static "baike.v1.0/news.js"}

<div class="news-content">
    <div class="collection-title clearfix">
        <div class="fl title-list">
                    <a {if $page->getAction[1]=="new"}class="current"{/if} href="{$_home}article_list/{if count($page->getAction[0])}{$page->getAction[0]}-new{else}new{/if}">最新</a>
                <a {if $page->getAction[1]=="recommend"}class="current"{/if} href="{$_home}article_list/{if count($page->getAction[0])}{$page->getAction[0]}-recommend{else}recommend{/if}">精华</a>


        </div>
        <a class="fr btn-zu" href="{Web_Global::createRentSpaceUrl()}"><i class="icon"></i>一键租场地</a>
    </div>
    {*tags 切换*}
        <ul class="news_tabs">
            <li><a href="{$_home}article_list/{if count($page->getAction[1])}{$page->getAction[1]}{else}new{/if}" {if empty($page->getAction[0])}class="news_tabs_active"{/if}> [
                    全部 ]</a></li>
            {foreach $page->getCategory as $k=>$v}
                <li>
                    <a href="{$_home}article_list/{$k}-{$page->getAction[1]}" {if !empty($page->getAction[0]) && $page->getAction[0]==$k} class="news_tabs_active"{/if}>[ {$v}
                        ]</a></li>
            {/foreach}
            <div class="clear"></div>
        </ul>
{*最新消息列表一个图片开始*}
{foreach $page->getArticleList['rows'] as $k=>$v}
<div class="news_list" data-id="{$v['id']}">
    {if !empty($v['logo'])}
    <div class="news_title_left">
        <div class="news_title_outside1">
            <a target="_blank" href="{$_home}article/{Func_NumEncode::e($v['id'])}.html" class="news_title"> {$v['title']}</a>
            <div class="clear"></div>
        </div>
        <div class="news_des">
            <div class="news_gb">
                <div class="news_bad clearfix">{$v['counter_view']}</div>
                <div class="news_good">{$v['counter_praise']}</div>
            </div>
            <div class="user_time clearfix">
                <span>{$v['author']|default:"云SPACE"}</span>·<span>{Func_Time::format($v['create_time'])}</span>
            </div>
        </div>
    </div>

        <div class="news_pic_one">
            <a target="_blank" href="{$_home}article/{Func_NumEncode::e($v['id'])}.html">
                <img src="{Page_Site_Global::displayMedia($v['logo'],"200","135")}" />
            </a>
        </div>
    {else}
        <div class="news_title_outside">
            <a href="{$_home}article/{Func_NumEncode::e($v['id'])}.html" class="news_title"> {$v['title']}</a>
            <div class="clear"></div>
        </div>

        <div class="news_des">
            <div class="news_gb">
                <div class="news_bad clearfix">{$v['counter_view']}</div>
                <div class="news_good">{$v['counter_praise']}</div>
            </div>

            <div class="user_time clearfix">
                <span>{$v['author']|default:"云SPACE"}</span> · <span>{Func_Time::format($v['update_time'])}</span>
            </div>
        </div>
    {/if}
    <div class="clear"></div>
</div>
{*最新消息列表一个图片结束*}
{/foreach}


{*{include file="Web_Static::inc/paging.tpl"}*}
<!--页码部分-->
{if $page->getArticleList['page']['dt'] !=0}
    <div class="pagers">
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
{*{else}*}
    {*<div class=" fl clearfix" style="width:930px">*}
        {*{include file="Web::inc/service_list_fl_no_result.tpl"}*}
    {*</div>*}
{/if}
</div>
<div class="clear"></div>
