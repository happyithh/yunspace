<!DOCTYPE html>
<html>
<head lang="en">
    {include "Web_Mobile_Static::chat.v1.0/inc.chat_head.tpl"}
</head>
<body>
<!--
<div class="top" style="background:#f5f5f5">
    <div class="top_left">
        <a href="javascript:;">
            {*<i class="ion-ios-arrow-back"></i>*}
        </a>
    </div>
    <div class="top-title">联系人</div>
</div>-->
<div class="chat-list-tabs">
    <a  href="http://{Core::$urls['host']}/m/chat/chat_list?type=contacts">
        <div class="fl chat-list-tab chat-list-tab1 {if $type =='contacts'}chat-list-tab-active{/if}" style="height:42px;width: 50%;background-color: #fbfbfb">
            联系人
        </div>
    </a>
    {*<div class="fl chat-list-tab chat-list-tab2" style="height:42px;">*}
    {*经纪人*}
    {*</div>*}
    <a  href="http://{Core::$urls['host']}/m/chat/chat_list?type=group">
        <div class="fl chat-list-tab chat-list-tab3 {if $type =='group'}chat-list-tab-active{/if}" style="height:42px;width:50%;background-color: #fbfbfb">
            群组
        </div>
    </a>
    <div class="clear"></div>
</div>
<div class="margin-top"></div>
<!--
<div class="chat-list chat-list-active" id="chat-list-tab1">

        {*默认状态下显示*}
        <div class="chat-list-prompt">
            <p><span class="ion-android-person"></span>&nbsp;您目前还没有联系人和群组</p>
        </div>
        <div class="chat-list-prompt-question">
            <p>什么是群组?</p>
            <p> 群组里包括了您的某个需求中所有涉及到的相关人员。通过群组更方便了您与相关活动人员的沟通。</p>
        </div>
        <div  class="chat-list-prompt-question">
            <p>如何获得您的群组？</p>
            <p>您在云SPACE提出活动需求之后将会生成相应的群组随着您活动需求的进展群组里陆续加入云SPACE活动顾问、供应商以及相关的工作人员</p>
        </div>

    </div>-->

<div class="chat-list" id="chat-list-tab1"  {if $type =='contacts'}style="display: block"{else}style="display: none"{/if}>
    {if $contacts_list}
        <!--  <ul class="chat-list-li">
        <li class=" relative">
            <a href="{$_route}chatter_message" class="chat-list-link block js-chat-list-link">
                <div class="chat-list-img absolute"><img src="img/chat.v1.0/icon.png" alt=""/></div>
                <p class="chat-list-text block">创建群聊</p>
            </a>
            <div class="clear"></div>
        </li>
    </ul>-->
        {foreach $contacts_list['letter'] as $v}
            <ul class="chat-list-li">
                <li class="height-1"><div class="sort">{$v}</div></li>
                {foreach $contacts_list['data'] as $kk=>$vv}
                    {if $vv['initials']==$v }
                        <li  class="relative">
                            <a href="http://{Core::$urls['host']}/m/chat/chat_body?to_account_id={$vv['contact_account_id']}&to_name={$vv['contact_name']}" class="chat-list-link block">
                                <div class="chat-list-img absolute">
                                    <img src="{$_root}user_center/avatar/{$vv['contact_account_id']}.jpg" alt=""/>
                                </div>
                                <p class="chat-list-text block">{$vv['contact_name']}</p>
                            </a>
                        </li>
                    {/if}
                {/foreach}
            </ul>
        {/foreach}
        <!-- <ul class="chat-list-li">
        <li class="height-1"><div class="sort">D</div></li>
        <li  class="relative">
            <a href="" class="chat-list-link block js-chat-list-link">
                <div class="chat-list-img absolute"><img src="img/chat.v1.0/icon.png" alt=""/></div>
                <p class="chat-list-text block">上海北岸科技有限公司</p>
            </a>
        </li>
        <li  class="relative">
            <a href="{$_route}chatter_message" class="chat-list-link block js-chat-list-link">
                <div class="chat-list-img absolute"><img src="img/chat.v1.0/icon.png" alt=""/></div>
                <p class=" chat-list-text block">1933老场坊-空中舞台</p>
            </a>
        </li>
        <li  class="relative">
            <a href="{$_route}chatter_message" class="chat-list-link block js-chat-list-link">
                <div class="chat-list-img absolute"><img src="img/chat.v1.0/icon.png" alt=""/></div>
                <p class=" chat-list-text block">思南会馆中心</p>
            </a>
        </li>
    </ul>-->
    {else}
        <div class="chat-collect-prompt-title">
            <p><span class="ion-android-person"></span>&nbsp;您目前还没有联系人和群组</p>
        </div>
        <div class="chat-collect-prompt-content">
            <h4>什么是群组?</h4>
            <p> 群组里包括了您的某个需求中所有涉及到的相关人员。通过群组更方便了您与相关活动人员的沟通。</p>
        </div>
        <div  class="chat-collect-prompt-content">
            <h4>如何获得您的群组？</h4>
            <p>您在云SPACE提出活动需求之后将会生成相应的群组随着您活动需求的进展群组里陆续加入云SPACE活动顾问、供应商以及相关的工作人员</p>
        </div>
    {/if}
</div>
<div class="chat-list" id="chat-list-tab3" {if $type =='group'}style="display: block"{else}style="display: none"{/if}>

    <!-- <ul class="chat-list-li">
        <li class=" relative">
            <a href="{$_route}chatter_message" class="chat-list-link block js-chat-list-link">
                <div class="chat-list-img absolute"><img src="img/chat.v1.0/icon.png" alt=""/></div>
                <p class="chat-list-text block">创建群聊</p>
            </a>
            <div class="clear"></div>
        </li>
    </ul>-->
    {if $group_list}
        <ul class="chat-list-li">
            {foreach $group_list as $kk=>$vv}
                {*<li class="height-1"><div class="sort">{$v}</div></li>*}
                <li  class="relative">
                    <a href="http://{Core::$urls['host']}/m/chat/chat_body?to_account_id={$vv['group_id']}&to_name={$vv['name']}" class="chat-list-link block">
                        <div class="chat-list-img absolute">
                            <img src="{$_root}user_center/avatar/{$vv['group_id']}.jpg" alt=""/>
                        </div>
                        <p class="chat-list-text block">{$vv['name']}</p>
                    </a>
                </li>
            {/foreach}
        </ul>
        <!-- <ul class="chat-list-li">
        <li class="height-1"><div class="sort">E</div></li>
        <li  class="relative">
            <a href="{$_route}chatter_message" class="chat-list-link block js-chat-list-link">
                <div class="chat-list-img absolute"><img src="img/chat.v1.0/icon.png" alt=""/></div>
                <p class="chat-list-text block">上海网络科技有限公司</p>
            </a>
        </li>
        <li  class="relative">
            <a href="{$_route}chatter_message" class="chat-list-link block js-chat-list-link">
                <div class="chat-list-img absolute"><img src="img/chat.v1.0/icon.png" alt=""/></div>
                <p class=" chat-list-text block">上海国际设计中心</p>
            </a>
        </li>
    </ul>
    <ul class="chat-list-li">
        <li class="height-1"><div class="sort">F</div></li>
        <li  class="relative">
            <a href="{$_route}chatter_message" class="chat-list-link block js-chat-list-link">
                <div class="chat-list-img absolute"><img src="img/chat.v1.0/icon.png" alt=""/></div>
                <p class="chat-list-text block">上海北岸科技有限公司</p>
            </a>
        </li>
        <li  class="relative">
            <a href="{$_route}chatter_message" class="chat-list-link block js-chat-list-link">
                <div class="chat-list-img absolute"><img src="img/chat.v1.0/icon.png" alt=""/></div>
                <p class=" chat-list-text block">1933老场坊-空中舞台</p>
            </a>
        </li>
        <li  class="relative">
            <a href="{$_route}chatter_message" class="chat-list-link block js-chat-list-link">
                <div class="chat-list-img absolute"><img src="img/chat.v1.0/icon.png" alt=""/></div>
                <p class=" chat-list-text block">思南会馆中心</p>
            </a>
        </li>
    </ul>-->
    {else}
        <div class="chat-collect-prompt-title">
            <p><span class="ion-android-person"></span>&nbsp;您目前还没有联系人和群组</p>
        </div>
        <div class="chat-collect-prompt-content">
            <p>什么是群组?</p>
            <p> 群组里包括了您的某个需求中所有涉及到的相关人员。通过群组更方便了您与相关活动人员的沟通。</p>
        </div>
        <div  class="chat-collect-prompt-content">
            <p>如何获得您的群组？</p>
            <p>您在云SPACE提出活动需求之后将会生成相应的群组随着您活动需求的进展群组里陆续加入云SPACE活动顾问、供应商以及相关的工作人员</p>
        </div>
    {/if}
</div>
{static "core/yunspace.js"}
</body>
</html>