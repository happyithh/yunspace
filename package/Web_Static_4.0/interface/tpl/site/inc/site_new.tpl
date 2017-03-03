{static "baike.v1.0/news.css"}
{static "baike.v1.0/news.js"}
{static "baike.v1.0/noresult.css"}
<div class="news-content">
{include file="Web_Static::site/inc/collection_title.tpl"}
    {*{var_dump($_tags)}*}
{*最新消息tab切换*}
    {if $article_list['rows'] || $_tags }
        <ul class="news_tabs">
            <li><a href="{$_home}site/{Func_Url::str_urlencode($page->info['space_name'],2)}#collection" {if empty($_tags)}class="news_tabs_active"{/if}> [
                    全部 ]</a></li>
            {foreach $tags as $k=>$v}
                <li>
                    <a href="{$_home}site/{Func_Url::str_urlencode($page->info['space_name'],2)}-{$page->baikeAction}-{$k}-tags/{$v}#collection" {if !empty($_tags) && $_tags==$k} class="news_tabs_active"{/if}>[ {$v}
                        ]</a></li>
            {/foreach}
            <div class="clear"></div>
        </ul>
    {/if}
{*最新消息列表多个图片开始*}
{*<div class="news_list">*}
    {*<div class="news_title_outside">*}
        {*<span class="news_title_top"></span>*}
        {*<span class="news_title_tag"><a href="#"> [推荐]</a></span>*}
        {*<a href="#" class="news_title"> 专注80、90后买车、用车新场景”云Space助力2015中国汽车生态</a>*}
        {*<div class="clear"></div>*}
    {*</div>*}
    {*<div class="news_pic_outside">*}
        {*<ul class="news_pic">*}
            {*<li><a href="#"> <img src="css/baike.v1.0/img/news_pic1.png" /> </a></li>*}
            {*<li><a href="#"><img src="css/baike.v1.0/img/news_pic1.png" /> </a></li>*}
            {*<li><a href="#"><img src="css/baike.v1.0/img/news_pic1.png" /> </a></li>*}
            {*<li><a href="#"><img src="css/baike.v1.0/img/news_pic1.png" /> </a></li>*}
            {*<div class="clear"></div>*}
        {*</ul>*}
    {*</div>*}
    {*<div class="news_des">*}
        {*<div class="news_gb">*}
            {*<div class="news_good">26</div>*}
            {*<div class="news_bad clearfix">5</div>*}
        {*</div>*}

        {*<div class="user_time clearfix">*}
            {*<span>小懒猫</span> · <span>4小时前</span>*}
        {*</div>*}
    {*</div>*}
{*</div>*}
{*最新消息列表多个图片结束*}
{if (!$_REQUEST['dp'] || $_REQUEST['dp']==1) && !$_tags}
{foreach $two_data as $k=>$v}
<div class="news_list" data-id="{$v['id']}">
    {if !empty($v['logo'])}
    <div class="news_title_left">
        <div class="news_title_outside1">
            <span class="news_title_top"></span>
            <span class="news_title_tag"><a href="#"> [推荐]</a></span>
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
    <div class="news_pic_one"><a target="_blank" href="{$_home}article/{Func_NumEncode::e($v['id'])}.html"><img src="{Page_Site_Global::displayMedia($v['logo'],"200","135")}" /></a> </div>
    {else}
        <div class="news_title_outside">
        <span class="news_title_top"></span>
        <span class="news_title_tag"><a href="#"> [推荐]</a></span>
        <a href="{$_home}article/{Func_NumEncode::e($v['id'])}.html" class="news_title"> {$v['title']}</a>
        <div class="clear"></div>
        </div>
        <div class="news_des">
        <div class="news_gb">
            <div class="news_bad clearfix">{$v['counter_view']}</div>
            <div class="news_good">{$v['counter_praise']}</div>
        </div>

        <div class="user_time clearfix">
        <span>{$v['author']|default:"云SPACE"}</span> · <span>{Func_Time::format($v['create_time'])}</span>
        </div>
        </div>
    {/if}
    <div class="clear"></div>
</div>
{/foreach}
{/if}
{if count($article_list['rows'])>0}
{*最新消息列表一个图片开始*}
{foreach $article_list['rows'] as $k=>$v}
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
                <span>{$v['author']|default:"云SPACE"}</span> · <span>{Func_Time::format($v['create_time'])}</span>
            </div>
        </div>
    {/if}
    <div class="clear"></div>
</div>
{*最新消息列表一个图片结束*}
{/foreach}
{else}
    {include file="Web_Static::site/inc/news_noresult_1.tpl"}
{/if}


{*{include file="Web_Static::inc/paging.tpl"}*}
<!--页码部分-->
{if $article_list['page']['dtp'] > 1}
    <div class="pagers">
        {if $article_list['page']['dpll']}
            <a href="{$article_list['page']['dup']}1" title="First">第一页</a>
            <a href="{$article_list['page']['dup']}{$article_list['page']['dp']-1}"
               title="Prev">上一页</a>
        {else}
            <a href="" class="prev first gray"><span>&laquo;&nbsp;</span>第一页</a>
            <a href="" class="prev gray">&lt;&nbsp;上一页</a>
        {/if}
        {for $i=$article_list['page']['dpl'] to $article_list['page']['dpr']}
            <a href="{$article_list['page']['dup']}{$i}"{if $i==$article_list['page']['dp']} class="active"{/if}>{$i}</a>
        {/for}

        {if $article_list['page']['dprr']}
            <a href="{$article_list['page']['dup']}{$article_list['page']['dp']+1}"
               title="Next">下一页</a>
            <a href="{$article_list['page']['dup']}{$article_list['page']['dtp']}"
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
<div class="news_content_right person_side">
    {*{include file="Web_Static::site/inc/person_side.tpl"}*}
</div>
<div class="clear"></div>
