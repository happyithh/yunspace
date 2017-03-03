<!DOCTYPE html>
<html>
<head>
    <script type='text/javascript'>
        function uaredirect(murl){
            try {
                if(document.getElementById("bdmark") != null){
                    return;
                }
                var urlhash = window.location.hash;
                if (!urlhash.match("fromapp")){
                    if ((navigator.userAgent.match(/(iPhone|iPod|Android|ios|iPad)/i))) {
                        location.replace(murl);
                    }
                }
            } catch(err){ }
        }
        uaredirect('http://www.yunspace.com.cn/feature_mobile/2015.5/tasting/index.html');
    </script>
    {include file="inc/html_head.tpl" owl=1}
    <link href="css/pr.css" type="text/css" rel="stylesheet">
</head>
<body>
{include 'inc/header_nav.tpl'}

<div class="party_head">
    <img src="images1/hy1.jpg" alt="会议逼格，你享我有！"/>
    <img src="images1/hy2.jpg" alt="会议逼格，你享我有！"/>
    <img src="images1/hy3.jpg" alt="会议逼格，你享我有！"/>
    <img src="images1/hy4.jpg" alt="会议逼格，你享我有！"/>
</div>
<div class="content_text">
    <p><img src="images1/hyt1.png" alt="云SPACE"/> </p>
    <p>以商务办公，创意创业，现代产业园为主体，区域内商业的时尚汇聚地和潮流风向标业态满足目标客户需求的，更丰富贴切的吸引更多的品牌概念客户在项目中形成集聚效应。</p>
    <p>
        <span>市场价：￥7200 </span>
        <span style="margin-right: 0px;">云·SPACE特价：</span>
        <span1 style="color: #4da6f1">￥6199 </span1>
        <span>容纳人数：200人</span>
    </p>
    <p>
        <a href="http://www.yunspace.com.cn/set_info/25.html" type="button" target="_blank" class="btn11">点击查看详情</a>
        <img src="images1/hyz1.png" alt="8.6折" style="padding-bottom: 3px;"/>
    </p>
    <p> <img src="images1/hyp1.jpg" alt="会议逼格，你享我有！"/></p>
</div>
<div class="party_back" style="background: #f7f7f7;">
    <div class="content_text">
        <p><img src="images1/hyt2.png" alt="智造局"/> </p>
        <p>园区建设取材上海二、三十年代盛行的ART-DECO 风格，采用深色砖面，并通过对整个园区商务功能和建筑布局的科学区分，形成特色鲜明的“街区式”建筑群，构建错落有致的里弄空间，延续海派文化传承.</p>
        <p>
            <span>市场价：￥22200</span>
            <span style="margin-right: 0px;">云·SPACE特价：</span>
            <span1 style="color: #756f9f;">￥18999 </span1>
            <span>容纳人数：80人</span>
        </p>
        <p>
            <a href="http://www.yunspace.com.cn/set_info/23.html" type="button" target="_blank" class="btn12">点击查看详情</a>
            <img src="images1/hyz2.png" alt="8.5折" style="padding-bottom: 3px;"/>
        </p>
        <p> <img src="images1/hyp2.jpg" alt="会议逼格，你享我有！"/></p>
    </div>
</div>

<div class="content_text">
    <p><img src="images1/hyt3.png" alt="云SPACE"/> </p>
    <p>融合多元文化与风格精髓的LAVIN玫瑰里已经酝酿成高端婚礼殿堂，浪漫的花海，充满自然气息的森林，设计经典的法式宫廷，360度全透明的婚礼仪式堂，法式长廊设计的宴会厅，时尚温馨的化妆间，以及专门设计的试餐餐厅，空间布局和景观设计兼顾浪漫与庄严，传统与现代，开放与私密，整体与细节淋漓尽致感受在Lavin玫瑰里。</p>
    <p>
        <span>市场价：￥88200 </span>
        <span style="margin-right: 0px;">云·SPACE特价：</span>
        <span1 style="color: #e1135e">￥63999 </span1>
        <span>容纳人数：400人</span>
    </p>
    <p>
        <a href="http://www.yunspace.com.cn/set_info/22.html" type="button" target="_blank" class="btn13">点击查看详情</a>
        <img src="images1/hyz3.png" alt="7.2折" style="padding-bottom: 3px;"/>
    </p>
    <p> <img src="images1/hyp3.jpg" alt="会议逼格，你享我有！"/></p>
</div>


{*<div class="video">*}
    {*<div class="video_content">*}
        {*<p>套餐案例展示<span>（仅供参考）</span></p>*}
        {*<p1 style="color:#ffffff">保时捷杭州十周年庆典</p1>*}
        {*<div class="embed-responsive embed-responsive-16by9">*}
            {*<video src="/upload/video/tasting.m4v"  type="video/mp4" width="1000" id="video1" onclick="playPause()" poster="{$_assets}images/sp1.jpg">*}
                {*对不起，您的浏览器不支持！！*}
            {*</video>*}
        {*</div>*}
    {*</div>*}
{*</div>*}

{*<script>*}
    {*var myVideo=document.getElementById("video1");*}

    {*function playPause()*}
    {*{*}
        {*if (myVideo.paused)*}
            {*myVideo.play();*}
        {*else*}
            {*myVideo.pause();*}
    {*}*}
{*</script>*}


{include file="inc/html_footer.tpl"}
</body>
</html>