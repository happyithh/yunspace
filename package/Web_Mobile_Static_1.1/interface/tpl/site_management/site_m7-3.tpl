<!DOCTYPE html>
<html lang="en">
<head>
    {include "Web_Mobile_Static::site_management/inc.meta.tpl"}
    {static "v1.0/global.css"}
    {static "site_management/footer.css"}
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
<div class="clear"></div>

{*tab切换*}


{*7活动适用行业类型标签选择*}
<div class="apply_add_tag_outside1">
    <div class="site_add_tag_word1">最多可设置5个活动类型</div>
    <ul class="apply_tag_list">
        <li>商业发布<div>&#8730;</div></li>
        <li>推广路演<div>&#8730;</div></li>
        <li>奢侈品<div>&#8730;</div></li>
        <li>文体娱乐文体娱乐文体娱<div>&#8730;</div></li>
        <li>文体娱乐<div>&#8730;</div></li>
        <li>文体娱乐<div>&#8730;</div></li>
        <li>文体娱乐<div>&#8730;</div></li>
    </ul>
    <div class="clear"></div>
</div>
<button class="site_confirm_btn">保存</button>


{static "v1.0/jquery-1.11.1.min.js"}
{static "core/yunspace.js"}
{static "site_management/site_m.js"}
</body>
</html>