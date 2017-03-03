<!DOCTYPE html>
<html>
<head lang="en">
    {include "Web_Mobile_Static::chat.v1.0/inc.chat_head.tpl"}
    {include "Web_Mobile_Static::v1.0/ionicons.min.css"}
    {*<script src="js/chat.v1.0/chat_demand.js"></script>*}
    {*<script src="js/chat.v1.0/chat.js"></script>*}
</head>
<body style="background:#ffffff;">
<div class="top" style="background:#f5f5f5">
    <div class="top_left">
        <a href="javascript:;">
            {*<i class="ion-ios-arrow-back"></i>*}
        </a>
    </div>
    <div class="top-title">收藏记录</div>
</div>
<div class="chat-list-tabs" style="margin-top: 42px;">
    <a href="/m/chat/chat_collect?type=space">
        <div class="fl chat-list-tab chat-list-tab1 {if $type =='space'}chat-list-tab-active{/if}" style="height:42px;width: 25%;background-color: #fbfbfb;position:static!important;">
            商品
        </div>
    </a>
    <a href="/m/chat/chat_collect?type=set">
        <div class="fl chat-list-tab chat-list-tab2 {if $type =='set'}chat-list-tab-active{/if}" style="height:42px;width:25%;background-color: #fbfbfb;position:static!important;">
            超值套餐
        </div>
    </a>
    <a href="/m/chat/chat_collect?type=vendor">
        <div class="fl chat-list-tab chat-list-tab3 {if $type =='vendor'}chat-list-tab-active{/if}" style="height:42px;width:25%;background-color: #fbfbfb;position:static!important;">
            供应商
        </div>
    </a>
    <a href="/m/chat/chat_collect?type=event">
        <div class="fl chat-list-tab chat-list-tab4 {if $type =='event'}chat-list-tab-active{/if}" style="height:42px;width:25%;background-color: #fbfbfb;position:static!important;">
            活动案例
        </div>
    </a>

    <div class="clear"></div>
</div>
{*默认状态下*}
{*<div class="chat-collect-prompt">*}
{*<div class="chat-collect-prompt-title">*}
{*<p><span class="ion-heart"></span>&nbsp;&nbsp;您还没心仪的商品，快去<a href="" class="collect-link">逛逛</a>吧</p>*}
{*</div>*}
{*<div  class="chat-collect-prompt-content">*}
{*<p>如何收藏商品?</p>*}
{*<ul class="collect-step">*}
{*<li>1、选择一个您心仪的商品，进入商品详情页面；</li>*}
{*<li>2、在详情页的右上方找到“分享”、“加入收藏”；</li>*}
{*<li>3、点击“<a href=""  class="collect-link">加入收藏</a>”，成功收藏了商品哦~。</li>*}
{*</ul>*}
{*</div>*}
{*</div>*}
<div class="chat-list" id="chat-list-tab3" style="display: block;">
    {if $list}
        <ul class="chat-recent">
            {foreach $list as $kk=>$vv}
                <li class="recent-item relative" style="margin: 10px 0">
                    <a href="http://{Core::$urls['host']}/{$type_url}/{$vv['id']}.html" target="_blank" title="{$vv['name']}">
                        <div class="recent-person absolute">
                            <img src="{$vv['logo']}">
                        </div>
                        <div class="recent-body">
                            <p class="recent-name" style="width: 70%;height:25px;overflow: hidden;">{$vv['name']}</p>

                            <p class="recent-name">
                                收藏时间：{date('Y-m-d', $vv['create_time'])}</p>
                        </div>
                        <div class="recent-code absolute" style="width: 100px;text-align: center;overflow: hidden">
                            <span class="recent-time">{if $vv['category_name']}{$vv['category_name']}{/if}</span>
                        </div>
                    </a>
                </li>
            {/foreach}
        </ul>
    {else}
    {if $type =='space'}
        <div class="chat-collect-prompt">
            <div class="chat-collect-prompt-title">
                <p><span class="ion-heart"></span>&nbsp;&nbsp;您还没心仪的商品，快去逛逛吧
                </p>
            </div>
            <div class="chat-collect-prompt-content">
                <h4>如何收藏商品?</h4>

                <p>1、选择一个您心仪的商品，进入商品详情页面；</p>

                <p>2、在预定下单按钮上方找到“加入收藏”</p>

                <p>
                    3、点击“加入收藏”，成功收藏了商品哦~。
                </p>
            </div>
        </div>
        {elseif $type =='set'}
            <div class="chat-collect-prompt">
                <div class="chat-collect-prompt-title">
                    <p><span class="ion-heart"></span>&nbsp;&nbsp;您还没心仪的套餐，快去逛逛吧
                    </p>
                </div>
                <div class="chat-collect-prompt-content">
                    <h4>如何收藏套餐?</h4>

                    <p>1、选择一个您心仪的套餐，进入套餐详情页面；</p>

                    <p>2、在套餐价格旁找到“加入收藏”</p>

                    <p>
                        3、点击“加入收藏”，成功收藏了套餐哦~。
                    </p>
                </div>
            </div>
        {elseif $type =='vendor'}
            <div class="chat-collect-prompt">
                <div class="chat-collect-prompt-title">
                    <p><span class="ion-heart"></span>&nbsp;&nbsp;您还没心仪的供应商，快去逛逛吧
                    </p>
                </div>
                <div class="chat-collect-prompt-content">
                    <h4>如何收藏供应商?</h4>

                    <p>1、在商品详情页中找到供应商信息，并点击”查看供应商“进入供应商页面 </p>

                    <p>2、在供应商页面的右上角找到“加入收藏”</p>

                    <p>
                        3、您可以直接在“服务商户”下找到心仪的供应商，并进入供应商页面找到“加入收藏”
                    </p>
                </div>
            </div>
    {elseif $type =='event'}
        <div class="chat-collect-prompt">
            <div class="chat-collect-prompt-title">
                <p><span class="ion-heart"></span>&nbsp;&nbsp;您还没心仪的活动案例，快去逛逛吧
                </p>
            </div>
            <div class="chat-collect-prompt-content">
                <h4>如何收藏活动案例?</h4>

                <p>1、在商品详情页中找到活动案例（没有活动案例将不显示） </p>

                <p>2、点击某个感兴趣的活动案例进入活动案例页面</p>

                <p>
                    3、在活动案例页面的右上角找到“加入收藏”

                </p>
            </div>
        </div>
    {/if}

    {/if}
</div>
{static "core/yunspace.js"}
</body>
</html>