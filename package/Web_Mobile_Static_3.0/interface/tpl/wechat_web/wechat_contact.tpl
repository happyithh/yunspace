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
    <h2>联系我们</h2>
    <ul class="ul-contact-list">
        <li>公司官网：<a href="http://www.yunspace.com.cn">www.yunspace.com.cn</a></li>
        <li>公司官网：<a href="mailto:service@yunspace.com.cn">service@yunspace.com.cn</a></li>
        <li>服务热线：<a href="tel:400-056-0599">400-056-0599</a></li>
    </ul>

    <h2>公司地址</h2>
    <ul class="ul-contact-list">
        <li>上海公司：长宁区淮海西路570号红坊创意园F211<br/>
            TEL：021-62806053</li>
        <li>北京公司：朝阳区左家庄中街6号院9号楼豪成大厦20层2011室<br/>
            TEL：010-53505004</li>
        <li>深圳公司：宝安区龙华梅龙路特区1980产业园D栋一楼<br/>
            TEL：18126390971</li>
        <li>广州公司：天河区红专厂创意园F18-C松鼠窝<br/>
            TEL：020-66653016</li>
    </ul>
</div>

{include file="Web_Mobile_Static::inc/to_top.tpl"}
{static "core/yunspace.js"}
</body>
</html>

