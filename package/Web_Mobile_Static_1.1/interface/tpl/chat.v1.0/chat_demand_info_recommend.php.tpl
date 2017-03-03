<!DOCTYPE html>
<html>
<head lang="en">
    {include "Web_Mobile_Static::chat.v1.0/inc.chat_head.tpl"}
</head>
<body style="overflow-x:hidden ">
{include "Web_Mobile_Static::chat.v1.0/inc.chat_demand_info_head.tpl"}

<div class="chat-demand-info-header" style="margin-top:88px">
    <p class="chat-demand-title">{$data['demand_name']}</p>

    <p class="chat-demand-header-icon js-more-recommend-click" style="margin-right: 25px;z-index:9999"
       yun="chatBar/chat_demand.js::showRecommend@click" yun-account_id="{$account_id}"
       yun-demand_id="{$_REQUEST['demand_id']}"><span
                class="ion-plus-circled"></span></p>

</div>
<div class="demand-body-more absolute" style="border:0px;z-index:878">
    <div class="demand-body-more-list relative">
        <ul class="demand-body-more-list-li ">
            <li><a href="javascript:;" class="message-more-choose block js-recommend"
                   yun="chatBar/chat_demand.js::showRecommendModal@click" data-id="set">推荐套餐</a></li>
            <li><a href="javascript:;" class="message-more-choose block js-recommend"
                   yun="chatBar/chat_demand.js::showRecommendModal@click" data-id="room">推荐场地</a></li>
            <li><a href="javascript:;" class="message-more-choose block js-recommend"
                   yun="chatBar/chat_demand.js::showRecommendModal@click" data-id="service">推荐配套服务</a></li>
            <li>
                <div class="clear"></div>
            </li>
        </ul>
        {*<div class="Triangle-6 absolute"></div>*}
    </div>
</div>
<div class="recommend-search fixed js-recommend-demand-search" id="recommend-search" style="z-index:12000">
    <p style="margin:0px;" class="search-recommend-title block js-search-recommend-title">请搜索推荐服务</p>

    <div class="search-recommend ">
        <input type="text" class="search-input js-search-input" yun="chatBar/chat_demand.js::searchResult@keyup"/>
    </div>
    {*搜索*}
    <div id="js-search-result">
        <li class="hidden">
            <p class="result-title">&nbsp;</p>
            <span class="recommend-submit js-recommend-submit" data-id="" data-cate="">推荐</span>

            <div class="clear"></div>
        </li>
    </div>
    <ul class="search-result js-search-result ">


    </ul>
    <p class="block absolute close-reset js-close" yun="chatBar/chat_demand.js::closeRecommendModal@click"><span
                class="icon ion-close-round"></span></p>
</div>
{*带看场地选项*}
<div class="demand-take-look fixed  block">
    <p style="margin:0px;" class="search-recommend-title block ">
        我想带看场地</p>

    <div class="demand-take-look-time">
        <span>时间：</span><select name="take-look-month">
            {for $i=Date('m'); $i<13; $i++}
                <option value="{$i}">{$i}月</option>
            {/for}
        </select>
        <select name="take-look-day">
            {for $i=1; $i<=31; $i++}
                <option value="{$i}" {if Date('d')==($i-1)}selected {/if} >{$i}号</option>
            {/for}
        </select>
        <select name="take-look-time">
            {for $i=5; $i<24; $i++}
                <option value="{$i}" {if Date('H')==$i}selected {/if} >{$i}:00</option>
            {/for}
        </select>
    </div>
    <div style="padding-left: 15px;">
        <span style="float: left">备注：</span>
        <textarea placeholder="填写备注" class="take-look-remark"></textarea>
    </div>
    <div class="demand-submit">
        <button yun="chatBar/chat_demand.js::demandTakeLookSubmit@click">提交</button>
    </div>
    <p class="block absolute close-reset js-close" yun="chatBar/chat_demand.js::closeRecommendModal@click"><span
                class="icon ion-close-round"></span></p>
</div>
{*带看场地end*}
{*****************************************  列表 start    *********************}
<div class="demand-info-tab">
    {*列表*}
    {if $data}
        <div class="demand-cander demand-tab" id="recommend_list" style="z-index:555;">
            {include "Web_Mobile_Static::chat.v1.0/inc/inc.chat_demand_recommend.php.tpl"}
        </div>
        {if $total> 1}
            <div class="show-more-record">
                <p class="more-recommend">点击加载更多&nbsp;<span
                            class="ion-ios-refresh-outline"></span></p>
            </div>
        {/if}
    {else}
        <div class="show-more-record" style="background-color: #FFF;">
            <p>暂无数据&nbsp;<span class="ion-ios-refresh-outline"></span></p>
        </div>
    {/if}
</div>
{*****************************************  列表 end    *********************}
{static "core/yunspace.js"}
</body>
<script>
    $('.more-recommend').click(function () {
        var last_id = $(".record-time-more").last().find('.more_id').val();
        var demand_id = $(".record-time-more").last().attr('data-demand-id');
        $.ajax({
            type: 'get',
            url: "?load_more=1",
            data: {
                last_id: last_id,
                demand_id: demand_id
            },
            success: function (data) {

                if (data.length > 0) {
                    $("#recommend_list").append(data);
                } else {
                    {**TODO::没有数据**}
                }

            }
        });
    });
</script>
</html>