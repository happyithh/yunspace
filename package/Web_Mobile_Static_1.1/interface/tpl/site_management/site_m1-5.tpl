<!DOCTYPE html>
<html lang="en">
<head>
    {include "Web_Mobile_Static::site_management/inc.meta.tpl"}
    {static "v1.0/global.css"}
    {static "site_management/footer.css"}
    {static "site_management/sweetalert.css"}
    {static "site_management/site_m.css"}

</head>
<body>
{*头部*}
<header class="site_header">
    <div class="clear_float">
        <div class="header_left">
            <a href="javascript:history.go(-1);"> <span class="icon-angle-left"></span></a>
        </div>
        <div class="header_middle">
            场地管理
        </div>
    </div>
</header>

{*1基本信息--设置商圈*}
<div class="site_add_tag_outside1">
    <div class="site_add_tag_word1">最多可设置3个商圈</div>
    <ul class="site_tag_list">
        <li>外滩<div>&#8730;</div></li>
        <li>美术馆<div>&#8730;</div></li>
        <li>老西门<div>&#8730;</div></li>
        <li>文体娱乐文体娱乐文体<div>&#8730;</div></li>
        <li>文体娱乐<div>&#8730;</div></li>
    </ul>
    <div class="clear"></div>
</div>
<button class="site_confirm_btn">保存</button>

<div class="site_pop">
    <div class="site_pop_title1">最多只能选择3个标签</div>
    <a class="site_pag_confirm1">确定</a>
</div>
<div class="site_mark"></div>

{static "v1.0/jquery-1.11.1.min.js"}
{static "site_management/site_m.js"}
{static "core/yunspace.js"}

</body>
</html>