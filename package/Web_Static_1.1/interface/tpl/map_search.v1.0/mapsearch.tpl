<!DOCTYPE html>
<html>
<head>
    {include file="Web_Static::v2.0/html_head.tpl"}
    {static "home.v3.0/data-picker.css"}
    {static "home.v3.0/home.css"}
    {static "mapsearch/mapsearch.css"}
    {static "mapsearch/slide.css"}
    <link rel="stylesheet" href="plugins/ionicons-master/css/ionicons.min.css">

    <!--引用百度地图API-->
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=aaNCRRcGGai6klHMOGZ8yBbP"></script>
</head>
<body>
{include file="Web_Static::v2.0/html_header3.1.tpl"}
<!--左侧百度地图-->
<div class="mapsearch">
    <!--百度地图容器-->
    <div id="map" style="width: auto;height: 100%;overflow: hidden;"></div>
iu
    <!--搜索框-->
    <form id="searchForm" action='' method='post'>
        <div class="range-room map-range-room">
            <div class="range-room-con">
                <div class="r-r-p">
                    在
                </div>
                <div class="r-r-select">
                    <div class="r-r-s-title select-click select1"  style="line-height: 40px;">
                        {*<input type="text" class="par2" id="customPlaces" placeholder="上海市中心" name="customPlaces" style="display: none"/>*}
                        <input type="text" class="par1" id="customPlace" placeholder="上海市中心" name="customPlace"/>
                    </div>
                </div>
                <div class="r-r-p r-r-p2">
                    附近
                </div>
                <div class="r-r-select distance">
                    <div class="r-r-s-title select-click select1"  style="line-height: 40px;">
                        <input type="text" class="par2" id="customDistance" name="customDistance" value="2公里" readonly/>
                        <span class="ion-arrow-down-b"  style="line-height: 40px;"></span>
                    </div>
                    <div class="drop-down-home dropDown hide" style="border: 1px solid #ededed;border-top: 0px;background: #fff;top:50px;">
                        <ul >
                            <li>0.5公里</li>
                            <li>1公里</li>
                            <li>3公里</li>
                            <li>5公里</li>
                            <li>6公里</li>
                        </ul>
                    </div>
                </div>
                <div class="r-r-button"  style="line-height: 40px;">
                    <button  type="submit" style="line-height: 40px;"><span class="icon-search"></span><span>找空间</span></button>
                    {*<input type="submit" style="line-height: 40px;" class="f-room" value="找空间" />*}
                </div>
            </div>

        </div>

    </form>

</div>

<!--右侧内容部分-->
<div class="mapsearch-content">
    <div class="mapsearch-cont">
        <div class="mcont-screening" id="mcont-screening">
            <dl class="clearfix dlist" id = "a">
                <dt>空间类型：</dt>
                <dd>
                    <a href="javascript:;">秀场展馆</a>
                    <a href="javascript:;">商业广场</a>
                    <a href="javascript:;">艺术馆画廊</a>
                    <a href="javascript:;">体育场馆</a>
                    <a href="javascript:;">影院剧院</a>
                    <a href="javascript:;">餐厅酒吧</a>
                    <a href="javascript:;">体育场馆</a>
                    <a href="javascript:;">影院剧院</a>
                    <a href="javascript:;">餐厅酒吧</a>
                    <a href="javascript:;">体育场馆</a>
                    <a href="javascript:;">影院剧院</a>
                    <i class="a_downup a_down"></i>
                </dd>
            </dl>
            <dl class="clearfix dlist" id = "b">
                <dt>适合人数：</dt>
                <dd>
                    <a href="javascript:;">秀场展馆</a>
                    <a href="javascript:;">商业广场</a>
                    <a href="javascript:;">艺术馆画廊</a>
                    <a href="javascript:;">体育场馆</a>
                    <a href="javascript:;">影院剧院</a>
                    <a href="javascript:;">餐厅酒吧</a>
                    <a href="javascript:;">体育场馆</a>
                    <a href="javascript:;">影院剧院</a>
                    <a href="javascript:;">餐厅酒吧</a>
                    <a href="javascript:;">体育场馆</a>
                    <a href="javascript:;">影院剧院</a>
                    <i class="a_downup a_down"></i>
                </dd>
            </dl>
            <dl class="clearfix dlist" id = "c">
                <dt>行政区域：</dt>
                <dd>
                    <a href="javascript:;">浦东新区</a>
                    <a href="javascript:;">黄浦区</a>
                    <a href="javascript:;">虹口区</a>
                    <a href="javascript:;">徐汇区</a>
                    <a href="javascript:;">闸北区</a>
                    <a href="javascript:;">静安区</a>
                    <a href="javascript:;">黄浦区</a>
                    <a href="javascript:;">虹口区 </a>
                    <a href="javascript:;">黄浦区</a>
                    <a href="javascript:;">黄浦区</a>
                    <a href="javascript:;">虹口区 </a>
                    <a href="javascript:;">黄浦区</a>
                    <a href="javascript:;">虹口区 </a>
                    <a href="javascript:;">黄浦区</a>
                    <a href="javascript:;">虹口区 </a>
                    <i class="a_downup a_down"></i>
                </dd>
            </dl>
            <dl class="clearfix dlist" id = "d">
                <dt>场地面积：</dt>
                <dd>
                    <a href="javascript:;">50㎡以下</a>
                    <a href="javascript:;">50~100㎡</a>
                    <a href="javascript:;">100~200㎡</a>
                    <a href="javascript:;">200~500㎡</a>
                    <a href="javascript:;">500~1000㎡</a>
                    <a href="javascript:;">1000㎡以上</a>
                    <i class="a_downup a_down"></i>
                </dd>
            </dl>
            <dl class="clearfix dlist slidehide" id = "e">
                <dt>活动类型：</dt>
                <dd>
                    <a href="javascript:;">商业发布</a>
                    <a href="javascript:;">会议会务</a>
                    <a href="javascript:;">主题派对</a>
                    <a href="javascript:;">展览展示</a>
                    <a href="javascript:;">新品发布会</a>
                    <a href="javascript:;">晚会年会</a>
                    <i class="a_downup a_down"></i>
                </dd>
            </dl>
            <dl class="clearfix dlist slidehide" id = "f">
                <dt>行业类型：</dt>
                <dd>
                    <a href="javascript:;">金融</a>
                    <a href="javascript:;">消费品</a>
                    <a href="javascript:;">通用</a>
                    <a href="javascript:;">奢侈品</a>
                    <a href="javascript:;">房地产</a>
                    <a href="javascript:;">游戏</a>
                    <i class="a_downup a_down"></i>
                </dd>
            </dl>
            <dl class="clearfix dlchoice">
                <dt>你已选择：</dt>
                <dd class="hv-choice-list">

                </dd>
                <dd class="choice-more c-up hide"><a class="more" href="javascript:;"><span>收起</span><i class="icon-putaway"></i></a></dd>
                <dd class="choice-more c-mo"><a class="more" href="javascript:;">更多选项</a></dd>
            </dl>
        </div>
        <!--mcont-screening-end-->

        <div class="mcont-list">
            <div class="mcont-list-title">
                <div class="sort fl">
                    <a class="active" href="javascript:;">综合排序</a>
                    <a href="javascript:;"><span>最新</span><span class="icon-sort"></span></a>
                    <a href="javascript:;"><span>最热</span><span class="icon-sort"></span></a>
                </div>
                <a class="back-list fr" href="">
                    <span class="icon-list"></span><span>切回列表</span>
                </a>
            </div>
            <ul class="mcont-list-cont">
                <li class="clearfix">
                    <div class="mcont-img">
                        <a href=""><img src="img/mapsearch/list_img1.jpg"></a>
                    </div>
                    <div class="mcont-details">
                        <h2><a href="">Finger Moving创意空间</a></h2>
                        <p><a href="">风筝森林里的幽会 墨西哥艺术中心年</a></p>
                        <div class="m-tag">
                            <span>展览展示</span>
                            <span>艺术展示</span>
                        </div>
                        <p>103㎡ | 50~100人 | 宝山区罗店镇联杨路3888号</p>
                    </div><!--mcont-details-end-->
                    <div class="mcont-price">
                        <strong>2590</strong><span>/元</span>
                    </div>
                </li>
                <li class="clearfix">
                    <div class="mcont-img">
                        <a href=""><img src="img/mapsearch/list_img1.jpg"></a>
                    </div>
                    <div class="mcont-details">
                        <h2><a href="">Finger Moving创意空间</a></h2>
                        <p><a href="">风筝森林里的幽会 墨西哥艺术中心年</a></p>
                        <div class="m-tag">
                            <span>展览展示</span>
                            <span>艺术展示</span>
                        </div>
                        <p>103㎡ | 50~100人 | 宝山区罗店镇联杨路3888号</p>
                    </div><!--mcont-details-end-->
                    <div class="mcont-price">
                        <strong>2590</strong><span>/元</span>
                    </div>
                </li>
                <li class="clearfix">
                    <div class="mcont-img">
                        <a href=""><img src="img/mapsearch/list_img1.jpg"></a>
                    </div>
                    <div class="mcont-details">
                        <h2><a href="">Finger Moving创意空间</a></h2>
                        <p><a href="">风筝森林里的幽会 墨西哥艺术中心年</a></p>
                        <div class="m-tag">
                            <span>展览展示</span>
                            <span>艺术展示</span>
                        </div>
                        <p>103㎡ | 50~100人 | 宝山区罗店镇联杨路3888号</p>
                    </div><!--mcont-details-end-->
                    <div class="mcont-price">
                        <strong>2590</strong><span>/元</span>
                    </div>
                </li>
                <li class="clearfix">
                    <div class="mcont-img">
                        <a href=""><img src="img/mapsearch/list_img1.jpg"></a>
                    </div>
                    <div class="mcont-details">
                        <h2><a href="">Finger Moving创意空间</a></h2>
                        <p><a href="">风筝森林里的幽会 墨西哥艺术中心年</a></p>
                        <div class="m-tag">
                            <span>展览展示</span>
                            <span>艺术展示</span>
                        </div>
                        <p>103㎡ | 50~100人 | 宝山区罗店镇联杨路3888号</p>
                    </div><!--mcont-details-end-->
                    <div class="mcont-price">
                        <strong>2590</strong><span>/元</span>
                    </div>
                </li>
                <li class="clearfix">
                    <div class="mcont-img">
                        <a href=""><img src="img/mapsearch/list_img1.jpg"></a>
                    </div>
                    <div class="mcont-details">
                        <h2><a href="">Finger Moving创意空间</a></h2>
                        <p><a href="">风筝森林里的幽会 墨西哥艺术中心年</a></p>
                        <div class="m-tag">
                            <span>展览展示</span>
                            <span>艺术展示</span>
                        </div>
                        <p>103㎡ | 50~100人 | 宝山区罗店镇联杨路3888号</p>
                    </div><!--mcont-details-end-->
                    <div class="mcont-price">
                        <strong>2590</strong><span>/元</span>
                    </div>
                </li>
                <li class="clearfix">
                    <div class="mcont-img">
                        <a href=""><img src="img/mapsearch/list_img1.jpg"></a>
                    </div>
                    <div class="mcont-details">
                        <h2><a href="">Finger Moving创意空间</a></h2>
                        <p><a href="">风筝森林里的幽会 墨西哥艺术中心年</a></p>
                        <div class="m-tag">
                            <span>展览展示</span>
                            <span>艺术展示</span>
                        </div>
                        <p>103㎡ | 50~100人 | 宝山区罗店镇联杨路3888号</p>
                    </div><!--mcont-details-end-->
                    <div class="mcont-price">
                        <strong>2590</strong><span>/元</span>
                    </div>
                </li>
            </ul>


            <!--筛选条件无结果时-开始-->
            <div class=" mcont-none">
                <div class="mcont-logo"><img src="img/mapsearch/m_logo.png" alt="logo"></div>
                <p>没找到这个场地呢，来看看我们的推荐吧</p>
                <a class="mcont-btn f-room" href="javascript:;">我要办活动</a>
            </div>
            <div class=" recommend-title">相关推荐</div>
            <ul class=" mcont-list-cont recommend">
                <li class="clearfix">
                    <div class="mcont-img">
                        <a href=""><img src="img/mapsearch/list_img1.jpg"></a>
                    </div>
                    <div class="mcont-details">
                        <h2><a href="">Finger Moving创意空间</a></h2>
                        <p><a href="">风筝森林里的幽会 墨西哥艺术中心年</a></p>
                        <div class="m-tag">
                            <span>展览展示</span>
                            <span>艺术展示</span>
                        </div>
                        <p>103㎡ | 50~100人 | 宝山区罗店镇联杨路3888号</p>
                    </div><!--mcont-details-end-->
                    <div class="mcont-price">
                        <strong>2590</strong><span>/元</span>
                    </div>
                </li>
                <li class="clearfix">
                    <div class="mcont-img">
                        <a href=""><img src="img/mapsearch/list_img1.jpg"></a>
                    </div>
                    <div class="mcont-details">
                        <h2><a href="">Finger Moving创意空间</a></h2>
                        <p><a href="">风筝森林里的幽会 墨西哥艺术中心年</a></p>
                        <div class="m-tag">
                            <span>展览展示</span>
                            <span>艺术展示</span>
                        </div>
                        <p>103㎡ | 50~100人 | 宝山区罗店镇联杨路3888号</p>
                    </div><!--mcont-details-end-->
                    <div class="mcont-price">
                        <strong>2590</strong><span>/元</span>
                    </div>
                </li>
            </ul>
            <!--筛选条件无结果时-结束-->

        </div><!--mcont-list-end-->

        <div class="pagers">
            <a href="" class="prev first gray"><span>«&nbsp;</span>第一页</a>
            <a href="" class="prev gray">&lt;&nbsp;上一页</a>
            <a href="" class="active">1</a>
            <a href="">2</a>
            <a href="">3</a>
            <a href="">4</a>
            <a href="">5</a>
            <a href="">6</a>
            <a href="">7</a>
            <a href="">8</a>
            <a href="" class="next">下一页&nbsp;&gt;</a>
            <a href="" class="next last">最后页<span>&nbsp;»</span></a>
        </div>
    </div><!--mapsearch-cont-end-->
</div>

<!--选项预览-->
{*<div class="m-preview hide">*}
    {*<a class="close" href="javascript:;"></a>*}
    {*<h1><a href="">Finger Moving创意空间</a></h1>*}
    {*<div class="m-banner">*}
        {*<div id="carousel-example-generic" class="carousel slide" data-ride="carousel">*}
            {*<!-- Indicators -->*}
            {*<ol class="carousel-indicators">*}
                {*<li data-target="#carousel-example-generic" data-slide-to="0" class="carousel-gui active"></li>*}
                {*<li data-target="#carousel-example-generic" data-slide-to="1" class="carousel-gui"></li>*}
                {*<li data-target="#carousel-example-generic" data-slide-to="2" class="carousel-gui"></li>*}
            {*</ol>*}
            {*<!-- Wrapper for slides -->*}
            {*<div class="carousel-inner" role="listbox"   style="overflow-x: hidden">*}
                {*<div class="item active">*}
                    {*<img src="img/mapsearch/banner_img1.jpg" alt="...">*}
                {*</div>*}
                {*<div class="item">*}
                    {*<img src="img/mapsearch/banner_img1.jpg" alt="...">*}
                {*</div>*}
                {*<div class="item">*}
                    {*<img src="img/mapsearch/banner_img1.jpg" alt="...">*}
                {*</div>*}
            {*</div>*}
            {*<a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">*}
                {*<span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>*}
                {*<span class="sr-only ion-ios-arrow-left"></span>*}
            {*</a>*}
            {*<a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">*}
                {*<span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>*}
            {*<span class="sr-only ion-ios-arrow-right ">*}
            {*</span>*}
            {*</a>*}
        {*</div>*}
    {*</div><!--m-banner-end-->*}
    {*<div class="mpw-cont">*}
        {*<div class="text clearfix">*}
            {*<span class="tit">参考价格：</span>*}
            {*<p>￥<strong>2590</strong><span>/元</span></p>*}
            {*<div class="collect js-collect"><span class="icon-collect colt1"></span><span>收藏</span></div>*}
        {*</div>*}
        {*<div class="ads-text clearfix">*}
            {*<span class="tit">具体地址：</span>*}
            {*<p>宝山区罗店镇联杨路3888号 </p>*}
        {*</div>*}
        {*<div class="m-tag clearfix">*}
            {*<span>展览展示</span>*}
            {*<span>艺术展品</span>*}
            {*<span>展览展示</span>*}
            {*<span>艺术展品</span>*}
        {*</div>*}
        {*<div class="k-text clearfix">*}
            {*<span class="tit">空间标准</span>*}
            {*<p>*}
                {*<span>使用面积 ：800㎡ </span>*}
                {*<span>空间层高 ：9m</span>*}
                {*<span>空间承重 ：1吨</span>*}
                {*<span>容纳人数：100人</span>*}
            {*</p>*}
        {*</div>*}
        {*<a href="" class="m-btn">查看详情</a>*}
    {*</div><!--mpw-cont-end-->*}
{*</div><!--m-preview-end-->*}
{include file="Web_Static::v2.0/form.tpl"}
{static "v3.0/header.v3.0.js"}
{static "js/bootstrap.min.js"}
{static "mapsearch/RichMarker.js"}
{static "mapsearch/mapsearch.js"}
{static "mapsearch/map.js"}
{static "core/yunspace.js"}
</body>
</html>