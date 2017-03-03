<!doctype html>
<html>
<head>
    {include file="Web_Static::v2.0/html_goto_pc.tpl" url="raiders-info/{$page->id}.html"}
    {include file="Web_Mobile_Static::activity_strategy.v2.0/inc.activity_strategy_meta.tpl"}
    {static "v1.0/global.css"}
    {static "activity_strategy.v2.0/act_strategy_header.css"}
    {static "activity_strategy.v2.0/activity_strategy_info.css"}
    {static "v1.0/jquery-1.11.1.min.js"}
    <link rel="stylesheet" href="plugins/ionicons-master/css/ionicons.min.css">
    <link rel="stylesheet" href="plugins/Swiper-master/css/swiper.min.css">
    <script src="plugins/Swiper-master/js/swiper.min.js"></script>
    {*<title>{$page->getRaidersDetail['title']}_云·Space－商业空间短租平台</title>*}
</head>
<body yun="activity_strategy.v2.0/activity_strategy_list.js::init">
<div yun="hide-app/hide-app.js::init"></div>
<div class="yun_find_info_header none">
    <div class="left">
        <a href="javascript:window.history.back();"><span class="ion-ios-arrow-back"></span></a>
    </div>
    <div class="center">
        <span>{$page->getRaidersDetail['title']}</span>
    </div>
    <div class="right">
        <a href="{$_root}m/search/set_list"><span class="ion-ios-search-strong"></span></a>
    </div>
</div>
<div class="content yun_find_info_id">
    {include file="Web_Mobile_Static::activity_strategy.v2.0/inc.activity_strategy_header.tpl"}
    <div class="yun_find_info">
        <div class="yun_find_img">
            <img src="img/activity_strategy/fxsx.png" alt="{$page->getRaidersDetail['title']}">
        </div>
        <div class="yun_find_title">
            <p>云·发现<br/><span>
                {foreach $page->allCategory as $k => $v}
                    {if $page->topCategory['top_id']==$v['id']}
                        <a href="{$_home}raiders/{$page->topCategory['top_id']}">{$v['name']}&nbsp;</a>
                    {/if}
                {/foreach}
                    <span style="color: #666">
                    >

                    </span>
                <a href="{$_home}raiders/{$page->getRaidersDetail['category_id']}">&nbsp;{$page->getRaidersDetail['category_name']}</a>
                </span>
            </p>
        </div>
    </div>
    <div class="yun_find_info_content">
        {if $page->getRaidersDetail['hide_logo']}
            <div class="info_img">
                {*<img src="img/activity_strategy/b1.png" alt="">*}
                <img src="{Page_Site_Global::displayMedia($page->getRaidersDetail['logo'],750,424)}" alt="{$page->getRaidersDetail['title']}">
            </div>
        {else}{/if}
        <div class="info_title">
            <p>{$page->getRaidersDetail['title']}</p>
            <div class="author">{if $page->getRaidersDetail['author']}{$page->getRaidersDetail['author']}{else}来自网络{/if}&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;{Date('Y-m-d',$page->getRaidersDetail['create_time'])}
                &nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;

                <img src="img/activity_strategy/eye.png" alt="{$page->getRaidersDetail['title']}">

                &nbsp;{$page->getRaidersDetail['counter_view']}</div>
        </div>

        {*<div class="info_article">*}
        {*{$page->getRaidersDetail['cont']}*}
        {*</div>*}
        {$str_parent}
        {if !empty($detail_des)}
            <div style="background: #fff;">
                <div class="info_article_tip">
                    <p class="info_article_tip_p">信息</p>
                    <p class="info_article_tip_p">{$page->getRaidersDetail['detail_des'][0]}</p>
                    <p class="info_article_tip_p">{$page->getRaidersDetail['detail_des'][1]}</p>
                    <p class="info_article_tip_p">{$page->getRaidersDetail['detail_des'][2]}</p>
                    <p class="info_article_tip_p">{$page->getRaidersDetail['detail_des'][3]}</p>
                </div>
            </div>
        {/if}
        {*<div class="product-code">*}
        {*<div class="product-code-title">场地信息</div>*}
        {*<div class="product-code-body">*}
        {*<div class="product-code-img">*}
        {*<img src="img/activity_strategy/a1.png" alt="">*}
        {*</div>*}
        {*<div class="product-code-con">*}
        {*<p>1933老厂房-宴会厅</p>*}
        {*<p>城市区域：<span>上海-虹口区</span></p>*}

        {*<p>所属商圈：<span>外滩</span></p>*}

        {*<p>使用面积：<span>1000平米</span></p>*}

        {*<p>容纳人数：<span>500人</span></p>*}
        {*</div>*}
        {*</div>*}
        {*<div class="product-code-look-info">*}
        {*<a href="">查看详情 &nbsp;></a>*}
        {*</div>*}
        {*</div>*}
        <div class="info_ok">
            <a href="javascript:;"  yun="activity_strategy.v2.0/activity_strategy_list.js::clickOk@click" {if $page->getRaidersDetail['counter_praise']==0}class{else}class="up"{/if}>
                <div class="ok_img">
                    {if $page->getRaidersDetail['counter_praise']==0}
                        <img src="img/activity_strategy/hand1.png" alt="{$page->getRaidersDetail['title']}" class="up_img">
                        <img src="img/activity_strategy/hand2.png" alt="{$page->getRaidersDetail['title']}" class="up_img none">
                    {else}
                        <img src="img/activity_strategy/hand1.png" alt="{$page->getRaidersDetail['title']}" class="up_img none">
                        <img src="img/activity_strategy/hand2.png" alt="{$page->getRaidersDetail['title']}" class="up_img">
                    {/if}
                </div>
                <span class="ok_num" data-title_id="{$page->getRaidersDetail['id']}">{$page->getRaidersDetail['counter_praise']}</span>&nbsp;&nbsp;
            </a>
        </div>
        <div class="info_footer">
            <div class="footer_logo">
                <img src="img/activity_strategy/logo2.png" alt="云space">
            </div>
            <p class="info_footer_title">相关阅读</p>
            <ul class="info_footer_about_list">
                {foreach $page->getRelationRead as $k => $v}
                    <li><a href="{$_home}raiders-info/{$v['id']}.html"><span>·</span>&nbsp;
                            {if mb_strlen($v['title'],'UTF-8')>20}
                                {mb_substr($v['title'],0,19,'UTF-8')}……
                            {else}{$v['title']}{/if}
                        </a></li>
                {/foreach}
            </ul>
        </div>
    </div>

    {static "core/yunspace.js"}
    {include "Web_Static::v2.0/html_tj.tpl"}
</body>
</html>