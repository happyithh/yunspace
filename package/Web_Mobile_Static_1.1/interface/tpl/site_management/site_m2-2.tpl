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
            <a href="javascript:history.go(-1);"><span class="icon-angle-left"></span></a>
        </div>
        <div class="header_middle">
            场地管理
        </div>
    </div>
</header>
<div class="clear"></div>

{*tab切换*}
<div class="site_tab_outside mt50">
    <ul class="site_tab">
        <a href="test1-1"><li>基本信息</li></a>
        <a href="test2-1"><li class="site_tab_active">空间标准</li></a>
        <a href="test3-1"><li>配套设施</li></a>
        <a href="test4-1"><li>使用规格</li></a>
        <a href="test5-1"><li>配套饮品</li></a>
        <a href="test6-1"><li>收费标准</li></a>
        <a href="test7-1"><li>活动适用</li></a>
        <a href="test8-1"><li>图片管理</li></a>
        <a href="test9-1"><li>子空间管理</li></a>
    </ul>
</div>

{*2空间标准表单*}
<div class="content_m mt10">
    <div class="site_tab_title">空间标准</div>
    <table class="site_attr">
        <tr>
            <td class="site_attr_title">使用面积</td>
            <td class="site_attr_content1">
                <input class="site_input" placeholder="2000">
            </td>
            <td class="site_attr_content2">㎡</td>
        </tr>
        <tr>
            <td class="site_attr_title">空间层高</td>
            <td class="site_attr_content1">
                <input class="site_input" placeholder="6">
            </td>
            <td class="site_attr_content2">米</td>
        </tr>
        <tr>
            <td class="site_attr_title">空间承重</td>
            <td class="site_attr_content" colspan="2">
                <input class="site_input" placeholder="请输入空间承重">
            </td>
        </tr>
        <tr>
            <td class="site_attr_title">容纳人数</td>
            <td class="site_attr_content1">
                <input class="site_input" placeholder="600">
            </td>
            <td class="site_attr_content2">人</td>
        </tr>
    </table>
</div>
<button class="site_confirm_btn">保存</button>

{static "v1.0/jquery-1.11.1.min.js"}
{static "core/yunspace.js"}
{static "site_management/site_m.js"}
</body>
</html>