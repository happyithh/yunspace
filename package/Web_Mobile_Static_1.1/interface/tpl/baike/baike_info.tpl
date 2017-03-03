<!DOCTYPE html>
<html lang="en">
<head>
    {include "Web_Mobile_Static::baike/inc.baike_head.tpl"}
    {static "product.v2.0/product.css"}
    {*{static "plugins/Swiper-master/css/swiper.min.css"}*}
    <link rel="stylesheet" href="plugins/Swiper-master/css/swiper.min.css">
    <link rel="stylesheet" href="plugins/ionicons-master/css/ionicons.min.css">
</head>
<body yun="product.v2.0/product.js::init" data-sid="{$page->id}">
    <div yun="hide-app/hide-app.js::isApp"></div>
    <div class="content" yun="lazyLoad/lazyLoad.js::init">
        <div class="product-part1">
            <div class="product-part1-logo">
                <img src="img/product.v2.0/logo.png" alt="">
            </div>
            <div class="product-part1-img-title">
                <div class="product-part1-img-title1">
                    {$page->info['seo_title']}
                </div>
                <div class="product-part1-img-title2 space_name">
                    {$page->info['space_name']}
                </div>
            </div>
            <div class="product-part1-img">
                {if $page->banner}
                    <img src="{Page_Site_Global::displayMedia($page->banner,"375","441")}">
                {/if}
            </div>
            <div class="product-part1-des">
                <div class="product-part1-des-p">
                    <div class="product-part1-des-p1">
                        <span>场地特色</span>
                        <div class="part1-des-p-line"></div>
                    </div>
                    <div class="product-part1-des-p2">
                        <span>{$page->info['special_tags']}</span>
                    </div>
                </div>
                <div class="product-part1-des-p">
                    <div class="product-part1-des-p1">
                        <span>详细地址</span>
                        <div class="part1-des-p-line"></div>
                    </div>
                    <div class="product-part1-des-p2 product-part1-des-addr">
                        <span>{$page->info['city']}市&nbsp;&nbsp;{$page->info['addr']}</span>
                    </div>
                </div>
            </div>
        </div>


        <div class="product-part2">
            <div class="product-part2-title">
                <span>场地图片</span>
                <div class="product-part2-title-line"></div>
            </div>
            <div class="product-part2-img">
                <ul class="product-part2-img-list product-part2-img-list1">
                    <li class="more-img none">
                        <a>
                            <img src="" alt="">
                        </a>
                    </li>
                    {foreach $spaceMedia['media_data'] as $k=>$v}
                        <li>
                            <a href="javascript:;">
                                <img src="{Page_Site_Global::displayMedia($v['path'],"355","187",1)}">
                                {*<img src="img/product.v2.0/t1.jpg">*}
                            </a>
                        </li>
                    {/foreach}
                </ul>
            </div>
            {if count($page->spaceMedia)>3}
                <div class="product-part2-load">
                    <div class="load-btn load-btn1" yun="product.v2.0/product.js::loadMoreImg@click" data-count-media="{count($page->spaceMedia)}" data-start-num="{$spaceMedia['start_num']}">
                        <span>查看更多</span>
                    </div>
                    <div class="loading-more loading-more1 none">
                        <div class="product-part2-load-p">加载更多</div>
                        <div class="product-part2-load-img">
                            <img src="img/product.v2.0/load-more.gif" alt="">
                        </div>
                    </div>
                    <div class="loaded loaded1 none">
                        <span>已加载全部</span>
                    </div>

                </div>
            {/if}
        </div>

        <div class="product-part3">
            <div class="product-part3-title">
                <span>基础信息</span>
                <div class="product-part3-title-line"></div>
            </div>
            <div class="product-part3-info">
                {foreach $page->tags  as $tk=>$tv}
                    {*{if $tk== 77 || $tk== 78 || $tk== 93}*}
                        <div class="product-part3-info-p">
                            <div class="product-part3-info-p1">
                                <span>{$tv['parent_name']}</span>
                            </div>
                            {foreach $tv as $ttk=>$ttv}
                                {if $ttk != "parent_name"}
                                    <div class="product-part3-info-p2">
                                        <span>{$ttk}&nbsp;&nbsp;-&nbsp;&nbsp;</span> <span>{str_replace(',','、',$ttv)}</span>
                                    </div>
                                {/if}
                            {/foreach}
                        </div>
                    {*{/if}*}
                {/foreach}
            </div>
        </div>

        <div class="product-part4 none">
            {*<div class="product-part3-title">*}
                {*<span>场地规格</span>*}
                {*<div class="product-part4-title-line"></div>*}
            {*</div>*}
            {*<div class="product-part3-info">*}
                {*{foreach $page->tags  as $tk=>$tv}*}
                    {*{if $tk!= 77 && $tk!= 78 && $tk!= 93}*}
                        {*<div class="product-part3-info-p">*}
                            {*<div class="product-part3-info-p1">*}
                                {*<span>{$tv['parent_name']}</span>*}
                            {*</div>*}
                            {*{foreach $tv as $ttk=>$ttv}*}
                                {*{if $ttk != "parent_name"}*}
                                    {*<div class="product-part3-info-p2">*}
                                        {*<span>{$ttk}&nbsp;&nbsp;-&nbsp;&nbsp;</span> <span>{str_replace(',','、',$ttv)}</span>*}
                                    {*</div>*}
                                {*{/if}*}
                            {*{/foreach}*}
                        {*</div>*}
                    {*{/if}*}
                {*{/foreach}*}
            {*</div>*}
        </div>

        <div class="product-part5 {if !$page->caseList}none{/if}">
            {*{if $page->caseList}*}
            <div class="product-part2-title product-part2-img-list2" style="padding-top: 10px;">
                <span>活动案例</span>
                <div class="product-part5-title-line"></div>
            </div>
            <div class="product-part2-img">
                <ul class="product-part2-img-list product-part2-img-list2">
                    {foreach $page->caseList as $k=>$v}
                        <li data-last_id="{$v['id']}">
                            <a href="{$_home}raiders-info/{$v['id']}.html" class="text">
                                <img src="{Page_Site_Global::displayMedia($v['logo'],"355","187",1)}">
                            </a>
                        </li>
                    {/foreach}
                </ul>
            </div>
            {*<div class="product-part2-load">*}
                {*<div class="load-btn load-btn2" yun="product.v2.0/product.js::loadMoreCase@click">*}
                        {*<span>查看更多</span>*}
                {*</div>*}
                {*<div class="loading-more loading-more2 none">*}
                    {*<div class="product-part2-load-p">加载更多</div>*}
                    {*<div class="product-part2-load-img">*}
                        {*<img src="img/product.v2.0/load-more.gif" alt="">*}
                    {*</div>*}
                {*</div>*}
                {*<div class="loaded  loaded2 none">*}
                    {*<span>已加载全部</span>*}
                {*</div>*}

            {*</div>*}

            {*{/if}*}
        </div>

        <div class="product-part6">
            <div class="product-part2-title" style="padding-top: 10px;">
                <span>场地位置</span>
                <div class="product-part6-title-line"></div>
            </div>
            <div class="product-position">
                <div class="product-position-con" id="allmap"></div>
            </div>
        </div>

        <div class="product-part7">
            <div class="product-part2-title" style="padding-top: 10px;">
                <span>场地简介</span>
                <div class="product-part5-title-line">

                </div>
            </div>
            <div class="product-part7-con">
                <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{strip_tags($page->info['des'])}</p>
            </div>
        </div>

            <div class="product-part8 {if !$itemList}none{/if}">
                <div class="product-part3-title">
                    <span>子空间</span>
                    <div class="product-part4-title-line"></div>
                </div>

                {foreach $itemList as $k=>$v}

                <div class="product-part3-info">
                    <div class="product-part3-info-p">
                        <a href="{$_home}service_info/{$v['product_id']}.html">
                            <div class="product-part3-info-p1">
                                <span>0{$k+1}/{$v['item_name']}</span>
                            </div>
                        </a>
                        <div class="product-part3-info-p2">
                            <span>面积&nbsp;&nbsp;-&nbsp;&nbsp;</span> <span>{$v['size']}m²</span>
                        </div>
                        <div class="product-part3-info-p2">
                            <span>可容纳人数&nbsp;&nbsp;-&nbsp;&nbsp; </span>
                            <span>
                                {if $v['min_people']==$v['max_people']}
                                    {if $v['min_people'] < 50}
                                        50人以下
                                    {else}
                                        {$v['min_people']}
                                    {/if}
                                {else}
                                    {$v['min_people']} ~ {$v['max_people']}
                                {/if}
                                人
                            </span>
                        </div>
                        <div class="product-part3-info-p2">
                            <span>参考价&nbsp;&nbsp;-&nbsp;&nbsp; </span>
                            <span>
                                {if $v['min_price']==$v['max_price'] && $v['min_price'] < 100}
                                    <code style="color:#f3a67c;">&nbsp; 面议&nbsp;</code>
                                {elseif $_COOKIE['look_price_phone']}
                                    {if $v['min_price']==$v['max_price']}
                                        ￥<code style="color:#40c1de">&nbsp;{$v['min_price']}&nbsp;</code> 元 / {if $v['price_unit']}{$v['price_unit']}{else}天{/if}
                                    {else}
                                        ￥<code style="color:#40c1de">&nbsp;{$v['min_price']} ~ {$v['max_price']}&nbsp;</code> 元 / {if $v['price_unit']}{$v['price_unit']}{else}天{/if}
                                    {/if}
                                {else}
                                    <code class="js-look-price" style="color:#40c1de">查看参考价</code>
                                    <code class="hide item_price_show">
                                        {if $v['min_price']==$v['max_price']}
                                            ￥<code style="color:#40c1de">&nbsp;{$v['min_price']}&nbsp;</code> 元 / {if $v['price_unit']}{$v['price_unit']}{else}天{/if}
                                        {else}
                                            ￥<code style="color:#40c1de">&nbsp;{$v['min_price']} ~ {$v['max_price']}&nbsp;</code> 元 / {if $v['price_unit']}{$v['price_unit']}{else}天{/if}
                                        {/if}
                                    </code>
                                {/if}
                            </span>
                        </div>
                    </div>
                </div>
                {/foreach}

            </div>


        {include "Web_Mobile_Static::baike/inc.baike_nav.tpl"}
    </div>
    <div class="product-fix">
        <div class="product-fix-p">
            {if $page->averagePrice['min_price']==$page->averagePrice['max_price'] && $page->averagePrice['min_price'] < 100}
                <div class="ref-price">
                    均价 <span>面议</span>
                 </div>
            {elseif $_COOKIE['look_price_phone']}
                <div class="ref-price">
                    均价
                    {if $page->averagePrice['min_price']==$page->averagePrice['max_price']}
                         <span>{$page->averagePrice['min_price']}</span> 元 / {if $page->averagePrice['price_unit']}{$page->averagePrice['price_unit']}{else}天{/if}
                    {else}
                        <span>{$page->averagePrice['min_price']} ~ {$page->averagePrice['max_price']}</span> 元 / {if $page->averagePrice['price_unit']}{$page->averagePrice['price_unit']}{else}天{/if}
                    {/if}
                </div>
            {else}
                <a class="js-look-price block" href="javascript:;">查看参考价</a>
                <div class="ref-price hide">
                    均价
                    {if $page->averagePrice['min_price']==$page->averagePrice['max_price']}
                        {if $page->averagePrice['min_price'] < 100}
                            <span>面议</span>
                        {else}
                            <span>{$page->averagePrice['min_price']}</span> 元 / {if $page->averagePrice['price_unit']}{$page->averagePrice['price_unit']}{else}天{/if}
                        {/if}
                    {else}
                        <span>{$page->averagePrice['min_price']} ~ {$page->averagePrice['max_price']}</span> 元 / {if $page->averagePrice['price_unit']}{$page->averagePrice['price_unit']}{else}天{/if}
                    {/if}
                </div>
            {/if}
        </div>
        <div class="product-fix-link">
            <a href="{$_home}inquiry" id="inquiryOrder">
                <div class="inquiry-order-img">
                    <img src="img/product.v2.0/icon_akey.png" alt="">
                </div>
                <p class="circle1 none"></p>
            </a>
        </div>
        <div class="product-fix-js">
            <a href="javascript:;" id="addToOrder" yun="product.v2.0/product.js::joinPrice@click" data-name="{$page->info['space_name']}">加入询价单</a>
            <div class="circle2 none"></div>
        </div>

    </div>

    <div class="product-back-top none"  yun="product.v2.0/product.js::backTop@click">
        返回顶部
    </div>
    {include "Web_Mobile_Static::baike/inc.baike_consult_price.tpl"}
    <script src="plugins/Swiper-master/js/swiper.min.js"></script>
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=aaNCRRcGGai6klHMOGZ8yBbP"></script>
    {static "v1.0/jquery-1.11.1.min.js"}
    {static "core/yunspace.js"}


</body>
</html>