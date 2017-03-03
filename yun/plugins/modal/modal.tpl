<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="css/v1.0/global.css"/>
    <link rel="stylesheet" href="{$_root}yun/plugins/modal/css/modal.css"/>
    <script src="js/v1.0/jquery-1.11.1.min.js"></script>
    <title>dropDown</title>
</head>
<body   yun-src="{$_root}yun/plugins/modal/">
{*移动端*}
<a href="javascript:;"  yun="js/modal.js::showModalMove@click"  style="display: block;line-height: 30px;width:80px;background: #DDDDDD">点击move</a>
<div class="modal-move">
    样式内容
</div>
{*PC端*}
{*需要提供title参数*}
<a href="javascript:;"  yun="js/modal.js::showModalPc@click"  yun-title="提醒内容" style="display: block;line-height: 30px;width:80px;background: #DDDDDD">点击PC</a>
<div class="modal-pc">
   <div class="modal-content">
        <div class="modal-title">

        </div>
        <div class="modal-ok">
           <a href="javascript:;"  yun="js/modal.js::sure@click">确&nbsp;定</a>
        </div>
   </div>
</div>
<div class="cover"></div>
{static "core/yunspace.js"}
</body>
</html>