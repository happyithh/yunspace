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
                    <li class="selected">所有选项</li>
                    <li>Hello!</li>
                    <li>你好!</li>
                    <li>Hi!</li>
                </ul>
                <span class="icon-c icon-clean js-ipt-clean"></span>
            </div><!--select-end-->
            <a class="search-btn" href="javascript:;"><span class="icon-c icon-search-btn"></span></a>
        </div>
    </div>

    <!--百度地图容器-->
    <div id="map" style="width: 100%;height: 100%;overflow: hidden;"></div>
</div>

</body>
</html>