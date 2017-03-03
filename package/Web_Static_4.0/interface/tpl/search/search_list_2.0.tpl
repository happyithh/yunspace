<!DOCTYPE html>
<html lang="en">
<head>
    {include file="Web_Static::inc/head_meta.tpl"}
    {static "search.v4.0/search2.css"}
    {static "search.v4.0/box.css"}
    {static "v4.0/data-picker.css"}
</head>
<body yun="search.v4.0/search.js::init">
{include file="Web_Static::inc/header_1.tpl"}

<div class="search_head_back">
    <div class="search_head">
        <div class="search_head_content">
            {include file="Web_Static::search/inc.search_result2.tpl"}
        </div>
    </div>
</div>
<div class="search_content">
    <div class="search_content_left">

        <div class="search_select_outside clearfix" id="search_content" {if !$page->getSpaceList['rows']}style="display: none" {/if}>
            <div class="search_select clearfix">

                <div class="search_select_content">
                    <div class="search_select_section">
                        <div class="search_select_section_left">
                            城市
                        </div>
                        <ul id="search_industry_type" class="search_select_section_right">
                            {*{foreach $page->getCityArr as $k=>$v}*}
                                {*{var_dump(Web_Search_Space_New::concatUrlTags('city', $k))}*}
                                {*<li {if $page->request['city_key'] && $page->request['city_key']==$k}class="search_select_active" {/if}>*}
                                    {*<a href="{$_home}{Web_Search_Space_New::concatUrlTags('city', $k)}"> {$v} </a>*}
                                {*</li>*}
                            {*{/foreach}*}
                            <div class="clear"></div>
                        </ul>
                        <p class="js-a-downup a-downup-wrapper">
                            <i class="icon-c a-downup"></i>
                        </p>
                        <div class="clear"></div>
                    </div>
                    {*{if isset($_REQUEST['city_key'])}*}
                        {*<div class="search_select_section">*}
                            {*<div class="search_select_section_left">*}
                                {*行政区域*}
                            {*</div>*}
                            {*<ul id="search_industry_type" class="search_select_section_right">*}
                                {*{foreach $page->getAreas($_REQUEST['city_key']) as $k=>$v}*}
                                    {*<li {if $page->request['filter'] && isset($page->request['filter'][4]) &&  $page->request['filter'][4]==$v}class="search_select_active" {/if}>*}
                                        {*<a href="{$_home}{Web_Search_Space_New::concatUrlTags(4, $v)}">{$v}</a>*}
                                    {*</li>*}
                                {*{/foreach}*}
                                {*<div class="clear"></div>*}
                            {*</ul>*}
                            {*<p class="js-a-downup a-downup-wrapper">*}
                                {*<i class="icon-c a-downup"></i>*}
                            {*</p>*}
                            {*<div class="clear"></div>*}
                        {*</div>*}
                    {*{/if}*}
                    <div class="search_select_section">
                        <div class="search_select_section_left">
                            场地类型
                        </div>
                        <ul id="search_activity_type" class="search_select_section_right">
                            {*{foreach $page->getBaiKeCategory as $k=>$v}*}
                                {*<li {if $page->request['category_id'] && $page->request['category_id']==$k}class="search_select_active" {/if}>*}
                                    {*<a href="{$_home}{Web_Search_Space_New::concatUrlTags('category', $v)}">{$v}</a>*}
                                {*</li>*}
                            {*{/foreach}*}
                            <div class="clear"></div>
                        </ul>
                        <p class="js-a-downup a-downup-wrapper">
                            <i class="icon-c a-downup"></i>
                        </p>
                        <div class="clear"></div>
                    </div>
                    <div class="search_select_section">
                        <div class="search_select_section_left">
                            适合活动类型
                        </div>
                        <ul id="search_activity_type" class="search_select_section_right">
                            {*{foreach $page->getActiveType as $k=>$v}*}
                                {*<li {if $page->request['filter'] && isset($page->request['filter'][49]) &&  ($page->request['filter'][49]==trim($v))}class="search_select_active" {/if}>*}
                                    {*<a href="{$_home}{Web_Search_Space_New::concatUrlTags(49, $v)}">{$v}</a>*}
                                {*</li>*}
                            {*{/foreach}*}
                            <div class="clear"></div>
                        </ul>
                        <p class="js-a-downup a-downup-wrapper">
                            <i class="icon-c a-downup"></i>
                        </p>
                        <div class="clear"></div>
                    </div>
                    <div class="search_select_section">
                        <div class="search_select_section_left">
                            空间容纳人数
                        </div>
                        <ul class="search_select_section_right clearfix">
                            <li><a href="">50人以下</a></li>
                            <li><a href="">50-100人</a></li>
                            <li><a href="">100-300人</a></li>
                            <li><a href="">300-500人</a></li>
                            <li><a href="">500-1000人</a></li>
                            <li><a href="">1000人以上</a></li>
                        </ul>
                        <p class="js-a-downup a-downup-wrapper">
                            <i class="icon-c a-downup"></i>
                        </p>
                        <div class="clear"></div>
                    </div>
                    <div class="search_select_section section_more_less">
                        <div class="search_select_section_left">
                            空间面积
                        </div>
                        <ul id="search_area_type" class="search_select_section_right">
                            {*{foreach $page->getSizeRange as $k=>$v}*}
                                {*<li {if $page->request['size_range'] && $page->request['size_range']==$k}class="search_select_active" {/if}>*}
                                    {*<a href="{$_home}{Web_Search_Space_New::concatUrlTags('size', $k)}">{$v}</a>*}
                                {*</li>*}
                            {*{/foreach}*}
                            <div class="clear"></div>
                        </ul>
                        <p class="js-a-downup a-downup-wrapper">
                            <i class="icon-c a-downup"></i>
                        </p>
                        <div class="clear"></div>
                    </div>
                    <div class="search_select_section section_more_less">
                        <div class="search_select_section_left">
                            户外/室内
                        </div>
                        <ul class="search_select_section_right clearfix">
                            <li><a href="">开放</a></li>
                            <li><a href="">半开放</a></li>
                            <li><a href="">室内</a></li>
                        </ul>
                        <p class="js-a-downup a-downup-wrapper">
                            <i class="icon-c a-downup"></i>
                        </p>
                        <div class="clear"></div>
                    </div>
                </div>
            </div>
        </div>
        <div class="more_less_wrap">
            <a href="#" class="others_search_more list_more_less clearfix">
                <div class="others_search_word"> 展开</div>
                <div class="others_search_icon clearfix"></div>
            </a>
        </div>

        <div class="search_select_outside none" id="search_selected">
            <div class="search_select">
                <div class="search_selected_title">你已选择</div>
                <ul class="search_selected">
                </ul>
                <div class="clear"></div>
            </div>
            <script>
                function shaixuan() {
                    var selectBut = '';
                    {if isset($page->request['filter'])}
                    {*{if $key=='filter'}*}
                    {foreach $page->request['filter'] as $k=>$v}
                    {if $k}
                    selectBut += ' <li><span>{$v}</span>' +
                    '<a href="{$_home}{Web_Search_Space_New::concatUrlTags($k,'')}"></a></li>';
                    {/if}
                    {/foreach}
                    {*{/if}*}
                    {/if}
                    {foreach $page->request as $key=>$val}
                    {if $key=='size_range' }
                    {if $val}
                    selectBut += ' <li><span>{$page->getSizeRange[$val]}</span>' +
                    '<a href="{$_home}{Web_Search_Space_New::concatUrlTags('size','')}"></a></li>';
                    {/if}
                    {/if}
                    {if $key=='category_id'}
                    {if $val}
                    selectBut += ' <li><span>{$page->getBaiKeCategory[$val]}</span>' +
                    '<a href="{$_home}{Web_Search_Space_New::concatUrlTags('category', '')}"></a></li>';
                    {/if}
                    {/if}
                    {if $key=='city_key'}
                    {if $val}
                    selectBut += ' <li><span>{$page->getCityArr[$val]}</span>' +
                    '<a href="{$_home}{Web_Search_Space_New::concatUrlTags('city','')}"></a></li>';
                    {/if}
                    {/if}
                    {/foreach}
                    if (selectBut) {
                        selectBut +='<li><a href="/spaces-tags/" class="search_selected_deleted"> 全部删除</a></li>';
                        $('#search_selected').removeClass('none');
                        $('#search_selected').css('display','block');
                    }
                    selectBut +='<div class="clear"></div>';
                    $('.search_selected').html(selectBut);
                }
                shaixuan();
            </script>
            {*<a href="#" class="search_select_btn" id="search_selected_btn">*}
            {*<i class="search_select_icon1"></i>*}
            {*<div class="search_select_word clearfix">筛选</div>*}
            {*</a>*}
            <div class="clear"></div>
        </div>

        <div class="search-sort clearfix">
            <div class="fl search-sort-list">
                <a href="" class="active">推荐</a>
                <span class="line">|</span>
                <a class="sort sort-jg" href="javascript:;">价格<i class="icon-sort"></i></a>
                <span class="line">|</span>
                <a class="sort sort-zs" href="javascript:;">指数<i class="icon-sort"></i></a>
            </div>
            <a href="#" class="fr sicon icon-map"> </a>
        </div>

        <div class="search_list clearfix">
            <div class="search_list_title_outside clearfix">
                <div class="search_list_title">
                    <a href="">艺术8<span>秀场展馆</span></a>
                    <p class="fr price">参考价：10000/天&nbsp;起</p>
                </div>
            </div>
            <div class="search_list_content clearfix">
                <div class="search_list_img">
                    <a href="{$_home}site/{Func_Url::str_urlencode($v['space_name'],1)}" target="_blank">
                        <img src="css/search.v4.0/img/img01.jpg" />
                    </a>
                    <div class="marks">
                        <p><span>露台</span><i class="bg"></i></p>
                        <p><span>江景</span><i class="bg"></i></p>
                    </div>
                </div>
                <div class="search_list_des clearfix">
                    <div class="search_list_word">
                        Z58的名字来源于中泰控股的首字母和番禺路58号地址上的数字。毗邻“国父”孙中山家族美丽花园的老厂房，如今被中泰照明改造成了一座面向世界的现当代设......
                    </div>
                    <div class="number-space clearfix">
                        <i class="sicon icon-people"></i>
                        <p>10人~15人</p>
                        <i class="sicon icon-area"></i>
                        <p>50㎡~130㎡</p>
                    </div>
                    <div class="adress clearfix">
                        <i class="sicon icon-adress"></i>
                        <p>上海市淮海西路570号</p>
                        <a href="">查看地图</a>
                    </div>
                    <ul class="infrastructure clearfix">
                        <li class="wc">
                            <span>洗手间</span>
                        </li>
                        <li class="dressing">
                            <span>化妆间</span>
                        </li>
                        <li class="wifi">
                            <span>WIFI</span>
                        </li>
                        <li class="air-conditioning">
                            <span>空调暖气</span>
                        </li>
                        <li class="lounge">
                            <span>休息室</span>
                        </li>
                        <li class="space-hoisting">
                            <span>空间吊点</span>
                        </li>
                        <li class="carpark">
                            <span>停车场</span>
                        </li>
                        <li class="lift">
                            <span>货运电梯</span>
                        </li>
                        <li class="projection">
                            <span>投影LED</span>
                        </li>
                        <li class="sound">
                            <span>灯光音响</span>
                        </li>
                        <li class="caterers">
                            <span>餐饮</span>
                        </li>
                    </ul>
                    <div class="search_list_web">
                        <span class="browse">浏览量：666</span>
                        <span class="indexs">指数：888</span>
                        <span class="space-fit-numb">4个合适空间/共9个空间</span>
                    </div><!--浏览量、指数-结束-->
                </div><!--右侧内容-结束-->
            </div><!--search_list_content-end-->
            <div class="fl space-fit-details none">
                <table cellpadding="0" cellspacing="0">
                    <tr>
                        <th width="18%">名称</th>
                        <th width="13%">面积（㎡）</th>
                        <th width="15%">人数</th>
                        <th width="23%">参考价</th>
                        <th width="13%">优惠价</th>
                        <th width="18%"></th>
                    </tr>
                    <tr>
                        <td>罗斯柴尔德厅</td>
                        <td>50</td>
                        <td>50人以下</td>
                        <td>
                            <p class="price">
                                <span class="text">搭建</span>
                                <span class="numb undline">￥15000/天</span>
                            </p>
                            <p class="price">
                                <span class="text">搭建</span>
                                <span class="numb undline">￥10000/天</span>
                            </p>
                        </td>
                        <td>
                            <p class="best-price">
                                <span>￥10000/天</span>
                            </p>
                            <p class="best-price">
                                <span>￥10000/天</span>
                            </p>
                        </td>
                        <td class="wp">
                            <a class="j_search_date lookprice none" href="javascript:;">查看档期和价格</a>
                        </td>
                    </tr>
                    <tr>
                        <td>罗斯柴尔德厅</td>
                        <td>50</td>
                        <td>50人以下</td>
                        <td>
                            <p class="price">
                                <span class="text">搭建</span>
                                <span class="numb">￥15000/天</span>
                            </p>
                        </td>
                        <td>
                            <p class="best-price">
                                <span>￥10000/天</span>
                            </p>
                        </td>
                        <td class="wp">
                            <a class="j_search_date lookprice none" href="javascript:;">查看档期和价格</a>
                        </td>
                    </tr>
                    <tr>
                        <td>罗斯柴尔德厅</td>
                        <td>50</td>
                        <td>50人以下</td>
                        <td>
                            <p class="price">
                                <span class="text">搭建</span>
                                <span class="numb">￥15000/天</span>
                            </p>
                        </td>
                        <td>
                            <p class="best-price">
                                <span>￥10000/天</span>
                            </p>
                        </td>
                        <td class="wp">
                            <a class="j_search_date lookprice none" href="javascript:;">查看档期和价格</a>
                        </td>
                    </tr>
                    <tr>
                        <td>罗斯柴尔德厅</td>
                        <td>50</td>
                        <td>50人以下</td>
                        <td>
                            <p class="price">
                                <span class="text">搭建</span>
                                <span class="numb">￥15000/天</span>
                            </p>
                        </td>
                        <td>
                            <p class="best-price">
                                <span>￥10000/天</span>
                            </p>
                        </td>
                        <td class="wp">
                            <a class="j_search_date lookprice none" href="javascript:;">查看档期和价格</a>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="6">
                            <a class="lookmore" href="">查看更多空间</a>
                        </td>
                    </tr>
                </table>
            </div>
        </div><!--search_list-end-->
        <div class="search_list clearfix">
            <div class="search_list_title_outside clearfix">
                <div class="search_list_title">
                    <a href="">艺术8<span>秀场展馆</span></a>
                    <p class="fr price">参考价：10000/天&nbsp;起</p>
                </div>
            </div>
            <div class="search_list_content clearfix">
                <div class="search_list_img">
                    <a href="{$_home}site/{Func_Url::str_urlencode($v['space_name'],1)}" target="_blank">
                        <img src="css/search.v4.0/img/img01.jpg" />
                    </a>
                    <div class="marks">
                        <p><span>露台</span><i class="bg"></i></p>
                        <p><span>江景</span><i class="bg"></i></p>
                    </div>
                </div>
                <div class="search_list_des clearfix">
                    <div class="search_list_word">
                        Z58的名字来源于中泰控股的首字母和番禺路58号地址上的数字。毗邻“国父”孙中山家族美丽花园的老厂房，如今被中泰照明改造成了一座面向世界的现当代设......
                    </div>
                    <div class="number-space clearfix">
                        <i class="sicon icon-people"></i>
                        <p>10人~15人</p>
                        <i class="sicon icon-area"></i>
                        <p>50㎡~130㎡</p>
                    </div>
                    <div class="adress clearfix">
                        <i class="sicon icon-adress"></i>
                        <p>上海市淮海西路570号</p>
                        <a href="">查看地图</a>
                    </div>
                    <ul class="infrastructure clearfix">
                        <li class="wc">
                            <span>洗手间</span>
                        </li>
                        <li class="dressing">
                            <span>化妆间</span>
                        </li>
                        <li class="wifi">
                            <span>WIFI</span>
                        </li>
                        <li class="air-conditioning">
                            <span>空调暖气</span>
                        </li>
                        <li class="lounge">
                            <span>休息室</span>
                        </li>
                        <li class="space-hoisting">
                            <span>空间吊点</span>
                        </li>
                        <li class="carpark">
                            <span>停车场</span>
                        </li>
                        <li class="lift">
                            <span>货运电梯</span>
                        </li>
                        <li class="projection">
                            <span>投影LED</span>
                        </li>
                        <li class="sound">
                            <span>灯光音响</span>
                        </li>
                        <li class="caterers">
                            <span>餐饮</span>
                        </li>
                    </ul>
                    <div class="search_list_web">
                        <span class="browse">浏览量：666</span>
                        <span class="indexs">指数：888</span>
                        <span class="space-fit-numb">4个合适空间/共9个空间</span>
                    </div><!--浏览量、指数-结束-->
                </div><!--右侧内容-结束-->
            </div><!--search_list_content-end-->
            <div class="fl space-fit-details none">
                <table cellpadding="0" cellspacing="0">
                    <tr>
                        <th width="18%">名称</th>
                        <th width="13%">面积（㎡）</th>
                        <th width="15%">人数</th>
                        <th width="23%">参考价</th>
                        <th width="13%">优惠价</th>
                        <th width="18%"></th>
                    </tr>
                    <tr>
                        <td>罗斯柴尔德厅</td>
                        <td>50</td>
                        <td>50人以下</td>
                        <td>
                            <p class="price">
                                <span class="text">搭建</span>
                                <span class="numb undline">￥15000/天</span>
                            </p>
                            <p class="price">
                                <span class="text">搭建</span>
                                <span class="numb undline">￥10000/天</span>
                            </p>
                        </td>
                        <td>
                            <p class="best-price">
                                <span>￥10000/天</span>
                            </p>
                            <p class="best-price">
                                <span>￥10000/天</span>
                            </p>
                        </td>
                        <td class="wp">
                            <a class="j_search_date lookprice none" href="javascript:;">查看档期和价格</a>
                        </td>
                    </tr>
                    <tr>
                        <td>罗斯柴尔德厅</td>
                        <td>50</td>
                        <td>50人以下</td>
                        <td>
                            <p class="price">
                                <span class="text">搭建</span>
                                <span class="numb">￥15000/天</span>
                            </p>
                        </td>
                        <td>
                            <p class="best-price">
                                <span>￥10000/天</span>
                            </p>
                        </td>
                        <td class="wp">
                            <a class="j_search_date lookprice none" href="javascript:;">查看档期和价格</a>
                        </td>
                    </tr>
                    <tr>
                        <td>罗斯柴尔德厅</td>
                        <td>50</td>
                        <td>50人以下</td>
                        <td>
                            <p class="price">
                                <span class="text">搭建</span>
                                <span class="numb">￥15000/天</span>
                            </p>
                        </td>
                        <td>
                            <p class="best-price">
                                <span>￥10000/天</span>
                            </p>
                        </td>
                        <td class="wp">
                            <a class="j_search_date lookprice none" href="javascript:;">查看档期和价格</a>
                        </td>
                    </tr>
                    <tr>
                        <td>罗斯柴尔德厅</td>
                        <td>50</td>
                        <td>50人以下</td>
                        <td>
                            <p class="price">
                                <span class="text">搭建</span>
                                <span class="numb">￥15000/天</span>
                            </p>
                        </td>
                        <td>
                            <p class="best-price">
                                <span>￥10000/天</span>
                            </p>
                        </td>
                        <td class="wp">
                            <a class="j_search_date lookprice none" href="javascript:;">查看档期和价格</a>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="6">
                            <a class="lookmore" href="">查看更多空间</a>
                        </td>
                    </tr>
                </table>
            </div>
        </div><!--search_list-end-->
        <div class="search_list clearfix">
            <div class="search_list_title_outside clearfix">
                <div class="search_list_title">
                    <a href="">艺术8<span>秀场展馆</span></a>
                    <p class="fr price">参考价：10000/天&nbsp;起</p>
                </div>
            </div>
            <div class="search_list_content clearfix">
                <div class="search_list_img">
                    <a href="{$_home}site/{Func_Url::str_urlencode($v['space_name'],1)}" target="_blank">
                        <img src="css/search.v4.0/img/img01.jpg" />
                    </a>
                    <div class="marks">
                        <p><span>露台</span><i class="bg"></i></p>
                        <p><span>江景</span><i class="bg"></i></p>
                    </div>
                </div>
                <div class="search_list_des clearfix">
                    <div class="search_list_word">
                        Z58的名字来源于中泰控股的首字母和番禺路58号地址上的数字。毗邻“国父”孙中山家族美丽花园的老厂房，如今被中泰照明改造成了一座面向世界的现当代设......
                    </div>
                    <div class="number-space clearfix">
                        <i class="sicon icon-people"></i>
                        <p>10人~15人</p>
                        <i class="sicon icon-area"></i>
                        <p>50㎡~130㎡</p>
                    </div>
                    <div class="adress clearfix">
                        <i class="sicon icon-adress"></i>
                        <p>上海市淮海西路570号</p>
                        <a href="">查看地图</a>
                    </div>
                    <ul class="infrastructure clearfix">
                        <li class="wc">
                            <span>洗手间</span>
                        </li>
                        <li class="dressing">
                            <span>化妆间</span>
                        </li>
                        <li class="wifi">
                            <span>WIFI</span>
                        </li>
                        <li class="air-conditioning">
                            <span>空调暖气</span>
                        </li>
                        <li class="lounge">
                            <span>休息室</span>
                        </li>
                        <li class="space-hoisting">
                            <span>空间吊点</span>
                        </li>
                        <li class="carpark">
                            <span>停车场</span>
                        </li>
                        <li class="lift">
                            <span>货运电梯</span>
                        </li>
                        <li class="projection">
                            <span>投影LED</span>
                        </li>
                        <li class="sound">
                            <span>灯光音响</span>
                        </li>
                        <li class="caterers">
                            <span>餐饮</span>
                        </li>
                    </ul>
                    <div class="search_list_web">
                        <span class="browse">浏览量：666</span>
                        <span class="indexs">指数：888</span>
                        <span class="space-fit-numb">4个合适空间/共9个空间</span>
                    </div><!--浏览量、指数-结束-->
                </div><!--右侧内容-结束-->
            </div><!--search_list_content-end-->
            <div class="fl space-fit-details none">
                <table cellpadding="0" cellspacing="0">
                    <tr>
                        <th width="18%">名称</th>
                        <th width="13%">面积（㎡）</th>
                        <th width="15%">人数</th>
                        <th width="23%">参考价</th>
                        <th width="13%">优惠价</th>
                        <th width="18%"></th>
                    </tr>
                    <tr>
                        <td>罗斯柴尔德厅</td>
                        <td>50</td>
                        <td>50人以下</td>
                        <td>
                            <p class="price">
                                <span class="text">搭建</span>
                                <span class="numb undline">￥15000/天</span>
                            </p>
                            <p class="price">
                                <span class="text">搭建</span>
                                <span class="numb undline">￥10000/天</span>
                            </p>
                        </td>
                        <td>
                            <p class="best-price">
                                <span>￥10000/天</span>
                            </p>
                            <p class="best-price">
                                <span>￥10000/天</span>
                            </p>
                        </td>
                        <td class="wp">
                            <a class="j_search_date lookprice none" href="javascript:;">查看档期和价格</a>
                        </td>
                    </tr>
                    <tr>
                        <td>罗斯柴尔德厅</td>
                        <td>50</td>
                        <td>50人以下</td>
                        <td>
                            <p class="price">
                                <span class="text">搭建</span>
                                <span class="numb">￥15000/天</span>
                            </p>
                        </td>
                        <td>
                            <p class="best-price">
                                <span>￥10000/天</span>
                            </p>
                        </td>
                        <td class="wp">
                            <a class="j_search_date lookprice none" href="javascript:;">查看档期和价格</a>
                        </td>
                    </tr>
                    <tr>
                        <td>罗斯柴尔德厅</td>
                        <td>50</td>
                        <td>50人以下</td>
                        <td>
                            <p class="price">
                                <span class="text">搭建</span>
                                <span class="numb">￥15000/天</span>
                            </p>
                        </td>
                        <td>
                            <p class="best-price">
                                <span>￥10000/天</span>
                            </p>
                        </td>
                        <td class="wp">
                            <a class="j_search_date lookprice none" href="javascript:;">查看档期和价格</a>
                        </td>
                    </tr>
                    <tr>
                        <td>罗斯柴尔德厅</td>
                        <td>50</td>
                        <td>50人以下</td>
                        <td>
                            <p class="price">
                                <span class="text">搭建</span>
                                <span class="numb">￥15000/天</span>
                            </p>
                        </td>
                        <td>
                            <p class="best-price">
                                <span>￥10000/天</span>
                            </p>
                        </td>
                        <td class="wp">
                            <a class="j_search_date lookprice none" href="javascript:;">查看档期和价格</a>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="6">
                            <a class="lookmore" href="">查看更多空间</a>
                        </td>
                    </tr>
                </table>
            </div>
        </div><!--search_list-end-->


        {*<div class="search-no">*}
        {*<div class="search-no-fig">找到相关场地0个</div>*}
        {*<div class="search-no-title">抱歉，没有找到与“<span>{$_REQUEST['keyword']}</span>”相关的场地内容！</div>*}
        {*<p class="search-no-suggest">建议您：</p>*}
        {*<ul class="search-no-suggest-content">*}
        {*<li>“<a href="{$_home}" class="search-no-back-home">返回首页</a>” 或“<a href="" class="search-no-refresh" onclick="window.location.reload();">刷新</a>”。</li>*}
        {*<li>使用<a href="{Web_Global::createRentSpaceUrl()}" class="search-no-back-home">一键租场地</a>让场地顾问为你推荐场地</li>*}
        {*<li>任何咨询、建议、意见请找<a href="mailto:service@yunspace.com.cn" class="search-no-mail"> service@yunspace.com.cn</a>。</li>*}
        {*<li>检查输入的文字是否有无。</li>*}
        {*</ul>*}
        {*</div>*}

        <div class="related_search">
            <div class="related_title">相关搜索</div>
            <ul class="related_content">
                {foreach $page->getSearchList  as $k=>$v}
                    <li><a href="{$_home}spaces-tags/{Func_Url::str_urlencode($v['search_title'])}"> {$v['search_title']}</a></li>
                {/foreach}
                <div class="clear"></div>
            </ul>
        </div>
        {include file="Web_Static::inc/paging_space.tpl"}
    </div>
    <div class="search_content_right_no clearfix">
        <ul class="search-no-right classify_rt_img">
            <li><a href="{$_root}space_library?action=form" class="space-rent"></a></li>
            <li><a href="{$_root}site_join" class="space-join"></a></li>
            <li><a href="{$_root}map2" class="space-map"></a></li>
            <li>
                <div class="search-no-right-weixin">
                    <img src="img/qrcode_space.png" >
                </div>
                <div class="search-no-right-content">
                    <div class="search-no-weixin-title">举起手机，扫一扫关注</div>
                    <div class="search-no-weixin-word">云·space微信公众号<br>随时随地获取方案</div>
                </div>
                <div class="clear"></div>
            </li>
        </ul>

    </div>
</div>

<!--查询档期和价格弹窗-开始-->
<div class="cover none" id="cover"></div>
<div class="search-box none" id="search-code">
    <div class="search-box-close">
        <a href="javascript:;" id="search-box-close"><img src="img/v4.0/close.png" alt=""></a>
    </div>
    <div class="search-box-title">
        <span>查询档期和价格</span>
    </div>
    <input type="hidden" name="from_type" class="from_type" value="1" >
    <input type="hidden" name="space_id" class="space_id">
    <input type="hidden" name="space_name" class="space_name">
    <input type="hidden" name="demand_city" class="demand_city">
    <ul class="search-box-item">
        <li>
            <div class="search-box-label">你的称呼</div>
            <input class="search-box-input" name="username" >
            <div class="search-box-placeholder">请输入你的称呼</div>
        </li>
        <li>
            <div class="search-box-label">你的手机号码</div>
            <input class="search-box-input"  name="phone"  >
            <div class="search-box-placeholder">查询结果将以短信方式发送给你</div>
        </li>
        <li>
            <div class="search-box-label">活动档期</div>
            <div class="enquiry-con-input-con">
                <input name="date_start" type="text" placeholder="开始日期" readonly style="width:33%;float: left" yun="product.v2.0/enquiry.js::dateSelect@click" class="datePicker search-date-start"  data-validate="true" data-error="请选择开始的活动日期" >
                <span style="float: left;width:4%;line-height: 30px;text-align: center">——</span>
                <input name="date_end" type="text" placeholder="结束日期" readonly style="width:33%;float: left" yun="product.v2.0/enquiry.js::dateSelect@click" class="datePicker search-date-end"  data-validate="true" data-error="请选择结束的活动日期" >
                <div class="clear"></div>
                <div class="search-date-outside">
                    <div yun="data-picker/js/date-picker.js::initPlugin" class="date-picker" yun-input=".datePicker"  yun-autohide="true" yun-autohidenode=".search-date-outside"
                         yun-with-input="false"></div>
                </div>
            </div>
        </li>
        <li>
            <div class="search-box-label">更多咨询</div>
            <input class="search-box-input" name="other_demand">
            <div class="search-box-placeholder">填写你想要咨询的其他问题</div>
        </li>
        <div class="clear"></div>
    </ul>
    <p class="none error_msg"></p>
    <div class="clear"></div>
    <button class="search-box-btn">提交</button>
    <div class="search-box-code-outside">
        <div class="search-box-code">
            <img src="img/qrcode_space.png" >
        </div>
        <div class="search-box-code-word">
            <span>打开微信，扫一扫关注</span><br>
            云·space 微信公众号<br>随时随地获取报价方案
        </div>
        <div class="clear"></div>
    </div>
</div>
<!--查询档期和价格弹窗-结束-->

{include file="Web_Static::inc/public_space.tpl"}
{include file="Web_Static::inc/html_footer.tpl"}
{static "core/yunspace.js"}
{static "search.v4.0/search2.js"}
{static "search.v4.0/highlight.js"}
</body>
</html>