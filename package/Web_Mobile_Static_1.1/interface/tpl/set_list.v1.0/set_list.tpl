<!doctype html>
<html>
<head>
    {include "Web_Mobile_Static::v1.0/head_meta.tpl"}
    {include "Web_Mobile_Static::set_list.v1.0/inc.head_set_list.tpl"}
</head>
<body data-url="{$_home}space/get_list_for_mobile">
{*top*}
<div class="top">
    <div class="top_left">
        <a href="{$_home}"><img src="img/v1.0/list_02.png"/></a>
    </div>
    <div class="top-title">超值套餐</div>
    <div class="top_right">
        <a href="{$_home}search/space"><img src="img/v1.0/list_04.png"/></a>
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
        <li>
            <a href="#" id="category_id1" name="category_id" data_value="1" text_value="排队酒会">排队酒会</a>
        </li>
        <li>
            <a href="#" id="category_id2" name="category_id" data_value="2" text_value="发布会">发布会</a>
        </li>
        <li>
            <a href="#" id="category_id3" name="category_id" data_value="3" text_value="路演">路演</a>
        </li>
        <li>
            <a href="#" id="category_id4" name="category_id" data_value="4" text_value="年会">年会</a>
        </li>
        <li>
            <a href="#" id="category_id5" name="category_id" data_value="5" text_value="派对">派对</a>
        </li>
        <li>
            <a href="#" id="category_id6" name="category_id" data_value="6" text_value="会议">会议</a>
        </li>
        <li>
            <a href="#" id="category_id7" name="category_id" data_value="7" text_value="沙龙">沙龙</a>
        </li>
        <li>
            <a href="#" id="category_id8" name="category_id" data_value="8" text_value="亲子">亲子</a>
        </li>
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
            <li>
                <a href="#">20人以内</a>
            </li>
            <li>
                <a href="#">20-50人</a>
            </li>
            <li>
                <a href="#">50-100人</a>
            </li>
            <li>
                <a href="#">100-200人</a>
            </li>
            <li>
                <a href="#">200-500人</a>
            </li>
            <li>
                <a href="#">500人以上</a>
            </li>
        </ul>
        <ul id="activity">
            <li><a href="#">0.5天</a></li>
            <li><a href="#">1天</a></li>
            <li><a href="#">2天</a></li>
            <li><a href="#">3天</a></li>
            <li><a href="#">4天</a></li>
            <li><a href="#">5天以上</a></li>
        </ul>
        <ul id="industry">
            <form action="?" method="post">
                <input placeholder="￥" name="price[start]" class="price-range-low" value="">
                <div class="middle-line">—</div>
                <input placeholder="￥" name="price[end]" class="price-range-high" value="">
                <div class="unit">元</div>
                <button class="js-btn-confirm btn-confirm">确定</button>
            </form>
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
                            <img src="images/vendor.jpg">
                        {/if}
                    </div>
                    <div class="list-item-right">
                        <p class="name">{$v['product_name']}</p>

                        <p class="address">地址:  {$v['attr_index'][$page->tagsName['城市']]}市{$v['addr']}</p>

                        <p class="price">参考价格:&nbsp;
                            <span>{if $v['price']>0}
                                    <span1>¥&nbsp;</span1>
                                    {$v['price']}{else}面议{/if}</span></p>
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