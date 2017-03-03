<!DOCTYPE html>
<html lang="en">
<head>
    {*<title>一键找文创</title>*}
    {include file="Web_Mobile_Static::inc/header_meta.tpl"}
    <meta name="full-screen" content="yes" />
    <meta name="x5-fullscreen" content="true" />
    <meta name="x5-page-mode" content="app" />

    {static "wchuang/wchuang.css"}
</head>
<body yun="wchuang/wchuang.js::init">
{include "Web_Mobile_Static::v1.0/inc.nav.tpl"}
<div class="content">

    <div class="find">
        合作活动
    </div>
    <div class="banner4" >
        {if $winchance_list}
        <ul class="banner4-list" id="content">
            {foreach $winchance_list as $k=>$v }
            <li>
                <a href="{$_home}site/{$v['active_name']}-百科">
                    <div class="banner4-img">
                        <img src="{$v['cover_logo']}" alt="{$v['active_name']}">
                    </div>
                    <div class="bg-cover">
                        <p class="banner4-title">{$v['active_name']}</p>
                        <p class="banner4-des">
                            {$v['ip_des']}
                        </p>
                        <div class="bn-data">
                            <p><span>{$v['click']}</span></p>
                            <p><span>{$v['is_love']+$v['is_go']}</span></p>
                        </div>
                    </div>
                </a>
            </li>
            {/foreach}
            {*<li>*}
                {*<a href="javascript:;">*}
                    {*<div class="banner4-img">*}
                        {*<img src="img/wchuang/img-act.jpg" alt="">*}
                    {*</div>*}
                    {*<div class="bg-cover">*}
                        {*<p class="banner4-title">国际工业大秀场</p>*}
                        {*<p class="banner4-des">*}
                            {*多元化设计园区*}
                        {*</p>*}
                        {*<div class="bn-data">*}
                            {*<p><span>29836</span></p>*}
                            {*<p><span>74</span></p>*}
                        {*</div>*}
                    {*</div>*}
                {*</a>*}
            {*</li>*}
            {*<li>*}
                {*<a href="javascript:;">*}
                    {*<div class="banner4-img">*}
                        {*<img src="img/wchuang/img-act.jpg" alt="">*}
                    {*</div>*}
                    {*<div class="bg-cover">*}
                        {*<p class="banner4-title">国际工业大秀场</p>*}
                        {*<p class="banner4-des">*}
                            {*多元化设计园区*}
                        {*</p>*}
                        {*<div class="bn-data">*}
                            {*<p><span>29836</span></p>*}
                            {*<p><span>74</span></p>*}
                        {*</div>*}
                    {*</div>*}
                {*</a>*}
            {*</li>*}
        </ul>
        {/if}
    </div>

    <div class="load-more">加载中...</div>
</div>

{static "v1.0/jquery-1.11.1.min.js"}
{static "core/yunspace.js"}
{static "winchance.v2.0/mobile_winchance.js"}
</body>
</html>