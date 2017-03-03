<!DOCTYPE html>
<html lang="en">
<head>
    <meta name=”viewport” content=”width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0,
          user-scalable=no”/>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no,minimal-ui" name="viewport"/>
    <meta name="apple-mobile-web-app-capable" content="yes"/>
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta content="telephone=no" name="format-detection"/>
    <meta name="full-screen" content="yes"/>
    <meta name="browsermode" content="application"/>
    <meta name="x5-orientation" content="portrait"/>
    <meta name="x5-fullscreen" content="true"/>
    <meta name="x5-page-mode" content="app"/>
    {static "index.v3.0/index.css"}
    {include file="Web_Mobile_Static::inc/header_meta.tpl"}
    {static "v3.0/loading.css"}
    {static "v3.0/font-awesome.min.css"}
    {static "v1.0/jquery-1.11.1.min.js"}
    {static "sites/sites.js"}
    <!--<link rel="stylesheet" href="plugins/ionicons-master/css/ionicons.min.css">-->
</head>
<body>
{include "Web_Mobile_Static::v1.0/inc.nav.tpl"}
<div yun="hide-app/hide-app.js::init" src=""></div>
<header class="header">
    <a href="{$_root}m/" class="back"><span class="fa fa-chevron-left"></span></a>
    <div class="title">{$page->seo['网页标题']}</div>
</header>
<div class="banner4" style="margin-top:44px;">
    <ul class="banner4-list">
        {foreach $page->getBaikeList['rows'] as $k=>$v}
            <li>
                <a href="{$_home}site/{Func_Url::str_urlencode($v['space_name'])}">
                    <div class="banner4-img">
                        {if !empty($v['mobile_logo'])}
                            <img src="{Page_Site_Global::displayMedia($v['mobile_logo'],640,424)}" alt="">
                        {else}
                            <img src="{Page_Site_Global::displayMedia($v['logo'],640,424)}" alt="">
                        {/if}
                    </div>
                    <div class="bg-cover">
                        <p class="banner4-title">{$v['space_name']}</p>

                        <p class="banner4-des">
                            {if !empty($v['attr']['营销标题'])}
                                {$v['attr']['营销标题']}
                            {elseif !empty($v['addr'])}
                                {$v['addr']}
                            {else}
                                ......
                            {/if}
                        </p>

                        <div class="bn-data">
                            <p><span>{$v['click']}</span></p>

                            <p><span>{$v['is_go']}</span></p>
                        </div>
                    </div>
                </a>
            </li>
        {/foreach}
    </ul>
</div>
<footer class="load-more-article" id="load-more-article" data-category-id="{$page->getType}">
    {if count($page->getBaikeList['rows'])<9}
        已加载全部
   {else}
        <div class="loading">
            {include file="Web_Mobile_Static::inc/loading.tpl"}
        </div>
    {/if}

</footer>
<div id="clone-img" data-href="{$_home}site/" class="none">
    <li>
        <a href="">
                <div class="banner4-img">
                    <img src="" alt="">
                </div>
                <div class="bg-cover">
                    <p class="banner4-title"></p>

                    <p class="banner4-des">
                    </p>

                    <div class="bn-data">
                        <p><span></span></p>
                        <p><span></span></p>
                    </div>
                </div>
        </a>
    </li>
</div>
{static "core/yunspace.js"}
</body>
</html>