<!DOCTYPE html>
<html>
<head lang="en">
    {include file="Web_Static::v2.0/html_goto_pc.tpl" url="service_info/{$page->id}.html"}
    {include "Web_Mobile_Static::v1.0/head_meta.tpl"}
    {include "Web_Mobile_Static::service_info.v1.0/inc.head_service_info.tpl"}
</head>
<body class="relative">
<div class="about-us">
    <h1>{$page->info['product_name']}</h1>
    <p>{$page->info['des']}</p>
</div>
<div class="origin-content">
    <div class="top">
        <div class="top_left">
            <a href="{if $page->productInfo['addr']}{$_home}space/{else}{$_home}service/{/if}"><i class="ion-ios-arrow-back"></i></a>
        </div>
        <div class="top-title">{$page->productInfo['product_name']}</div>
        <div class="top_right">
            <a href="javascript:toggleNavBox();"><i class="ion-android-menu"></i></a>
        </div>
    </div>
    <div class="image-content-area">
        <div class="swiper-container">
            <div class="swiper-wrapper">
                {foreach $page->productInfo['media'] as $mk=>$mv}
                    {foreach $mv as $vv}
                        <div class="swiper-slide">
                        {if $vv[2]}
                            <a href="#" class="js-open-video-panel" data-video-src="{$vv[2]}" >
                                <img src="{Page_Site_Global::displayMedia($vv[1],768,576,2)}"
                                     title="{$info['attr']['城市']}{$info['product_name']}-{$info['attr']['基本信息>适合活动类型']}-{$vv[0]}"/>
                            </a>
                        {else}
                            <img src="{Page_Site_Global::displayMedia($vv[1],768,576,1)}"
                                 title="{$info['attr']['城市']}{$info['product_name']}-{$info['attr']['基本信息>适合活动类型']}-{$vv[0]}"/>
                        {/if}
                        </div>
                    {/foreach}
                {/foreach}
            </div>
            <div class="swiper-pagination"></div>
        </div>
    </div>
    <div class="base-info-area">
        <ul>
            <li>
                <img class="base-icon" src="img/service_info.v1.0/productName.png"/>

                <div class="base-label">商品名称&nbsp:&nbsp</div>
                <div class="base-content">{$page->productInfo['product_name']}</div>
            </li>
            <li>
                <img class="base-icon" src="img/service_info.v1.0/productLabel.png"/>

                <div class="base-label">服务标签&nbsp:&nbsp</div>
                <div class="base-content">
                    {foreach explode(',',$page->productInfo['attr_new'][Page_Site_Global::tagsName('适合活动类型')]) as $ak=>$av}
                        <a href="{$_root}space/{$page->productInfo['category_id']}?filter[{Page_Site_Global::tagsName('适合活动类型')}]={$av}">{$av}</a>
                    {/foreach}</div>
            </li>
            {if $page->productInfo['addr']}
            <li>
                <img class="base-icon" src="img/service_info.v1.0/productAddr.png"/>

                <div class="base-label">具体地址&nbsp:&nbsp</div>
                <div class="base-content">{$page->productInfo['addr']}</div>
            </li>
            {/if}
            <li>
                <img class="base-icon" src="img/service_info.v1.0/productPrice.png"/>

                <div class="base-label">参考价格&nbsp:&nbsp</div>
                <div class="base-content-larger">
                    {if $page->productInfo['price'] >0}
                        <strong>¥ {$page->productInfo['price']} </strong>
                    {else}
                        面议
                    {/if}
                </div>
            </li>
        </ul>
    </div>
    <div class="function-area">
        <ul>
            <li class="open-right-panel" data-panel="service-product-intro">
                <img class="function-icon" src="img/service_info.v1.0/productIntro.png"/>

                <div class="function-label">商品介绍</div>
                <div class="function-arrow"><i class="ion-chevron-right"></i></div>
            </li>
            <li class="open-right-panel" data-panel="service-product-info">
                <img class="function-icon" src="img/service_info.v1.0/productInfo.png"/>

                <div class="function-label">商户信息</div>
                <div class="function-arrow"><i class="ion-chevron-right"></i></div>
            </li>
            <li class="open-right-panel" data-panel="service-product-schedule">
                <img class="function-icon" src="img/service_info.v1.0/productSchedule.png"/>
                <div class="function-label">查询档期</div>
                <div class="function-arrow"><i class="ion-chevron-right"></i></div>
            </li>
            {if $page->eventInfo['page']['dt'] !=0}
            <li class="open-right-panel" data-panel="service-product-case">
                <img class="function-icon" src="img/service_info.v1.0/productCase.png"/>
                <div class="function-label">活动案例</div>
                <div class="function-arrow"><i class="ion-chevron-right"></i></div>
            </li>
            {/if}
        </ul>
    </div>
    <div class="best-pair-area">
        <div class="best-title">猜你喜欢</div>
        <div class="left-arrow"><i class="ion-chevron-left"></i></div>
        <div class="right-arrow"><i class="ion-chevron-right"></i></div>
        <div class="swiper-container">
            <div class="swiper-wrapper">
                {foreach $page->guessYouLike as $key=>$val}
                    <div class="swiper-slide">
                        <a href="{$root}{$val['id']}.html"><img src="{Page_Site_Global::displayMedia($val['logo'],200,0,1)}"></a>

                        <p class="title">{$val['product_name']}</p>

                        <p class="price">
                            {if $val['price'] >0}
                                <strong>¥ {$val['price']} </strong>
                            {else}
                                面议
                            {/if}</p>
                    </div>
                {/foreach}
            </div>
        </div>
    </div>

    <div class="bottom-nav-area">
        <a data-url="{$_root}ajax_collect" class="collect" data-uid="{$smarty.session.user.id}" data-status=""   data-id="{$page->id}" data-type="space" href="javascript:;">
            <div class="normal-block  js-favorite">
                <span class="ion-android-star-outline " style="color:#000;font-size: 20px;"></span>
                <p style="color:#000;margin-top: 0px;">收藏</p>
            </div>
        </a>
        <a href="/booking?id={$page->id}">
            <div class="normal-block block-right-border">
                <span class="ion-clipboard" style="color:#000;font-size: 20px;"></span>
                <p>预定</p>
            </div>
        </a>
        <div class="larger-block">
            <p><a href="tel:4000560599" style="display: block"><span class="ion-ios-telephone" style="font-size: 18px;"></span>&nbsp;电话咨询</a></p>
        </div>
    </div>
    <div class="nav-box">{include 'Web_Mobile_Static::nav_box.v1.0/nav-box.tpl'}</div>
    <div class="mask-layer"></div>
</div>

<div class="right-panel panel-service-product-intro">{include 'Web_Mobile_Static::panel.v1.0/panel-service-product-intro.tpl'}</div>
<div class="right-panel panel-service-product-info">{include 'Web_Mobile_Static::panel.v1.0/panel-service-product-info.tpl'}</div>
<div class="right-panel panel-service-product-case">{include 'Web_Mobile_Static::panel.v1.0/panel-service-product-case.tpl'}</div>
<div class="right-panel panel-service-product-reserve">{include 'Web_Mobile_Static::panel.v1.0/panel-service-product-reserve.tpl'}</div>
<div class="right-panel panel-service-product-schedule">{include 'Web_Mobile_Static::panel.v1.0/panel-service-product-schedule.tpl'}</div>
<div class="right-panel panel-video">{include 'Web_Mobile_Static::panel.v1.0/panel-video.tpl'}</div>
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