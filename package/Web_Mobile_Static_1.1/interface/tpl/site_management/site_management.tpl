<!DOCTYPE html>
<html lang="en">
<head>
    {include "Web_Mobile_Static::site_management/inc.meta.tpl"}
    <link rel="stylesheet" href="plugins/font-awesome/css/font-awesome.min.css">
    <link rel="stylesheet" href="plugins/framework7/css/framework7.ios.min.css">
    {*<link rel="stylesheet" href="plugins/fullcalendar/fullcalendar.min.css">*}
    {static "v1.0/global.css"}
    {static "site_management/site_management.css"}
    {static "site_management/footer.css"}
</head>
<body yun="site_management/site_management.js::init" class="body-c">
<div class="site_cover none" id="site_cover"></div>
<div class="site_body">
<header class="site_header">
    <div class="clear_float">
        <div class="site_header_dropDown" id="site_header_dropDown">
            <p><code class="item_li" data-id="{$item_id}">{mb_strimwidth($item_name,0,16,'','utf-8')}</code><span class="icon-angle-down" style="padding-left: 10px;"></span></p>
        </div>
        <div class="show_dropDown none" id="show_dropDown">
            <ul>
                {*{$_data['data'][0]['item_name']}*}
                {foreach $item_info as $k=>$v}
                <li data-id="{$k}">
                    <a href="{$_root}m/site_management/{$k}" class="external">{mb_strimwidth($v,0,16,'','utf-8')}</a>
                </li>
                {*<li>星空广场</li>*}
                {*<li>星空广场</li>*}
                {*<li>星空广场</li>*}
                {*<li>星空广场</li>*}
                {*<li>星空广场</li>*}
                {/foreach}
            </ul>
        </div>
        <a class="site_header_change external" href="{$_root}m/site_management/schedule_create">
            <span class="icon-plus"></span>
        </a>
        <a class="site_header_change external" href="{$_root}m/site_management/schedule{if $item_id}/{$item_id}{/if}">
            <span class="icon-list"></span>
        </a>
    </div>
</header>
<div class="site_content">
    <section class="site_content_calender">
        <div class="views">
            <!-- Your main view, should have "view-main" class-->
            <div class="view view-main">
                <!-- Pages, because we need fixed-through navbar and toolbar, it has additional appropriate classes-->
                <div class="pages navbar-through toolbar-through">
                    <!-- Index Page-->
                    <div data-page="index" class="page">
                        <!-- Scrollable page content-->
                        <div class="page-content">
                            <div class="content-block">
                                <div style="padding:0; margin-right:-15px; width:auto" class="content-block-inner">
                                    <div id="calendar-inline-container"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <section class="state_dates">
        <div class="state_date">
            <div class="state_date_color"></div>
            <p class="state_date_p">已预订</p>
        </div>
        <div class="state_date">
            <div class="state_date_color"></div>
            <p class="state_date_p">有意向</p>
        </div>
        <div class="state_date">
            <div class="state_date_color"></div>
            <p class="state_date_p">未预订</p>
        </div>
    </section>
    <section class="site_content_table" style="display: none">
        {*<section class="site_content_table">*}
        <header class="site_content_table_header">
            <div><span>起止时间</span></div>
            <div><span>租金（元）</span></div>
            <div><span>活动名称</span></div>
            <div><span>订单来源</span></div>
        </header>
        <div class="none no_content" style="color: #999999;width: 100%;height: 200px;text-align: center;line-height: 150px"></div>
        <div class="clone_state_order none state_order">
            <div class="state_order_one"><span>11.29-12.03</span></div>
            <div class="state_order_two"><span>5000</span></div>
            <div class="state_order_three"><span class="san"></span><a href="{$_root}m/site_management/schedule_info/" class="order_link external"><span>王先生</span></a></div>
            <div class="state_order_four"><span>云space</span></div>
        </div>
        <section class="site_content_table_body state_ordered">
            <div id="state_one_num"><span>已预订（{count($yuding)}）</span></div>
            {foreach $yuding as $k=>$v}
            <div class="state_order">
                <div><span>{date("m.d",$v['activity_start_time'])}~{date("m.d",$v['activity_end_time'])}</span></div>
                <div><span>{$v['detail']['price']}</span></div>
                <div><a href="{$_root}m/site_management/schedule_info/{$v['id']}" class="order_link external"><span>{$v['detail']['活动名称']}</span></a></div>
                <div><span>{if $v['from_where']==1}云SPACE{elseif $v['from_where']==2}朋友介绍{elseif $v['from_where']==3}老客户{elseif $v['from_where']==4}媒体广告{elseif $v['from_where']==5}其他渠道{/if}</span></div>
            </div>
            {/foreach}
        </section>

        <section class="site_content_table_body state_pre">
            <div id="state_two_num"><span>意向预订（{count($yixiang)}）</span></div>
            {foreach $yixiang as $k=>$v}
            <div class="state_order">
                <div><span>{date("m.d",$v['activity_start_time'])}~{date("m.d",$v['activity_end_time'])}</span></div>
                <div><span>{$v['detail']['price']}</span></div>
                <div><a href="{$_root}m/site_management/schedule_info/{$v['id']}" class="order_link external"><span>{$v['detail']['活动名称']}</span></a></div>
                <div><span>{if $v['from_where']==1}云SPACE{elseif $v['from_where']==2}朋友介绍{elseif $v['from_where']==3}老客户{elseif $v['from_where']==4}媒体广告{elseif $v['from_where']==5}其他渠道{/if}</span></div>
            </div>
            {/foreach}
        </section>
    </section>
    {*<section class="site_content_table_body_message">*}
        {*<div id="site_content_table_body_message_info">*}
            {*<p>{$_data['total']['year']}年{$_data['total']['month']}月 {$_data['total']['item_name']}</p>*}
            {*<p>有 {$_data['total']['total_item']} 家在您的空间场地举办活动（含已签协议和活动结束）</p>*}
            {*<p>共占用场地 {if floor($_data['total']['total_day']*100)/100 >30}30{else}{floor($_data['total']['total_day']*100)/100}{/if} 天；场地月利用率 {if floor($_data['total']['total_rate']*100)/100 > 100}100{else}floor($_data['total']['total_rate']*100)/100{/if} %</p>*}
            {*<p>目标租金： {$_data['total']['目标租金']} 元</p>*}
            {*<p>实际租金： {$_data['total']['实际租金']} 元</p>*}
            {*<p>租金目标达成率 {floor($_data['total']['租金达成率']*100)/100} %</p>*}
        {*</div>*}
    {*</section>*}
</div>
</div>
<script src="plugins/framework7/js/framework7.min.js"></script>
{if !empty($token) && !empty($user_id)}
{else}
{include "Web_Mobile_Static::site_management/inc.footer.tpl"}
{/if}
{static "v1.0/jquery-1.11.1.min.js"}
{static "v1.0/velocity.js"}
{*<script src='plugins/moment/moment.min.js'></script>*}
{*<script src='plugins/fullcalendar/fullcalendar.min.js'></script>*}
{*<script src='plugins/fullcalendar/lang-all.js'></script>*}
{static "core/yunspace.js"}
<script>
</script>


</body>
</html>