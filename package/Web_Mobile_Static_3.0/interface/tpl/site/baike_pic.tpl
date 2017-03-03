<!DOCTYPE>
<html>
<head>
    {include file="Web_Mobile_Static::inc/header_meta.tpl"}
    <meta name="full-screen" content="yes" />
    <meta name="x5-fullscreen" content="true" />
    <meta name="x5-page-mode" content="app" />
    {static "encyclopedia/encyclopedia.css"}
    {static "encyclopedia/swiper-3.3.1.min.css"}
    {static "v4.0/font-awesome.min.css"}

    {*{static "encyclopedias/jquery.scrollTo.js"}*}
    {static "encyclopedias/swiper-3.3.1.jquery.min.js"}
    {static "encyclopedias/encyclopedias.js"}
    {static "encyclopedias/pic.js"}
</head>
<body>
<div style="z-index:2;background:#fff;">
    {include "Web_Mobile_Static::v1.0/inc.nav.tpl"}
    {*场地图片2016/6/20添加*}
    {*<div class="baike_pic_back">*}
    {*<a href=javascript:go(-1);> < 返回</a>*}
    {*</div>*}
    {*<div class="baike_m_line" style="margin: 0px;"></div>*}


    <div class="topline">
        <a class="topline-back" href="javascript:history.go(-1);"><img src="/package/Web_Mobile_Static_1.1/interface/assets/img/v1.0/list_02.png"></a>
        <div class="topline-center">
            {if $page->item_id==false}
            {$page->info['space_name']}
            {else}
                {$page->info['space_name']}-{$page->itemInfo['item_name']}
            {/if}
            <span>({count($page->spaceMedia)}张)</span>
            <div class="clear"></div>
        </div>
    </div>

    <div class="loading none">
        <img src="img/encyclopedias/loading.jpg"/>
    </div>

    <div class=baike_pic_outside>
        {*<div class="baike_m_c_title">奢居会<span>(76张)</span></div>*}
        <div class="baike_pic">
            <ul>
                {foreach $page->spaceMedia as $k=>$v}
                    <li>
                        <a data-to="{$k}">
                            <img class="lazy" data-original="{Page_Site_Global::displayMedia($v['path'],200,120)}" src="">
                        </a>
                    </li>
                {/foreach}
            </ul>
        </div>
        {*<div class="baike_m_icon_down" id="baike_m_pic_down">*}
        {*<img src="img/encyclopedias/baike_m_icon_down.png">*}
        {*</div>*}
        {*<div class="baike_m_icon_up" id="baike_m_pic_up">*}
        {*<img src="img/encyclopedias/baike_m_icon_up.png">*}
        {*</div>*}
    </div>
</div>

{*场地图片大图部分*}
{*<div class="cover_pic">*}


    {*<ul>*}
        {*{foreach $page->spaceMedia as $k=>$v}*}
        {*<li id="here_{$k}">*}
            {*<img class="lazy" data-original="{if $k>1}{Page_Site_Global::displayMedia($v['path'],600,480)}{/if}" src="{if $k<=1}{Page_Site_Global::displayMedia($v['path'],600,480)}{/if}">*}
        {*</li>*}
        {*{/foreach}*}
    {*</ul>*}


    {*<div class="swiper-container">*}
        {*<div class="swiper-wrapper">*}
            {*{foreach $page->spaceMedia as $k=>$v}*}
               {*<div class="swiper-slide" id="here_{$k}">*}
                   {*<img class="lazy" data-original="{if $k>1}{Page_Site_Global::displayMedia($v['path'],600,480)}{/if}" src="{if $k<=1}{Page_Site_Global::displayMedia($v['path'],600,480)}{/if}">*}
               {*</div>*}
            {*{/foreach}*}
        {*</div>*}
    {*</div>*}

{*</div>*}
    <div class="swiper-container cover_pic_one" style=" position:fixed;top:0;width:100%;height:100%;z-index:-1;background:rgba(0,0,0,0.8);opacity:0">
        <div class="cover_pic_icon">
            <img src="img/encyclopedias/cover_close.png">
        </div>

        <div class="swiper-wrapper">
            {foreach $page->spaceMedia as $k=>$v}
                <div class="swiper-slide">
                     <img alt="" data-original="{Page_Site_Global::displayMedia($v['path'],600,480)}" src="">
                </div>
            {/foreach}
            {*<div class="swiper-slide"> *}
                {*<img src="" alt="" data-original="/package/Web_Mobile_Static_3.0/interface/assets/img/city_collaborate/logo-com.png">*}
            {*</div>*}
            {*<div class="swiper-slide"> *}
                {*<img src="" alt="" data-original="/package/Web_Mobile_Static_3.0/interface/assets/img/city_collaborate/logo-com.png">*}
            {*</div>*}
        </div>
    </div>


{*<script>*}
    {*$(function() {*}
        {*$("img.lazy").lazyload();*}
    {*});*}
{*</script>*}

{static "encyclopedias/jquery.lazyload.min.js"}
<script>

</script>
</body>
</html>