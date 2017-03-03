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
            &nbsp;
        </div>
        <div class="header_middle">
            场地管理
        </div>
        <div class="header_right">
            &nbsp;
        </div>
    </div>
</header>
<div class="clear"></div>

<div class="occupy"></div>

{if !empty($space_pedia)}
{foreach $space_pedia as $k=>$v}
    <div class="content_m mt10">
        <div class="space_list">
            <div class="space_list_icon">
                <span>场地{$k+1}</span>
            </div>
            <div class="space_list_img">
                <img src="{Page_Site_Global::displayMedia($v['space_logo'],373,278)}">
            </div>
            {*<a href="/m/test_site/basic_info?space_pedia_id={$v['space_pedia_id']}" class="son_list_a">*}
            <div class="space_list_word">
                <div class="space_list_word_left" style="width: 100%;">
                    {*<a href="/m/site/{$v['space_name']}-百科">*}
                    <div class="space_list_item">
                        <a href="/m/site/{$v['space_name']}-百科">
                            <div class="space_list_item_left" style="width: 25%;float: left">场地名称：</div>
                            {*<a href="/m/site/{$v['space_name']}-百科"><div class="space_list_item_title">{$v['space_name']}</div></a>*}
                            <div class="space_list_item_title">{$v['space_name']}</div>
                        </a>
                        <div class="clear"></div>
                    </div>
                    {*</a>*}
                </div>
                {*</div>*}
                {*<div class="space_list_word">*}
                <div class="space_list_word_left" style="width: 100%;">
                    <a href="/m/test_site/basic_info?space_pedia_id={$v['space_pedia_id']}" class="son_list_a">
                        <div class="space_list_word_right">
                            <i class="icon-angle-right"></i>
                        </div>
                        <div class="space_list_item">
                            <div class="space_list_item_left" style="padding-top: 3px;width: 25%;">特色标签：</div>
                            <ul class="space_list_pag">
                                {if !empty($v['attr']['特色标签'])}
                                    {foreach $v['attr']['特色标签'] as $kk=>$vv}
                                        <li>{$vv}</li>
                                    {/foreach}
                                {/if}
                                {*<li>江景</li>*}
                                {*<li>露台</li>*}
                                <div class="clear"></div>
                            </ul>
                            <div class="clear"></div>
                        </div>
                        <div class="space_list_item">
                            <div class="space_list_item_left" style="padding-top: 3px;width: 25%;">详细地址：</div>
                            <div class="space_list_item_addr">{$v['addr']}</div>
                            <div class="clear"></div>
                        </div>
                    </a>
                </div>
                {*</div>*}
                {*<div class="space_list_word_right">*}
                {*<i class="icon-angle-right"></i>*}
                {*</div>*}
                <div class="clear"></div>
            </div>
            {*</a>*}
        </div>
        <ul class="son_list">
            {*{foreach $v['item_info'] as $item_k=>$item_v}*}
            {*<a href="/m/test_site/space_item_show?space_item_id={$item_v['space_item_id']}&space_pedia_id={$v['space_pedia_id']}" class="son_list_a">*}
            {*<li class="son_list_content">*}
            {*<div class="son_list_left">*}
            {*<img src="{Page_Site_Global::displayMedia($item_v['item_logo'],130,97)}">*}
            {*</div>*}
            {*<div class="son_list_middle">*}
            {*<div class="son_list_title">*}
            {*<div class="son_list_title_left">空间{$item_k+1}：</div>*}
            {*<div class="son_list_title_right">{$item_v['item_name']}</div>*}
            {*<div class="clear"></div>*}
            {*</div>*}
            {*<div class="son_list_item"><span>场地面积：</span>{$item_v['size']}㎡</div>*}
            {*<div class="son_list_item"><span>租金价格：</span>{$item_v['min_price']}元-{$item_v['max_price']}元/天</div>*}
            {*</div>*}
            {*<div class="son_list_right">*}
            {*<i class="icon-angle-right"></i>*}
            {*</div>*}
            {*<div class="clear"></div>*}
            {*</li>*}
            {*</a>*}
            {*{/foreach}*}
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
{/foreach}
{else}
    <div>敬请期待！</div>
{/if}


{*<div class="content_m mt10">*}
{*<div class="space_list">*}
{*<div class="space_list_icon">*}
{*<span>场地2</span>*}
{*</div>*}
{*<div class="space_list_img">*}
{*<img src="img/site_management/space_list_img.jpg">*}
{*</div>*}
{*<a href="test1-1" class="son_list_a">*}
{*<div class="space_list_word">*}
{*<div class="space_list_word_left">*}
{*<div class="space_list_item">*}
{*<div class="space_list_item_left">场地名称：</div>*}
{*<div class="space_list_item_title">宝山秀场</div>*}
{*<div class="clear"></div>*}
{*</div>*}
{*<div class="space_list_item">*}
{*<div class="space_list_item_left" style="padding-top: 3px;">特色标签：</div>*}
{*<ul class="space_list_pag">*}
{*<li>英伦风情</li>*}
{*<li>江景</li>*}
{*<li>露台</li>*}
{*<div class="clear"></div>*}
{*</ul>*}
{*<div class="clear"></div>*}
{*</div>*}
{*<div class="space_list_item">*}
{*<div class="space_list_item_left">详细地址：</div>*}
{*<div class="space_list_item_addr">上海市黄浦区外马路579号</div>*}
{*<div class="clear"></div>*}
{*</div>*}
{*</div>*}
{*<div class="space_list_word_right">*}
{*<i class="icon-angle-right"></i>*}
{*</div>*}
{*<div class="clear"></div>*}
{*</div>*}
{*</a>*}
{*</div>*}
{*<ul class="son_list">*}
{*<a href="test9-1" class="son_list_a">*}
{*<li class="son_list_content">*}
{*<div class="son_list_left">*}
{*<img src="img/site_management/son_list_img.jpg">*}
{*</div>*}
{*<div class="son_list_middle">*}
{*<div class="son_list_title">*}
{*<div class="son_list_title_left">空间1：</div>*}
{*<div class="son_list_title_right">宝山秀场正厅</div>*}
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
{*<div class="clear"></div>*}
{*</ul>*}
{*</div>*}

{include "Web_Mobile_Static::site_management/inc.footer.tpl"}
{static "v1.0/jquery-1.11.1.min.js"}
{static "core/yunspace.js"}
{static "site_management/site_m.js"}
</body>
</html>