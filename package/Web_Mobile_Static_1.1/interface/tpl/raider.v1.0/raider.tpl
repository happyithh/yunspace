<!doctype html>
<html>
<head>
    {include "Web_Mobile_Static::v1.0/head_meta.tpl"}
    {include "Web_Mobile_Static::service.v1.0/inc.head_service.tpl"}
    <link rel="stylesheet" href="css/raider.v1.0/raider.css"/>
</head>
<body data-url="{$_home}service/get_list_for_mobile">

{*top*}
<div class="top">
    <div class="top_left">
        <a href="{$_home}"><i class="ion-ios-arrow-back"></i></a>
    </div>
    <div class="top-title">活动攻略</div>
    <div class="top_right">
        <a href="{$_home}search/service"><i class="ion-ios-search-strong"></i></a>
    </div>
</div>

{*guide*}
<div class="guide_m_raider">
  <ul>
    <li><a href="#" class="guide_m_raider_active"> 全部</a></li>
    <li><a href="#">活动方案</a></li>
    <li><a href="#">经典案例</a></li>
    <li><a href="#">经验分享</a></li>
    <li><a href="#">精选专题</a></li>
  </ul>
</div>

<script>
    $(document).ready(function () {
        $('.guide_m_raider a').click(function () {
            $('.guide_m_raider a').removeClass('guide_m_raider_active');
            $(this).addClass('guide_m_raider_active');
        });
    });
</script>


{include file="Web_Mobile_Static::raider.v1.0/inc/raider_list.tpl"}



<div id="topcontrol" class="" title="Scroll Back to Top">
    <img src="img/v1.0/up.png">
</div>
{include "Web_Static::v2.0/html_tj.tpl"}
</body>
</html>