<!doctype html>
<html>
<head>
    {include "Web_Mobile_Static::v1.0/head_meta.tpl"}
    {include "Web_Mobile_Static::space.v1.0/inc.head_space.tpl"}
</head>
<body data-url="{$_home}space/get_list_for_mobile">
{include "Web_Mobile_Static::v1.0/inc.nav.tpl"}

<div class="top">
    <div class="top_left">
        <a href="{$_home}"><i class="ion-ios-arrow-back"></i></a>
    </div>
    <div class="top-title">空间场地</div>
    <div class="top_right">
        <a href="{$_home}search/space"><i class="ion-ios-search-strong"></i></a>
    </div>
</div>

{*guide*}
<div class="list-guide">
    <ul class="space-list-guide-content">
        <li id="nearby-li"><a id="nearby" href="#">城市</a></li>
        <li id="type-li"><a id="type-space" href="#">类型</a></li>
        <li id="filter-li"><a id="filter">筛选</a></li>
        <li id="sort-li"><a id="sort" href="#">排序</a></li>
    </ul>
</div>

{*nearby*}
<div class="nearby">
    <div class="nearby-left">
        <ul class="nearby-tab">
            <li class="nearby-active" data-value = "nearbymi">城市</li>
            <li data-value="adminarea">行政区</li>
            <li data-value="businesscircle">热门商圈</li>
        </ul>
    </div>
    <div class="nearby-right">
        <ul class="nearby-area active">
            {foreach $_REQUEST['cities'] as $k=>$v}
            {*<li class="nearby-select" data-value="附近">城市<span>（智能范围）</span></li>*}
            <li data_type="500" id="nearbymi1" name="nearbymi" data-value="1" {if $_COOKIE['city']==$v} class="nearby-select"{/if} >
                <a href="{$_root}m/space?df_city={$v}">{$v}</a>
            </li>
            {/foreach}
            {*<li data_type="1000" id="nearbymi2" name="nearbymi" data-value="2" >500-1000米</li>*}
            {*<li data_type="2000" id="nearbymi3" name="nearbymi" data-value="3" >1000-2000米</li>*}
            {*<li data_type="4000"  id="nearbymi4" name="nearbymi" data-value="4" >2000-4000米</li>*}
            {*<li data_type="10000" id="nearbymi5" name="nearbymi" data-value="5" >4000-10000米</li>*}
        </ul>
        <ul class="nearby-administration">
            {foreach $page->filterAttr as $k=>$v}
                {if $k==4}
                    {foreach $v['val'] as $vk=>$vv}
                        {if $vv}
                            <li id="aa{substr(md5({$vk}),0,8)}"  name="adminarea"   data-value="{$vk}" style="color: #000;">
                                {$vk}
                            </li>
                        {/if}
                    {/foreach}
                {/if}
            {/foreach}
        </ul>
        <ul class="nearby-district">
            {foreach $page->filterAttr as $k=>$v}
                {if $k==2}
                    {foreach $v['val'] as $vk=>$vv}
                        {if $vv}
                            <li  id="bc{substr(md5({$vk}),0,8)}"   name="businesscircle"  data-value="{$vk}" style="color: #000;">
                                {$vk}
                            </li>
                        {/if}
                    {/foreach}
                {/if}
            {/foreach}
        </ul>
    </div>
    <div class="clear"></div>
</div>
{*type*}
<div class="space-type">
    {if $page->categoryId}
        <ul class="space-type-content">
            {$i=11}
            {foreach $page->categoryTree[$page->topCategoryId['topCategoryId']] as $k=>$v}
                {if $v}
                    <li><span class="space-icon-list"><img src="img/v1.0/icon{$i}.png"></span>
                        <a href="#" id="category_id{$k}" name="category_id" data_value="{$k}" text_value="{$v}">{$v}</a>
                    </li>
                    {$i=$i+1}
                {/if}
            {/foreach}
            <li class="show-all active"><a href="#" class="active" id="category_id0" name="category_id" data_value="0" text_value="空间场地">所有类型</a></li>
        </ul>
    {/if}
</div>
{*filter*}
<div class="filter">
    <ul class="filter-tab">
        <li id="area-tab" class="filter-tab-active">
            <span class="area_tab"><p>空间面积</p><span1 class="area_tab_icon"></span1></span>
        </li>
        <li id="activity-tab">
            <span href="#" class="activity_tab"><p>适合活动</p><span1 class="activity_tab_icon"></span1></span>
        </li>
        <li style="margin-right: 0;" id="industry-tab">
            <span href="#" class="industry-tab"><p>适合行业</p><span1 class="industry_tab_icon"></span1></span>
        </li>
        <div class="clear"></div>
    </ul>
    <div class="filter-content">
        <ul id="area">
            {foreach $page->size_range as $sizek=>$sizev}
                <li>
                    <a href="#" id="size_range{$sizek}" name="size_range" data-value="{$sizek}">{$sizev}</a>
                </li>
            {/foreach}
        </ul>
        <ul id="activity">
            {if $page->getPhoneAttr(1)}
                {foreach $page->getPhoneAttr(1) as $k=>$v}
                    <li><a href="#" id="activity{$k+1}" name="activity" data-value="{$v}">{$v}</a></li>
                {/foreach}
            {/if}
        </ul>
        <ul id="industry">
            {if $page->getPhoneAttr(2)}
                {foreach $page->getPhoneAttr(2) as $k=>$v}
                    <li><a href="#" id="industry{$k+1}" name="industry" data-value="{$v}">{$v}</a></li>
                {/foreach}
            {/if}
        </ul>
    </div>
</div>

{*sort*}
<div class="sort">
    <ul class="sort-content">
        <li class="sort-active" id="orderBy1" name="orderBy1" data_value="1">综合排序</li>
        <li id="orderBy3" name="orderBy3" data_value="3">最热排序</li>
        <li id="orderBy2" name="orderBy2" data_value="2">最新排序</li>
    </ul>
</div>
{*list*}
<div class="list-item">
    <ul>
        {foreach $page->getSpaceList['rows'] as $k=>$v}
            <li>
                <a href="{$_home}service_info/{$v['id']}.html">
                    <div class="list-item-left">
                        {if $v['logo']}
                            <img src="{Page_Site_Global::displayMedia($v['logo'],275,195)}">
                        {else}
                            <img src="img/v1.0/vendor.jpg">
                        {/if}
                    </div>
                    <div class="list-item-right">
                        <p class="name">{$v['product_name']}</p>

                        <p class="address">地址:  {$v['attr_index'][$page->tagsName['城市']]}市{$v['addr']}</p>

                        <p class="price">参考价格:&nbsp;
                            <span>{if $v['price']>0}<span1>¥&nbsp;</span1>{$v['price']}{else}面议{/if}</span></p>
                    </div>
                    <div class="clear"></div>
                </a>
            </li>
        {/foreach}
    </ul>
</div>
<div style="padding: 12px 12px 20px; ">
    <button type="button" class="button-load">
        加载更多...
    </button>
</div>
<div class="dayer"></div>
{include "Web_Static::v2.0/html_tj.tpl"}
</body>
</html>