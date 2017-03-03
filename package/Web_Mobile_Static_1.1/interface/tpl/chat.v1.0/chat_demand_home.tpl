<!DOCTYPE html>
<html>
<head lang="en">
    {include "Web_Mobile_Static::chat.v1.0/inc.chat_head.tpl"}
    {include "Web_Mobile_Static::v1.0/ionicons.min.css"}
    <script src="js/chat.v1.0/chat_demand.js"></script>
    {*<script src="js/chat.v1.0/chat.js"></script>*}
</head>
<body>
<div class="cover fixed" style="z-index:12000" yun="chat_demand.js::closeRecommendModal@click"></div>
<div class="top" style="background:#f5f5f5;z-index:15000">
    <div class="top_left">
        <a  href="javascript:;" onclick="window.history.go(-1)"><i class="ion-ios-arrow-back"></i></a>
    </div>
    <div class="top-title">最新联系人</div>
</div>
<div class="cover fixed"></div>
<div class="demand-tab-change">
    <ul class="demand-tab-change-list">
        <li><p class="demand-tab-change-list-click" yun="chat_demand.js::tabActive@click" yun-id="0"><span class="ion-android-textsms"></span></p></li>
        <li><p class="demand-tab-change-list-click" yun="chat_demand.js::tabActive@click" yun-id="1"><span class="ion-android-create"></span></p></li>
        <li><p class="demand-tab-change-list-click" yun="chat_demand.js::tabActive@click" yun-id="2"><span class="ion-android-calendar"></span></p></li>
    </ul>
</div>

<div class="chat-demand-info-header" style="margin-top:88px">
    <p class="chat-demand-title">Sasha's下午茶套餐沙龙</p>
    <p class="chat-demand-header-icon js-more-make-click"  style="margin-right:25px;right:0px;top:0px;" yun="chat_demand.js::showMake@click"><span class="ion-chevron-down"></span></p>
    <p class="chat-demand-header-icon js-more-recommend-click"  style="right:0px;top:0px;" yun="chat_demand.js::showRecommend@click"><span class="ion-plus-circled"></span></p>
    <ul class="record-make">
        <li><a href="javascript:;">更多操作</a></li>
        <li><a href="javascript:;" yun="chat_demand.js::makeActive@click">删除</a></li>
        <li><a href="javascript:;" yun="chat_demand.js::makeActive@click">编辑</a></li>
    </ul>

</div>
<div class="demand-body-more absolute" style="border:0px;">
    <div class="demand-body-more-list relative">
        <ul class="demand-body-more-list-li ">
            <li><a href="javascript:;" class="message-more-choose block js-recommend"  yun="chat_demand.js::showRecommendModal@click" data-id="set">推荐套餐</a></li>
            <li><a href="javascript:;" class="message-more-choose block js-recommend"  yun="chat_demand.js::showRecommendModal@click" data-id="room">推荐场地</a></li>
            <li><a href="javascript:;" class="message-more-choose block js-recommend"  yun="chat_demand.js::showRecommendModal@click" data-id="service">推荐配套服务</a></li>
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
        <input type="text" class="search-input js-search-input" yun="chat_demand.js::searchResult@keyup"/>
    </div>
    <ul class="search-result js-search-result ">
        {*<li><p class="result-title">获得由泰国领事馆，泰国政府认证办法的全球</p><a href="javascript:;" class="recommend-submit js-recommend-submit">推荐</a><div class="clear"></div></li>*}
        {*<li><p class="result-title">获得由泰国领事馆，泰国政府认证办法的全球</p><a href="javascript:;" class="recommend-submit js-recommend-submit">推荐</a><div class="clear"></div></li>*}
        {*<li><p class="result-title">获得由泰国领事馆，泰国政府认证办法的全球</p><a href="javascript:;" class="recommend-submit js-recommend-submit">推荐</a><div class="clear"></div></li>*}
    </ul>
    <p class="block absolute close-reset js-close" yun="chat_demand.js::closeRecommendModal@click"><span class="icon ion-close-round"></span></p>
</div>


<div class="demand-info-tab">
    {*需求信息*}
    <div class="chat-demand-info" >
        <div class="chat-demand-info-month">7月7日</div>
        <ul class="chat-demand-info-lists">
            <li><div class="circle-demand"></div><p class="demand-info-list">活动名称：<span>沙龙酒会研讨发展之路</span></p></li>
            <li><div class="circle-demand"></div><p class="demand-info-list">活动人数：<span>50-150人</span></p></li>
            <li><div class="circle-demand"></div><p class="demand-info-list">活动类型：<span>商业发布、新品发布会、宴会会议</span></p></li>
            <li><div class="circle-demand"></div><p class="demand-info-list">活动预算：<span>10万-50万</span></p></li>
            <li><div class="circle-demand"></div><p class="demand-info-list">活动需求：<span>梦竹缘农业产品品尝体验馆以园区内 纯净天然有机食材，为美食爱好者烹 调出健康美味的农家菜！~</span></p></li>
        </ul>
    </div>
    {*消息页面*}
    <div class="chat-demand-message-info  none demand-tab">
        <Iframe src="{$_home}chat/chat_body" id="test" width="100%" height="505" scrolling="no" frameborder="0"></iframe>
    </div>
    {*日历页面*}
    <div class="demand-cander none demand-tab">
        <div class="chat-demand-info-month">7月7日</div>
        <ul class="cander-record">
            <li>
                <div class="record-message">
                    <div class="record-time-more">
                        <p class="record-time">2015.7.29&nbsp;18:35</p>
                        <p class="record-icon" yun="chat_demand.js::showState@click"><span class="ion-chevron-down"></span></p>

                    </div>
                    <div class="record-message-info">
                        <ul class="record-state">
                            <li><a href="javascript:;" yun="chat_demand.js::stateActive@click">推荐</a></li>
                            <li><a href="javascript:;" yun="chat_demand.js::stateActive@click">意向</a></li>
                            <li><a href="javascript:;" yun="chat_demand.js::stateActive@click">订单</a></li>
                        </ul>
                        <p>好的，你看一下你的场地图片好的，你看一下你的场地图片好的，你看一下你的场地图片好的，你看一下你的场地图片<span class="record-code">推荐</span></p>
                    </div>
                    <ul class="record-img">
                        <li><img src="img/chat.v1.0/lufei.jpg" alt=""></li>
                        <li><img src="img/chat.v1.0/lufei.jpg" alt=""></li>
                        <li><img src="img/chat.v1.0/lufei.jpg" alt=""></li>
                    </ul>
                </div>
                <div class="person-record-img"><img src="img/chat.v1.0/lufei.jpg" alt=""></div>
            </li>
            <li>
                <div class="record-message">
                    <div class="record-time-more">
                        <p class="record-time">2015.7.29&nbsp;18:35</p>
                        <p class="record-icon" yun="chat_demand.js::showState@click"><span class="ion-chevron-down"></span></p>
                    </div>
                    <div class="record-message-info">
                        <ul class="record-state">
                            <li><a href="javascript:;" yun="chat_demand.js::stateActive@click">推荐</a></li>
                            <li><a href="javascript:;" yun="chat_demand.js::stateActive@click">意向</a></li>
                            <li><a href="javascript:;" yun="chat_demand.js::stateActive@click">订单</a></li>
                        </ul>
                        <p class="">好的，你看一下你的场地图片好的，你看一下你的场地图片好的，你看一下你的场地图片好的，你看一下你的场地图片<span class="record-code">推荐</span></p>
                    </div>

                </div>
                <div class="person-record-img"><img src="img/chat.v1.0/lufei.jpg" alt=""></div>
            </li>
            <li>
                <div class="record-message">
                    <div class="record-time-more">
                        <p class="record-time">2015.7.29&nbsp;18:35</p>
                        <p class="record-icon" yun="chat_demand.js::showState@click"><span class="ion-chevron-down"></span></p>
                    </div>
                    <div class="record-message-info">
                        <ul class="record-state">
                            <li><a href="javascript:;" yun="chat_demand.js::stateActive@click">推荐</a></li>
                            <li><a href="javascript:;" yun="chat_demand.js::stateActive@click">意向</a></li>
                            <li><a href="javascript:;" yun="chat_demand.js::stateActive@click">订单</a></li>
                        </ul>
                        <p class="">好的，你看一下你的场地图片好的，你看一下你的场地图片好的，你看一下你的场地图片好的，你看一下你的场地图片<span class="record-code">推荐</span></p>
                    </div>

                </div>
                <div class="person-record-img"><img src="img/chat.v1.0/lufei.jpg" alt=""></div>
            </li>
        </ul>
        <div class="clear"></div>
        <div class="show-more-record">
            <p>点击加载更多&nbsp;<span class="ion-ios-refresh-outline"></span></p>
        </div>
    </div>
    {*需求表单*}
    <div class="set-demand none demand-tab">
        <div class="chat-demand-info-month">7月7日</div>
        <div class="demand-form">
            <form action="">
                <div class="demand-input">
                    <div class="demand-name">活动名称</div>
                    <input type="text" placeholder="请填写活动名称">
                </div>
                <div class="demand-input">
                    <div class="demand-name">活动人数</div>
                    <select>
                        <option value="">50</option>
                        <option value="">100-200</option>
                        <option value="">300-500</option>
                    </select>
                </div>
                <div class="demand-input">
                    <div class="demand-name">活动类型</div>
                    <select>
                        <option value="">空间场地</option>
                        <option value="">配套服务</option>
                        <option value="">场地搭建</option>
                    </select>
                </div>
                <div class="demand-input">
                    <div class="demand-name">活动预算</div>
                    <select>
                        <option value="">10-15万</option>
                        <option value="">20-30万</option>
                        <option value="">50万以上</option>
                    </select>
                </div>
                <div class="demand-input">
                    <div class="demand-name">活动需求</div>
                    <textarea type="text" placeholder="请填写活动需求"></textarea>
                </div>
                <div class="demand-submit">
                    <button>立即提交</button>
                </div>
            </form>
        </div>
    </div>


</div>
{static "core/yunspace.js"}
</body>
</html>