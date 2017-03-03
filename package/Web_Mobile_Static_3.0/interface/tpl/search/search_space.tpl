<!doctype html>
<html>
<head lang="en">
    {include "Web_Mobile_Static::v1.0/head_meta.tpl"}
    <link rel="stylesheet" href="plugins/ionicons-master/css/ionicons.css"/>
    <link href="css/search/list3.css" rel="stylesheet">
    {*<script src="js/v1.0/search.js"></script>*}
    {static "search/search.js"}
</head>
<body>
<div class="top search-style">
    {*<form action="?" method="post">*}
        <input type="hidden" name="searchtype" value="{Core::$urls['action']}">

        <div class="search">
            <div class="search_center">
                <span class="icon-search ion-ios-search-strong"></span>
                <input type="text" name="keyword" class="search-input" placeholder="搜索空间场地/商圈/地址等" id="searchBox">
            </div>
            <div id="index-cross" class="clear-cross ion-ios-close-empty"></div>
        </div>
        <div class="top_right">
            <a href="javascript:history.go(-1);">取消</a>
        </div>
    {*</form>*}
</div>
<div class="search-content padding-top50">
    {if count(getHotBaikeNameAsTags)>0}
        <div class="tags">
            {foreach $page->getHotBaikeNameAsTags as $k=>$v}
                <a class="tg" href="javascript:;">{$v['baike_name']}</a>
            {/foreach}
            {*<a class="tg" href="javascript:;">红坊</a>*}
            {*<a class="tg" href="javascript:;">人民大会堂</a>*}
            {*<a class="tg" href="javascript:;">国家会展中心国家会展中心国家会展中心</a>*}
            {*<a class="tg" href="javascript:;">人民大会堂</a>*}
            {*<a class="tg" href="javascript:;">国家会展中心</a>*}

        </div>
    {/if}
    <div class="search-history">
        <dl class="s-history">
            <dt class="clearfix">
            <h5 class="fl">搜索历史</h5>

            <p class="fr js-clearbtn"><span class="fl ion-ios-trash-outline"></span><a class="fl clearbtn"
                                                                                       href="javascript:;">清空历史记录</a>
            </p>
            </dt>
            <dd class="nonesearch hidden">暂无搜索记录</dd>
            <dd class="clearfix">
                <a class="clearfix" href="javascript:;">
                    <span class="fl ion-ios-clock-outline"></span>

                    <p>红坊</p>
                </a>
                <span class="fr js-clear-line ion-ios-close-empty"></span>
            </dd>
            <dd class="clearfix">
                <a class="clearfix" href="javascript:;">
                    <span class="fl ion-ios-clock-outline"></span>

                    <p>人民大会堂</p>
                </a>
                <span class="fr js-clear-line ion-ios-close-empty"></span>
            </dd>
            <dd class="clearfix">
                <a class="clearfix" href="javascript:;">
                    <span class="fl ion-ios-clock-outline"></span>

                    <p>国家会展中心</p>
                </a>
                <span class="fr js-clear-line ion-ios-close-empty"></span>
            </dd>
            <dd class="clearfix">
                <a class="clearfix" href="javascript:;">
                    <span class="fl ion-ios-clock-outline"></span>

                    <p>宝山秀场</p>
                </a>
                <span class="fr js-clear-line ion-ios-close-empty"></span>
            </dd>
        </dl>

        <!--搜索下拉提示-->
        <ul class="search-recommend hidden" data-url="{$_home}search/">
            <li class="clearfix">
                {*<a href="{$_home}search/space_name">*}
                    {*<p class="fl search-name"><span>搜索含 红坊 名称的</span><span class='orange'> 场地</span></p>*}
                    {*<span class='fr result name-result'>1个结果</span>*}
                {*</a>*}
            </li>

            <li class="clearfix">
                {*<a href="{$_home}search/address&keyword=">*}
                    {*<p class="fl search-addr"><span>搜索含 红坊 名称的</span><span class="orange"> 地址</span></p>*}
                    {*<span class="fr result addr-result">0个结果</span>*}
                {*</a>*}
            </li>
        </ul>
        <div class="rent-btn-wrap">
            <a href="{$_home}inquiry" class="rent-btn">一键租场地</a>

            <p>提交你的活动需求<br>快速匹配适合您的场地</p>
        </div>
    </div>
</div>

<!--热门场地推荐-->
<div class="hot-space">
    <div class="hot-space-title">
        <h5>热门场地</h5>
    </div>
    {if count($page->getHotBaikeDetail)}
        <ul class="hot-space-list">
            {foreach $page->getHotBaikeDetail as $k=>$v}
                <li>
                    <a class="clearfix" href="{$_home}site/{Func_Url::str_urlencode({$v['baike_name']})}">
                        <div class="fl list-item-left">
                            <img src="{Page_Site_Global::displayMedia($v['baike_logo'],150,113)}">
                        </div>
                        <div class="fl list-item-right">
                            <p class="name">{$v['baike_name']}</p>

                            <p class="address">{$v['addr']}</p>

                            <p class="price">面积：{if !empty($v['baike_size'])}{$v['baike_size']}m²{else}暂无{/if}</p>
                        </div>
                    </a>
                </li>
            {/foreach}
        </ul>
    {/if}
</div>
{include "Web_Static::v2.0/html_tj.tpl"}
</body>
{static "core/yunspace.js"}
</html>
