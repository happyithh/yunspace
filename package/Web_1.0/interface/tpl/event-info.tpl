<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="css/lightSlider.css">
    <link href='css/jquery.fancybox.css' rel='stylesheet' media="screen"/>
    {include file="inc/html_head.tpl" owl=1}
</head>
<body>
{include file="inc/header_nav.tpl"}
{*{var_dump($info)}*}
<div class="content">
    <div class="bg_w">
        <div class="con wrap clearfix">
            <div class="crumbs fl ">
				<span>
					<a href="{$_root}">首页></a>
					<a href="{$_root}event">活动></a>
					<a href="{$_root}event_info/{$info['id']}.html">{$info['event_name']}</a>
				</span>

                <h1>{$info['event_name']}</h1>

                <div class="s_info">
                    <span>地址：</span>{$info['addr']}
                    {*<span class="s_btn" data-toggle="modal" data-target="#openMap"><a href="javascript:void(0)">查看地图</a></span>*}
                </div>
            </div>
            <div class="fr t_cl">
                <div class="text-r mb10">
                    <font class="par">{$info['counter_view']}</font>
                    人已浏览
                </div>
                {*<div class="sac">*}
                    {*<span onclick="showBox('{$_assets}')" class=" s_share_btn s_btn inline-block bgc"><a href="javascript:;">分享</a></span>*}
                    {*<span data-url="{$_root}ajax_collect" class="s_btn inline-block bgc" id='collect' data-uid="{$smarty.session.user.id}" data-status data-id="{$info['id']}" data-type="event"><a href="javascript:;">{$msg}*}
                    {*</a></span>*}
                {*</div>*}
                <style>
                    .product_icon{ float: right;}
                    .product_icon h5{ float: right; margin-top: 10px; margin-left: 20px;}
                    .product_icon h5 a{ color: #00c3c3!important;}
                </style>
                <div class="product_icon">
                    <h5 class="icon">
                        <a data-url="{$_root}ajax_collect" class='collect' data-uid="{$smarty.session.user.id}" data-status data-id="{$info['id']}" data-type="event" href="javascript:;"><i class="glyphicon glyphicon-heart-empty"></i>&nbsp;<span>收藏</span></a>
                    </h5>
                    <h5 class="icon" id="share">
                        <a onclick="showBox('{$_assets}')" href="javascript:;"><span class="fa fa-share-alt"></span>&nbsp;分享</a>
                    </h5>
                </div>
            </div>
        </div>
    </div>
    <div class="con wrap clearfix">
        <!-- 左边一块 -->
        <div class="s_left fl csi_sl" id="s_left">
            {if $info['des']}
            <div class="border1 s_kj csi_s" style="margin-top: 0">
                <div class="kj_ti">活动概要</div>
                <div class="">
                    {mb_substr(strip_tags($info['des']),0,100,'utf-8')}
                </div>
            </div>
            {/if}
            <div class="page_nt">
                活动详情
            </div>
            <div class="csi_hd">
                <div class="img_w">
                    <div class="server_inner_banner" style="display:block">
                        <ul id="imageGallery" class="gallery list-unstyled">
                                {foreach $info['media'] as $k=>$v}
                                    {foreach $v[1] as $vv}
                                        <li data-thumb="{Page_Site_Global::displayMedia($vv[1],264,176)}">
                                        {if $vv[2]}
                                            <a href="{$vv[2]}" class="imageBox videoBox" data-fancybox-group="gallery">
                                                <img src="{Page_Site_Global::displayMedia($vv[1],768,0,2)}" title="{$info['event_name']}-{$vv[0]}"/>
                                            </a>
                                        {else}
                                            <a href="{Page_Site_Global::displayMedia($vv[1],768,0,1)}" class="imageBox" data-fancybox-group="gallery">
                                                <img class="vendorlogo" src="{Page_Site_Global::displayMedia($vv[1],768,0,1)}" title="{$info['event_name']}-{$vv[0]}"/>
                                            </a>
                                        {/if}
                                        </li>
                                    {/foreach}
                                {/foreach}
                        </ul>
                    </div>
                </div>
                <p>
                    {$info['des']}
                </p>

            </div>
            {if $events}
                <div class="page_nt">
                    相关案例介绍
                </div>
                <ul class="border1 s_kj csi_s">
                    {foreach $events as $ek=>$ev}
                        <li class="list_c">
                            <div class="kj_ti">{$ev['case_name']}</div>
                            <div class="">
                                {$ev['des']|default:'该案例暂无简介...'}
                            </div>
                        </li>
                    {/foreach}
                </ul>
            {/if}
        </div>
        <!-- 左边一块结束 -->

        <!-- 右边一块 -->
        <div class="s_right fr csi_sr border1">
            <span class="if_yl">其他案例</span>
            {foreach $events as $v}
                <div class="list_c">
                    <div class="list_img">
                        <a href="{$_root}event_info/{$v['event_id']}.html">
                            {if {$v['logo']}}
                                <img src="{Data_Config_Site::displayMedia($v['logo'],768,0,2)}">
                            {else}
                                <img width="114" height="85" src="img/s_logo.jpg">
                            {/if}
                        </a>
                    </div>
                    <div class="list_wz">
                        <h3>
                            <a href="{$_root}event_info/{$v['event_id']}.html" class="me_in">{$v['case_name']}</a>
                            {*<a class="see_m" href="{$_root}event_info/{$v['event_id']}.html">查看详情</a>*}
                        </h3>
                    </div>
                </div>
            {/foreach}

        </div>
    </div>
</div>
{if $info['addr']}
    {include file="inc/baidu_map_in_info.tpl"}
{/if}
<script type="text/javascript" src="js/jquery.lightSlider.js"></script>
<script src='js/jquery.fancybox.pack.js'></script>
<script type="text/javascript" src='js/banner.js'></script>
<script type="text/javascript" src='js/collect.js'></script>
{include file="inc/html_share.tpl"}
<div style="margin-top:50px;" class="mt50"></div>
{include file="Web_Static::v2.0/html_footer.tpl"}
</body>
</html>