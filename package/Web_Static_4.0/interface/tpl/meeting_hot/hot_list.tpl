<!doctype html>
<html lang="en">
<head>
    {include file="Web_Static::meeting-hot/hot_header.tpl"}
</head>
<body>
{include file="Web_Static::inc/header_1.tpl"}
<div class="banner">
    <img class="hidden-xs" src="img/meeting/hot-item/banner-big.jpg">
    <img class="visible-xs" src="img/meeting/hot-item/banner-sm.jpg">
</div>
<div class="banenr-bar">
    <img src="img/meeting/hot-item/ggbar.jpg">
</div>

<!--特色/创意空间-->
<div class="banner" id="tese">
    <img class="hidden-xs" src="img/meeting/hot-item/tesebanner-big.jpg">
    <img class="visible-xs" src="img/meeting/hot-item/tesebanner-sm.jpg">
</div>
<div class="container">
    <ul class="spacelist clearfix">
        <li class="explan col-md-4 col-xs-12">
            <div class="explan-title display-center">特色空间</div>
            <div class="explan-cont">
                <p>特色小型空间，适合小型公司的年会空间；</p>
                <p>不仅场地特色有料，吃喝玩乐内容全覆盖；</p>
                <p>年会就要这么high翻天</p>
            </div>
        </li>
        {foreach $page->getTeSeList as $k=>$v}
            <li class="col-md-4 col-sm-6 col-xs-12">
                <h5><a href="{$_home}meeting_hot_details/{Func_NumEncode::e($v['id']+100)}.html" target="_blank">{if $v['space_name']!=$v['item_name']}{$v['space_name']}--{$v['item_name']}{else}{$v['space_name']}{/if}</a></h5>
                <div class="text">{$v['space_info']}</div>
                <a href="{$_home}meeting_hot_details/{Func_NumEncode::e($v['id']+100)}.html"  target="_blank" class="img"><img src="{$v['list_img']}"></a>
                <div class="pricecont clearfix">
                    <div class="fl left">
                        <p class="dis-price">¥ <strong>{$v['new_price']}</strong>元／天 <span>起</span></p>
                        <p class="price">¥ {$v['old_price']} 元／天</p>
                        <p class="expl">{$v['remarks']}</p>
                    </div>
                    <a href="javascript:" class="fr btn-shopping js-showform" data-id="{$v['id']}" data-space_name="{$v['space_name']}-{$v['item_name']}"></a>
                </div>
            </li>
        {/foreach}
        {*<li class="col-md-4 col-sm-6 col-xs-12">*}
            {*<h5>Sigma</h5>*}
            {*<div class="text">上海第一家“电影会所”，拥有一个“小型电影院”和一个“数码播放厅”。</div>*}
            {*<div class="img"><img src="img/meeting/hot-item/banner-sm.jpg"></div>*}
            {*<div class="pricecont clearfix">*}
                {*<div class="fl left">*}
                    {*<p class="dis-price">¥ <strong>60000</strong>元／天 <span>起</span></p>*}
                    {*<p class="price">¥ 140000 元／天</p>*}
                    {*<p class="expl">免服务费（含税）</p>*}
                {*</div>*}
                {*<a href="javascript:" class="fr btn-shopping"></a>*}
            {*</div>*}
        {*</li>*}
        {*<li class="col-md-4 col-sm-6 col-xs-12">*}
            {*<h5>Sigma</h5>*}
            {*<div class="text">上海第一家“电影会所”，拥有一个“小型电影院”和一个“数码播放厅”。</div>*}
            {*<div class="img"><img src="img/meeting/hot-item/banner-sm.jpg"></div>*}
            {*<div class="pricecont clearfix">*}
                {*<div class="fl left">*}
                    {*<p class="dis-price">¥ <strong>60000</strong>元／天 <span>起</span></p>*}
                    {*<p class="price">¥ 140000 元／天</p>*}
                    {*<p class="expl">免服务费（含税）</p>*}
                {*</div>*}
                {*<a href="javascript:" class="fr btn-shopping"></a>*}
            {*</div>*}
        {*</li>*}
        {*<li class="col-md-4 col-sm-6 col-xs-12">*}
            {*<h5>Sigma</h5>*}
            {*<div class="text">上海第一家“电影会所”，拥有一个“小型电影院”和一个“数码播放厅”。</div>*}
            {*<div class="img"><img src="img/meeting/hot-item/banner-sm.jpg"></div>*}
            {*<div class="pricecont clearfix">*}
                {*<div class="fl left">*}
                    {*<p class="dis-price">¥ <strong>60000</strong>元／天 <span>起</span></p>*}
                    {*<p class="price">¥ 140000 元／天</p>*}
                    {*<p class="expl">免服务费（含税）</p>*}
                {*</div>*}
                {*<a href="javascript:" class="fr btn-shopping"></a>*}
            {*</div>*}
        {*</li>*}
        {*<li class="col-md-4 col-sm-6 col-xs-12">*}
            {*<h5>Sigma</h5>*}
            {*<div class="text">上海第一家“电影会所”，拥有一个“小型电影院”和一个“数码播放厅”。</div>*}
            {*<div class="img"><img src="img/meeting/hot-item/banner-sm.jpg"></div>*}
            {*<div class="pricecont clearfix">*}
                {*<div class="fl left">*}
                    {*<p class="dis-price">¥ <strong>60000</strong>元／天 <span>起</span></p>*}
                    {*<p class="price">¥ 140000 元／天</p>*}
                    {*<p class="expl">免服务费（含税）</p>*}
                {*</div>*}
                {*<a href="javascript:" class="fr btn-shopping"></a>*}
            {*</div>*}
        {*</li>*}
    </ul>
</div>


<!--大型空间-->
<div class="banner" id="big">
    <img class="hidden-xs" src="img/meeting/hot-item/bigbanner-big.jpg">
    <img class="visible-xs" src="img/meeting/hot-item/bigbanner-sm.jpg">
</div>
<div class="container">
    <ul class="spacelist clearfix">
        <li class="explan col-md-4 col-xs-12">
            <div class="explan-title display-center">大型空间</div>
            <div class="explan-cont big-explan-cont">
                <p>3000平以上超大年会空间，上海地标区域展览馆；</p>
                <p>自由搭建，随心策划，大气震撼；</p>
                <p>金融科技、医药快消、互联网游戏等首选</p>
            </div>
        </li>
        {foreach $page->getLargeScaleList as $k=>$v}
            <li class="col-md-4 col-sm-6 col-xs-12">
                <h5><a href="{$_home}meeting_hot_details/{Func_NumEncode::e($v['id']+100)}.html" target="_blank">{if $v['space_name']!=$v['item_name']}{$v['space_name']}--{$v['item_name']}{else}{$v['space_name']}{/if}</a></h5>
                <div class="text">{$v['space_info']}</div>
                <a href="{$_home}meeting_hot_details/{Func_NumEncode::e($v['id']+100)}.html"  target="_blank" class="img"><img src="{$v['list_img']}"></a>
                <div class="pricecont clearfix">
                    <div class="fl left">
                        <p class="dis-price">¥ <strong>{$v['new_price']}</strong>元／天 <span>起</span></p>
                        <p class="price">¥ {$v['old_price']} 元／天</p>
                        <p class="expl">{$v['remarks']}</p>
                    </div>
                    <a href="javascript:" class="fr btn-shopping js-showform" data-id="{$v['id']}" data-space_name="{$v['space_name']}-{$v['item_name']}"></a>
                </div>
            </li>
        {/foreach}
        {*<li class="col-md-4 col-sm-6 col-xs-12">*}
            {*<h5>墨西哥艺术中心-大厅</h5>*}
            {*<div class="text">上海第一家“电影会所”，拥有一个“小型电影院”和一个“数码播放厅”。</div>*}
            {*<div class="img"><img src="img/meeting/hot-item/banner-sm.jpg"></div>*}
            {*<div class="pricecont clearfix">*}
                {*<div class="fl left">*}
                    {*<p class="dis-price">¥ <strong>60000</strong>元／天 <span>起</span></p>*}
                    {*<p class="price">¥ 140000 元／天</p>*}
                    {*<p class="expl">免服务费（含税）</p>*}
                {*</div>*}
                {*<a href="javascript:" class="fr btn-shopping"></a>*}
            {*</div>*}
        {*</li>*}
        {*<li class="col-md-4 col-sm-6 col-xs-12">*}
            {*<h5>Sigma</h5>*}
            {*<div class="text">上海第一家“电影会所”，拥有一个“小型电影院”和一个“数码播放厅”。</div>*}
            {*<div class="img"><img src="img/meeting/hot-item/banner-sm.jpg"></div>*}
            {*<div class="pricecont clearfix">*}
                {*<div class="fl left">*}
                    {*<p class="dis-price">¥ <strong>60000</strong>元／天 <span>起</span></p>*}
                    {*<p class="price">¥ 140000 元／天</p>*}
                    {*<p class="expl">免服务费（含税）</p>*}
                {*</div>*}
                {*<a href="javascript:" class="fr btn-shopping"></a>*}
            {*</div>*}
        {*</li>*}
        {*<li class="col-md-4 col-sm-6 col-xs-12">*}
            {*<h5>Sigma</h5>*}
            {*<div class="text">上海第一家“电影会所”，拥有一个“小型电影院”和一个“数码播放厅”。</div>*}
            {*<div class="img"><img src="img/meeting/hot-item/banner-sm.jpg"></div>*}
            {*<div class="pricecont clearfix">*}
                {*<div class="fl left">*}
                    {*<p class="dis-price">¥ <strong>60000</strong>元／天 <span>起</span></p>*}
                    {*<p class="price">¥ 140000 元／天</p>*}
                    {*<p class="expl">免服务费（含税）</p>*}
                {*</div>*}
                {*<a href="javascript:" class="fr btn-shopping"></a>*}
            {*</div>*}
        {*</li>*}
        {*<li class="col-md-4 col-sm-6 col-xs-12">*}
            {*<h5>Sigma</h5>*}
            {*<div class="text">上海第一家“电影会所”，拥有一个“小型电影院”和一个“数码播放厅”。</div>*}
            {*<div class="img"><img src="img/meeting/hot-item/banner-sm.jpg"></div>*}
            {*<div class="pricecont clearfix">*}
                {*<div class="fl left">*}
                    {*<p class="dis-price">¥ <strong>60000</strong>元／天 <span>起</span></p>*}
                    {*<p class="price">¥ 140000 元／天</p>*}
                    {*<p class="expl">免服务费（含税）</p>*}
                {*</div>*}
                {*<a href="javascript:" class="fr btn-shopping"></a>*}
            {*</div>*}
        {*</li>*}
        {*<li class="col-md-4 col-sm-6 col-xs-12">*}
            {*<h5>Sigma</h5>*}
            {*<div class="text">上海第一家“电影会所”，拥有一个“小型电影院”和一个“数码播放厅”。</div>*}
            {*<div class="img"><img src="img/meeting/hot-item/banner-sm.jpg"></div>*}
            {*<div class="pricecont clearfix">*}
                {*<div class="fl left">*}
                    {*<p class="dis-price">¥ <strong>60000</strong>元／天 <span>起</span></p>*}
                    {*<p class="price">¥ 140000 元／天</p>*}
                    {*<p class="expl">免服务费（含税）</p>*}
                {*</div>*}
                {*<a href="javascript:" class="fr btn-shopping"></a>*}
            {*</div>*}
        {*</li>*}
    </ul>
</div>
<!--中型空间-->
<div class="banner" id="mid">
    <img class="hidden-xs" src="img/meeting/hot-item/midbanner-big.jpg">
    <img class="visible-xs" src="img/meeting/hot-item/midbanner-sm.jpg">
</div>
<div class="container">
    <ul class="spacelist clearfix">
        <li class="explan col-md-4 col-xs-12">
            <div class="explan-title display-center">中型空间</div>
            <div class="explan-cont ">
                <p>500-2000平中型年会场地，拥有得天独厚的特色；</p>
                <p>一站式服务，意想不到的惊喜</p>
            </div>
        </li>
        {foreach $page->getMidSizeList as $k=>$v}
            <li class="col-md-4 col-sm-6 col-xs-12">
                <h5><a href="{$_home}meeting_hot_details/{Func_NumEncode::e($v['id']+100)}.html" target="_blank">{if $v['space_name']!=$v['item_name']}{$v['space_name']}--{$v['item_name']}{else}{$v['space_name']}{/if}</a></h5>
                <div class="text">{$v['space_info']}</div>
                <a href="{$_home}meeting_hot_details/{Func_NumEncode::e($v['id']+100)}.html"  target="_blank" class="img"><img src="{$v['list_img']}"></a>
                <div class="pricecont clearfix">
                    <div class="fl left">
                        <p class="dis-price">¥ <strong>{$v['new_price']}</strong>元／天 <span>起</span></p>
                        <p class="price">¥ {$v['old_price']} 元／天</p>
                        <p class="expl">{$v['remarks']}</p>
                    </div>
                    <a href="javascript:" class="fr btn-shopping js-showform" data-id="{$v['id']}" data-space_name="{$v['space_name']}-{$v['item_name']}"></a>
                </div>
            </li>
        {/foreach}
        {*<li class="col-md-4 col-sm-6 col-xs-12">*}
        {*<h5>墨西哥艺术中心-大厅</h5>*}
        {*<div class="text">上海第一家“电影会所”，拥有一个“小型电影院”和一个“数码播放厅”。</div>*}
        {*<div class="img"><img src="img/meeting/hot-item/banner-sm.jpg"></div>*}
        {*<div class="pricecont clearfix">*}
        {*<div class="fl left">*}
        {*<p class="dis-price">¥ <strong>60000</strong>元／天 <span>起</span></p>*}
        {*<p class="price">¥ 140000 元／天</p>*}
        {*<p class="expl">免服务费（含税）</p>*}
        {*</div>*}
        {*<a href="javascript:" class="fr btn-shopping"></a>*}
        {*</div>*}
        {*</li>*}
        {*<li class="col-md-4 col-sm-6 col-xs-12">*}
        {*<h5>Sigma</h5>*}
        {*<div class="text">上海第一家“电影会所”，拥有一个“小型电影院”和一个“数码播放厅”。</div>*}
        {*<div class="img"><img src="img/meeting/hot-item/banner-sm.jpg"></div>*}
        {*<div class="pricecont clearfix">*}
        {*<div class="fl left">*}
        {*<p class="dis-price">¥ <strong>60000</strong>元／天 <span>起</span></p>*}
        {*<p class="price">¥ 140000 元／天</p>*}
        {*<p class="expl">免服务费（含税）</p>*}
        {*</div>*}
        {*<a href="javascript:" class="fr btn-shopping"></a>*}
        {*</div>*}
        {*</li>*}
        {*<li class="col-md-4 col-sm-6 col-xs-12">*}
        {*<h5>Sigma</h5>*}
        {*<div class="text">上海第一家“电影会所”，拥有一个“小型电影院”和一个“数码播放厅”。</div>*}
        {*<div class="img"><img src="img/meeting/hot-item/banner-sm.jpg"></div>*}
        {*<div class="pricecont clearfix">*}
        {*<div class="fl left">*}
        {*<p class="dis-price">¥ <strong>60000</strong>元／天 <span>起</span></p>*}
        {*<p class="price">¥ 140000 元／天</p>*}
        {*<p class="expl">免服务费（含税）</p>*}
        {*</div>*}
        {*<a href="javascript:" class="fr btn-shopping"></a>*}
        {*</div>*}
        {*</li>*}
        {*<li class="col-md-4 col-sm-6 col-xs-12">*}
        {*<h5>Sigma</h5>*}
        {*<div class="text">上海第一家“电影会所”，拥有一个“小型电影院”和一个“数码播放厅”。</div>*}
        {*<div class="img"><img src="img/meeting/hot-item/banner-sm.jpg"></div>*}
        {*<div class="pricecont clearfix">*}
        {*<div class="fl left">*}
        {*<p class="dis-price">¥ <strong>60000</strong>元／天 <span>起</span></p>*}
        {*<p class="price">¥ 140000 元／天</p>*}
        {*<p class="expl">免服务费（含税）</p>*}
        {*</div>*}
        {*<a href="javascript:" class="fr btn-shopping"></a>*}
        {*</div>*}
        {*</li>*}
        {*<li class="col-md-4 col-sm-6 col-xs-12">*}
        {*<h5>Sigma</h5>*}
        {*<div class="text">上海第一家“电影会所”，拥有一个“小型电影院”和一个“数码播放厅”。</div>*}
        {*<div class="img"><img src="img/meeting/hot-item/banner-sm.jpg"></div>*}
        {*<div class="pricecont clearfix">*}
        {*<div class="fl left">*}
        {*<p class="dis-price">¥ <strong>60000</strong>元／天 <span>起</span></p>*}
        {*<p class="price">¥ 140000 元／天</p>*}
        {*<p class="expl">免服务费（含税）</p>*}
        {*</div>*}
        {*<a href="javascript:" class="fr btn-shopping"></a>*}
        {*</div>*}
        {*</li>*}
    </ul>
</div>

<!--酒店-->
<div class="banner" id="bar">
    <img class="hidden-xs" src="img/meeting/hot-item/hotelbanner-big.jpg">
    <img class="visible-xs" src="img/meeting/hot-item/hotelbanner-sm.jpg">
</div>
<div class="container">
    <ul class="spacelist clearfix">
        <li class="explan col-md-4 col-xs-12">
            <div class="explan-title display-center">酒店</div>
            <div class="explan-cont">
                <p>酒店场地，设施齐全，交通方便，省钱省心；</p>
                <p>活动策划，餐饮服务等多项选择的一站式服务；</p>
            </div>
        </li>
        {foreach $page->getHotelList as $k=>$v}
            <li class="col-md-4 col-sm-6 col-xs-12">
                <h5><a href="{$_home}meeting_hot_details/{Func_NumEncode::e($v['id']+100)}.html" target="_blank">{if $v['space_name']!=$v['item_name']}{$v['space_name']}--{$v['item_name']}{else}{$v['space_name']}{/if}</a></h5>
                <div class="text">{$v['space_info']}</div>
                <a href="{$_home}meeting_hot_details/{Func_NumEncode::e($v['id']+100)}.html"  target="_blank" class="img"><img src="{$v['list_img']}"></a>
                <div class="pricecont clearfix">
                    <div class="fl left">
                        <p class="dis-price">¥ <strong>{$v['new_price']}</strong>元／天 <span>起</span></p>
                        <p class="price">¥ {$v['old_price']} 元／天</p>
                        <p class="expl">{$v['remarks']}</p>
                    </div>
                    <a href="javascript:" class="fr btn-shopping js-showform" data-id="{$v['id']}" data-space_name="{$v['space_name']}-{$v['item_name']}"></a>
                </div>
            </li>
        {/foreach}
        {*<li class="col-md-4 col-sm-6 col-xs-12">*}
            {*<h5>墨西哥艺术中心-大厅</h5>*}
            {*<div class="text">上海第一家“电影会所”，拥有一个“小型电影院”和一个“数码播放厅”。</div>*}
            {*<div class="img"><img src="img/meeting/hot-item/banner-sm.jpg"></div>*}
            {*<div class="pricecont clearfix">*}
                {*<div class="fl left">*}
                    {*<p class="dis-price">¥ <strong>60000</strong>元／天 <span>起</span></p>*}
                    {*<p class="price">¥ 140000 元／天</p>*}
                    {*<p class="expl">免服务费（含税）</p>*}
                {*</div>*}
                {*<a href="javascript:" class="fr btn-shopping"></a>*}
            {*</div>*}
        {*</li>*}
        {*<li class="col-md-4 col-sm-6 col-xs-12">*}
            {*<h5>墨西哥艺术中心-大厅</h5>*}
            {*<div class="text">上海第一家“电影会所”，拥有一个“小型电影院”和一个“数码播放厅”。</div>*}
            {*<div class="img"><img src="img/meeting/hot-item/banner-sm.jpg"></div>*}
            {*<div class="pricecont clearfix">*}
                {*<div class="fl left">*}
                    {*<p class="dis-price">¥ <strong>60000</strong>元／天 <span>起</span></p>*}
                    {*<p class="price">¥ 140000 元／天</p>*}
                    {*<p class="expl">免服务费（含税）</p>*}
                {*</div>*}
                {*<a href="javascript:" class="fr btn-shopping"></a>*}
            {*</div>*}
        {*</li>*}
    </ul>
</div>

<!--影院-->
<div class="banner" id="mv">
    <img class="hidden-xs" src="img/meeting/hot-item/mvbanner-big.jpg">
    <img class="visible-xs" src="img/meeting/hot-item/mvbanner-sm.jpg">
</div>
<div class="container">
    <ul class="spacelist clearfix">
        <li class="explan col-md-4 col-xs-12">
            <div class="explan-title display-center">影院</div>
            <div class="explan-cont">
                <p>顶级品质，顶级服务；</p>
                <p>现场独一无二的震撼；</p>
                <p>精美菜肴，环境优雅，逼格瞬间提升；</p>
            </div>
        </li>
        {foreach $page->getCinemaList as $k=>$v}
            <li class="col-md-4 col-sm-6 col-xs-12">
                <h5><a href="{$_home}meeting_hot_details/{Func_NumEncode::e($v['id']+100)}.html" target="_blank">{if $v['space_name']!=$v['item_name']}{$v['space_name']}--{$v['item_name']}{else}{$v['space_name']}{/if}</a></h5>
                <div class="text">{$v['space_info']}</div>
                <a href="{$_home}meeting_hot_details/{Func_NumEncode::e($v['id']+100)}.html"  target="_blank" class="img"><img src="{$v['list_img']}"></a>
                <div class="pricecont clearfix">
                    <div class="fl left">
                        <p class="dis-price">¥ <strong>{$v['new_price']}</strong>元／天 <span>起</span></p>
                        <p class="price">¥ {$v['old_price']} 元／天</p>
                        <p class="expl">{$v['remarks']}</p>
                    </div>
                    <a href="javascript:" class="fr btn-shopping js-showform" data-id="{$v['id']}" data-space_name="{$v['space_name']}-{$v['item_name']}"></a>
                </div>
            </li>
        {/foreach}
        {*<li class="col-md-4 col-sm-6 col-xs-12">*}
            {*<h5>墨西哥艺术中心-大厅</h5>*}
            {*<div class="text">上海第一家“电影会所”，拥有一个“小型电影院”和一个“数码播放厅”。</div>*}
            {*<div class="img"><img src="img/meeting/hot-item/banner-sm.jpg"></div>*}
            {*<div class="pricecont clearfix">*}
                {*<div class="fl left">*}
                    {*<p class="dis-price">¥ <strong>60000</strong>元／天 <span>起</span></p>*}
                    {*<p class="price">¥ 140000 元／天</p>*}
                    {*<p class="expl">免服务费（含税）</p>*}
                {*</div>*}
                {*<a href="javascript:" class="fr btn-shopping"></a>*}
            {*</div>*}
        {*</li>*}
        {*<li class="col-md-4 col-sm-6 col-xs-12">*}
            {*<h5>墨西哥艺术中心-大厅</h5>*}
            {*<div class="text">上海第一家“电影会所”，拥有一个“小型电影院”和一个“数码播放厅”。</div>*}
            {*<div class="img"><img src="img/meeting/hot-item/banner-sm.jpg"></div>*}
            {*<div class="pricecont clearfix">*}
                {*<div class="fl left">*}
                    {*<p class="dis-price">¥ <strong>60000</strong>元／天 <span>起</span></p>*}
                    {*<p class="price">¥ 140000 元／天</p>*}
                    {*<p class="expl">免服务费（含税）</p>*}
                {*</div>*}
                {*<a href="javascript:" class="fr btn-shopping"></a>*}
            {*</div>*}
        {*</li>*}
    </ul>
</div>

<a href="{$_home}meeting" class="banner yearbanner">
    <img src="img/meeting/hot-item/year-banner.jpg">
</a>

<!--悬浮导航-->
<div class="sidenav">
    <div class="sidetitle">热卖套餐</div>
    <ul class="">
        <li><a data-id="tese" href="javascript:;">特色场地</a></li>
        <li><a data-id="big" href="javascript:;">大型场地</a></li>
        <li><a data-id="mid" href="javascript:;">中型场地</a></li>
        <li><a data-id="bar" href="javascript:;">酒店</a></li>
        <li><a data-id="mv" href="javascript:;">影院</a></li>
    </ul>
    <div class="backtop js-backtop">返回顶部</div>
</div>

{include file="Web_Static::meeting_hot/form.tpl"}
{include file="Web_Static::inc/html_footer.tpl"}
{include file="Web_Static::meeting-hot/hot_footer.tpl"}
</body>
<script src="js/year-hot-js/yearhot.js"></script>

</html>