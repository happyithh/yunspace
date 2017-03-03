<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <title>百科</title>
    {*{include file="Web_Static::v2.0/html_head.tpl"}*}
    {static "v4.0/common.css"}
    {static "baike.v1.0/baike_common.css"}
    {static "baike.v1.0/baike.css"}
    {static "baike.v1.0/back_search_in.css"}
    {static "baike.v1.0/baike.js"}
    {static "baike.v1.0/banner.js"}
    {static "baike.v1.0/jquery.nav.js"}
    {static "js/jquery-1.9.1.min.js"}
</head>
<body>
{include file="Web_Static::inc/header.tpl"}
<div class="baike-content-sub">
    {include file="Web_Static::site/inc/collection_title.tpl"}
    <div class="subspace-content subbox clearfix">
        <div class="fl subspace-sidebar">
            <ul class="subspace-menu clearfix">
                {foreach $itemList as $k=>$v}
                    <li class="{if $page->item_id==$v['id']}current{/if}" yun="item_list/item_list.js::itemInfo@click" yun-items="#all_site_item" >
                        <p class="text">{$v['item_name']}</p>
                    </li>
                {/foreach}
            </ul>

            <!--类型-->
            <div class="comn subspace-type">
                <div class="sub-title blue">类型</div>
                <p>场地<span class="line">-</span>{$page->info['category_name']}</p>
                <p>行业<span class="line">-</span>{str_replace(",","、",$page->info["attr"][9])}</p>
                <p>活动<span class="line">-</span>{str_replace(",","、",$page->tags["93"]['活动类型'])}</p>
            </div>

            <!--容量-->
            <div class="comn subspace-capacity">
                <div class="sub-title green">容量</div>
                <p>面积<span class="line">-</span>{$page->info["attr"]['10']}</p>
                <p>层高<span class="line">-</span>{$page->info["attr"]['6']}</p>
                <p>承重<span class="line">-</span>{$page->info["attr"]['11']}</p>
                <p>人数<span class="line">-</span>{$page->info["attr"]['8']}</p>
            </div>

            <!--标签-->
            <div class="comn subspace-marks">
                <div class="sub-title purple">标签</div>
                {foreach $page->info['special_tags_arr'] as $k=>$v}
                    <span class="mark">{$v}</span>
                {/foreach}
            </div>

            <!--配套设施-开始-->
            <div class="comn" id="nv-facilities">
                <div class="comn-title clearfix">
                    <i class="icon-facilities"></i><span>配套设施</span>
                </div>
                <div class="comn-baike-facilities clearfix">
                    <ul>
                        <li class="li1 {if $page->info['attr'][14] && $page->info['attr'][14]!="无"}active{/if}">
                            <div class="gray-bg">
                                <div class="icon"></div>
                            </div>
                            <p>洗手间</p>
                        </li>
                        <li class="li2 {if $page->info['attr'][13] &&  $page->info['attr'][13]!="无"}active{/if}">
                            <div class="gray-bg">
                                <div class="icon"></div>
                            </div>
                            <p>化妆间</p>
                        </li>
                        <li class="li3 {if $page->info['attr'][12] && $page->info['attr'][12]!="无"}active{/if}">
                            <div class="gray-bg">
                                <div class="icon"></div>
                            </div>
                            <p>休息室</p>
                        </li>
                        <li class="li4 {if $page->info['attr'][15] && $page->info['attr'][15]!="无"}active{/if}">
                            <div class="gray-bg">
                                <div class="icon"></div>
                            </div>
                            <p>空间吊点</p>
                        </li>
                        <li class="li5 {if $page->info['attr'][17] && $page->info['attr'][17]!="无"}active{/if}">
                            <div class="gray-bg">
                                <div class="icon"></div>
                            </div>
                            <p>空调暖气</p>
                        </li>
                        <li class="li6 {if $page->info['attr'][18] && $page->info['attr'][18]!="无"}active{/if}">
                            <div class="gray-bg">
                                <div class="icon"></div>
                            </div>
                            <p>网络WIFI</p>
                        </li>
                        <li class="li7 {if $page->info['attr'][5] && $page->info['attr'][5]!="无"}active{/if}">
                            <div class="gray-bg">
                                <div class="icon"></div>
                            </div>
                            <p>停车泊位</p>
                        </li>
                        <li class="li8 {if $page->info['attr'][19] && $page->info['attr'][19]!="无"}active{/if}">
                            <div class="gray-bg">
                                <div class="icon"></div>
                            </div>
                            <p>货运电梯</p>
                        </li>
                        <li class="li9 {if $page->info['attr'][20] && $page->info['attr'][20]!="无"}active{/if}">
                            <div class="gray-bg">
                                <div class="icon"></div>
                            </div>
                            <p>投影LED</p>
                        </li>
                        <li class="li10 {if $page->info['attr'][21] && $page->info['attr'][21]!="无"}active{/if}">
                            <div class="gray-bg">
                                <div class="icon"></div>
                            </div>
                            <p>灯光音响</p>
                        </li>
                        <li class="li11 {if $page->info['attr'][22] && $page->info['attr'][22]!="无"}active{/if}">
                            <div class="gray-bg">
                                <div class="icon"></div>
                            </div>
                            <p>餐饮</p>
                        </li>
                    </ul>
                </div>
            </div><!--baike-facilities-end-->

            <!--场地简介-开始-->
            <div class="comn" id="nv-areaBrief">
                <div class="comn-title clearfix">
                    <i class="icon-intro"></i><span>场地简介</span>
                </div>
                <div class="comn-baike-intro clearfix">
                    <p>{strip_tags($page->info['des'],"<a>")}</p>
                </div>
            </div><!--baike-intro-end-->

        </div>
        <div id="all_site_item">
        {foreach $itemList as $k=>$v}
            {if $v['id']==$page->item_id}
            <div class="fl subspace-cont subspace-box padding-bottom">
                   {include "Web_Static::site/inc/item_info.tpl"}
            </div>
            {else}
                {* <div class="fl subspace-cont subspace-box" yun-load="{$_home}site/{Func_Url::str_urlencode($page->info['space_name'],2)}-百科-{Func_NumEncode::e($v['id'])}inner?item_dp=2">
                </div> *}
                <div class="fl subspace-cont subspace-box" yun-load="{$_home}site/{Func_Url::str_urlencode($page->info['space_name'],2)}-百科-{Func_NumEncode::e($v['id'])}inner">
                </div>
            {/if}
        {/foreach}
        </div>
    </div>
</div>

<!--图片展示弹窗-->
{*<div class="pop-img">*}
    {*<div class="close js-close"></div>*}
    {*<div class="title clearfix">*}
        {*<h3 class="img_title"></h3>*}
        {*<p><span class="img_number">1</span>/{count($page->spaceMedia)}</p>*}
    {*</div>*}
    {*<div class="img">*}
        {*<img src="img/space_info/space_img1.jpg">*}
    {*</div>*}
{*</div>*}
</body>
</html>