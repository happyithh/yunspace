<!DOCTYPE html>
<html lang="en">
<head>
    {include file="Web_Static::inc/head_meta.tpl"}
    {static "classify/classify.css"}
</head>
<body yun="classify/classify.js::init">
{include file="Web_Static::inc/header_1.tpl"}
<div class="content">
    <div class="wrapper">
        <div class="nav-chunk clearfix">
            {*{var_dump($page->getType)}*}
            <a href="{$_home}sites/112" class="icon-chunk-1 icon-chunk {if $page->getType=='112'||!isset($page->getType)}active{/if}">
                <p>空间</p>
                <span class="arrow-d"></span>
            </a>
           <a href="{$_home}sites/200" class="icon-chunk-2 icon-chunk {if $page->getType=='200'}active{/if}">
                <p>文创</p>
               <span class="arrow-d"></span>
            </a>
            <a href="{$_home}sites/400" class="icon-chunk-3 icon-chunk {if $page->getType=='400'}active{/if}">
                <p>零售</p>
                <span class="arrow-d"></span>
            </a>
            <a href="{$_home}sites/300" class="icon-chunk-4 icon-chunk {if $page->getType=='300'}active{/if}">
                <p>发现</p>
                <span class="arrow-d"></span>
            </a>

        </div>

        <ul class="n-nav clearfix">
            {*{var_dump($page->getChildrenName)}*}
            {if !empty($page->getChildrenName[$page->getType])}
                <li class="{if !$page->getChildrenType}active{/if}"><a href="{$_home}sites/{$page->getType}">全部分类</a></li>
                {foreach $page->getChildrenName[$page->getType] as $k=>$v}
                    {if $v['name']!='写字楼'}
                    <li class="{if $page->getChildrenType==$v['id']}active{/if}"><a href="{$_home}sites/{$page->getType}-{$v['id']}-tags/{$v['name']}">{$v['name']}</a></li>
                    {/if}
                {/foreach}
            {/if}
        </ul>

        <div class="img-list clearfix">
            {foreach $page->getBaikeList['rows'] as $k=>$v}
            <div class="img-wrap">
                <a href="{$_home}site/{Func_Url::str_urlencode($v['space_name'])}" class="list-a">
                    <img src="{Page_Site_Global::displayMedia($v['logo'],376,256)}" alt=""/>
                    <div class="mark"></div>
                    <div class="text">
                        <div class="textInner">
                            <span class="name">{$v['space_name']}</span>
                            {if !empty($v['attr']['营销标题'])}
                                <span class="addr">{$v['attr']['营销标题']}</span>
                            {elseif !empty($v['addr'])}
                                <span class="addr">{$v['addr']}</span>
                            {else}
                                <span class="addr">...</span>
                            {/if}
                        </div>
                    </div>

                </a>
                <div class="operate">
                    <span class="icon-3 yun-icon "><i class=" "></i>{$v['is_go']}</span>
                    <span class="fl icon-4 yun-icon "><i class=" "></i>{$v['click']}</span>
                    <span class="fr icon-5 yun-icon"><i class=" "></i>{$v['article_sum']|default:0}</span>
                </div>

            </div>
            {/foreach}
        </div>
    </div>
    {include file="Web_Static::inc/paging_1.1.tpl"}
    {include file="Web_Static::inc/public_space.tpl"}
    {include file="Web_Static::inc/html_footer.tpl"}
</div>
{static "v4.0/jquery-1.11.min.js"}
{static "v4.0/jquery.easing.1.3.min.js"}
{static "core/yunspace.js"}

</body>
</html>