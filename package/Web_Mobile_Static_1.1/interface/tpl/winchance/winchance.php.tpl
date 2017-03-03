<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no,minimal-ui">
    <meta name="format-detection" content="telephone=no"/>
    <link type="text/css" rel="stylesheet" href="css/v1.0/style_public.css">
    <link type="text/css" rel="stylesheet" href="css/mobile_winchance.v1.0/winchance_mbl.css">
    <link rel="stylesheet" href="plugins/Swiper-master/css/swiper.min.css">
    {static "v1.0/jquery-1.11.1.min.js"}
    {static "winchance/jquery.SuperSlide.2.1.js"}
    <script src="plugins/Swiper-master/js/swiper.min.js"></script>
    {include file="Web_Mobile_Static::winchance/inc.winchance_meta.tpl"}
    <title>文创活动 - 文创活动【云·Space－商业空间短租平台】</title>
</head>
<body yun="activity_strategy.v2.0/activity_strategy_list.js::init">
<div class="w-banner">
    <div class="show_find">
        <div class="show_find_body swiper-container">
            <div class="show_find_body_list swiper-wrapper">

                {foreach $raiders_list as $k=>$v}
                    <div class="show_find_body_li swiper-slide">
                        <a href="{$_home}raiders-info/{$v['id']}.html" style="color:#fff">
                            <img src="{Page_Site_Global::displayMedia($v['logo'],375,270)}">

                            <div class="bg-shadow"></div>
                            <div class="show_find_body_li_des">
                                {if mb_strlen($v['title'],'UTF-8')>7}
                                    {mb_substr($v['title'],0,6,'UTF-8')}...
                                {else}{$v['title']}{/if}
                                {*{$v['title']}*}
                                <br>
                                {if mb_strlen($v['des'],'UTF-8')>9}
                                    {mb_substr($v['des'],0,9,'UTF-8')}...
                                {else}{$v['des']}{/if}
                                {*{$v['des']}*}
                            </div>
                        </a>
                    </div>
                {/foreach}

            </div>
        </div>
        <div class="show_find_num">
            <div class="show_find_square"></div>
            <p class="img_num"></p>
        </div>
    </div>
</div>

<!--云·space的优势-->
<div class="w-adg">
    <div class="w-title">
        <h2>云·SPACE的优势</h2>
    </div>
    <div class="w-adg-cont w-adg-cont1">
        <h3>平台优势</h3>
        <img src="img/winchance/adg_pt.jpg">
    </div>
    <div class="w-adg-cont w-adg-cont2">
        <h3 style="border-top:1px solid #e7e7e7">团队优势</h3>
        <img src="img/winchance/adg_pt.jpg">
    </div>
</div>

<!--合作活动-->
<div class="w-act">
    <div class="w-title">
        <h2>合作活动</h2>
    </div>
    {if $winchance_list}
        <div id="content">
            {include "Web_Mobile_Static::winchance/inc.list.tpl"}
        </div>
        <div class="load-more" style="cursor: pointer">加载中...</div>
    {/if}
</div>
{static "core/yunspace.js"}
{static "winchance/mobile_winchance.js"}
{include "Web_Static::v2.0/html_tj.tpl"}
</body>
</html>