<!DOCTYPE html>
<html>
<head lang="en">
    {include "Web_Mobile_Static::chat.v1.0/inc.chat_head.tpl"}
</head>
<body>
<div class="top" style="background:#f5f5f5">
    <div class="top_left">
        <a href="javascript:;">
            {*<i class="ion-ios-arrow-back"></i>*}
        </a>
    </div>
    <div class="top-title">需求记录</div>
</div>
<div class="demand-change" style="margin-top: 44px;">
    <p class="change-click change-click-active change" yun="chat_demand.js::showDemand@click" yun-id="1">处理中</p>

    <p class="change-click change" yun="chat_demand.js::showDemand@click" yun-id="2">已完成</p>

    <p class="demand-delete change" yun="chat_demand.js::showDemand@click" yun-id="3"><span class="ion-trash-a"></span>
    </p>
</div>
{*默认状态下显示*}
{*<div class="chat-collect-prompt">*}
{*<div class="chat-collect-prompt-title">*}
{*<p><span class="ion-document-text"></span>&nbsp;&nbsp;您还发布过活动需求，快去<a href="" class="collect-link">发布</a>吧</p>*}
{*</div>*}
{*<div  class="chat-collect-prompt-content">*}
{*<p>什么是活动需求?</p>*}
{*<ul class="collect-step">*}
{*<li style="line-height:30px;">活动需求是指您对将要举办活动的一个想法、要求以及云SPACE的服务</li>*}
{*</ul>*}
{*<p>如何发布活动需求?</p>*}
{*<ul class="collect-step">*}
{*<li>1、云SPACE网站上z找“我要办活动板块”；</li>*}
{*<li>2、拨打云SPACE服务热线<a href=""  class="collect-link">400-056-0599</a>；</li>*}
{*<li>3、在商品详情页内右上角找到“预约咨询”。</li>*}
{*</ul>*}
{*</div>*}
{*</div>*}
<div id="demand-event">
    <ul class=" demand-event tab-demand hidden" >
        <li class="demand-month"></li>
    </ul>
</div>
<div id="list-name">
    <li class="hidden">
        <a href="javascript:;" class="demand-list">
            <span class="ion-clock demand-icon-1"></span>
            <span class="demand-title">Sasha's下午茶套餐沙龙</span>
            <span class="ion-chevron-right demand-icon-2"></span>
        </a>
    </li>
</div>

<div class="tab-demands">
    <div  id="no-data" style="text-align: center">没有数据</div>
</div>
{static "core/yunspace.js"}
</body>
</html>