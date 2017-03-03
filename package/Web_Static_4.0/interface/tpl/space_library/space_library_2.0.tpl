<!DOCTYPE html>
<html lang="en">
<head>
    {include file="Web_Static::v4.0/html_goto_mobile.tpl" url="m/"}
    {include file="Web_Static::inc/head_meta.tpl"}
    {static "v4.0/common.css"}
    {static "v4.0/jqueryui.min.css"}
    {static "v4.0/jquery-ui-slider-pips.min.css"}
    {static "baike.v1.0/baike_common.css"}
    {static "map.v1.0/map_common.css"}
    {static "space_library/space_library.css"}
    {static "get_space/get_space.css"}
    <!--引用百度地图API-->
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=aaNCRRcGGai6klHMOGZ8yBbP"></script>
</head>
<body yun="space_library/space_library.js::init">
    {include file="Web_Static::inc/header_1.tpl"}
    <!-- 首图-->
    {include file="Web_Static::space_library/inc/carousel.tpl"}
    <div class="content" >
        <!-- 找场地-->
        <div class="find-space">
            <p class="title">分类查找</p>
            <p class="des">全国<code>20</code>个城市，丰富的场地类型，<code>1500</code>个核心场地，<code>5万</code>个加盟场地</p>
            <div class="cate-nav" id="cate-nav">
                <ul class="cate-nav-list clearfix" id="cate-nav-list">
                    <li><a href="http://www.yunspace.com.cn/spaces-category-tags/{urlencode('秀场展馆')}" class="cate-one" target="_blank"><p>秀场展馆</p></a></li>
                    <li><a href="http://www.yunspace.com.cn/spaces-category-tags/{urlencode('商业广场')}" class="cate-two" target="_blank"><p>商业广场</p></a></li>
                    <li><a href="http://www.yunspace.com.cn/spaces-category-tags/{urlencode('艺术馆画廊')}" class="cate-three" target="_blank"><p>艺术馆画廊</p></a></li>
                    <li><a href="http://www.yunspace.com.cn/spaces-category-tags/{urlencode('星级酒店')}" class="cate-four" target="_blank"><p>星级酒店</p></a></li>
                    <li><a href="http://www.yunspace.com.cn/spaces-category-tags/{urlencode('影院剧院')}" class="cate-five" target="_blank"><p>影院剧院</p></a></li>
                    <li><a href="javascript:void(0)" class="cate-six" id="more-cates"><p>更多分类</p></a></li>
                    <li><a href="javascript:void(0)" class="cate-seven"><p>咖啡馆书店</p></a></li>
                    <li><a href="http://www.yunspace.com.cn/spaces-category-tags/{urlencode('体育场馆')}" class="cate-eight" target="_blank"><p>体育场馆</p></a></li>
                    <li><a href="http://www.yunspace.com.cn/spaces-category-tags/{urlencode('餐厅酒吧')}" class="cate-nine" target="_blank"><p>餐厅酒吧</p></a></li>
                    <li><a href="http://www.yunspace.com.cn/spaces-category-tags/{urlencode('高端会所')}" class="cate-ten" target="_blank"><p>高端会所</p></a></li>
                    <li><a href="http://www.yunspace.com.cn/spaces-category-tags/{urlencode('会务中心')}" class="cate-eleven" target="_blank"><p>会务中心</p></a></li>
                    <li><a href="http://www.yunspace.com.cn/spaces-category-tags/{urlencode('公共空间')}" class="cate-twelve" target="_blank"><p>公共空间</p></a></li>
                    <li><a href="http://www.yunspace.com.cn/spaces-category-tags/{urlencode('社区学校')}" class="cate-thirteen" target="_blank"><p>社区学校</p></a></li>
                    <li><a href="http://www.yunspace.com.cn/spaces-category-tags/{urlencode('特色场地')}" class="cate-fourteen" target="_blank"><p>特色场地</p></a></li>
                    <li><a href="javascript:void(0)" class="cate-fifteen"><p>游船码头</p></a></li>
                    <li><a href="javascript:void(0)" class="cate-sixteen"><p>文化街区</p></a></li>
                </ul>
            </div>
            <p class="title" style="margin-top:30px;">搜索</p>
            <div class="search">
                <form action="/space"  method="get" class="lib_form">
                    <div class="form-input">
                        <input type="text" placeholder="搜索场地，你可以输入场地名称或者进地标进行查找" id="suggestId" name="keyword2" growing-track="true" />
                        <input type="hidden" class="lib_lng" name="lng"/>
                        <input type="hidden" class="lib_lat" name="lat"//>
                        <input type="hidden" class="lib_city"  name="city"//>
                    </div>
                    <button type="button" class="form-btn" id="search-space" data-root="{$_root}">搜索一下</button>
                </form>
            </div>
            <ul class="hot-search">
                <li>热搜词:</li>
                <li><a target="_blank" href="http://www.yunspace.com.cn/spaces-{$_COOKIE['city_key']}-tags">{$_COOKIE['city']}</a></li>
                <li><a target="_blank" href="http://www.yunspace.com.cn/spaces-49-tags/{Func_Url::str_urlencode('会议会务')}">会议会务</a></li>
                <li><a target="_blank" href="http://www.yunspace.com.cn/spaces-49-tags/{Func_Url::str_urlencode('文体娱乐')}">文艺演出</a></li>
                <li><a target="_blank" href="http://www.yunspace.com.cn/spaces-49-tags/{Func_Url::str_urlencode('晚会年会')}">晚会年会</a></li>
                <li><a target="_blank" href="http://www.yunspace.com.cn/spaces-49-tags/{Func_Url::str_urlencode('主题派对')}">主题派对</a></li>
            </ul>
        </div>
        <!-- 地图-->
        <div class="city-map">
            <div class="header clearfix">
                <div class="m-left">
                    <p class="cn">{if $_COOKIE['city']}{$_COOKIE['city']}{else}上海{/if}</p>
                    <div class="select">
                        <a href="javascript:;">城市选择</a>
                        <ul class="more clearfix" id="city-select-map">
                            {foreach $page->cities as $k=>$v}
                                <li>
                                    <a href="{$_home}city/{$k}" {if  $v==$_COOKIE['city']} class="city-active"{/if}>{$v}</a>
                                    {****位置不可置换*******}
                                    {*<a href="{$_home}city/{$k}" style="width: 0px;height: 0px;overflow: hidden">{$v}</a>*}
                                </li>
                            {/foreach}

                        </ul>
                    </div>
                </div>
                <a href="http://{Core::$urls['host']}/map2" target="_blank" class="join-link">进入场地地图</a>
            </div>
            <div class="body">
                <!--百度地图容器-->
                <div id="map" style="width: 100%;height: 100%;overflow: hidden; position: relative">
                    <div class="list-wrap" id="js-list-wrap">加载中...</div>
                </div>
                <div class="map-scale-btn">
                    <a class="icon-c scale scale-enlarge" href="javascript:;" id="zoomUp"></a>
                    <a class="icon-c scale scale-reduce" href="javascript:;" id="zoomDown"></a>
                </div>
            </div>
        </div>
        <!-- 热门场地-->
        <div class="hot-space" id="hot-space">
            <!-- header-->
            <div class="header">
                <p class="title">热门场地</p>
                <ul class="list" id="tab-list">
                    <li class="li-active"><a href="javascript:;" class="i-one i-active">秀场展馆</a></li>
                    <li><a href="javascript:;" class="i-two">商业广场</a></li>
                    <li><a href="javascript:;" class="i-three">高端会所</a></li>
                    <li><a href="javascript:;" class="i-four">会务中心</a></li>
                    <li><a href="javascript:;" class="i-five">餐厅酒吧</a></li>
                </ul>
            </div>
            <!-- body-space-->
            <div class="hot-body" id="hot-body">
                {include file="Web_Static::space_library/inc/hot.tpl"}

            </div>
        </div>

    </div>
    <!-- 左侧浮动-->
    <div class="fix-bg none">
        <div class="fix-table">
            <div class="side-fix" id="side-fix">
                <ul class="list">
                    <li class="icon-f1"><a href="javascript:;">秀场展馆</a></li>
                    <li class="icon-f2"><a href="javascript:;">商业广场</a></li>
                    <li class="icon-f3"><a href="javascript:;">高端会所</a></li>
                    <li class="icon-f4"><a href="javascript:;">会务中心</a></li>
                    <li class="icon-f5"><a href="javascript:;">餐厅酒吧</a></li>
                    <li class="mao-active"><a href="javascript:;">场地招募</a></li>
                </ul>
            </div>
        </div>
    </div>

    <!-- 立即参与-->
    <div class="join-block">
        <div class="join">
            <div class="join-body clearfix">
                <div class="join-left fl">
                    <div class="join-title">云SPACE场地大招募</div>
                    <div class="join-des">
                        <p>场地闲置？没有人气？管理麻烦？</p>
                        <p>云·SPACE为您解决场地烦恼！</p>
                        <p>快来秀出您的场地吧~</p>
                    </div>
                    <div class="join-button">
                        <a target="_blank" href="{$_root}site_join">立即参与</a>
                    </div>
                </div>
                <div class="join-map"></div>
            </div>
        </div>
    </div>
    <!-- 各地场地-->
    <div class="cate-space-footer">
        <div class="clearfix cate-space-footer-title js-footer-city-venues">
            <div class="footer-li fl">
                <div class="footer-li-header footer-li-header-active">上海活动场地</div>
            </div>
            <div class="footer-li fl">
                <div class="footer-li-header">北京活动场地</div>
            </div>
            <div class="footer-li fl">
                <div class="footer-li-header">广州活动场地</div>
            </div>
            <div class="footer-li fl">
                <div class="footer-li-header">深圳活动场地</div>
            </div>
            <div class="footer-li fl">
                <div class="footer-li-header">成都活动场地</div>
            </div>
            <div class="footer-li fl">
                <div class="footer-li-header">杭州活动场地</div>
            </div>
        </div>
        <div class="footer-act-list">
            <ul class="footer-li-list clearfix">
                <li><a target="_blank" href="http://www.yunspace.com.cn/spaces-sh-49-tags/{Func_Url::str_urlencode('晚会年会')}">上海年会场地</a></li>
                <li><a target="_blank" href="http://www.yunspace.com.cn/spaces-sh-49-tags/{Func_Url::str_urlencode('新品发布会')}">上海发布会场地</a></li>
                <li><a target="_blank" href="http://www.yunspace.com.cn/spaces-sh-49-tags/{Func_Url::str_urlencode('推广路演')}">上海路演场地</a></li>
                <li><a target="_blank" href="http://www.yunspace.com.cn/spaces-sh-49-tags/{Func_Url::str_urlencode('时尚走秀')}">上海走秀场地</a></li>
                <li><a target="_blank" href="http://www.yunspace.com.cn/spaces-sh-size-tags/1">上海沙龙场地</a></li>
                <li><a target="_blank" href="http://www.yunspace.com.cn/spaces-sh-49-tags/{Func_Url::str_urlencode('主题派对')}">上海派对场地</a></li>
                <li><a target="_blank" href="http://www.yunspace.com.cn/spaces-sh-49-tags/{Func_Url::str_urlencode('餐厅酒吧')}">上海聚会场地</a></li>
                <li><a target="_blank" href="http://www.yunspace.com.cn/spaces-sh-category-tags/{Func_Url::str_urlencode('体育场馆')}">上海运动场馆</a></li>
                <li><a target="_blank" href="http://www.yunspace.com.cn/spaces-sh-category-tags/{Func_Url::str_urlencode('特色场地')}">上海特色场地</a></li>
                <li><a target="_blank" href="http://www.yunspace.com.cn/spaces-sh-size-tags/2000">上海大型场地</a></li>
                <li><a target="_blank" href="http://www.yunspace.com.cn/spaces-sh-49-tags/{Func_Url::str_urlencode('户外拓展')}">上海团建场地</a></li>
                <li><a target="_blank" href="http://www.yunspace.com.cn/site/{Func_Url::str_urlencode('云SPACE宝山秀场-百科')}">上海宝山秀场</a></li>
            </ul>
        </div>
        <div class="footer-act-list none">
            <ul class="footer-li-list clearfix">
                <li><a target="_blank" href="http://www.yunspace.com.cn/spaces-bj-49-tags/{Func_Url::str_urlencode('晚会年会')}">北京年会场地</a></li>
                <li><a target="_blank" href="http://www.yunspace.com.cn/spaces-bj-49-tags/{Func_Url::str_urlencode('新品发布会')}">北京发布会场地</a></li>
                <li><a target="_blank" href="http://www.yunspace.com.cn/spaces-bj-49-tags/{Func_Url::str_urlencode('推广路演')}">北京路演场地</a></li>
                <li><a target="_blank" href="http://www.yunspace.com.cn/spaces-bj-49-tags/{Func_Url::str_urlencode('时尚走秀')}">北京走秀场地</a></li>
                <li><a target="_blank" href="http://www.yunspace.com.cn/spaces-bj-size-tags/1">北京沙龙场地</a></li>
                <li><a target="_blank" href="http://www.yunspace.com.cn/spaces-bj-49-tags/{Func_Url::str_urlencode('主题派对')}">北京派对场地</a></li>
                <li><a target="_blank" href="http://www.yunspace.com.cn/spaces-bj-49-tags/{Func_Url::str_urlencode('餐厅酒吧')}">北京聚会场地</a></li>
                <li><a target="_blank" href="http://www.yunspace.com.cn/spaces-bj-category-tags/{Func_Url::str_urlencode('体育场馆')}">北京运动场馆</a></li>
                <li><a target="_blank" href="http://www.yunspace.com.cn/spaces-bj-category-tags/{Func_Url::str_urlencode('特色场地')}">北京特色场地</a></li>
                <li><a target="_blank" href="http://www.yunspace.com.cn/spaces-bj-size-tags/2000">北京大型场地</a></li>
                <li><a target="_blank" href="http://www.yunspace.com.cn/spaces-bj-49-tags/{Func_Url::str_urlencode('户外拓展')}">北京团建场地</a></li>
                <li><a target="_blank" href="http://www.yunspace.com.cn/spaces-bj-category-tags/{Func_Url::str_urlencode('商业广场')}">北京商场场地</a></li>
            </ul>
        </div>
        <div class="footer-act-list none">
            <ul class="footer-li-list clearfix">
                <li><a target="_blank" href="http://www.yunspace.com.cn/spaces-gz-49-tags/{Func_Url::str_urlencode('晚会年会')}">广州年会场地</a></li>
                <li><a target="_blank" href="http://www.yunspace.com.cn/spaces-gz-49-tags/{Func_Url::str_urlencode('新品发布会')}">广州发布会场地</a></li>
                <li><a target="_blank" href="http://www.yunspace.com.cn/spaces-gz-49-tags/{Func_Url::str_urlencode('推广路演')}">广州路演场地</a></li>
                <li><a target="_blank" href="http://www.yunspace.com.cn/spaces-gz-49-tags/{Func_Url::str_urlencode('时尚走秀')}">广州走秀场地</a></li>
                <li><a target="_blank" href="http://www.yunspace.com.cn/spaces-gz-size-tags/1">广州沙龙场地</a></li>
                <li><a target="_blank" href="http://www.yunspace.com.cn/spaces-gz-49-tags/{Func_Url::str_urlencode('主题派对')}">广州派对场地</a></li>
                <li><a target="_blank" href="http://www.yunspace.com.cn/spaces-gz-49-tags/{Func_Url::str_urlencode('餐厅酒吧')}">广州聚会场地</a></li>
                <li><a target="_blank" href="http://www.yunspace.com.cn/spaces-gz-category-tags/{Func_Url::str_urlencode('体育场馆')}">广州运动场馆</a></li>
                <li><a target="_blank" href="http://www.yunspace.com.cn/spaces-gz-category-tags/{Func_Url::str_urlencode('特色场地')}">广州特色场地</a></li>
                <li><a target="_blank" href="http://www.yunspace.com.cn/spaces-gz-size-tags/2000">广州大型场地</a></li>
                <li><a target="_blank" href="http://www.yunspace.com.cn/spaces-gz-49-tags/{Func_Url::str_urlencode('户外拓展')}">广州团建场地</a></li>
                <li><a target="_blank" href="http://www.yunspace.com.cn/spaces-gz-category-tags/{Func_Url::str_urlencode('商业广场')}">广州商场场地</a></li>
            </ul>
        </div>
        <div class="footer-act-list none">
            <ul class="footer-li-list clearfix">
                <li><a target="_blank" href="http://www.yunspace.com.cn/spaces-sz-49-tags/{Func_Url::str_urlencode('晚会年会')}">深圳年会场地</a></li>
                <li><a target="_blank" href="http://www.yunspace.com.cn/spaces-sz-49-tags/{Func_Url::str_urlencode('新品发布会')}">深圳发布会场地</a></li>
                <li><a target="_blank" href="http://www.yunspace.com.cn/spaces-sz-49-tags/{Func_Url::str_urlencode('推广路演')}">深圳路演场地</a></li>
                <li><a target="_blank" href="http://www.yunspace.com.cn/spaces-sz-49-tags/{Func_Url::str_urlencode('时尚走秀')}">深圳走秀场地</a></li>
                <li><a target="_blank" href="http://www.yunspace.com.cn/spaces-sz-size-tags/1">深圳沙龙场地</a></li>
                <li><a target="_blank" href="http://www.yunspace.com.cn/spaces-sz-49-tags/{Func_Url::str_urlencode('主题派对')}">深圳派对场地</a></li>
                <li><a target="_blank" href="http://www.yunspace.com.cn/spaces-sz-49-tags/{Func_Url::str_urlencode('餐厅酒吧')}">深圳聚会场地</a></li>
                <li><a target="_blank" href="http://www.yunspace.com.cn/spaces-sz-category-tags/{Func_Url::str_urlencode('体育场馆')}">深圳运动场馆</a></li>
                <li><a target="_blank" href="http://www.yunspace.com.cn/spaces-sz-category-tags/{Func_Url::str_urlencode('特色场地')}">深圳特色场地</a></li>
                <li><a target="_blank" href="http://www.yunspace.com.cn/spaces-sz-size-tags/2000">深圳大型场地</a></li>
                <li><a target="_blank" href="http://www.yunspace.com.cn/spaces-sz-49-tags/{Func_Url::str_urlencode('户外拓展')}">深圳团建场地</a></li>
                <li><a target="_blank" href="http://www.yunspace.com.cn/spaces-sz-category-tags/{Func_Url::str_urlencode('商业广场')}">深圳商场场地</a></li>
            </ul>
        </div>
        <div class="footer-act-list none">
            <ul class="footer-li-list clearfix">
                <li><a target="_blank" href="http://www.yunspace.com.cn/spaces-cd-49-tags/{Func_Url::str_urlencode('晚会年会')}">成都年会场地</a></li>
                <li><a target="_blank" href="http://www.yunspace.com.cn/spaces-cd-49-tags/{Func_Url::str_urlencode('新品发布会')}">成都发布会场地</a></li>
                <li><a target="_blank" href="http://www.yunspace.com.cn/spaces-cd-49-tags/{Func_Url::str_urlencode('推广路演')}">成都路演场地</a></li>
                <li><a target="_blank" href="http://www.yunspace.com.cn/spaces-cd-49-tags/{Func_Url::str_urlencode('时尚走秀')}">成都走秀场地</a></li>
                <li><a target="_blank" href="http://www.yunspace.com.cn/spaces-cd-size-tags/1">成都沙龙场地</a></li>
                <li><a target="_blank" href="http://www.yunspace.com.cn/spaces-cd-49-tags/{Func_Url::str_urlencode('主题派对')}">成都派对场地</a></li>
                <li><a target="_blank" href="http://www.yunspace.com.cn/spaces-cd-49-tags/{Func_Url::str_urlencode('餐厅酒吧')}">成都聚会场地</a></li>
                <li><a target="_blank" href="http://www.yunspace.com.cn/spaces-cd-category-tags/{Func_Url::str_urlencode('体育场馆')}">成都运动场馆</a></li>
                <li><a target="_blank" href="http://www.yunspace.com.cn/spaces-cd-category-tags/{Func_Url::str_urlencode('特色场地')}">成都特色场地</a></li>
                <li><a target="_blank" href="http://www.yunspace.com.cn/spaces-cd-size-tags/2000">成都大型场地</a></li>
                <li><a target="_blank" href="http://www.yunspace.com.cn/spaces-cd-49-tags/{Func_Url::str_urlencode('户外拓展')}">成都团建场地</a></li>
                <li><a target="_blank" href="http://www.yunspace.com.cn/spaces-cd-category-tags/{Func_Url::str_urlencode('商业广场')}">成都商场场地</a></li>
            </ul>
        </div>
        <div class="footer-act-list none">
            <ul class="footer-li-list clearfix">
                <li><a target="_blank" href="http://www.yunspace.com.cn/spaces-hz-49-tags/{Func_Url::str_urlencode('晚会年会')}">杭州年会场地</a></li>
                <li><a target="_blank" href="http://www.yunspace.com.cn/spaces-hz-49-tags/{Func_Url::str_urlencode('新品发布会')}">杭州发布会场地</a></li>
                <li><a target="_blank" href="http://www.yunspace.com.cn/spaces-hz-49-tags/{Func_Url::str_urlencode('推广路演')}">杭州路演场地</a></li>
                <li><a target="_blank" href="http://www.yunspace.com.cn/spaces-hz-49-tags/{Func_Url::str_urlencode('时尚走秀')}">杭州走秀场地</a></li>
                <li><a target="_blank" href="http://www.yunspace.com.cn/spaces-hz-size-tags/1">杭州沙龙场地</a></li>
                <li><a target="_blank" href="http://www.yunspace.com.cn/spaces-hz-49-tags/{Func_Url::str_urlencode('主题派对')}">杭州派对场地</a></li>
                <li><a target="_blank" href="http://www.yunspace.com.cn/spaces-hz-49-tags/{Func_Url::str_urlencode('餐厅酒吧')}">杭州聚会场地</a></li>
                <li><a target="_blank" href="http://www.yunspace.com.cn/spaces-hz-category-tags/{Func_Url::str_urlencode('体育场馆')}">杭州运动场馆</a></li>
                <li><a target="_blank" href="http://www.yunspace.com.cn/spaces-hz-category-tags/{Func_Url::str_urlencode('特色场地')}">杭州特色场地</a></li>
                <li><a target="_blank" href="http://www.yunspace.com.cn/spaces-hz-size-tags/2000">杭州大型场地</a></li>
                <li><a target="_blank" href="http://www.yunspace.com.cn/spaces-hz-49-tags/{Func_Url::str_urlencode('户外拓展')}">杭州团建场地</a></li>
                <li><a target="_blank" href="http://www.yunspace.com.cn/spaces-hz-category-tags/{Func_Url::str_urlencode('商业广场')}">杭州商场场地</a></li>
            </ul>
        </div>
    </div>
    {include file="Web_Static::inc/public_space.tpl"}
    {static "v4.0/jquery.easing.1.3.min.js"}
    {static "v4.0/jquery.lazyload.min.js"}
    {static "map.v1.0/RichMarker.js"}
    {*{static "space_library/library-map.js"}*}
    {static "space_library/banner.js"}
    {static "v4.0/jquery-plus-ui.min.js"}
    {static "v4.0/jquery-ui-slider-pips.js"}
    {static "core/yunspace.js"}
    {include file="Web_Static::inc/html_footer.tpl"}
    {static "space_library/library-map.js"}
    {*<script src="js/space_library/library-map.js"></script>*}
</body>
</html>