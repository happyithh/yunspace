<!DOCTYPE html>
<html lang="en">
<head>
    {include "Web_Mobile_Static::site_management/inc.meta.tpl"}
    {*{static "v1.0/global.css"}*}
    {static "site_management/footer.css"}
    {static "site_management/management_schedule.css"}
    {*<link rel="stylesheet" type="text/css" media="screen" href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css">*}
    {*{static "site_management/bootstrap-datetimepicker.min.css"}*}
    {static "site_management/common.css"}
    {static "site_management/datePicker.css"}
    {*{static "site_management/site_management.css"}*}
    {*{static "v1.0/data-picker.css"}*}
</head>
<body>
<div class="site_cover none" id="site_cover"></div>
<header class="site_header">
    <div class="clear_float">
        <div class="site_header_dropDown" id="site_header_dropDown">
            <p><code class="item_li" data-id="{$item_id}">{mb_strimwidth($item_name,0,16,'','utf-8')}</code><span class="icon-angle-down"></span></p>
        </div>
        <div class="show_dropDown none" id="show_dropDown">
            <ul>
                {foreach $item_info as $k=>$v}
                    <li data-id="{$k}">
                        <a href="{$_root}m/site_management/schedule/{$k}" class="external">{mb_strimwidth($v,0,16,'','utf-8')}</a>
                    </li>
                {/foreach}
            </ul>
        </div>
        <a class="site_header_change external" href="{$_root}m/site_management/schedule_create">
            <span class="icon-plus"></span>
        </a>
        <a class="site_header_change external" href="{$_root}m/site_management">
            <span class="icon-th"></span>
        </a>
    </div>
</header>

<div class="schedule_title">
    <div class="schedule_title_left">
        {*<input type='text' class="datePicker" />*}
        <div class="lie">选择日期:<input  id="beginTime" class="kbtn" /></div>
        {*<div class="date none">*}
            {*<div yun="data-picker/js/date-picker.js::initPlugin" class="date-picker" yun-input=".datePicker"*}
                 {*yun-with-input="false"></div>*}
        {*</div>*}
    </div>
    <div class="select-condition">
        <select>
            <option value ="volvo">有意向</option>
            <option value ="saab">已预订</option>
            <option value="opel">签约流程中</option>
            <option value="audi">已签订</option>
        </select>
    </div>

    <div class="clear"></div>
</div>

<div class="tian"></div>

<div class="schedule_content">
    <div class="schedule_content_top" id="rqTop" style="display: none">
        <div class="schedule_date">
           日期
        </div>
        <div class="schedule_intention">
           有意向
            {*<br/>*}
            {*<span1 class="icon-angle-left"></span1>*}
            {*<span2 class="icon-angle-right"></span2>*}
        </div>
        <div class="schedule_booked">
           已预定
        </div>
        <div class="schedule_process">
           签约流程中
        </div>
        <div class="schedule_signed">
           已签协议
        </div>
    </div>
    <div class="schedule_content_top" id="rqTop2">
        <div class="schedule_date">
            日期
        </div>
        <div class="schedule_intention">
            有意向

        </div>
    </div>
    <div style="height: 61px"></div>
    <div class="schedule_content_c" id="calendarContent">
        {*<div class="schedule_content_item">*}
          {*<div class="item_date">11月15日<br>星期日</div>*}
          {*<div class="item_intention"></div>*}
          {*<div class="item_booked"></div>*}
          {*<div class="item_process"></div>*}
          {*<div class="item_signed"></div>*}
        {*</div>*}

    </div>



    <div class="footer">

    </div>

</div>

<div id="datePlugin"></div>
<button class="load-more" id="loadMore">查看更多档期</button>
{*<div class="management_dayer management_dayer_v"></div>*}

{include "Web_Mobile_Static::site_management/inc.footer.tpl"}
{*{static "site_management/management_schedule.js"}*}
<script src="plugins/framework7/js/framework7.min.js"></script>
{static "v1.0/velocity.js"}
{static "site_management/calendar-vertical-condition.js"}

{*{static "site_management/moment.min.js"}*}
{*{static "site_management/bootstrap-datetimepicker.min.js"}*}
{static "v1.0/jquery-1.11.1.min.js"}
{static "site_management/iscroll.js"}
{static "site_management/date.js"}
{static "site_management/datePicker.js"}
{static "core/yunspace.js"}


</body>
</html>