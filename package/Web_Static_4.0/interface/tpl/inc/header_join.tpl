{static "v4.0/code.css"}
<ul class="nav-list clearfix fl">
    <li><a href="http://www.yunspace.com.cn">首页</a></li>
    <li class="more-hover">
        <a href="javascript:;" class="show-more  {if $page->getType==112 || $nav=='space_library' || Core::$urls['path']=='/map2'}active{/if}">空间</a>
        <ul class="header-more-list bg-blue" style="top:100%">
            <li><a {if $nav=='space_library'}class="hover-active"{/if} href="{$_home}space_library">场地库</a></li>
            <li><a {if Core::$urls['path']=='/map2'}class="hover-active"{/if} href="{$_home}map2">场地地图</a></li>
            <li><a {if $page->getType==112}class="hover-active"{/if} href="{$_home}sites/112" style="border:0px !important;">空间资讯</a></li>
        </ul>
    </li>
    <li class="more-hover">
        <a href="javascript:;" class="show-more  {if $page->getType==200 ||  $nav=='winchance' || $page->getType==200}active{/if}">文创</a>
        <ul class="header-more-list bg-blue" style="top:100%">
            <li><a {if $nav=='winchance'}class="hover-active"{/if} href="{$_home}winchance">项目库</a></li>
            <li><a {if $page->getType==200}class="hover-active"{/if} href="{$_home}sites/200" style="border:0px !important;">文创资讯</a></li>
        </ul>
    </li>
    <li {if $page->getType==400}class="active"{/if}><a href="{$_home}sites/400">行业</a></li>
    <li class="{if $page->getType==300}active{/if}"><a href="{$_home}sites/300">发现</a></li>
    <li class="{if $nav=='paper'}active{/if}"><a href="{$_home}database/paper">文库</a></li>
    <li><a href="#">|</a></li>
    <li class="{if Core::$urls['path']=='/article/3124147.html'}active{/if}"><a href="{$_root}site_join">场地出租</a></li>
    {*<li><a href="http://d15.yunspace.com.cn/feature/2015.9/join/index.html">代理商加盟</a></li>*}
    <li class="{if $nav=='join'}active{/if}"><a href="{$_home}join/index">城市合伙人</a></li>
    <li><a href="{$_root}yunspace/about_us">关于我们</a></li>
    <li><a href="javascript:;" yun="inc.v4.0/header.js::showCode@click" yun-id="0">移动版</a></li>
    <li><a href="javascript:;" yun="inc.v4.0/header.js::showCode@click" yun-id="1">公众号</a></li>
    <li><a href="javascript:;" yun="inc.v4.0/header.js::showCode@click" yun-id="2">App</a></li>
</ul>
<ul class="nav-list clearfix fr">
    <li><a href="{Web_Global::createRentSpaceUrl()}" class="yun-icon icon-1">一键租场地</a></li>
    <li><a href="javascript:;" class="yun-icon icon-2 login_user" id="login_user" >登录/注册</a></li>
</ul>
{include file="Web_Static::inc/header_qrcode.tpl"}