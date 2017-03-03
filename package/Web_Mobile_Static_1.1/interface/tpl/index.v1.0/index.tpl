<!DOCTYPE html>
<html>
<head lang="en">
    {include "Web_Mobile_Static::v1.0/head_meta.tpl"}
    {include "Web_Mobile_Static::index.v1.0/inc.head_index.tpl"}
</head>
<body>
<div class="title-area">
    {if $__user['user']['avatar']}
        <a href="{$_root}user_center/login"><img
                    src="{Page_Site_Global::displayMedia({$__user['user']['avatar']},200,200)}" class="land"/></a>
    {else}
        <a href="{$_root}user_center/login"><img src="img/index.v1.0/land.png" class="land"/></a>
    {/if}
    <img src="img/index.v1.0/logo.png" class="logo"/>
    <select class="city">
        {foreach $_REQUEST['cities'] as $v}
            <option {if $v==$_COOKIE['city']}selected="selected" {/if}>{$v}</option>
        {/foreach}
    </select>

    <div class="search-icon">
        <a href="javascript:toggleNavBox();"><i class="ion-android-menu"></i></a>
    </div>

</div>
<div class="image-content-area">
    <div class="swiper-container">
        <div class="swiper-wrapper">
            {if $banner}
                <!-- Slides -->
                {foreach $banner as $v}
                    <div class="swiper-slide">
                        {if $v['url']}
                            <a href="{$v['url']}"><img src="{Page_Site_Global::displayMedia($v['path'],640,480,0)}"
                                                       alt="{$v['title']}"></a>
                        {else}
                            <a href="javascript:void(0)"><img
                                        src="{Page_Site_Global::displayMedia($v['path'],640,480,0)}"
                                        alt="{$v['title']}"></a>
                        {/if}
                    </div>
                {/foreach}
            {else}
                <a href="javascript:void(0)">
                    <img src="img/vendor.jpg" alt="云space"></a>
            {/if}
        </div>
        <div class="swiper-pagination"></div>
    </div>
</div>
<div class="function-area">
    <a href="{$_home}set_list">
        <div class="value-package">
            <img src="img/index.v1.0/package.png"/>

            <p>超值套餐</p>
        </div>
    </a>
    <a href="{$_home}index/requirement">
        {*<a onclick="popupSubmitRequirement(this)">*}
        <div class="submission-requirement">
            <img src="img/index.v1.0/requirement.png"/>

            <p>我要办活动</p>
        </div>
    </a>
    <a href="{$_home}space">
        <div class="space-space">
            <img src="img/index.v1.0/space.png"/>

            <p>空间场地</p>
        </div>
    </a>
    <a href="{$_home}service">
        <div class="supporting-service">
            <img src="img/index.v1.0/service.png"/>

            <p>配套服务</p>
        </div>
    </a>
</div>
<div class="bottom-nav-area">
    <div class="contact-us">
        <a href="tel:4000560599"><img src="img/index.v1.0/contact.png"/></a>
    </div>
    <a class="vendor-join" href="{$_home}index/vendor_join">
        {*<a class="vendor-join" onclick="popupVendorJoin(this)">*}
        <img src="img/index.v1.0/vendor_join.png"/>
    </a>
</div>
{*Todo*}
{*临时性注释，在框架插件完成后可能会恢复*}
{*<div class="popup popup-vendor-join">{include 'Web_Mobile_Static::index.v1.0/inc.popup-vendorJoin.tpl'}</div>*}
{*<div class="popup popup-submit-requirement">{include 'Web_Mobile_Static::index.v1.0/inc.popup-submitRequirement.tpl'}</div>*}
{*<div class="maskLayer">*}
{*<div>*}
{*<img src="img/index.v1.0/loading.gif"/>*}
{*</div>*}
{*</div>*}
<div class="nav-box">{include 'Web_Mobile_Static::nav_box.v1.0/nav-box.tpl'}</div>
<div class="mask-layer"></div>
{include "Web_Static::v2.0/html_tj.tpl"}
</body>
</html>