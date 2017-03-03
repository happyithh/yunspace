<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    {include file="Web_Static::inc/head_meta.tpl"}
    {static "v4.0/common.css"}
    {static "about/about.css"}
    <link href="http://vjs.zencdn.net/5.10.4/video-js.css" rel="stylesheet">
    <!-- If you'd like to support IE8 -->
    <script src="http://vjs.zencdn.net/ie8/1.1.2/videojs-ie8.min.js"></script>
</head>
<body>
{include file="Web_Static::inc/header_1.tpl"}
<div class="about-location">
    <div class="wrapper">
        <div class="crumb">
            <a href="{$_home}">首页</a>&gt;<a href="{$_root}about" class="active">关于我们</a>
        </div>
    </div>
</div>
<div class="about_banner"></div>
<div class="wrapper about-wrapper clearfix">
    {include file="Web_Static::about/inc/left_nav.tpl"}

    <div class="about-content fr">
        <div class="about-title">
            <h2>云SPACE介绍</h2>
        </div>
        <div style="position: relative">
            <video id="my-video" class="video-js" controls preload="auto" width="830" height="466.8"
                   poster="/package/Web_Static_4.0/interface/assets/img/about/a.png" data-setup="{}">
                <source src="http://s2.yunspace.com.cn/yunspace-2016.mp4" type='video/mp4'>
                <!-- <source src="MY_VIDEO.webm" type='video/webm'> -->
                <p class="vjs-no-js">
                    To view this video please enable JavaScript, and consider upgrading to a web browser that
                    <a href="http://videojs.com/html5-video-support/" target="_blank">supports HTML5 video</a>
                </p>
            </video>

            <script src="http://vjs.zencdn.net/5.10.4/video.js"></script>
        </div>
        <h5>●&nbsp;公司简介</h5>
        <p>云 space（www.yunspace.com.cn) 隶属于上海星期网络科技有限公司，成立于2012年3月，是国内首家集场地、文创IP项目的展示、管理、交易为一体的商业空间服务平台，提供从活动空间到活动内容的综合解决方案。公司总部位于上海，在北京、广州、深圳、成都等主要城市设立分支机构。截至2016年5月，公司在长沙、厦门、武汉、昆明等15个区域设立了城市合伙人，平台上线场地近5万家，覆盖全国24个城市。</p>
        <p>了解更多云SPACE相关信息请下载详细介绍文档</p>
        <a class="about-download" href="{$___urls["assets"]}js/about/aboutus2016.pdf" target="_blank">下载云SPACE公司介绍PDF<span>↓</span></a><br>
        <a class="about-download" href="{$___urls["assets"]}js/about/ysp_brief_2016.pdf" target="_blank">Download 2016 YUN SPACE Brief<span>↓</span></a>


        <div class="about-title">
            <h2>公司愿景</h2>
        </div>
        <p>成为中国领先的商业空间短租平台</p>
        <p>&nbsp;</p>

        <div class="about-title">
            <h2>公司大事记</h2>
        </div>
        <div class="memorabilia">
            <p>2012年03月 —— www.yunspace.com.cn 官网上线，首次上线500家场地</p>
            <p>2013年03月 —— 第一个自运营场地——【云SPACE大宁秀场】开业</p>
            <p>2014年05月 —— 北京、深圳、广州、成都分站陆续成立</p>
            <p>2014年07月 —— 【云SPAC大宁秀场】承办Chanel秋冬时装高定会，从此成为众多国际品牌青睐的秀场</p>
            <p>2014年11月 —— 获得上海市促进文化创意产业扶持资金；微信订阅号获得腾讯【微信大赛公众号评选100强】</p>
            <p>2014年12月 —— 完成第一轮融资</p>
            <p>2015年03月 —— 云SPACE微信订阅用户突破10万</p>
            <p>2015年10月 —— 第二个自运营场地 ——【云SPACE宝山秀场】开业；微信订阅号获得【2015 上海设计之都活动周优秀合作媒体】奖
            </p>
            <p>2015年11月 —— 【云SPACE宝山秀场】成为国内第一个成功的大型秀场众筹项目，募得资金近74万，超过众酬目标8.68%</p>
            <p>2015年12月 —— 平台订单交易价值70亿 ，同比增长794%，每季度以300%的速度递增</p>
            <p>2016年01月 —— 新版网站上线，上线场地达50000家，首发行业第一个场地指数；文创IP频道上线，旨在为国内商业空间引进全球优质的文创内容，打造更丰富的消费场景</p>
            <p>2016年04月 —— 首届云SPACE文创体验日在环球港落幕，当天众多云SPACE粉丝和媒体体验了平台上线项目——魔法美术馆与移动迷宫</p>
            <p>2016年05月 —— 5月20日，第三代标识和标语启用，新标识更简洁、实用、国际化及倡导服务精神，新标语 “商业空间短租平台”体现了公司核心价值；第三个自运营项目——【云SPACE国际工业秀场】正式启用；零售短租频道上线，为全球零售品牌实现全国落地</p>
        </div>


        <div class="about-title">
            <h2>公众平台</h2>
        </div>
        <ul class="about-qrcode clearfix">
            <li>
                <img src="img/about/qrcode1.jpg">
                <p>云SPACE移动版</p>
            </li>
            <li>
                <img src="img/qrcode_info.png">
                <p>微信订阅号<br>关注活动资讯</p>
            </li>
            <li>
                <img src="img/qrcode_space.png">
                <p>微信服务号<br>关注场地资源</p>
            </li>
            {*<li>*}
                {*<img src="img/about/qrcode4.jpg">*}
                {*<p>商业空间短租平台<br>一键租场地</p>*}
            {*</li>*}
            <li>
                <img src="img/ygj_new.png" height="100" width="100">
                <p>云SPACE场地大师<br>空间场地管理App</p>
            </li>
        </ul>
    </div><!--about-content-end-->
</div><!--wrapper-end-->
{include file="Web_Static::inc/html_footer.tpl"}
{include file="Web_Static::inc/public_space.tpl"}
</body>

</html>