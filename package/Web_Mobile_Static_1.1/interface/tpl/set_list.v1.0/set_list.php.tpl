<!doctype html>
<html>
<head>
    {include "Web_Mobile_Static::v1.0/head_meta.tpl"}
    {include "Web_Mobile_Static::set_list.v1.0/inc.head_set_list.tpl"}
</head>
<body data-url="{$_home}set_list/get_list_for_mobile">
{*top*}
<div class="top">
    <div class="top_left">
        <a href="{$_home}"><i class="ion-ios-arrow-back"></i></a>
    </div>
    <div class="top-title">超值套餐</div>
    <div class="top_right">
        <a href="{$_home}search/set_list"><i class="ion-ios-search-strong"></i></a>
    </div>
</div>
{*guide*}
<div class="list-guide">
    <ul class="space-list-guide-content">
        <li id="nearby-li"><a id="nearby" href="#">附近</a></li>
        <li id="type-li"><a id="type-space" href="#">类型</a></li>
        <li id="filter-li"><a id="filter">筛选</a></li>
        <li id="sort-li"><a id="sort" href="#">排序</a></li>
    </ul>
</div>

{*nearby*}
<div class="nearby">
    <div class="nearby-left">
        <ul class="nearby-tab">
            <li class="nearby-active" data-value="nearbymi">附近</li>
            <li data-value="adminarea">行政区</li>
            <li data-value="businesscircle">热门商圈</li>
        </ul>
    </div>
    <div class="nearby-right">
        <ul class="nearby-area active">
            <li class="nearby-select" data-value="附近">附近<span>（智能范围）</span></li>
            <li data_type="500" id="nearbymi1" name="nearbymi" data-value="1">500米</li>
            <li data_type="1000" id="nearbymi2" name="nearbymi" data-value="2">500-1000米</li>
            <li data_type="2000" id="nearbymi3" name="nearbymi" data-value="3">1000-2000米</li>
            <li data_type="4000" id="nearbymi4" name="nearbymi" data-value="4">2000-4000米</li>
            <li data_type="10000" id="nearbymi5" name="nearbymi" data-value="5">4000-10000米</li>
        </ul>
        <ul class="nearby-administration">
            {foreach $page->filterAttr as $k=>$v}
                {if $k==4}
                    {foreach $v['val'] as $vk=>$vv}
                        {if $vv}
                            <li id="aa{substr(md5({$vk}),0,8)}" name="adminarea" data-value="{$vk}"
                                style="color: #000;">
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
                            <li id="bc{substr(md5({$vk}),0,8)}" name="businesscircle" data-value="{$vk}"
                                style="color: #000;">
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
    <ul class="space-type-content">
        {foreach $page->allCategory as $key=>$val}
        <li>
            <a href="#" id="category_id{$key}" name="category_id" data_value="{$key}" text_value="{$val}">{$val}</a>
        </li>
        {/foreach}
        <li class="show-all active"><a href="#" class="active" id="category_id0" name="category_id" data_value="0"
                                       text_value="超值套餐">所有类型</a></li>
    </ul>
</div>
{*filter*}
<div class="filter">
    <ul class="filter-tab">
        <li id="area-tab" class="filter-tab-active">
            <span class="area_tab"><p>人数</p><span1 class="area_tab_icon"></span1></span>
        </li>
        <li id="activity-tab">
            <span href="#" class="activity_tab"><p>天数</p><span1 class="activity_tab_icon"></span1></span>
        </li>
        <li style="margin-right: 0;" id="industry-tab">
            <span href="#" class="industry-tab"><p>价格区间</p><span1 class="industry_tab_icon"></span1></span>
        </li>
        <div class="clear"></div>
    </ul>
    <div class="filter-content">
        <ul id="area">
            {foreach $page->searchValue as $key =>$val}
                {if $key=="人数"}
                    {foreach $val as $kk=>$vv}
                        <li>
                            <a href="#" id="peoplenum{$kk}" name="peoplenum"  data-value="{$kk}"> {$vv}</a>
                        </li>
                    {/foreach}
                {/if}
            {/foreach}
        </ul>
        <ul id="activity">
            {foreach $page->searchValue as $key =>$val}
                {if $key=="天数"}
                    {foreach $val as $kk=>$vv}
                        <li>
                            <a href="#" id="daynum{$kk}" name="daynum" data-value="{$kk}"> {$vv}</a>
                        </li>
                    {/foreach}
                {/if}
            {/foreach}
        </ul>
        <ul id="industry">
            <input placeholder="￥" name="price_start" class="price-range-low" value="">
            <div class="middle-line">—</div>
            <input placeholder="￥" name="price_end" class="price-range-high" value="">
            <div class="unit">元</div>
            <button class="js-btn-confirm btn-confirm">确定</button>
            <button class="js-btn-clear btn-clear">清除</button>
        </ul>
    </div>
</div>

{*sort*}
<div class="sort">
    <ul class="sort-content">
        <li class="sort-active" id="orderBy1" name="orderBy" data_value="1">综合排序</li>
        <li id="orderBy3" name="orderBy" data_value="3">最热排序</li>
        <li id="orderBy2" name="orderBy" data_value="2">最新排序</li>
    </ul>
</div>
{*list*}
<div class="list-item">
    <ul>
        {foreach $page->getSetList['rows']  as $k=>$val}
            <li>
                <a href="{$_home}set_info/{$val->id}.html">
                    <div class="list-item-left">
                        {if $val->logo}
                            <img src="{Page_Site_Global::displayMedia($val->logo,275,195)}">
                        {else}
                            <img src="images/vendor.jpg">
                        {/if}
                    </div>
                    <div class="list-item-right">
                        <p class="name">{$val->set_name}</p>

                        <p class="address">地址:  {$val->addr}</p>

                        <p class="price">参考价格:&nbsp;
                            <span>{if $val->detail['套餐价']}
                            ￥{$val->detail['套餐价']}
                            {if $val->detail['计价单位']}
                                    /{$val->detail['计价单位']}
                                {/if}
                        {else}
                            面议
                        {/if}</span></p>
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
    <button type="button" class="btn btn-default btn-block button-load">
        加载更多...
    </button>
</div>
<div class="dayer"></div>
{include "Web_Static::v2.0/html_tj.tpl"}
</body>
</html>