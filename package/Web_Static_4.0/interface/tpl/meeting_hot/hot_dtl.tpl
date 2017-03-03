<!doctype html>
<html lang="en">
<head>
    {include file="Web_Static::meeting-hot/hot_header.tpl"}
    {static "map.v1.0/map_common.css"}
    <style>
        @media (min-width: 991px){
            .container {
                width: 1200px !important;
            }
        }
    </style>
</head>
<body>
{include file="Web_Static::inc/header_1.tpl"}
<div class="container">
    <div class="hot-location clearfix">
        <a href="{$_home}meeting">年会专题</a><span>&gt;</span>
        <a href="{$_home}meeting/hot_list">热卖套餐</a><span>&gt;</span>
        <a href="{$_home}meeting/hot_list">{$page->detail['category']}</a><span>&gt;</span>
        <p>{if $page->detail['space_name']!=$page->detail['item_name']}{$page->detail['space_name']}--{$page->detail['item_name']}{else}{$page->detail['space_name']}{/if}</p>
    </div>

    <div class="spacetop clearfix">
        <div class="space-carousel col-md-6 col-xs-12">
            <div class="swiper-container">
                <div class="swiper-wrapper">
                    {if $page->detail['info_img']}
                        {foreach  $page->detail['info_img'] as $k=>$v}
                            <div class="swiper-slide">
                                <a href="javascript:;"><img src="{$v['path']}"></a>
                            </div>
                        {/foreach}
                    {else}
                        <div class="swiper-slide">
                            <a href=""><img src="img/meeting/hot-item/space-banner.png"></a>
                        </div>
                    {/if}
                    {*<div class="swiper-slide">*}
                        {*<a href=""><img src="img/meeting/hot-item/space-banner.png"></a>*}
                    {*</div>*}
                    {*<div class="swiper-slide">*}
                        {*<a href=""><img src="img/meeting/hot-item/space-banner.png"></a>*}
                    {*</div>*}
                </div>
                <div class="yun-swiper-prev">
                    <span class="icon-arrowleft black"></span>
                </div>
                <div class="yun-swiper-next">
                    <span class="icon-arrowright black"></span>
                </div>

            </div>
        </div>
        <div class="spacetop-cont col-md-6 col-xs-12">
            <div class="title">{if $page->detail['space_name']!=$page->detail['item_name']}{$page->detail['space_name']}--{$page->detail['item_name']}{else}{$page->detail['space_name']}{/if}</div>
            <p class="explan">{$page->detail['space_info']}</p>
            <div class="price-cont clearfix">
                <div class="spprice col-md-8 col-sm-8 col-xs-12">
                    <p>云SPACE特价</p>
                    <div class="price">
                        <strong>¥ {$page->detail['new_price']}／天</strong>
                        <span>起 {$page->detail['remarks']}</span>
                    </div>
                </div>
                <div class="origprice col-md-4 col-sm-4 col-xs-12">
                    <p>云SPACE原价</p>
                    <div class="price">
                        <strong>¥ {$page->detail['old_price']}/天</strong>
                    </div>
                </div>
            </div>

            <div class="about-spec">
                <p><span class="title">套餐期限：</span>{$page->detail['start_time']} - {$page->detail['end_time']}</p>
                <p><span class="title">可容纳桌数：</span>{$page->detail['max_seat']}桌</p>
                <p><span class="title">预订数量限制：</span>{$page->detail['start_seat']}桌起订</p>
                {*<p><span class="title">场地面积：</span>{if $page->detail['is_outside']}室内{else}室外{/if}{$page->detail['area']}㎡</p>*}
                <p><span class="title">场地面积：</span>室内{$page->detail['area']}㎡</p>
            </div>
            <div class="orderbtn js-showform" data-id="{$page->detail['id']}" data-space_name="{$page->detail['space_name']}-{$page->detail['item_name']}">立即预订</div>
        </div><!--space-cont-end-->
    </div><!--spacedtl-end-->

    <div class="spacedtl clearfix col-md-8 col-xs-12">
        <ul class="navlist clearfix">
            <li data-id="intro" class="current col-md-4 col-sm-4 col-xs-4"><a href="javascript:;">空间介绍</a></li>
            <li data-id="dtl" class="col-md-4 col-sm-4 col-xs-4"><a href="javascript:;">套餐详情</a></li>
            <li data-id="notice" class="col-md-4 col-sm-4 col-xs-4"><a href="javascript:;">预订须知</a></li>
        </ul>

        <!--空间介绍-->
        <div class="title fl clearfix"  id="intro">
            <h5 class="fl">空间介绍</h5>
            <a href="{$_home}site/{Func_Url::str_urlencode($page->detail['space_name'],1)}" TARGET="_blank" class="fr">查看空间详情<span class="icon-arw">&gt;</span></a>
        </div>
        <div class="text">
            {$page->detail['space_des']}
            {*<p>上海第一家“电影会所”，拥有一个“小型电影院”和一个“数码播放厅”。除此之外，“华大”还拥有顶级的“潮州菜”厨师班底，有着许多别家餐厅品尝不到的“经典潮州菜”。拥有一个“超大露台”和“雪茄吧”，大厅餐位“懒散”摆开，“不多但舒适”，适合需要“私秘性”的各种聚会。</p>*}
        </div>
        {*<div class="img"><img src="img/meeting/hot-item/banner-sm.jpg"></div>*}
        <div class="place">套餐位置：{$page->detail['addr']}</div>

        <div class="map" id="map">
            {*<img src="http://api.map.baidu.com/staticimage/v2?ak=4GZSopVwwnspWo0pE72Nwgx2aOKnTonL&center={$page->detail['geo_lng']},{$page->detail['geo_lat']}&width=300&height=200&zoom=11" alt="地图">*}
        </div>

        <!--套餐详情-->
        <div class="title" id="dtl">
            <h5 class="fl">套餐详情</h5>
        </div>
        <div class="text">
            {$page->detail['annual_des']}
            {*<p>冷菜8款：精品凉菜八小蝶</p>*}
            {*<p>热菜9款：三丝海皇鱼肚羹、上汤黄油大龙虾、黑椒洋葱牛仔骨、广式经典豉油鸡、姜葱高汤炒肉蟹、孜然烤特级羊肉、夏果甜豆鲜百合、蒜蓉粉丝蒸扇贝、清蒸游水笋壳鱼、上汤瑶柱娃娃菜、XO酱海鲜炒米饭</p>*}
            {*<p>甜品1款：冰糖木瓜银耳羹</p>*}
            {*<p>水果1款：时令鲜果大拼盘</p>*}
        </div>
        {*<div class="img"><img src="img/meeting/hot-item/banner-sm.jpg"></div>*}

        <!--预订须知-->
        <div class="title"  id="notice">
            <h5 class="fl">预订须知</h5>
        </div>
        <div class="text">
            {$page->detail['book_des']}
            {*<p>1、在线订商品直接一键下单，云SPACE在接到订单后，会由客服直接跟您联系，请保持手机畅通；</p>*}
            {*<p>2、预定热线：400-056-0599</p>*}
        </div>
    </div>
    <div class="space-sidebar col-md-4 col-xs-12">
        <div class="title">更多套餐推荐</div>
        <ul>
            {if $page->recommendList}
                {foreach $page->recommendList as $k=>$v}
                    <li>
                        <a href="{$_home}meeting_hot_details/{Func_NumEncode::e($v['id']+100)}.html"  target="_blank" class="img"><img src="{$v['recommend_img']}"></a>
                        <h5><a href="{$_home}meeting_hot_details/{Func_NumEncode::e($v['id']+100)}.html" target="_blank">{if $v['space_name']!=$v['item_name']}{$v['space_name']}--{$v['item_name']}{else}{$v['space_name']}{/if}</a></h5>
                        {*<div class="tabs">标签：会议用餐、年会、培训讲座、发布会、婚宴、主题派对、企业聚会、露台</div>*}
                        <p>{$v['space_info']}</p>
                        <div class="price">
                            ¥ {$v['new_price']} {$v['remarks']}
                        </div>
                    </li>
                {/foreach}
            {/if}
            {*<li>*}
                {*<div class="img"><img src="img/meeting/hot-item/banner-sm.jpg"></div>*}
                {*<h5>首善财富会</h5>*}
                {*<div class="tabs">标签：会议用餐、年会、培训讲座、发布会、婚宴、主题派对、企业聚会、露台</div>*}
                {*<p>上海第一家“电影会所”，拥有一个“小型电影院”和一个“数码播放厅”。</p>*}
                {*<div class="price">*}
                    {*¥ 60000 免服务费（含税）*}
                {*</div>*}
            {*</li>*}
            {*<li>*}
                {*<div class="img"><img src="img/meeting/hot-item/banner-sm.jpg"></div>*}
                {*<h5>首善财富会</h5>*}
                {*<div class="tabs">标签：会议用餐、年会、培训讲座、发布会、婚宴、主题派对、企业聚会、露台</div>*}
                {*<p>上海第一家“电影会所”，拥有一个“小型电影院”和一个“数码播放厅”。</p>*}
                {*<div class="price">*}
                    {*¥ 60000 免服务费（含税）*}
                {*</div>*}
            {*</li>*}
        </ul>
    </div>

</div>
{include file="Web_Static::meeting_hot/form.tpl"}
{include file="Web_Static::inc/html_footer.tpl"}
{include file="Web_Static::meeting-hot/hot_footer.tpl"}
</body>
<script src="js/year-hot-js/yearhot.js"></script>
<script>
    var thisLat = "{$page->detail['geo_lat']}",thisLng = "{$page->detail['geo_lng']}",thisSpaceName = "{$page->detail['space_name']}";
    thisLat = thisLat/10000;
    thisLng = thisLng/10000;
//    console.log(thisLat,thisLng);
</script>
{*{include file="Web_Static::site/inc/schedule_price_pop.tpl"}*}
<script type="text/javascript" src="http://developer.baidu.com/map/custom/stylelist.js"></script>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=aaNCRRcGGai6klHMOGZ8yBbP"></script>
<script type="text/javascript" src="js/map.v1.0/RichMarker.js"></script>
<script type="text/javascript" src="js/baike.v1.0/map.js"></script>
{*{static "year-hot/banner.js"}*}
</html>