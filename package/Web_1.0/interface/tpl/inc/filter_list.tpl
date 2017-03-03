<!DOCTYPE html>
<html>
<head>
    {include file="inc/html_head.tpl"}
    <link rel="stylesheet" type="text/css" href="css/filter.css">
</head>
<body>

<div class=" wrap clearfix s_lt">
   <!--tab切换开始 -->
   <div id="nav_scr" class="nav_scr">
    <ul id="wapNexNav" class="wapNexNav clearfix">
        <li class="active"><a href="#">场地搭建</a></li>
        <li><a href="#">印刷制作</a></li>
        <li><a href="#">AV设备租赁</a></li>
        <li><a href="#">视频制作</a></li>
        <li><a href="#">活动拍摄</a></li>
        <li><a href="#">演出表演</a></li>
        <li><a href="#">外烩餐饮</a></li>
        <li><a href="#">物料制作</a></li>
        <li><a href="#">第三方劳务</a></li>
        <!--手机导航 js添加 -->
    </ul>

    <ul class="nav_sl clearfix con guide" id="nav_sl">
        <li>
            <a href="#">场地搭建</a>
        </li>
        <li>
            <a href="#">印刷制作</a>
        </li>
        <li>
            <a href="#" class="hover">AV设备租赁</a>
        </li>
        <li>
            <a href="#">视频制作</a>
        </li>
        <li>
            <a href="#">活动拍摄</a>
        </li>
        <li>
            <a href="#">演出表演</a>
        </li>
        <li>
            <a href="#">外烩餐饮</a>
        </li>
        <li>
            <a href="#">物料制作</a>
        </li>
        <li>
            <a href="#">第三方劳务</a>
        </li>
    </ul>
    <span class="nar"><i class="fa fa-angle-right"></i></span>
</div>

   <!--筛选区域开始 -->
    <div class="table-responsive">
   <div class="filter_outside">
<div class="filter_selected">
    <div class="filter_title_selected">
        已选条件：
    </div>
    <div class="filter_item">
        <ul class="filter_item_selected">
            <li>人民广场<button type="button" class="close close_button" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button></li>
            <li>人民广场<button type="button" class="close close_button" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button></li>
            <li>人民广场<button type="button" class="close close_button" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button></li>
            <li>人民广场<button type="button" class="close close_button" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button></li>
            <li>人民广场<button type="button" class="close close_button" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button></li>
        </ul>
    </div>
    <a href="#" class="clearup" style="color: #34495e;">清空所有条件</a>
</div>

<div class="filter_unselected">
    <div class="filter_title">
        服务类型：
    </div>
    <div class="filter_unselected_item">
        <ul class="dropdrown">
            <li>商业广场</li><li>创意园区</li><li>超市卖场</li><li>会议中心</li><li>酒店</li><li>写字楼</li><li>剧场影院</li><li>体育馆</li><li>会所</li><li>餐厅</li><li>酒吧</li>
            <li>游艇别墅</li><li>赛车场</li><li>美术馆</li><li>博物馆</li><li>社区</li><li>展览馆</li><li>标志建筑</li><li>特色空间</li><li>公园</li><li>码头</li><li>绿地广场</li><li>学校</li>
        </ul>
    </div>
    <div class="clear"></div>
</div>
<div class="filter_unselected">
    <div class="filter_title">
        适合活动：
    </div>
    <div class="filter_unselected_item">
        <ul class="dropdrown">
            <li>小于200㎡</li><li>200-500㎡</li><li>500-800㎡</li><li>800-1000㎡</li><li>1000-2000㎡</li><li>2000㎡以上</li>
        </ul>
    </div>
    <div class="clear"></div>
</div>
<div class="filter_unselected">
    <div class="filter_title">
        适合行业：
    </div>
    <div class="filter_unselected_item">
        <ul class="dropdrown">
            <li>黄埔</li><li>徐汇</li><li>长宁</li><li>静安</li><li>普陀</li><li>闸北</li><li>虹口</li><li>奉贤</li><li>杨浦</li><li>闵行</li><li>宝山</li><li>嘉定</li>
            <li>浦东新区</li><li>金山</li><li>松江</li><li>青浦</li><li>崇明县</li>
        </ul>
    </div>
    <div class="clear"></div>
</div>
<div class="filter_unselected" style="border-bottom: none;">
    <div class="filter_title">
        热门商圈：
    </div>
    <div class="filter_unselected_item">
        <ul class="dropdrown">
            <li>上海体育场</li><li>淮海路</li><li>南京西路</li><li>人民广场</li><li>中山公园</li><li>徐家汇</li><li>陆家嘴</li><li>东方明珠</li>
            <li>五角场</li><li>静安寺</li><li>世纪公园</li><li>外滩</li><li>长寿路</li><li>中环百联</li><li>世博源</li><li>虹口足球场</li>
        </ul>
    </div>
    <div class="clear"></div>
</div>


</div>

    <div class="search_outside">
        <form class="form-inline">
            <div class="form-group form_search">
                <label class="sr-only" for="search">...</label>
                <div class="input-group input_search">
                    <input type="text" class="form-control input-lg is" id="search" placeholder="">
                    <a class="input-group-addon search_button">
                        搜&nbsp;索
                    </a>
                </div>
            </div>
        </form>
    </div>
   <!--展开更多开始 -->
        <script>
            $(document).ready(function () {
                $('.mose_ke').click(function() {
                    $('.table-responsive').toggle();
                });
            });
        </script>
</div>
    <div class="mose_ke mose_ke_border" id="mose_ke">
        展开更多筛选条件
    </div>




</body>

