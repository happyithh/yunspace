{*{var_dump($page->info)}*}
<!DOCTYPE>
<html>
<head>
    {*{include file="Web_Static::v4.0/html_goto_pc.tpl" url="m/wechat_article"}*}
    {include file="Web_Mobile_Static::inc/header_meta.tpl"}
    <meta name="viewport" content="width=device-width" />
    <meta name="full-screen" content="yes" /><!-- UC强制全屏 -->
    <meta name="x5-fullscreen" content="true" /><!-- QQ强制全屏 -->
    {static "wechat_web/wechat_web.css"}
    <link href="http://vjs.zencdn.net/5.10.4/video-js.css" rel="stylesheet">
</head>
<body>
<div class="wechat-cont-text">
    <h2>企业介绍</h2>
    <p>云SPACE(www.yunspace.com.cn)隶属于上海星期网络科技有限公司，成立于2012年3月，是国内首家集空间场地、文创IP、零售短租的展示、管理、交易为一体的商业空间服务平台，提供从活动空间到活动内容的综合解决方案。</p>
    <p>公司总部位于上海，在北京、广州、深圳、成都等主要城市设立分支机构。平台上线场地<span class="red">5</span>万家，覆盖13种不同类型的空间，遍及<span class="red">24</span>个城市、同时拥有近<span class="red">300</span>个IP项目、<span class="red">1,000</span>多家零售品牌资源。</p>
    <img src="img/wechat_web/img-intro.jpg" alt="图片">

    <h2>企业视频</h2>
    <div style="position: relative">
        <video id="my-video" class="video-js" controls preload="auto" width="100%" height="auto"
               poster="/package/Web_Static_4.0/interface/assets/img/about/a.png" data-setup="{}">
            <source src="http://s2.yunspace.com.cn/yunspace-2016.mp4" type='video/mp4'>
            <!-- <source src="MY_VIDEO.webm" type='video/webm'> -->
            <p class="vjs-no-js">
                To view this video please enable JavaScript, and consider upgrading to a web browser that
                <a href="http://videojs.com/html5-video-support/" target="_blank">supports HTML5 video</a>
            </p>
        </video>
    </div>
</div>

{include file="Web_Mobile_Static::inc/to_top.tpl"}
{static "core/yunspace.js"}
</body>
</html>

