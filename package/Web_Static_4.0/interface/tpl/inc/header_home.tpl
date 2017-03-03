{static "v4.0/code.css"}
<div class="top-luc">
    <div class="header-bg"></div>
    <div class="wrapper header">
        <nav class="clearfix nav">
            <a class="logo" href="{$_home}"><img src="img/logo_0520.png" alt="云SPACE"/></a>
            <ul class="nav-list clearfix fl">
                {*<li class="logo"></li>*}
                <li><a href="{$_home}">首页</a></li>
                <li class="more-hover active">
                    <!--<a href="{$_home}sites/112">空间</a>-->
                    <a href="{$_home}space_library" class="show-more">空间</a>
                    <ul class="header-more-list">
                        <li><a href="{$_home}space_library">场地库</a></li>
                        <li><a href="{$_home}map2">场地地图</a></li>
                        <li><a href="{$_home}article_list/112.html" style="border:0px;">空间资讯</a></li>
                    </ul>
                </li>
                <li class="more-hover">
                    <!--<a href="{$_home}sites/200">文创</a>-->
                    <a href="{$_home}winchance" class="show-more">文创</a>
                    <ul class="header-more-list">
                        <li><a href="{$_home}winchance">项目库</a></li>
                        <li><a href="{$_home}article_list/200.html" style="border:0px;">文创资讯</a></li>
                    </ul>
                </li>
                <li  class="more-hover">
                    <a href="{$_home}retail" class="show-more  {if $nav=='retail'}active{/if}">零售</a>
                    <ul class="header-more-list " style="top:100%">
                        <li><a {if $nav=='retail'}class="hover-active"{/if} href="{$_home}retail">零售短租</a></li>
                        <li><a {if $page->getType==400}class="hover-active"{/if} href="{$_home}article_list/400.html">零售资讯</a></li>
                    </ul>
                </li>
                <!--<li><a href="{$_home}sites/400">资讯</a></li>-->
                <li><a href="{$_home}sites/300">发现</a></li>
                {*<li><a href="{$_home}database/site">场地库</a></li>*}
                <!--<li><a href="{Web_Global::createRentSpaceUrl()}">场地库</a></li>-->
                <!--<li><a href="{$_home}winchance">项目库</a></li>-->
                {*<li><a href="{$_home}database/company">公司库</a></li>*}
                <li><a href="{$_home}article_list/index.html">文库</a></li>
                <li><a href="{$_home}topic_list">专题</a></li>
                <!--<li><a href="{$_home}map2" class="hot">场地地图</a></li>-->

                <li><a href="#">|</a></li>
                <li><a href="{$_root}site_join">场地加盟</a></li>
                {*<li><a href="http://d15.yunspace.com.cn/feature/2015.9/join/index.html">代理商加盟</a></li>*}
                <li><a href="{$_home}city_painter">城市运营商</a></li>
                <li><a href="{$_root}yunspace/about_us">关于我们</a></li>
                <li><a href="#"  yun="inc.v4.0/header.js::showCode@click" yun-id="0">移动版</a></li>
                <li><a href="#"  yun="inc.v4.0/header.js::showCode@click" yun-id="1">公众号</a></li>
                <li><a href="#"  yun="inc.v4.0/header.js::showCode@click" yun-id="2">App</a></li>
            </ul>
            <ul class="nav-list clearfix fr">
                <li><a style="color:#fff;">服务热线：400-056-0599</a></li>
                {*<li><a href="javascript:;"   class="yun-icon icon-2 login_user" id="login_user">登录/注册</a></li>*}
            </ul>
        </nav>
        <a href="{$_root}index_2015" class="old-web">
            <img src="img/home/back_old.png" alt="">
        </a>
    </div>
</div>
{include file="Web_Static::inc/header_qrcode.tpl"}
