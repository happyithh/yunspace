<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="css/v1.0/global.css"/>
    <link rel="stylesheet" href="{$_root}yun/plugins/tabChange/css/tabChange.css"/>
    <script src="js/v1.0/jquery-1.11.1.min.js"></script>
    <title>dropDown</title>
</head>
<body   yun-src="{$_root}yun/plugins/tabChange/">

<div class="tab-change">
    {*tab导航*}
    {*col-2:width50%
    col-3:width33.3%
    col-4:width25%
    col-5:width20%
    *}
    {*当tab-nav宽度变化时，line宽度也需变化*}
        <ul class="tab-nav cle relative">
            <li class="col-5 fl"><a href="javascript:;" class="nav-click nav-click-active"  yun="js/tabChange.js::tabChange@click" yun-id="1">tab1</a></li>
            <li class="col-5 fl"><a href="javascript:;" class="nav-click"  yun="js/tabChange.js::tabChange@click" yun-id="2">tab2</a></li>
            <li class="col-5 fl"><a href="javascript:;" class="nav-click"  yun="js/tabChange.js::tabChange@click" yun-id="3">tab3</a></li>
            <li class="col-5 fl"><a href="javascript:;" class="nav-click"  yun="js/tabChange.js::tabChange@click" yun-id="4">tab4</a></li>
            <li class="col-5 fl"><a href="javascript:;" class="nav-click"  yun="js/tabChange.js::tabChange@click" yun-id="5">tab5</a></li>
            <li class="line col-5 absolute"></li>
        </ul>
    {*tab内容*}
    <div class="tab-cont">
        <div class="tab cle tab-active">
            111111111111111111111111111111111111
        </div>
        <div class="tab cle">
            222222222222222222222222
        </div>
        <div class="tab cle">
            333333333333333333333333
        </div>
        <div class="tab cle">
            44444444444444444444444
        </div>
        <div class="tab cle">
           55555555555555555555555555555555555
        </div>
    </div>
</div>

{static "core/yunspace.js"}
</body>
</html>