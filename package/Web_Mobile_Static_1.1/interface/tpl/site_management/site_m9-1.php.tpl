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
            <a href="/m/test_site/site_list"> <span class="icon-angle-left"></span></a>
        </div>
        <div class="header_middle">
            场地管理
        </div>
        <a href="/m/test_site/space_item_list_edit?space_pedia_id={$_REQUEST['space_pedia_id']}&space_item_id={$_REQUEST['space_item_id']}">
        <div class="header_right">
            修改
        </div>
        </a>
    </div>
</header>
<div class="clear"></div>

{*tab切换*}
<div class="site_tab_outside mt50">
    <ul class="site_tab">
        {*<a href="test1-1"><li>基本信息</li></a>*}
        {*<a href="test2-1"><li>空间标准</li></a>*}
        {*<a href="test3-1"><li>配套设施</li></a>*}
        {*<a href="test4-1"><li>使用规格</li></a>*}
        {*<a href="test5-1"><li>配套饮品</li></a>*}
        {*<a href="test6-1"><li>收费标准</li></a>*}
        {*<a href="test7-1"><li>活动适用</li></a>*}
        {*<a href="test8-1"><li>图片管理</li></a>*}
        {*<a href="test9-1"><li class="site_tab_active">子空间管理</li></a>*}
        <a href="/m/test_site/basic_info?space_pedia_id={$_REQUEST['space_pedia_id']}"> <li>基本信息</li></a>
        <a href="/m/test_site/space_std?space_pedia_id={$_REQUEST['space_pedia_id']}"><li>空间标准</li></a>
        <a href="/m/test_site/mating_service?space_pedia_id={$_REQUEST['space_pedia_id']}"><li>配套设施</li></a>
        {*<a href="/m/test_site/use_std?space_pedia_id={$_REQUEST['space_pedia_id']}"><li>使用规格</li></a>*}
        {*<a href="/m/test_site/mating_drink?space_pedia_id={$_REQUEST['space_pedia_id']}"><li>配套饮品</li></a>*}
        {*<a href="/m/test_site/money_std?space_pedia_id={$_REQUEST['space_pedia_id']}"><li>收费标准</li></a>*}
        <a href="/m/test_site/act_apply?space_pedia_id={$_REQUEST['space_pedia_id']}"><li>活动适用</li></a>
        <a href="/m/test_site/image_show?space_pedia_id={$_REQUEST['space_pedia_id']}"><li>图片管理</li></a>
        {*<a href="/m/test_site/space_item_list?space_pedia_id={$_REQUEST['space_pedia_id']}"><li class="site_tab_active">子空间管理</li></a>*}
    </ul>
</div>


{*9子空间管理*}
<div class="content_m mt10">
    <div class="site_tab_title">子空间管理</div>
    <table class="site_attr">
        <tr>
            <td class="site_attr_title">所属场地</td>
            <td class="site_attr_content">{$data['space_name']}</td>
        </tr>
        <tr>
            <td class="site_attr_title">子空间名称</td>
            <td class="site_attr_content">{$data['item_name']}</td>
        </tr>
        <tr>
            <td class="site_attr_title">面积</td>
            <td class="site_attr_content">{$data['size']} ㎡</td>
        </tr>
        <tr>
            <td class="site_attr_title">子空间标签</td>
            <td class="site_attr_content">
                <ul class="site_pag">
                    {foreach $tags as $k=>$v}
                    <li>{$v['tag_value']}</li>
                    {/foreach}
                    {*<li>人流大</li>*}
                    <div class="clear"></div>
                </ul>
            </td>
        </tr>
        <tr>
            <td class="site_attr_title">场地租金</td>
            <td class="site_attr_content">¥ {$data['min_price']}-{$data['max_price']}</td>
        </tr>
        <tr>
            <td class="site_attr_title">容纳人数</td>
            <td class="site_attr_content">
                {$data['min_people']}-{$data['max_people']} 人
            </td>
        </tr>
        <tr>
            <td class="site_attr_title" rowspan="2">空间描述</td>
            <td class="site_attr_content">
                <div class="same_site_des">同场地描述</div>
                <div class="site_attr_unselected site_fr">
                    {*<span class="icon-ok"></span>*}
                </div>
                <div class="clear"></div>
            </td>
        </tr>
        <tr>
            <td class="site_attr_content">
                {$data['des']}
            </td>
        </tr>
        <tr>
            <td class="site_attr_title">子空间联系人</td>
            <td class="site_attr_content">{$data['contacts']}</td>
        </tr>
        <tr>
            <td class="site_attr_title">联系人手机号</td>
            <td class="site_attr_content">{$data['phone']}</td>
        </tr>
        <tr>
            <td class="site_attr_title">联系人邮箱</td>
            <td class="site_attr_content">{$data['email']}</td>
        </tr>
    </table>
</div>

{include "Web_Mobile_Static::site_management/inc.footer.tpl"}
{static "v1.0/jquery-1.11.1.min.js"}
{static "core/yunspace.js"}
{static "site_management/site_m.js"}
</body>
</html>