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

{*1基本信息--设置轨道交通*}
<div class="site_add_tag_outside1">
    <div class="site_add_tag_word1">最多可设置3条轨道交通</div>
    <ul class="site_tag_list">
        <li>1号线<div>&#8730;</div></li>
        <li>2号线<div>&#8730;</div></li>
        <li>3号线<div>&#8730;</div></li>
        <li>4号线<div>&#8730;</div></li>
        <li>5号线<div>&#8730;</div></li>
        <li>6号线<div>&#8730;</div></li>
        <li>7号线<div>&#8730;</div></li>
        <li>8号线<div>&#8730;</div></li>
        <li>9号线<div>&#8730;</div></li>
        <li>10号线<div>&#8730;</div></li>
        <li>11号线<div>&#8730;</div></li>
        <li>12号线<div>&#8730;</div></li>
        <li>13号线<div>&#8730;</div></li>
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