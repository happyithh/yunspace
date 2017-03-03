<!DOCTYPE html>
<html>
<head lang="en">
    {include file="Web_Static::v2.0/html_goto_pc.tpl" url="set_info/{$page->id}.html"}
    {include "Web_Mobile_Static::v1.0/head_meta.tpl"}
    {include "Web_Mobile_Static::set_info.v1.0/inc.head_set_info_v3.tpl"}
</head>
<body>
<div class="about-us">
    <h1>{$page->info['set_name']}</h1>

    <p>{mb_substr(strip_tags($page->info['des']),0,300,'utf-8')}</p>
</div>
<div class="origin-content">
<div class="top">
    <div class="top_left">
        <a href="{if $page->info['addr']}{$_home}set_list/{else}{$_home}set_list/{/if}"><i class="ion-ios-arrow-back"></i></a>
    </div>
    <div class="top-title">{$page->info['set_name']}</div>
    <div class="top_right">
        <a href="javascript:toggleNavBox();"><i class="ion-android-menu"></i></a>
    </div>
</div>
<div class="cover"></div>
<div class="version-choose">
    <p class="version-cate">套餐场地版本分类</p>
    <span class="ion-close close-cate"></span>

    <div style="clear:both"></div>
    <ul class="cate">
        {foreach $page->otherVersion as $k=>$v}
            <li>
                <a href="{$_home}set_info/{$v['id']}.html" class="cate-name {if $page->info['version']==$v['version']} active{/if}" data-text="{$v['version']}">{$v['version']}</a>
            </li>
        {/foreach}
    </ul>
    <div style="clear:both"></div>
</div>
<div class="image-content-area" data-id="{$page->info['schedule_product_id']}" data-text="{$id}">
    <div class="swiper-container">
        <div class="swiper-wrapper">
            {foreach $page->media as $mk=>$mv}
                {foreach $mv as $vv}
                    <div class="swiper-slide">
                        <img src="{Page_Site_Global::displayMedia($vv[1],768,576,1)}"
                             title="{$info['attr']['城市']}{$info['product_name']}-{$info['attr']['基本信息>适合活动类型']}-{$vv[0]}" width="100%"/>
                    </div>
                {/foreach}
            {/foreach}
        </div>
        <div class="swiper-pagination"></div>
    </div>
</div>
<div class="top-info-area">
    <p class="larger-title">{$page->info['set_name']}</p>
    {if $page->info['detail']['市场价']}
    <s class="market-price">&nbsp&nbsp市场价&nbsp:&nbsp￥{$page->info['detail']['市场价']}
        {if $page->info['detail']['计价单位']}
        /{$page->info['detail']['计价单位']}
        {/if}&nbsp&nbsp</s>
    {/if}
    <div class="current-price">
        <p class="price">
            ¥ {$page->info['detail']['套餐价']}
            {if $page->info['detail']['计价单位']}
                /{$page->info['detail']['计价单位']}
            {/if}</p>

        {if $page->info['detail']['市场价']}
        <div class="discount">{intval($page->info['detail']['套餐价']/$page->info['detail']['市场价']*100)/10}
            折
        </div>
        {/if}
        <div class="clear"></div>
    </div>

    <div class="choose-set">
        <a href="javascript:;" class="version">
            <p class="cate-title">{$page->info['version']}</p>

            <div class="choose-arrow">
                <i class="ion-ios-arrow-down"></i></div>
        </a>
    </div>
</div>
<div class="basic-info-area">
    <ul>
        <li>
            <div class="left-text">城市</div>
            <div class="right-text city">{$page->info['attr_index']['城市']}</div>
        </li>
        <li>
            <div class="left-text">类别</div>
            <div class="right-text category" data-id="{{$page->info['category_id']}}">{$page->allCategory[$page->info['category_id']]}</div>
        </li>
        <li>
            <div class="left-text">人数</div>
            <div class="right-text number_person">{$page->info['attr_index']['人数']}</div>
        </li>
        <li>
            <div class="left-text">天数</div>
            <div class="right-text time">{$page->info['attr_index']['天数']}</div>
        </li>
        <li>
            <div class="left-text">有效期</div>
            <div class="right-text time">{$page->info['attr_index']['开始时间']}
                &nbsp;至&nbsp;{$page->info['attr_index']['结束时间']}</div>
        </li>
        {if $page->info['addr']}
        <li>
            <div class="left-text">地址</div>
            <div class="right-text addr">{$page->info['addr']}</div>
        </li>
        {/if}
    </ul>
</div>
<div class="function-area">
    <ul>
        <li class="open-right-panel" data-panel="service-product-intro">
            <img class="function-icon" src="img/service_info.v1.0/productIntro.png"/>

            <div class="function-label">套餐详情</div>
            <div class="function-arrow">
                <i class="ion-chevron-right"></i></div>
        </li>
        <li class="open-right-panel" data-panel="service-product-case" {if $case[0]==''}style="display: none"{/if}>
            <img class="function-icon" src="img/service_info.v1.0/productCase.png"/>

            <div class="function-label">活动案例</div>
            <div class="function-arrow">
                <i class="ion-chevron-right"></i></div>
        </li>
        <li class="open-right-panel" data-panel="service-product-schedule">
            <img class="function-icon" src="img/service_info.v1.0/productSchedule.png"/>
            <div class="function-label">查询档期</div>
            <div class="function-arrow"><i class="ion-chevron-right"></i></div>
        </li>
        <li class="open-right-panel" data-panel="service-product-reserve">
            <img class="function-icon" src="img/service_info.v1.0/productReserve.png"/>

            <div class="function-label">预定须知</div>
            <div class="function-arrow">
                <i class="ion-chevron-right"></i></div>
        </li>
    </ul>
</div>
<div class="best-pair-area">
    <div class="best-title">最佳搭配</div>
    <div class="left-arrow">
        <i class="ion-chevron-left"></i></div>
    <div class="right-arrow">
        <i class="ion-chevron-right"></i></div>
    <div class="swiper-container">
        <div class="swiper-wrapper">
            <div class="swiper-slide">
                <a href="/vendor_info/168.html"><img src="http://www.yunspace.com.cn/uploads/200_200/201502/o_19f7nh0forh1sm91mjcnie97ca.jpg"></a>

                <p class="title">上海临境文化传播有限公司</p>

                <p class="price"></p>
            </div>
            <div class="swiper-slide">
                <a href="/vendor_info/2975.html"><img src="http://www.yunspace.com.cn/uploads/200_200/201505/i_5552f94f698f1.jpg"></a>

                <p class="title">上海蓝森宴会餐饮有限公司</p>
            </div>
            <div class="swiper-slide">
                <a href="/vendor_info/2835.html"><img src="http://www.yunspace.com.cn/uploads/275_195/201503/o_19haimc7knov1gkmrqr195s1bi77.JPG"></a>

                <p class="title">上海佰胜汽车租赁有限公司</p>
            </div>
            <div class="swiper-slide">
                <a href="/vendor_info/150.html"><img src="http://www.yunspace.com.cn/uploads/275_195/201503/o_19hacjm4g4u71jturk11nuc1hjrb.jpg"></a>

                <p class="title">上海睿派汽车租赁服务有限公司 1</p>
            </div>
            <div class="swiper-slide">
                <a href="/vendor_info/2568.html"><img src="http://www.yunspace.com.cn/uploads/275_195/201503/o_19gooffcmdtq1fpn14fc15rc1v4td.jpg"></a>

                <p class="title">上海市保安服务总公司</p>
            </div>
        </div>
    </div>
</div>
<div class="bottom-nav-area">
    <a data-url="{$_root}ajax_collect" class="collect" data-uid="{$smarty.session.user.id}" data-status=""   data-id="{$page->id}" data-type="space" href="javascript:;">
        <div class="normal-block  js-favorite">
            <span class="ion-android-star" style="color:#000;font-size: 20px;"></span>
            <p style="color:#000;margin-top: 0px;">收藏</p>
        </div>
    </a>
    <a href="/product_set_booking?id={$page->id}">
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
<div class="right-panel panel-service-product-intro">{include 'Web_Mobile_Static::panel.v1.0/panel-service-product-set-intro.tpl'}</div>
<div class="right-panel panel-service-product-info">{include 'Web_Mobile_Static::panel.v1.0/panel-service-product-info.tpl'}</div>
<div class="right-panel panel-service-product-case">{include 'Web_Mobile_Static::panel.v1.0/panel-service-product-set-case.tpl'}</div>
<div class="right-panel panel-service-product-reserve">{include 'Web_Mobile_Static::panel.v1.0/panel-service-product-reserve.tpl'}</div>
<div class="right-panel panel-service-product-schedule">{include 'Web_Mobile_Static::panel.v1.0/panel-service-product-schedule.tpl'}</div>
<a href="#" class="round-button-back close-panel"><img src="img/v1.0/back.png"/>
</a>
<div class="submit-success absolute js-submit-success">
    提交成功！！
</div>
<div class="favorite-msg">
    <p>取消收藏成功！</p>
</div>
{include "Web_Static::v2.0/html_tj.tpl"}
</body>
</html>