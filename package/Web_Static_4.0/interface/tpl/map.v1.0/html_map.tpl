<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <title>地图搜索</title>
    {static "v4.0/common.css"}
    {static "map.v1.0/map.css"}
    {static "js/jquery-1.9.1.min.js"}
    {static "map.v1.0/map.js"}
    <!--引用百度地图API-->
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=aaNCRRcGGai6klHMOGZ8yBbP"></script>
</head>
<body>
{include file="Web_Static::inc/header.tpl"}
<div class="container">
    <div class="map-container">
        <div class="search">
            <div class="select">
                <input class="hvselect" type="text" placeholder="搜索你想要找的场地">
                <ul>
                    <li class="selected">影院</li>
                    <li>上海奢居会<span>上海</span></li>
                    <li>申通快递</li>
                    <li>上海南京东路苹果手机维修</li>
                    <li>苹果维修</li>
                    <li>傣妹火锅<span>上海市黄浦区</span></li>
                </ul>
                <span class="icon-c icon-clean js-ipt-clean"></span>
            </div><!--select-end-->
            <a class="search-btn" href="javascript:;"><span class="icon-c icon-search-btn"></span></a>
        </div>
        <!--筛选内容部分-->
        <div class="mapsearch-cont">
            <div class="mcont-screening" id="mcont-screening">
                <dl class="clearfix dlchoice">
                    <dt>你已选择</dt>
                    <dd class="hv-choice-list clearfix">
                        <p class="hv">
                            <span>上海</span>
                            <a class="delete-btn js-delete icon-c" href="javascript:;"></a>
                        </p>
                        <p class="hv">
                            <span>浦东新区</span>
                            <a class="delete-btn js-delete icon-c" href="javascript:;"></a>
                        </p>
                        <p class="hv">
                            <span>主题派对</span>
                            <a class="delete-btn js-delete icon-c" href="javascript:;"></a>
                        </p>
                        <p class="hv">
                            <span>主题派对</span>
                            <a class="delete-btn js-delete icon-c" href="javascript:;"></a>
                        </p>
                        <p class="hv">
                            <span>主题派对</span>
                            <a class="delete-btn js-delete icon-c" href="javascript:;"></a>
                        </p>
                        <div class="choice-delete-all fr">
                            <span class="icon-c icon-delete"></span>
                            <a class="delete js-delete-all" href="javascript:;">全部删除</a>
                        </div>
                    </dd>
                </dl>
                <dl class="clearfix dlist">
                    <dt>行政区域</dt>
                    <dd>
                        <a href="javascript:;">浦东新区</a>
                        <a href="javascript:;">黄浦区</a>
                        <a href="javascript:;">虹口区</a>
                        <a href="javascript:;">徐汇区</a>
                        <a href="javascript:;">闸北区</a>
                        <a href="javascript:;">静安区</a>
                        <p class="js-a-downup a-downup-wrapper"><i class="icon-c a-downup"></i></p>
                    </dd>
                </dl>
                <dl class="clearfix dlist">
                    <dt>活动类型</dt>
                    <dd>
                        <a href="javascript:;">商业发布</a>
                        <a href="javascript:;">会议会务</a>
                        <a href="javascript:;">主题派对</a>
                        <a href="javascript:;">展览展示</a>
                        <p class="js-a-downup a-downup-wrapper"><i class="icon-c a-downup"></i></p>
                    </dd>
                </dl>
                <dl class="clearfix dlist">
                    <dt>场地面积</dt>
                    <dd>
                        <a href="javascript:;">100~200㎡</a>
                        <a href="javascript:;">200~500㎡</a>
                        <a href="javascript:;">500~1000㎡</a>
                        <a href="javascript:;">1000㎡以上</a>
                        <p class="js-a-downup a-downup-wrapper"><i class="icon-c a-downup"></i></p>
                    </dd>
                </dl>

            </div>
            <!--mcont-screening-end-->

            <div class="mcont-list">
                <div class="mcont-list-title">
                    <a class="active" href="javascript:;">综合排序</a>
                    <a href="javascript:;">最热</a>
                    <a href="javascript:;">浏览量</a>
                    <a href="javascript:;">指数</a>
                </div>
                <ul class="mcont-list-cont">
                    <li class="clearfix">
                        <div class="mcont-img">
                            <a href=""><img src="img/map/img_list1.jpg"></a>
                        </div>
                        <div class="mcont-details">
                            <h2><a href="">黄浦区奢居会户外会所</a></h2>
                            <p>展览展示 \ 艺术品展出  \ 演场演出</p>
                            <div class="m-info">
                                <span>浏览量：456</span>
                                <span class="zshu">指数：8</span>
                            </div>
                        </div><!--mcont-details-end-->
                        <div class="mcont-inquiry clearfix">
                            <span class="icon-c icon-inq-gray"></span>
                            <div class="mcont-inquiry-details">
                                <span class="icon-c icon-inq-white"></span>
                                <p>查询档期和价格</p>
                            </div>
                        </div>
                    </li>
                    <li class="clearfix">
                        <div class="mcont-img">
                            <a href=""><img src="img/map/img_list1.jpg"></a>
                        </div>
                        <div class="mcont-details">
                            <h2><a href="">黄浦区奢居会户外会所</a></h2>
                            <p>展览展示 \ 艺术品展出  \ 演场演出</p>
                            <div class="m-info">
                                <span>浏览量：456</span>
                                <span class="zshu">指数：8</span>
                            </div>
                        </div><!--mcont-details-end-->
                        <div class="mcont-inquiry clearfix">
                            <span class="icon-c icon-inq-gray"></span>
                            <div class="mcont-inquiry-details">
                                <span class="icon-c icon-inq-white"></span>
                                <p>查询档期和价格</p>
                            </div>
                        </div>
                    </li>
                    <li class="clearfix">
                        <div class="mcont-img">
                            <a href=""><img src="img/map/img_list1.jpg"></a>
                        </div>
                        <div class="mcont-details">
                            <h2><a href="">黄浦区奢居会户外会所</a></h2>
                            <p>展览展示 \ 艺术品展出  \ 演场演出</p>
                            <div class="m-info">
                                <span>浏览量：456</span>
                                <span class="zshu">指数：8</span>
                            </div>
                        </div><!--mcont-details-end-->
                        <div class="mcont-inquiry">
                            <span class="icon-c icon-inq-gray"></span>
                            <div class="mcont-inquiry-details">
                                <span class="icon-c icon-inq-white"></span>
                                <p>查询档期和价格</p>
                            </div>
                        </div>
                    </li>
                    <li class="clearfix">
                        <div class="mcont-img">
                            <a href=""><img src="img/map/img_list1.jpg"></a>
                        </div>
                        <div class="mcont-details">
                            <h2><a href="">黄浦区奢居会户外会所</a></h2>
                            <p>展览展示 \ 艺术品展出  \ 演场演出</p>
                            <div class="m-info">
                                <span>浏览量：456</span>
                                <span class="zshu">指数：8</span>
                            </div>
                        </div><!--mcont-details-end-->
                        <div class="mcont-inquiry">
                            <span class="icon-c icon-inq-gray"></span>
                            <div class="mcont-inquiry-details">
                                <span class="icon-c icon-inq-white"></span>
                                <p>查询档期和价格</p>
                            </div>
                        </div>
                    </li>
                </ul>
            </div><!--mcont-list-end-->

        </div><!--mapsearch-cont-end-->
    </div>

    <!--百度地图容器-->
    <div id="map" style="width: 100%;height: 100%;overflow: hidden;"></div>
    <div class="map-scale-btn">
        <a class="icon-c scale scale-reduce" href="javascript:;"></a>
        <a class="icon-c scale scale-enlarge" href="javascript:;"></a>
    </div>
</div>

</body>
</html>