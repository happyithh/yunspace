{*<!DOCTYPE html>*}
{*<html lang="en">*}
{*<head>*}
    {*{include file="Web_Mobile_Static::inc/header_meta.tpl"}*}
{*</head>*}
{*<body yun="search_about/search_about.js::init">*}
<div>
    <!--搜索栏-->
    <div class="search-tool-wrap">
        <div class="fl search-tool">
            <input class="search-text-fill" type="text" placeholder="地标/用途/空间名称" id="suggestId">
            <i class="delt" id="index-cross"></i>
        </div>
        <p class="fr search-cancel">关闭</p>
    </div>
</div>



<!--搜索下拉列表-->
{include "Web_Mobile_Static::search_about/inc/inc_search_list.tpl"}

<!--搜索定位内容-->
{include "Web_Mobile_Static::search_about/inc/inc_search_cont.tpl"}

{*{static "v1.0/jquery-1.11.1.min.js"}*}
{*</body>*}
{*</html>*}