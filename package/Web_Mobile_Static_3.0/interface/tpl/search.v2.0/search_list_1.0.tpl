<!doctype html>
<html>
<head lang="en">
    {include file="Web_Static::v4.0/html_goto_pc.tpl" url="space"}
    <title>空间搜索</title>
    {include "Web_Mobile_Static::v1.0/head_meta.tpl"}
    {include "Web_Mobile_Static::search.v2.0/inc/inc.head_search.tpl"}
    {static "comment/comment.css"}
    {static "v3.0/nouislider.tooltips.css"}
    {static "v3.0/nouislider.pips.css"}
    {static "v3.0/nouislider.min.css"}
    {static "search.v.2.0/search.css"}
    {static "search.v.2.0/search.css"}
    {*{static "search.v2.0/search.js"}*}
    {static "search_about/search_about.css"}
    <!--引用百度地图API-->
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=aaNCRRcGGai6klHMOGZ8yBbP"></script>
</head>
<body data-root="{$_home}">
{include "Web_Mobile_Static::v1.0/inc.nav.tpl"}
{*<div class="mask"></div>*}
<div class="yun-load-tab none">
    <div style="position: relative;width:100%;
    height:100%">
        
        <div class="yun-load ">
            <div class="text">
                <span style="">云SPACE</span>
            </div>

        </div>
    </div>

</div>

{*顶部搜索框*}
<div id="list-search">
    <div class="search_top clearfix">
        <div class="back_icon">
            <a href="{$_home}" class="ion-ios-arrow-back" data-pack="ios" data-tags="chevron, left"></a>
        </div>
        <a class="search_input" data-src="{$_home}space_new/search" href="javascript:;"></a>
    </div>


    <div class="all-filter">
        <div class="cover none"></div>
        <div class="filter-fixed">
            {*顶部地址定位*}
            <div class="location clearfix">
                <div>
                    <span class="ion-ios-location-outline" data-pack="ios" data-tags="navigation, map, gps, pin"></span>
                <span class="location_addr">
                上海长宁区红坊创意园
                </span>
                    <a class="location_btn">更换</a>
                </div>
                {*<div class="filter_selected_item t1">*}
                {*&nbsp;&nbsp;<a href="#" class="ion-compose filter_selected_deleted" data-pack="default" data-tags="delete, trash, kill, x"></a>*}
                {*</div>*}
                {*<div class="filter_selected_item t2">*}
                {*0-5千&nbsp;&nbsp;<a href="#" class="ion-compose filter_selected_deleted" data-pack="default" data-tags="delete, trash, kill, x"></a>*}
                {*</div>*}
            </div>
            <div class="filter-ab">
                {*顶部筛选标题*}
                <div class="filter-title">
                    <ul class="clearfix">
                        <li class="filter-title-price" id="filter-title-price"><span>价格</span>&nbsp;&nbsp;<span
                                    class="ion-android-arrow-dropdown" data-pack="android"
                                    data-tags="chevron, navigation"></span></li>
                        <li class="filter-title_filter" id="filter-title_filter"><span>筛选</span>&nbsp;&nbsp;<span
                                    class="ion-android-arrow-dropdown" data-pack="android"
                                    data-tags="chevron, navigation"></span></li>
                        <li class="filter-title-sort" id="filter-title-sort"><span>综合排序</span>&nbsp;&nbsp;<span
                                    class="ion-android-arrow-dropdown" data-pack="android"
                                    data-tags="chevron, navigation"></span></li>
                        <div class="clear"></div>
                    </ul>
                </div>

                {*顶部筛选内容-价格tab*}
                <div class="filter-con" id="filter-price">
                    {include "Web_Mobile_Static::search.v2.0/inc/search_price.tpl"}
                </div>


                {*顶部筛选内容-筛选tab*}
                <div class="filter-con" id="filter-filter">
                    {include "Web_Mobile_Static::search.v2.0/inc/search_filter.tpl"}
                </div>
                {*顶部筛选内容-排序tab*}
                <div class="filter-con" id="filter-sort">
                    {include "Web_Mobile_Static::search.v2.0/inc/search_sort.tpl"}
                </div>

            </div>
        </div>

        {*筛选内容-排序tab*}
        <div class="filter-content" id="filter-content">
            <div class="circle none" id="circle"></div>
            {if count($page->getItemList['data']['rows'])>0}
                <ul class="filter-list">
                    {foreach $page->getItemList['data']['rows'] as $k=>$v}
                        <li class="clearfix">
                            <a href="{$_home}site/{Func_Url::str_urlencode($v['baike_name'])}-百科-{$v['item_id']}">
                                <div class="filter-list-img">
                                    {if !empty($v['baike_mobile_logo'])}
                                        <img src="{Page_Site_Global::displayMedia($v['baike_mobile_logo'],248,160)}"
                                             alt="{$v['baike_item_name']}"/>

                                        {if count($v['item_media'])>0}
                                            <div class="space-img-sum">{count($v['item_media'])}张</div>
                                        {/if}
                                    {else}
                                        <img src="img/search.v2.0/img_zu.jpg" alt=""/>
                                    {/if}
                                    {*<div class="space-img-sum">{count($v['item_media'])}张</div>*}
                                </div>
                                <div class="filter-list-right">
                                    <div class="space-title clearfix">
                                        <div class="space-name">{$v['baike_item_name']}</div>
                                        {*<div class="space-icon-active space-icon"></div>*}
                                        {*<div class="space-icon-default space-icon" data-id="{Func_NumEncode::e($v['item_id'])}"></div>*}
                                    </div>
                                    <div class="space-label clearfix">
                                        {if !empty($v['size'])}
                                            <div class="space-squer fl"><span></span>&nbsp;{$v['size']}㎡</div>
                                        {/if}
                                        {if !empty($v['addr'])}
                                            <div class="space-addr fl"><span></span>&nbsp;{$v['attr']['所属商圈']}</div>
                                        {/if}
                                        <div class="space-distance fr" data-geo_lat="{$v['geo_lat']}"
                                             data-geo_lng="{$v['geo_lng']}">&nbsp;</div>
                                    </div>
                                    <div class="space-price clearfix">
                                        {if !empty($v['min_price'])}
                                            <div class="space-price-symbol ion-social-yen fl" data-pack="social"
                                                 data-tags="currency, trade, money, japanese"></div>
                                            <div class="space-price-number fl">{$v['min_price']}</div>
                                            <div class="space-price-unit fl">{$v['price_unit']}&nbsp;起</div>
                                            <div class="space-price-icon ion-ios-arrow-right fl" data-pack="ios"
                                                 data-tags="chevron"></div>
                                        {else}
                                            <div class="space-price-unit fl">面议</div>
                                        {/if}
                                    </div>

                                    {*<a href="{$_home}site/{Func_Url::str_urlencode($v['baike_name'])}-百科-{Func_NumEncode::e($v['item_id'])}">*}

                                    {*</a>*}
                                    {*<a href="{$_home}site/{Func_Url::str_urlencode($v['baike_name'])}-百科-{Func_NumEncode::e($v['item_id'])}">*}

                                    {*</a>*}
                                </div>
                            </a>
                            <div class="space-icon-default space-icon"
                                 data-id="{$v['item_id']}" data-baike_id="{$v['baike_id']}" data-price="{$v['min_price']}"></div>
                        </li>
                    {/foreach}
                </ul>
            {/if}
            <!---用于js加载的数据无图片处理--->
            <img id="no-item-logo" src="img/search.v2.0/img_zu.jpg" alt="" style="display: none;"/>
            <div class="yun-loading">
                <div class="load-animate">
                    云SPACE疯狂加载中......
                </div>
            </div>
        </div>
        {*筛选内容-排序tab*}
        <a href="javascript:;" class="inquiry none" data-src="{$_home}space_new/consult">
            <div>
                <span>批量询价查档期</span>

                <p class="inquiry-sum">0</p>
            </div>
        </a>
        <a href="{$_home}inquiry" class="inquiry-2">
            <div>
                <span>一键租场地</span>
            </div>
        </a>
    </div>
</div>
<img src="img/search.v2.0/nospace.png" style="display: none" id="no-space">
<div class="search-body" id="search-body">

</div>
<div class="current-body" id="current-body">

</div>

{static "v3.0/nouislider.min.js"}
{static "search.v2.0/search.js"}
{static "core/yunspace.js"}
<div id="allmap" style="display:none"></div>
<script type="text/javascript">


</script>
</body>
</html>