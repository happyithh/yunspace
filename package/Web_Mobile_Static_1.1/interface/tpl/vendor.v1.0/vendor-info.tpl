<!DOCTYPE html>
<html>
<head lang="en">
    {include "Web_Mobile_Static::v1.0/head_meta.tpl"}
    {include "Web_Mobile_Static::service_info.v1.0/inc.head_service_info.tpl"}

</head>
<body class="relative">
<div class="about-us">
    {*<h1>{$page->info['product_name']}</h1>*}
    <h1>{$page->VendorInfo['vendor_name']}</h1>
    <p>{mb_substr($page->VendorInfo['des'],0,20,'UTF-8')}</p>
</div>
<div class="origin-content">
    <div class="top">
        <div class="top_left">
            <a href="{$_home}vendor/"><i class="ion-ios-arrow-back"></i></a>
        </div>
        <div class="top-title"></div>
        <div class="top_right">
            <a href="javascript:toggleNavBox();"><i class="ion-android-menu"></i></a>
        </div>
    </div>
    <div class="vendor_logo_area">
        <hr>
        <div class="vendor_logo_img">
            {*<img src="img/vendor_info.v1.0/vendor_logo.jpg">*}
            {if $page->VendorInfo['logo']}
                <img src="{Page_Site_Global::displayMedia($page->VendorInfo['logo'],275,195)}">
            {else}
                <img src="img/v1.0/vendor.jpg">
            {/if}
        </div>
        <div class="vendor_name">
            {$page->VendorInfo['vendor_name']}<br>
            {if $page->VendorInfo['vendor_remarks']['签约状态']==2}
            <img src="img/vendor_info.v1.0/pag.png">
            {/if}
        </div>
        <div class="clear"></div>
    </div>

    <div class="function-area" style="height: 140px;">
        <ul>
            <li class="open-right-panel" data-panel="service-product-info">
                <img class="function-icon" src="img/service_info.v1.0/productIntro.png"/>

                <div class="function-label">基本信息</div>
                <div class="function-arrow"><i class="ion-chevron-right"></i></div>
            </li>
            <li class="open-right-panel" data-panel="service-product-intro">
                <img class="function-icon" src="img/service_info.v1.0/productInfo.png"/>

                <div class="function-label">公司简介</div>
                <div class="function-arrow"><i class="ion-chevron-right"></i></div>
            </li>

        </ul>
    </div>
    <div class="vendor_service">
        <div class="vendor_service_title">
           服务内容
        </div>
        {foreach $page->productInfo as $k=>$v}
        <div class="vendor_service_content">
            <div class="vendor_service_left">
                {*<img src="img/vendor_info.v1.0/vendor_service.jpg">*}
                {if $v['logo']}
                    <img src="{Page_Site_Global::displayMedia($v['logo'],275,195)}">
                {else}
                    <img src="img/vendor_info.v1.0/vendor_service.jpg">
                {/if}
            </div>
            <div class="vendor_service_right">
                <p class="name">{$v['product_name']}</p>
                <p class="adr">地址：{$v['attr_new'][46]}市</p>
            </div>
            <div class="clear"></div>
        </div>
        {/foreach}
        {*<div class="vendor_service_content">*}
            {*<div class="vendor_service_left">*}
                {*<img src="img/vendor_info.v1.0/vendor_service.jpg">*}
            {*</div>*}
            {*<div class="vendor_service_right">*}
                {*<p class="name">奇瑞经销商年会-大屏制作</p>*}
                {*<p class="adr">地址：上海市北京市西城区里仁街倍建里五号楼1单元501</p>*}
            {*</div>*}
            {*<div class="clear"></div>*}
        {*</div>*}
        {*<div class="vendor_service_content">*}
            {*<div class="vendor_service_left">*}
                {*<img src="img/vendor_info.v1.0/vendor_service.jpg">*}
            {*</div>*}
            {*<div class="vendor_service_right">*}
                {*<p class="name">奇瑞经销商年会-大屏制作</p>*}
                {*<p class="adr">地址：上海市北京市西城区里仁街倍建里五号楼1单元501</p>*}
            {*</div>*}
            {*<div class="clear"></div>*}
        {*</div>*}
    </div>
    <div class="bottom-nav-area">
        <a href="{$_home}vendorContact">
            <div class="contact_vendor">
                <img src="img/vendor_info.v1.0/icon.png">
                <p>联系供应商</p>
            </div>
        </a>

        <a data-url="{$_root}ajax_collect" class="collect" data-uid="{$smarty.session.user.id}" data-status=""   data-id="{$page->id}" data-type="space" href="javascript:;">
            <div class="normal-block favorite-off js-favorite vendor_collect">
                <p>收藏</p>
            </div>
        </a>

    </div>
    <div class="nav-box">{include 'Web_Mobile_Static::nav_box.v1.0/nav-box.tpl'}</div>
    <div class="mask-layer"></div>
</div>

<div class="right-panel panel-service-product-info">{include 'Web_Mobile_Static::panel.v1.0/panel-vendor-infomation.tpl'}</div>
<div class="right-panel panel-service-product-intro">{include 'Web_Mobile_Static::panel.v1.0/panel-vendor-brief.tpl'}</div>
<a href="#" class="round-button-back close-panel"><img src="img/v1.0/back.png"/> </a>
<div class="submit-success absolute js-submit-success">
    提交成功！！
</div>
<div class="favorite-msg">
    <p>取消收藏成功！</p>
</div>
{include "Web_Static::v2.0/html_tj.tpl"}
</body>
</html>