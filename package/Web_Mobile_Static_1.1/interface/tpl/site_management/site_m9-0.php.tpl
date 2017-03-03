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
        {*<a href="test9-2">*}
            {*<div class="header_right">*}
                {*修改*}
            {*</div>*}
        {*</a>*}
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
    <ul class="son_list">
        {foreach $data as $k=>$v}
        <a href="/m/test_site/space_item_show?space_item_id={$v['id']}&space_pedia_id={$_REQUEST['space_pedia_id']}" class="son_list_a">
        <li class="son_list_content">
            <div class="son_list_left">
                <img src="{Page_Site_Global::displayMedia($v['logo'],50,50)}" style="width: 118px;height: 74px;">
            </div>
            <div class="son_list_middle">
                <div class="son_list_title">
                    <div class="son_list_title_left">空间{$k+1}：</div>
                    <div class="son_list_title_right">{$v['item_name']}</div>
                    <div class="clear"></div>
                </div>
                <div class="son_list_item"><span>场地面积：</span>{$v['size']}㎡</div>
                <div class="son_list_item"><span>租金价格：</span>{$v['min_price']}元/天&nbsp;-&nbsp;{$v['max_price']}元/天</div>
            </div>
            <div class="son_list_right">
                <i class="icon-angle-right"></i>
            </div>
            <div class="clear"></div>
        </li>
        </a>
        {/foreach}


        {*<a href="test9-1" class="son_list_a">*}
        {*<li class="son_list_content">*}
            {*<div class="son_list_left">*}
                {*<img src="img/site_management/son_list_img.jpg">*}
            {*</div>*}
            {*<div class="son_list_middle">*}
                {*<div class="son_list_title">*}
                    {*<div class="son_list_title_left">空间1：</div>*}
                    {*<div class="son_list_title_right">宝山秀场露台平台宝*}
                        {*山秀场露台平台</div>*}
                    {*<div class="clear"></div>*}
                {*</div>*}
                {*<div class="son_list_item"><span>场地面积：</span>1700㎡</div>*}
                {*<div class="son_list_item"><span>租金价格：</span>80000元/天</div>*}
            {*</div>*}
            {*<div class="son_list_right">*}
                {*<i class="icon-angle-right"></i>*}
            {*</div>*}
            {*<div class="clear"></div>*}
        {*</li>*}
        {*</a>*}



        <div class="clear"></div>
    </ul>
</div>

{include "Web_Mobile_Static::site_management/inc.footer.tpl"}
{static "v1.0/jquery-1.11.1.min.js"}
{static "core/yunspace.js"}
{static "site_management/site_m.js"}
</body>
</html>