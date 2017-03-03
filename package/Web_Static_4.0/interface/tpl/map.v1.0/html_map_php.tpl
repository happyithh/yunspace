<!DOCTYPE html>
<html>
<head>
    {include file="Web_Static::inc/head_meta.tpl"}
    {*<meta charset="utf-8" />*}
    {*<meta http-equiv="X-UA-Compatible" content="IE=Edge">*}
    {*<title>地图搜索</title>*}
    {*{static "v4.0/common.css"}*}
    {static "map.v1.0/map_common.css"}
    {static "map.v1.0/map.css"}
    {*{static "js/jquery-1.9.1.min.js"}*}
    {*{static "mapsearch/mapsearch.css"}*}
    {*{static "map.v1.0/map.js"}*}

    <!--引用百度地图API-->
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=aaNCRRcGGai6klHMOGZ8yBbP"></script>
</head>
<body>
{include file="Web_Static::inc/header_1.tpl"}
<div class="container">
    <div class="loading clearfix" id="loadingImg">
        <div class="fl load-gif"><img src="img/map/loading.gif"/></div>
        <p>加载中...</p>
    </div>
    <div class="map-container">
        <div class="search">
            <div class="select">
                <input class="hvselect" type="text" placeholder="输入你想要定位的地点" id="customPlace" growing-track="true">
                <ul>
                    <li class="selected">找场地</li>
                    <li><a href="{$_home}spaces-sh-49-tags/{Func_Url::str_urlencode('晚会年会')}">上海年会场地</a></li>
                    <li><a href="{$_home}spaces-sh-49-tags/{Func_Url::str_urlencode('新品发布会')}">上海发布会场地</a></li>
                    <li><a href="{$_home}spaces-sh-49-tags/{Func_Url::str_urlencode('推广路演')}">上海路演场地</a></li>
                    <li><a href="{$_home}spaces-sh-49-tags/{Func_Url::str_urlencode('时尚走秀')}">上海走秀场地</a></li>
                    <li><a href="{$_home}spaces-sh-size-tags/1">上海沙龙场地</a></li>
                    <li><a href="{$_home}spaces-sh-49-tags/{Func_Url::str_urlencode('主题派对')}">上海派对场地</a></li>
                    <li><a href="{$_home}spaces-sh-49-tags/{Func_Url::str_urlencode('餐厅酒吧')}">上海聚会场地</a></li>
                    <li><a href="{$_home}spaces-sh-category-tags/{Func_Url::str_urlencode('体育场馆')}">上海运动场馆</a></li>
                    <li><a href="{$_home}spaces-sh-category-tags/{Func_Url::str_urlencode('特色场地')}">上海特色场地</a></li>
                    <li><a href="{$_home}spaces-sh-size-tags/2000">上海大型场地</a></li>
                    <li><a href="{$_home}spaces-sh-49-tags/{Func_Url::str_urlencode('户外拓展')}">上海团建场地</a></li>
                    <li><a href="{$_home}site/{Func_Url::str_urlencode('云SPACE宝山秀场-百科')}">上海宝山秀场</a></li>
                    <li><a href="{$_home}spaces-bj-49-tags/{Func_Url::str_urlencode('晚会年会')}">北京年会场地</a></li>
                    <li><a href="{$_home}spaces-bj-49-tags/{Func_Url::str_urlencode('新品发布会')}">北京发布会场地</a></li>
                    <li><a href="{$_home}spaces-bj-49-tags/{Func_Url::str_urlencode('推广路演')}">北京路演场地</a></li>
                    <li><a href="{$_home}spaces-bj-49-tags/{Func_Url::str_urlencode('时尚走秀')}">北京走秀场地</a></li>
                    <li><a href="{$_home}spaces-bj-size-tags/1">北京沙龙场地</a></li>
                    <li><a href="{$_home}spaces-bj-49-tags/{Func_Url::str_urlencode('主题派对')}">北京派对场地</a></li>
                    <li><a href="{$_home}spaces-bj-49-tags/{Func_Url::str_urlencode('餐厅酒吧')}">北京聚会场地</a></li>
                    <li><a href="{$_home}spaces-bj-category-tags/{Func_Url::str_urlencode('体育场馆')}">北京运动场馆</a></li>
                    <li><a href="{$_home}spaces-bj-category-tags/{Func_Url::str_urlencode('特色场地')}">北京特色场地</a></li>
                    <li><a href="{$_home}spaces-bj-size-tags/2000">北京大型场地</a></li>
                    <li><a href="{$_home}spaces-bj-49-tags/{Func_Url::str_urlencode('户外拓展')}">北京团建场地</a></li>
                    <li><a href="{$_home}spaces-bj-category-tags/{Func_Url::str_urlencode('商业广场')}">北京商场场地</a></li>
                    <li><a href="{$_home}spaces-gz-49-tags/{Func_Url::str_urlencode('晚会年会')}">广州年会场地</a></li>
                    <li><a href="{$_home}spaces-gz-49-tags/{Func_Url::str_urlencode('新品发布会')}">广州发布会场地</a></li>
                    <li><a href="{$_home}spaces-gz-49-tags/{Func_Url::str_urlencode('推广路演')}">广州路演场地</a></li>
                    <li><a href="{$_home}spaces-gz-49-tags/{Func_Url::str_urlencode('时尚走秀')}">广州走秀场地</a></li>
                    <li><a href="{$_home}spaces-gz-size-tags/1">广州沙龙场地</a></li>
                    <li><a href="{$_home}spaces-gz-49-tags/{Func_Url::str_urlencode('主题派对')}">广州派对场地</a></li>
                    <li><a href="{$_home}spaces-gz-49-tags/{Func_Url::str_urlencode('餐厅酒吧')}">广州聚会场地</a></li>
                    <li><a href="{$_home}spaces-gz-category-tags/{Func_Url::str_urlencode('体育场馆')}">广州运动场馆</a></li>
                    <li><a href="{$_home}spaces-gz-category-tags/{Func_Url::str_urlencode('特色场地')}">广州特色场地</a></li>
                    <li><a href="{$_home}spaces-gz-size-tags/2000">广州大型场地</a></li>
                    <li><a href="{$_home}spaces-gz-49-tags/{Func_Url::str_urlencode('户外拓展')}">广州团建场地</a></li>
                    <li><a href="{$_home}spaces-gz-category-tags/{Func_Url::str_urlencode('商业广场')}">广州商场场地</a></li>
                    <li><a href="{$_home}spaces-sz-49-tags/{Func_Url::str_urlencode('晚会年会')}">深圳年会场地</a></li>
                    <li><a href="{$_home}spaces-sz-49-tags/{Func_Url::str_urlencode('新品发布会')}">深圳发布会场地</a></li>
                    <li><a href="{$_home}spaces-sz-49-tags/{Func_Url::str_urlencode('推广路演')}">深圳路演场地</a></li>
                    <li><a href="{$_home}spaces-sz-49-tags/{Func_Url::str_urlencode('时尚走秀')}">深圳走秀场地</a></li>
                    <li><a href="{$_home}spaces-sz-size-tags/1">深圳沙龙场地</a></li>
                    <li><a href="{$_home}spaces-sz-49-tags/{Func_Url::str_urlencode('主题派对')}">深圳派对场地</a></li>
                    <li><a href="{$_home}spaces-sz-49-tags/{Func_Url::str_urlencode('餐厅酒吧')}">深圳聚会场地</a></li>
                    <li><a href="{$_home}spaces-sz-category-tags/{Func_Url::str_urlencode('体育场馆')}">深圳运动场馆</a></li>
                    <li><a href="{$_home}spaces-sz-category-tags/{Func_Url::str_urlencode('特色场地')}">深圳特色场地</a></li>
                    <li><a href="{$_home}spaces-sz-size-tags/2000">深圳大型场地</a></li>
                    <li><a href="{$_home}spaces-sz-49-tags/{Func_Url::str_urlencode('户外拓展')}">深圳团建场地</a></li>
                    <li><a href="{$_home}spaces-sz-category-tags/{Func_Url::str_urlencode('商业广场')}">深圳商场场地</a></li>
                    <li><a href="{$_home}spaces-cd-49-tags/{Func_Url::str_urlencode('晚会年会')}">成都年会场地</a></li>
                    <li><a href="{$_home}spaces-cd-49-tags/{Func_Url::str_urlencode('新品发布会')}">成都发布会场地</a></li>
                    <li><a href="{$_home}spaces-cd-49-tags/{Func_Url::str_urlencode('推广路演')}">成都路演场地</a></li>
                    <li><a href="{$_home}spaces-cd-49-tags/{Func_Url::str_urlencode('时尚走秀')}">成都走秀场地</a></li>
                    <li><a href="{$_home}spaces-cd-size-tags/1">成都沙龙场地</a></li>
                    <li><a href="{$_home}spaces-cd-49-tags/{Func_Url::str_urlencode('主题派对')}">成都派对场地</a></li>
                    <li><a href="{$_home}spaces-cd-49-tags/{Func_Url::str_urlencode('餐厅酒吧')}">成都聚会场地</a></li>
                    <li><a href="{$_home}spaces-cd-category-tags/{Func_Url::str_urlencode('体育场馆')}">成都运动场馆</a></li>
                    <li><a href="{$_home}spaces-cd-category-tags/{Func_Url::str_urlencode('特色场地')}">成都特色场地</a></li>
                    <li><a href="{$_home}spaces-cd-size-tags/2000">成都大型场地</a></li>
                    <li><a href="{$_home}spaces-cd-49-tags/{Func_Url::str_urlencode('户外拓展')}">成都团建场地</a></li>
                    <li><a href="{$_home}spaces-cd-category-tags/{Func_Url::str_urlencode('商业广场')}">成都商场场地</a></li>
                    <li><a href="{$_home}spaces-hz-49-tags/{Func_Url::str_urlencode('晚会年会')}">杭州年会场地</a></li>
                    <li><a href="{$_home}spaces-hz-49-tags/{Func_Url::str_urlencode('新品发布会')}">杭州发布会场地</a></li>
                    <li><a href="{$_home}spaces-hz-49-tags/{Func_Url::str_urlencode('推广路演')}">杭州路演场地</a></li>
                    <li><a href="{$_home}spaces-hz-49-tags/{Func_Url::str_urlencode('时尚走秀')}">杭州走秀场地</a></li>
                    <li><a href="{$_home}spaces-hz-size-tags/1">杭州沙龙场地</a></li>
                    <li><a href="{$_home}spaces-hz-49-tags/{Func_Url::str_urlencode('主题派对')}">杭州派对场地</a></li>
                    <li><a href="{$_home}spaces-hz-49-tags/{Func_Url::str_urlencode('餐厅酒吧')}">杭州聚会场地</a></li>
                    <li><a href="{$_home}spaces-hz-category-tags/{Func_Url::str_urlencode('体育场馆')}">杭州运动场馆</a></li>
                    <li><a href="{$_home}spaces-hz-category-tags/{Func_Url::str_urlencode('特色场地')}">杭州特色场地</a></li>
                    <li><a href="{$_home}spaces-hz-size-tags/2000">杭州大型场地</a></li>
                    <li><a href="{$_home}spaces-hz-49-tags/{Func_Url::str_urlencode('户外拓展')}">杭州团建场地</a></li>
                    <li><a href="{$_home}spaces-hz-category-tags/{Func_Url::str_urlencode('商业广场')}">杭州商场场地</a></li>
                </ul>
                <span class="icon-c icon-clean js-ipt-clean" id="clearInput"></span>
            </div><!--select-end-->
            <a class="search-btn" href="javascript:;"><span class="icon-c icon-search-btn"></span></a>
        </div>
        <!--筛选内容部分-->
        <div id="mapsearchCont" class="mapsearch-cont-wrap">
            <div class="mapsearch-cont">
            <div class="mcont-screening" id="mcont-screening">
                <dl class="clearfix dlchoice show-chosen" id="showChosen">
                    <dt>你已选择</dt>
                    <dd class="hv-choice-list clearfix" id="chosenList">
                        {*<a class="hv">*}
                            {*上海*}
                            {*<span class="delete-btn js-delete icon-c" href="javascript:;"></span>*}
                        {*</a>*}

                        {*<div class="choice-delete-all fr">*}
                            {*<span class="icon-c icon-delete"></span>*}
                            {*<a class="delete js-delete-all" href="javascript:;">全部删除</a>*}
                        {*</div>*}
                    </dd>
                </dl>
                {*<dl class="clearfix dlist">*}
                    {*<dt>行政区域</dt>*}
                    {*<dd>*}
                        {*<a href="javascript:;">浦东新区</a>*}
                        {*<a href="javascript:;">黄浦区</a>*}
                        {*<a href="javascript:;">虹口区</a>*}
                        {*<a href="javascript:;">徐汇区</a>*}
                        {*<a href="javascript:;">闸北区</a>*}
                        {*<a href="javascript:;">静安区</a>*}
                        {*<p class="js-a-downup a-downup-wrapper"><i class="icon-c a-downup"></i></p>*}
                    {*</dd>*}
                {*</dl>*}
                {foreach $searchNewTags as $k=>$val}
                    <dl class="clearfix dlist " id="a_{$k}">
                        <dt>{$topTagsName[$k]}</dt>
                        <dd>
                            {foreach $val as $kk=>$vv}
                                <a href="{$_route}{Page_Site_Global::concatUrlTags($kk, $vv)}" data-value="{$kk}">{$vv}</a>
                            {/foreach}
                            <p class="js-a-downup a-downup-wrapper"><i class="icon-c a-downup"></i></p>
                        </dd>
                    </dl>
                {/foreach}

            </div>
            <!--mcont-screening-end-->
            <div class="mcont-list">
                <div class="mcont-list-title" id="sortList">
                    <a class="active" href="?orderBy=" data-id="1">综合排序</a>
                    <a href="?orderBy=2" data-id="2"><span>最新</span><span class="icon-sort"></span></a>
                    <a href="?orderBy=3" data-id="3"><span>最热</span><span class="icon-sort"></span></a>
                </div>
                <div id="listContent">

                </div>
                {*{if $list['rows']}*}
                    {*{include "Web_Static::map.v1.0/inc/list.tpl"}*}
                {*{else}*}
                    {*{include "Web_Static::map.v1.0/inc/no_result.tpl"}*}

                {*{/if}*}

            </div>
            <!--mcont-list-end-->

        </div><!--mapsearch-cont-end-->
        </div>
    </div>

    <!--百度地图容器-->
    <div id="map" style="width: 100%;height: 100%;overflow: hidden; position: relative">
        <div class="list-wrap" id="js-list-wrap">sss</div>
    </div>
    <div class="map-scale-btn">
        <a class="icon-c scale scale-enlarge" href="javascript:;" id="zoomUp"></a>
        <a class="icon-c scale scale-reduce" href="javascript:;" id="zoomDown"></a>
    </div>

</div>
{include file="Web_Static::map.v1.0/inc/consult_pop.tpl"}
{static "map.v1.0/RichMarker.js"}
{static "map.v1.0/yunspace-map.js"}
{include file="Web_Static::v4.0/html_tj.tpl"}
</body>
</html>