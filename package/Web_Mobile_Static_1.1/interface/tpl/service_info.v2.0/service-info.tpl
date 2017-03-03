<!DOCTYPE html>
<html>
<head lang="en">
    {include file="Web_Static::v2.0/html_goto_pc.tpl" url="service_info/{$page->id}.html"}
    {include "Web_Mobile_Static::v1.0/head_meta.tpl"}
    {include "Web_Mobile_Static::service_info.v2.0/inc.head_service_info.tpl"}
</head>
<body class="relative">
{include "Web_Mobile_Static::v1.0/inc.nav.tpl"}
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
            <a href="{$_home}search/space"><i class="ion-ios-search-strong"></i></a>
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

                <div class="base-label">场地名称&nbsp:&nbsp</div>
                <div class="base-content base-other product-title">{$page->productInfo['product_name']}</div>
            </li>
            <li>
                <img class="base-icon" src="img/service_info.v1.0/productLabel.png"/>

                <div class="base-label">服务标签&nbsp:&nbsp</div>
                <div class="base-content base-tags">
                    {foreach explode(',',$page->productInfo['attr_new'][Page_Site_Global::tagsName('适合活动类型')]) as $ak=>$av}
                        <a href="{$_root}space/{$page->productInfo['category_id']}?filter[{Page_Site_Global::tagsName('适合活动类型')}]={$av}">{$av}</a>
                    {/foreach}</div>
            </li>
            {if $page->productInfo['addr']}
            <li>
                <img class="base-icon" src="img/service_info.v1.0/productAddr.png"/>

                <div class="base-label">具体地址&nbsp:&nbsp</div>
                <div class="base-content base-other product-addr">{$page->productInfo['addr']}</div>
            </li>
            {/if}
            <li>
                <img class="base-icon" src="img/service_info.v1.0/productPrice.png"/>

                <div class="base-label">参考价格&nbsp:&nbsp</div>
                <div class="base-content-larger product-price">
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

                <div class="function-label">场地介绍</div>
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
        <a href="tel:4000560599">
            <div class="normal-block block-right-border">
                <span class="icon ion-ios-telephone" style="font-size: 20px;line-height: 22px;"></span>
                <p>咨询</p>
            </div>
        </a>
        <a class="collect" data-space_id="{$page->productInfo['id']}" data-space_logo="{$page->productInfo['logo']}" href="javascript:;">
            <div class="normal-block  js-favorite">
                <!--只做效果用-star-->
                <i class="js-star-move icon-star" style="font-size: 22px;line-height: 22px;"></i>
                <!--只做效果用-end-->

                <span class="icon ion-android-star-outline " style="font-size: 22px;line-height: 22px;"></span>
                <p>收藏</p>
            </div>
        </a>
        <a class="js-share" href="javascript:;">
            <div class="normal-block block-right-border">
                <span class="icon ion-android-share-alt" style="font-size: 18px;line-height: 22px;"></span>
                <p>分享</p>
            </div>
        </a>
        <div class="larger-block">
            <p><a href="{$_home}inquiry" style="display: block">一键租场地</a></p>
        </div>
    </div>

    <div class="share-bg hidden"></div>
    <div class="share">
        <h5>分享到：</h5>
        <div class="share-list clearfix">
            <ul class="bdsharebuttonbox">
                <li>
                    <a href="#" class="bds_weixin" data-cmd="weixin" title="分享到微信"></a>
                    <span>朋友圈</span>
                </li>
                <li>
                    <a href="#" class="bds_tsina" data-cmd="tsina" title="分享到新浪微博"></a>
                    <span>新浪微博</span>
                </li>
                <li>
                    <a href="#" class="bds_sqq" data-cmd="sqq" title="分享到QQ好友"></a>
                    <span>QQ好友</span>
                </li>
                <li>
                    <a href="#" class="bds_qzone" data-cmd="qzone" title="分享到QQ空间"></a>
                    <span>QQ空间</span>
                </li>
            </ul>
            <script>
                window._bd_share_config={ "common":{ "bdSnsKey":{ },"bdText":"","bdMini":"2","bdMiniList":["qzone","bdysc","renren","bdxc","tqf","douban","sqq","ibaidu","mogujie","huaban","hx","youdao","qingbiji","xinhua","isohu","wealink","iguba","twi","h163","copy"],"bdPic":"","bdStyle":"1","bdSize":"32"},"share":{ },"image":{ "viewList":["weixin","tsina","sqq","qzone"],"viewText":"分享到：","viewSize":"32"},"selectShare":{ "bdContainerClass":null,"bdSelectMiniList":["weixin","tsina","sqq","qzone"]}};with(document)0[(getElementsByTagName('head')[0]||body).appendChild(createElement('script')).src='http://bdimg.share.baidu.com/static/api/js/share.js?v=89860593.js?cdnversion='+~(-new Date()/36e5)];
            </script>
        </div>

        {*<ul class="share-list clearfix">*}
            {*<li>*}
                {*<a href="javascript:;"><img src="img/service_info.v1.0/friends-world.png"><span>朋友圈</span></a>*}
            {*</li>*}
            {*<li>*}
                {*<a href="javascript:;"><img src="img/service_info.v1.0/friends-weixin.png"><span>微信好友</span></a>*}
            {*</li>*}
            {*<li>*}
                {*<a href="javascript:;"><img src="img/service_info.v1.0/sina.png"><span>新浪微博</span></a>*}
            {*</li>*}
            {*<li>*}
                {*<a href="javascript:;"><img src="img/service_info.v1.0/friends-qq.png"><span>QQ好友</span></a>*}
            {*</li>*}
            {*<li>*}
                {*<a href="javascript:;"><img src="img/service_info.v1.0/qq-space.png"><span>QQ空间</span></a>*}
            {*</li>*}
        {*</ul>*}
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
<script src="js/v1.0/collect.js"></script>
</body>
</html>