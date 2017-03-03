<!DOCTYPE html>
<html>
<head>
    {include file="inc/html_head.tpl"}
    <link rel="stylesheet " type="text/css" href="css/map.css">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no"/>
    <script type="text/javascript" src="js/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=aaNCRRcGGai6klHMOGZ8yBbP"></script>
</head>
<body>
{include file="inc/header_nav.tpl"}
<div class="content">
<!---map左侧--->
<div class="pull-left map1">
    <div class="map-a">
        <div class="map-search">
            <form class="form-inline" action="?{$page->filterString}" method="get">

                <input type="hidden" name="category_id" value="{$page->categoryId}">

                <div class="pull-left sea1">
                    {*<div class="pull-left hb"><input type="text" name="search" value="请输入完整的问题，如“修改合同"></div>*}
                    {*<div class="pull-left hc "><a href="#" class="btn btn-primary">搜索</a></div>*}
                    <div class="input-group">
                        <input class="form-control" placeholder="搜索关键词" name="keyword"
                               value="{htmlspecialchars($_REQUEST['keyword'])}" type="text">
                            <span class="input-group-btn">
                            <button type="submit" class="btn btn-default search_btn">
                                <i class="fa fa-search"></i>
                            </button>
                            </span>
                    </div>
                </div>
            </form>
            <div class="pull-right sea2">
                <div class="down_box1">

                </div>

                <div class="clearfix"></div>
            </div>
        </div>
    </div>

    <div>
        <!---map中间--->
        <div class="map3">
            <div class="sea3">
                <div class="pull-left kw">
                    <div class="pull-left text2"><span>空间场地</span></div>
                    <div class="down_box2">
                        <select class="form-control input-sm" name="spaceType" onchange="changeSpaceType(this)">
                            <option value="{$page->categoryId}">全部</option>
                            {foreach $page->categoryTree[$page->topCategoryId['topCategoryId']] as $k=>$v}
                                {if $v}
                                    <option value="{$k}"
                                            {if  $_REQUEST['category_id']==$k}selected="selected" {/if}>{$v}</option>
                                {/if}
                            {/foreach}
                        </select>
                    </div>
                </div>

                <div class="pull-left kw">
                    <div class="pull-left text2"><span>行政区域</span></div>
                    <div class="down_box2">
                        <select class="form-control input-sm" name="areaType" onchange="changeAreaType(this)">
                            <option value="all" {if $_REQUEST['filter'][$page->tagsName['行政区域']]=='all'}selected{/if} >
                                全部
                            </option>
                            {if $page->filterAttr[$page->tagsName['行政区域']]}
                                {foreach $page->filterAttr[$page->tagsName['行政区域']]['val'] as $key=>$val}
                                    <option {if $_REQUEST['filter'][$page->tagsName['行政区域']]== $key}selected{/if}
                                            value="{$key}">{$key}</option>
                                {/foreach}
                            {/if}
                        </select>
                    </div>
                </div>

                <div class="pull-left kw">
                    <div class="pull-left text2"><span>服务行业</span></div>
                    <div class="down_box2">
                        <select class="form-control input-sm" name="serverType" id="" onchange="changeServerType(this)">
                            <option value="all">全部</option>
                            {if $page->filterAttr[$page->tagsName['服务行业类型']]}
                                {foreach $page->filterAttr[$page->tagsName['服务行业类型']]['val'] as $key=>$val}
                                    <option {if $_REQUEST['filter'][$page->tagsName['服务行业类型']]== $key}selected{/if}>{$key}</option>
                                {/foreach}
                            {/if}
                        </select>
                    </div>
                </div>
            </div>
        </div>
        <div id="allmap"></div>

        <div style="overflow: auto;">
            <div style="overflow: auto;margin: auto 0px;display: none">
                {include 'inc/service_list_fl_no_result.tpl'}
            </div>
        </div>
    </div>
</div>
<!---map右侧--->
<div class="pull-right map2" style="display: none">
    <div class="pull-left sidebar-toggler show" id="list"></div>
    <div class="pull-right map4 ">
        <div class="map2-middle">
            <ul>
                {foreach $page->getMapList['rows'] as $key=>$v}
                    <li>
                        <div class="pull-left m-img">
                            <a href="{$_root}service_info/{$v['id']}.html">
                                {if $v['logo']}
                                <img src="{$v['logo']}"></a>
                            {else}
                            <img src="images/map1.jpg"></a>
                            {/if}
                        </div>
                        <div class="pull-right text1">
                            <h4><a href="#"> {$v['product_name']}</a></h4>
                            {*<p>供应商: 上海独秀会展服务有限公司<br>*}
                            {*适合活动类型 : 商业发布,展览展示,新品发布会</p>*}
                            <span>价格：面议</span>

                            <p><a class="btn" style="border: 1px solid #000;height: 30px;"
                                  href="{$_root}service_info/{$v['id']}.html">查看详情</a></p>
                        </div>
                        <div class="clearfix"></div>
                    </li>
                {/foreach}
            </ul>
        </div>
        <div class="pag_out" style="text-align: center">

            <ul class="pagination" style="margin: 20px 4px;">
                {if $page->getMapList['page']['dpll']}
                    <li class="prev">
                        <a href="{$page->getMapList['page']['dup']}1" title="First"><i
                                    class="fa fa-angle-double-left"></i>&nbsp;第一页</a>
                    </li>
                    <li class="prev">
                        <a href="{$page->getMapList['page']['dup']}{$page->getMapList['page']['dp']-1}" title="Prev"><i
                                    class="fa fa-angle-left"></i>&nbsp;上一页</a>
                    </li>
                {else}
                    <li class="prev disabled">
                        <a title="First"><i class="fa fa-angle-double-left"></i>&nbsp;第一页</a>
                    </li>
                    <li class="prev disabled">
                        <a title="Prev"><i class="fa fa-angle-left"></i>&nbsp;上一页</a>
                    </li>
                {/if}
                {if $page->getMapList['page']['dprr']}
                    <li class="next">
                        <a href="{$page->getMapList['page']['dup']}{$page->getMapList['page']['dp']+1}" title="Next">下一页&nbsp;<i
                                    class="fa fa-angle-right"></i></a>
                    </li>
                    <li class="next">
                        <a href="{$page->getMapList['page']['dup']}{$page->getMapList['page']['dtp']}" title="Last">最后页&nbsp;<i
                                    class="fa fa-angle-double-right"></i></a>
                    </li>
                {else}
                    <li class="next disabled">
                        <a title="Next">下一页&nbsp;<i class="fa fa-angle-right"></i></a>
                    </li>
                    <li class="next disabled">
                        <a title="Last">最后页&nbsp;<i class="fa fa-angle-double-right"></i></a>
                    </li>
                {/if}
            </ul>
        </div>
    </div>
</div>

<div class="clearfix"></div>
</div>
<style>
    .show {
        position: absolute;
        right: 0;
    }

    .hidden {
        display: inline;
    }
</style>
{include file="Web_Static::v2.0/html_footer.tpl"}
<script type="text/javascript"
        src="http://api.map.baidu.com/library/TextIconOverlay/1.2/src/TextIconOverlay_min.js"></script>
<script type="text/javascript"
        src="http://api.map.baidu.com/library/MarkerClusterer/1.2/src/MarkerClusterer_min.js"></script>
<script type="text/javascript">
    //空间类型
    function changeSpaceType(o) {
        var cid = $(o).children('option:selected').val();
        var data = {
            category_id: cid
        };
        mapAjax(data);
    }
    //区域
    function changeAreaType(o) {
        var area = $(o).children('option:selected').val();
        var cid = $("select[name=spaceType]").children('option:selected').val();
        var data = {
            category_id: cid,
            "filter[{$page->tagsName['行政区域']}]": area
        };
        mapAjax(data);
    }
    //适合活动
    function changeServerType(o) {
        var server = $(o).children('option:selected').val();
        var cid = $("select[name=spaceType]").children('option:selected').val();
        var area = $("select[name=areaType]").children('option:selected').val();
        var data = {
            category_id: cid,
            'filter[{$page->tagsName['行政区域']}]': area,
            'filter[{$page->tagsName['服务行业类型']}]': server
        };
        mapAjax(data);
    }
    //ajax请求数据
    function mapAjax(condition) {
        condition['getType'] = 'ajax';
        $.ajax({
            url: "?",
            data: condition,
            success: function (data) {
                data = eval('[' + data + ']');
                var dataList = data[0]['rows'];
                if(dataList.length < 1){
                    alert('很抱歉没有找到您要查询的内容！');
                }
                var data_info = new Array();
                for (var i = 0; i < dataList.length; i++) {
                    data_info[i] = [
                        (dataList[i]['geo_lng'] / 1000), (dataList[i]['geo_lat'] / 1000), dataList[i]['product_name'], dataList[i]['addr'], dataList[i]['attr_index'], dataList[i]['id'], dataList[i]['logo']
                    ];
                }
                getMapData(data_info);
            }
        });
    }
    {*var data_info_init = eval([*}
    {*{foreach $page->getMapList['rows'] as $key=>$val}*}
    {*[{round($val['geo_lng']/1000,3)}, {str_pad(round($val['geo_lat']/1000,4),6,'01')}, "{$val['product_name']}", "{$val['addr']}", "{$val['attr_index']}", "{$val['id']}", "{$val['logo']}"],*}
    {*{/foreach}*}
    {*]);*}


    //清除marker点
    function deletePoint() {
        var allOverlay = map.getOverlays();
        for (var i = 0; i < allOverlay.length - 1; i++) {
            map.removeOverlay(allOverlay[i]);
        }
    }
    //异步请求
    function getMapData(data_info) {
        //百度地图API功能
        var map = new BMap.Map("allmap", {
            minZoom: 14, maxZoom: 19
        });
        map.centerAndZoom("{$_COOKIE['city']}", 14);
        map.enableScrollWheelZoom();
        map.addControl(new BMap.NavigationControl()); // 添加平移缩放控件
        map.addControl(new BMap.ScaleControl()); // 添加比例尺控件
        map.addControl(new BMap.OverviewMapControl()); //添加缩略地图控件
        //添加窗口
        var MAX = data_info.length;
        var markers = [];
        var pt = null;
        for (var i = 0; i < MAX; i++) {
            pt = new BMap.Point(data_info[i][0], data_info[i][1]);
            var opts = {
                title: '<span style="font-size:16px;color:#0A8021">' + data_info[i][2] + '</span>'
            };
            var content = "<div style='line-height:1.8em;font-size:12px;border-radius:5px; width: 280px;height: 90px;color: #555'>" +
                    "<div style='float: left;overflow: auto;width: 170px;'><b>地址:</b>" + data_info[i][3] + "</br>" +
                    "<b>价格:</b>面议</br>" +
                    "<a style='border-radius:3px;margin-top:10px;width:50px;padding:3px 20px;background-color: #0f7ddb;color: #FFF' href='{$_root}service_info/" + data_info[i][5] + ".html'>详情</a></div>" +
                    "<div style='float: right'><img src='" + data_info[i][6] + "' style='width: 100px;'></div>" +
                    "</div>";
            marker = new BMap.Marker(pt);
            markers.push(marker);
            map.addOverlay(marker);               // 将标注添加到地图中
            addClickHandler(content, opts, marker,map);

        }

        //最简单的用法，生成一个marker数组，然后调用markerClusterer类即可。
        var markerClusterer = new BMapLib.MarkerClusterer(map, {
            markers: markers
        });
        map.addOverlay(markerClusterer);

    }
    function addClickHandler(content, opts, marker,map) {
        marker.addEventListener("click", function (e) {
                    openInfo(content, opts, e,map)
                }
        )
    }
    function openInfo(content, opts, e,map) {
        var p = e.target;
        var point = new BMap.Point(p.getPosition().lng, p.getPosition().lat);
        var infoWindow1 = new BMap.InfoWindow(content, opts);    // 创建信息窗口对象
        map.openInfoWindow(infoWindow1, point);                  //开启信息窗口
    }

    var data = {
        category_id: {$page->categoryId}
    };
    mapAjax(data);

</script>
<script>
    $(function () {
        $('#list').click(function () {
            $(".map4").toggle();
            $("#list").toggleClass('show');
//$('.map2').animate({
//    right:'-95%'
//},1000)
        })


    })
</script>
</body>
</html>

