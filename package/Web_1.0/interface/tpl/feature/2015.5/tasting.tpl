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
    <img src="img/party_02.jpg" alt="品鉴会超值套餐 ￥23999 起"/>
    <img src="img/party_03.jpg" alt="品鉴会超值套餐 ￥23999 起"/>
    <img src="img/party_04.jpg" alt="品鉴会超值套餐 ￥23999 起"/>
    <img src="img/party_05.jpg" alt="品鉴会超值套餐 ￥23999 起"/>
    <img src="img/party_06.jpg" alt="品鉴会超值套餐 ￥23999 起"/>
</div>
<div class="content_text">
    <p><img src="img/party_09.jpg" alt="月见花"/> </p>
    <p>VESPERTINE由国际顶尖设计师事务所GETTYS 主导设计，带给您“蒸汽朋克”的时尚秀感。</p>
    <p>
        <span>市场价：￥54900 </span>
        <span style="margin-right: 0px;">云·SPACE特价：</span>
        <span1 style="color: #ea9931">￥28999 </span1>
        <span>容纳人数：100~130人</span>
    </p>
    <p>
        <a href="http://www.yunspace.com.cn/set_info/14.html" type="button" target="_blank" class="btn1">点击查看详情</a>
        <img src="img/party_13.png" alt="5.2折" style="padding-bottom: 3px;"/>
    </p>
    <ul>
        <li><img src="img/party_17.jpg" alt="活动图片"/></li>
        <li><img src="img/party_19.jpg" alt="活动图片"/></li>
        <li><img src="img/party_21.jpg" alt="活动图片"/></li>
    </ul>
    <ul>
        <li><img src="img/party_25.jpg" alt="活动图片"/></li>
        <li><img src="img/party_27.jpg" alt="活动图片"/></li>
        <li><img src="img/party_29.jpg" alt="活动图片"/></li>
    </ul>
</div>
<div class="party_back">
    <div class="content_text">
        <p><img src="img/party_32.jpg" alt="奢居会"/> </p>
        <p style="color: #fff;">集视觉效果与舒适体验为一体的私人会所，个性化的至尊服务，奢居会将带您领略别具一格的英伦风情。</p>
        <p style="color: #fff;">
            <span>市场价：￥54900</span>
            <span style="margin-right: 0px;">云·SPACE特价：</span>
            <span1 style="color: #65dfd5;">￥40999 </span1>
            <span>容纳人数：100~130人</span>
        </p>
        <p>
            <a href="http://www.yunspace.com.cn/set_info/17.html" type="button" target="_blank" class="btn2">点击查看详情</a>
            <img src="img/party_36.png" alt="7.4折" style="padding-bottom: 3px;"/>
        </p>
        <ul>
            <li><img src="img/party_40.jpg" alt="活动图片"/></li>
            <li><img src="img/party_42.jpg" alt="活动图片"/></li>
            <li><img src="img/party_44.jpg" alt="活动图片"/></li>
            <li><img src="img/party_46.jpg" alt="活动图片"/></li>
        </ul>
        <ul>
            <li><img src="img/party_51.jpg" alt="活动图片"/></li>
            <li><img src="img/party_52.jpg" alt="活动图片"/></li>
            <li><img src="img/party_53.jpg" alt="活动图片"/></li>

        </ul>
    </div>
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