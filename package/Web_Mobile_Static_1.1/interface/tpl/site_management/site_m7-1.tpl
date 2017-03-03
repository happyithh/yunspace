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
            <a href="test0"> <span class="icon-angle-left"></span></a>
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
        <a href="test1-1"> <li>基本信息</li></a>
        <a href="test2-1"><li>空间标准</li></a>
        <a href="test3-1"><li>配套设施</li></a>
        <a href="test4-1"><li>使用规格</li></a>
        <a href="test5-1"><li>配套饮品</li></a>
        <a href="test6-1"><li>收费标准</li></a>
        <a href="test7-1"><li class="site_tab_active">活动适用</li></a>
        <a href="test8-1"><li>图片管理</li></a>
        <a href="test9-1"><li>子空间管理</li></a>
    </ul>
</div>

{*7活动适用*}
<div class="content_m mt10">
    <div class="site_tab_title">活动适用</div>
    <table class="site_attr">
        <tr>
            <td class="site_attr_title">行业类型</td>

            <td class="site_attr_content">
                <a href="test7-2">
                <ul class="site_pag">
                    <li>消费品</li>
                    <li>奢侈品</li>
                    <div class="clear"></div>
                    <div class="site_pag_edit">
                        <span class="icon-angle-right"></span>
                    </div>
                </ul>
                </a>
            </td>

        </tr>
        <tr>
            <td class="site_attr_title">活动类型</td>

            <td class="site_attr_content">
                <a href="test7-3">
                    <ul class="site_pag">
                    <li>商业发布</li>
                    <li>新品发布会</li>
                    <li>艺术品展出</li>
                    <li>推广路演</li>
                    <div class="clear"></div>
                    <div class="site_pag_edit">
                        <span class="icon-angle-right"></span>
                    </div>
                </ul>
                </a>
            </td>

        </tr>
    </table>
</div>


{include "Web_Mobile_Static::site_management/inc.footer.tpl"}
{static "v1.0/jquery-1.11.1.min.js"}
{static "core/yunspace.js"}
{static "site_management/site_m.js"}
</body>
</html>