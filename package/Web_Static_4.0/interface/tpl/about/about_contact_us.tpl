<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    {include file="Web_Static::inc/head_meta.tpl"}
    {static "v4.0/common.css"}
    {static "about/about.css"}
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
            <h2>联系我们</h2>
        </div>

        <ul class="about-contact clearfix">
            <li class="fl">
                <h5>●&nbsp;总部（上海）</h5>
                <p>地址：淮海西路570号红坊创意园F211（近民生美术馆）</p>
                <p>电话：400-056-0599</p>
                <p>邮箱：service@yunspace.com.cn</p>
            </li>
            <li class="fr">
                <h5>●&nbsp;北京</h5>
                <p>地址：朝阳区左家庄中街6号院9号楼豪成大厦20层2011室</p>
                <p>电话：400-056-0599</p>
                <p>邮箱：service@yunspace.com.cn</p>
            </li>
            <li class="fl">
                <h5>●&nbsp;广州</h5>
                <p>地址：天河区林和中路林和苑6栋4401室</p>
                <p>电话：400-056-0599</p>
                <p>邮箱：service@yunspace.com.cn</p>
            </li>
            <li class="fr">
                <h5>●&nbsp;深圳</h5>
                <p>地址：宝安区龙华梅龙路特区1980产业园D栋一楼</p>
                <p>电话：400-056-0599</p>
                <p>邮箱：service@yunspace.com.cn</p>
            </li>
            <li class="fl">
                <h5>●&nbsp;成都</h5>
                <p>地址：锦江区东御街18号百扬大厦11楼1111室</p>
                <p>电话：400-056-0599</p>
                <p>邮箱：service@yunspace.com.cn</p>
            </li>
        </ul>

    </div><!--about-content-end-->
</div><!--wrapper-end-->
{include file="Web_Static::inc/html_footer.tpl"}
{include file="Web_Static::inc/public_space.tpl"}
</body>

</html>