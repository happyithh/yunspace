<!DOCTYPE html>
<html>
<head lang="en">
    {include "Web_Mobile_Static::chat.v1.0/inc.chat_head.tpl"}
</head>
<body>
{include "Web_Mobile_Static::chat.v1.0/inc.chat_demand_info_head.tpl"}

<div class="chat-demand-info-header" style="margin-top:88px">
    <p class="chat-demand-title">{$data['demand_name']}</p>

    <a href="{$root}chat_demand_edit?demand_id={$_REQUEST['demand_id']}"
       class="chat-demand-header-icon js-more-make-click" style="margin-right:25px;right:0px;top:0px;">
        <span class="ion-android-create"></span></p>
    </a>

</div>
<div class="demand-info-tab">
    {*需求信息*}
    <div class="chat-demand-info">
        <div class="chat-demand-info-month">{$data['date']}</div>
        <ul class="chat-demand-info-lists">
            <li>
                <div class="circle-demand"></div>
                <p class="demand-info-list">活动名称：<span>{$data['demand']['活动名称']|default:"待定"}</span></p>
            </li>
            <li>
                <div class="circle-demand"></div>
                <p class="demand-info-list">活动人数：<span>{$data['demand']['活动人数']|default:"待定"}</span></p>
            </li>
            <li>
                <div class="circle-demand"></div>
                <p class="demand-info-list">活动类型：<span>{$data['demand']['活动类型']|default:"待定"}</span></p>
            </li>
            <li>
                <div class="circle-demand"></div>
                <p class="demand-info-list">开始时间：<span>{$data['demand']['开始时间']|default:"待定"}</span></p>
            </li>
            <li>
                <div class="circle-demand"></div>
                <p class="demand-info-list">活动预算：<span>{$data['demand']['活动预算']|default:"待定"}</span></p>
            </li>
            <li>
                <div class="circle-demand"></div>
                <p class="demand-info-list">具体要求：<span>{$data['demand']['具体要求']|default:"待定"}</span></p>
            </li>
        </ul>
    </div>
</div>
{static "core/yunspace.js"}
</body>
</html>