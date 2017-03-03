<!doctype html>
<html>
<head>
    {include "Web_Mobile_Static::v1.0/head_meta.tpl"}
    {include "Web_Mobile_Static::service.v1.0/inc.head_service.tpl"}
</head>
<body data-url="{$_home}service/get_list_for_mobile">
{*top*}
<div class="top">
    <div class="top_left">
        <a href="{$_home}"><i class="ion-ios-arrow-back"></i></a>
    </div>
    <div class="top-title">配套服务</div>
    <div class="top_right">
        <a href="{$_home}search/service"><i class="ion-ios-search-strong"></i></a>
    </div>
</div>
{*guide*}
<div class="list-guide">
    <ul class="list-guide-content">
        <li id="type-li">
            <a id="type-service" href="#">类型</a></li>
        <li id="filter-li"><a id="filter">筛选</a></li>
        <li id="sort-li"><a id="sort" href="#">排序</a></li>
    </ul>
</div>
{*type*}
<div class="type">
    <ul class="type-content">
        {$ti=1}
        {foreach $page->categoryTree[0] as $k=>$v}
            {if $v}
                <li>
                    <span class="list-img"><img src="img/v1.0/icon0{$ti}.png"></span>
                    <a href="#" id="category_id{$k}" name="category_id" data_value="{$k}" text_value="{$v}">{$v}</a>
                </li>
            {/if}
            {$ti = $ti+1}
        {/foreach}
        <li class="show-all active">
            <a href="#" class="active" id="category_id0" name="category_id" data_value="0" text_value="配套服务">所有类型</a>
        </li>
    </ul>
</div>

{*filter*}
<div class="filter">
    <ul class="filter-tab">
        <li id="activity-tab" class="service-li filter-tab-active">
            <span href="#" class="activity_tab"><p>适合活动</p><span1 class="activity_tab_icon"></span1></span>
        </li>
        <li style="margin-right: 0;" id="industry-tab" class="service-li">
            <span href="#" class="industry-tab"><p>适合行业</p><span1 class="industry_tab_icon"></span1></span>
        </li>
        <div class="clear"></div>
    </ul>
    <div class="filter-content">
        <ul id="activity">
            {if $page->getPhoneAttr(1)}
                {foreach $page->getPhoneAttr(1) as $k=>$v}
                    <li>
                        <a href="#" id="activity{$k+1}" name="activity" data-value="{$v}">{$v}</a>
                    </li>
                {/foreach}
            {/if}
        </ul>
        <ul id="industry">
            {if $page->getPhoneAttr(2)}
                {foreach $page->getPhoneAttr(2) as $k=>$v}
                    <li>
                        <a href="#" id="industry{$k+1}" name="industry" data-value="{$v}">{$v}</a>
                    </li>
                {/foreach}
            {/if}
        </ul>
    </div>
</div>

{*sort*}
<div class="sort">
    <ul class="sort-content">
        <li class="sort-active" id="orderBy1" name="orderBy1" data_value="1">
            综合排序
        </li>
        <li id="orderBy3" name="orderBy3" data_value="3">
            最热排序
        </li>
        <li id="orderBy2" name="orderBy2" data_value="2">
            最新排序
        </li>
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
                            <img src="images/vendor.jpg">
                        {/if}
                    </div>
                    <div class="list-item-right">
                        <p class="name">{$v['product_name']}</p>
                        <p class="address">
                            {if Core::$urls['route'] =="space/"}
                            地址:  {$v['attr_index'][$page->tagsName['城市']]}
                            市{$v['addr']}</p>
                        {else}
                        供应商：{$page->vendors[$v['vendor_id']]['vendor_name']}
                        {/if}
                        <p class="price">参考价格:&nbsp;
                        <span>{if $v['price']>100}
                                <span1>¥&nbsp;</span1>
                                {$v['price']}{else}面议{/if}</span>
                        </p>
                    </div>
                    <div class="clear"></div>
                </a>
            </li>
        {/foreach}
    </ul>
</div>
<div id="topcontrol" class="" title="Scroll Back to Top">
    <img src="img/v1.0/up.png">
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