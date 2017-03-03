<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="css/v1.0/global.css"/>
    <link rel="stylesheet" href="{$_root}yun/plugins/dropDown/css/dropDown.css"/>
    <link rel="stylesheet" href="{$_root}yun/plugins/dropDown/css/ionicons.min.css"/>
    <script src="js/v1.0/jquery-1.11.1.min.js"></script>
    <script src="{$_root}yun/plugins/dropDown/js/dropDown.js"></script>
    <title>dropDown</title>
</head>
<body   yun-src="{$_root}yun/plugins/dropDown/">
<div class="drop-down-body">
    <div class="drop">
        <div class="drop-nav">
            <div class="drop-click col-4" yun="js/dropDown.js::showDrop@click" yun-id="0">
                <a href="javascript:;" class="">
                    下拉框1
                    <span class="ion-arrow-down-b  drop-icon"></span>
                    <div class="drop-border"></div>
                </a>
            </div>
            <div class="drop-click col-4" yun="js/dropDown.js::showDrop@click"  yun-id="1">
                <a href="javascript:;">
                    下拉框2
                    <span class="ion-arrow-down-b  drop-icon"></span>
                    <div class="drop-border"></div>
                </a>
            </div>
            <div class="drop-click col-4 "  yun="js/dropDown.js::showDrop@click"  yun-id="2">
                <a href="javascript:;">
                    下拉框3
                    <span class="ion-arrow-down-b   drop-icon"></span>
                    <div class="drop-border"></div>
                </a>
            </div>
            <div class="drop-click col-4 "  yun="js/dropDown.js::showDrop@click"  yun-id="3">
                <a href="javascript:;">
                    下拉框4
                    <span class="ion-arrow-down-b   drop-icon"></span>
                    <div class="drop-border"></div>
                </a>
            </div>
        </div>

        <div class="drop-content">
            <div class="drop-con">1111111111111111111111111111111111</div>
            <div class="drop-con">2222222222222222222222222222222222</div>
            <div class="drop-con">3333333333333333333333333333333333</div>
            <div class="drop-con">4444444444444444444444444444444444</div>
        </div>
    </div>
</div>
<div class="cover"></div>
{static "core/yunspace.js"}
</body>
</html>