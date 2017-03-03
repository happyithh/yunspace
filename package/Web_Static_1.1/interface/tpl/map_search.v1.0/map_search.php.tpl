<!DOCTYPE html>
<html>
<head>
    <!--设置ie渲染模式为最高-->
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    {include file="Web_Static::v2.0/html_head.tpl"}
    {static "home.v3.0/data-picker.css"}
    {static "home.v3.0/home.css"}
    {static "mapsearch/slide.css"}
    <link rel="stylesheet" href="plugins/ionicons-master/css/ionicons.min.css">
    {*TODO::IE8 下*}
    <link rel="stylesheet" href="css/mapsearch/mapsearch.css">
    <!--[if lte IE 8]>
    <link rel="stylesheet" href="css/mapsearch/mapsearch_ie8.css">
    <![endif]-->
    <!--引用百度地图API-->
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=aaNCRRcGGai6klHMOGZ8yBbP"></script>

</head>
<body>
{include file="Web_Static::v2.0/html_header_min.tpl"}

{include file="Web_Static::v2.0/form.tpl"}
<!--左侧百度地图-->
<div class="mapsearch">
    <!--加载中提示状态-->
    <div class="loading clearfix" id="loadingImg">
        <div class="fl load-gif"><img src="img/mapsearch/loading.gif"/></div>
        <p>加载中...</p>
    </div>

    <!--百度地图容器-->
    <div id="map" style="width: auto;height: 100%;overflow: hidden;"></div>

    <!--搜索框-->
    <form action="" id="searchForm">
        <div class="range-room map-range-room">
            <div class="range-room-con">
                <div class="r-r-select map-area">
                    <div class="r-r-s-title select-click select1" style="line-height: 30px;">
                        <div id="showAreaText" data-area="">选择区域</div>
                        <span class="ion-arrow-down-b" style="line-height: 30px;"></span>
                    </div>
                    {*<input type="text" class="select-input hide no-show act-in cate-input" value="选择区域"/>*}

                    <div class="drop-down-home dropDown hide"
                         style="border: 1px solid #ededed;border-top: 0px;background: #fff;top:50px;" id="areaDrop">
                        <ul style="height:204px;">
                            {foreach $city_area as $area =>$av}
                                <li>{$av['name']}</li>
                            {/foreach}
                        </ul>
                    </div>
                </div>
                <div class="r-r-p">
                    在
                </div>

                <div class="r-r-select">
                    <div class="r-r-s-title select-click select1" style="line-height: 40px;">
                        <input class="par1" id="customPlace"

                               placeholder="{$_COOKIE['city']}"/>
                    </div>
                </div>
                <div class="r-r-p r-r-p2">
                    附近
                </div>
                <div class="r-r-select distance">
                    <div class="r-r-s-title select-click select1 " style="line-height: 40px;">
                        <input class="par2" id="customDistance"
                               value="1公里"/>
                        <span class="ion-arrow-down-b" style="line-height: 40px;"></span>
                    </div>
                    <div class="drop-down-home dropDown hide"
                         style="border: 1px solid #ededed;border-top: 0px;background: #fff;top:50px;" id="distanceDrop">
                        <ul style="height:204px;">
                            {foreach $distance as $k=>$val}
                                <li data-value="{$k}">{$val}</li>
                            {/foreach}
                        </ul>
                    </div>
                </div>
                <div class="r-r-button hide" style="line-height: 40px;">
                    <button type="submit" style="line-height: 40px;"><span
                                class="icon-search"></span><span>找空间</span></button>
                </div>
            </div>

        </div>
    </form>

</div>

<!--右侧内容部分-->
<div class="mapsearch-content">
    <div class="mapsearch-cont">
        <div class="mcont-screening" id="mcont-screening">
            {foreach $searchTags as $k=>$val}
                <dl class="clearfix dlist " id="a_{$k}">
                    <dt>{$topTagsName[$k]}：</dt>
                    <dd>
                        {foreach $val as $kk=>$vv}
                            <a href="{$_route}{Page_Site_Global::concatUrlTags($kk, $vv)}" data-value="{$kk}">{$vv}</a>
                        {/foreach}
                        <i class="a_downup a_down"></i>
                    </dd>
                </dl>
            {/foreach}
            <dl class="clearfix dlchoice">
                <dt>你已选择：</dt>
                <dd class="hv-choice-list" id="chosenList">

                </dd>
                <dd class="choice-more c-up hide"><a class="more" href="javascript:;"><span>收起</span><i
                                class="icon-putaway"></i></a></dd>
                <dd class="choice-more c-mo"><a class="more" href="javascript:;">更多选项</a></dd>
            </dl>
        </div>
        <!--mcont-screening-end-->

        <div class="mcont-list">
            <div class="mcont-list-title">
                <div class="sort fl" id="sortList">
                    <a class="active" href="?orderBy=" data-id="1">综合排序</a>
                    <a href="?orderBy=2" data-id="2"><span>最新</span><span class="icon-sort"></span></a>
                    <a href="?orderBy=3;" data-id="3"><span>最热</span><span class="icon-sort"></span></a>
                </div>
                <a class="back-list fr" href="{$_root}space/sh">
                    <span class="icon-list"></span><span>切回列表</span>
                </a>
            </div>
        </div>
        <!--mcont-list-end-->
        <div id="listContent">
            {if $list['rows']}
                {include "Web_Static::map_search.v1.0/inc/list.tpl"}
            {else}
                {include "Web_Static::map_search.v1.0/inc/no_result.tpl"}

            {/if}
        </div>
        <!--mapsearch-cont-end-->

    </div>
</div>

<script>
    localhost = "{Core::$urls['host']}";
</script>
<!--m-preview-end-->
{include file="Web_Static::v2.0/form.tpl"}
{*{include file="Web_Static::v2.0/html_footer.tpl"}*}
{static "js/bootstrap.min.js"}
{static "mapsearch/RichMarker.js"}
<script src="js/mapsearch/mapsearch.js"></script>
{include "Web_Static::v2.0/html_tj.tpl"}
</body>
</html>