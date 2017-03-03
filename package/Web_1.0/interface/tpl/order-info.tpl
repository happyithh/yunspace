<!DOCTYPE html>
<html>
<head>
    {include file="inc/html_head.tpl"}
    <title>云 space</title>
    <style>
        @media (max-width: 1024px){
            .order_date1, .order_date2, .order_date3, .order_date4, .order_date5{ display: none;}
            .booking_step ul li div{ width: initial;}
            .xgb a{ width: 100%; margin-top: 10px;}
            ul.chats li{ width: 550px;}
            .pull-right{ float: none!important}
        }

    </style>
</head>
<body>
{include file="inc/header_nav1.tpl"}
<div class="content">
    <div class="wbs">
        <div class="booking_step  wrap">
            <ul class="clearfix{if $orderinfo['order_status']<0} cancel{/if}">
                <li>
                    <span>1</span>

                    <p>预定下单</p>

                    <div class="order_date1">{date('Y-m-d H:i', $orderinfo['create_time'])}</div>
                </li>
                <li{if $orderinfo['create_time']&&!$orderinfo['create_time2']} class="active"{/if}>
                    <span>2</span>

                    <p>订单审核</p>
                    {if $orderinfo['create_time2']}
                        <div class="order_date5">{date('Y-m-d H:i', $orderinfo['create_time2'])}</div>
                    {elseif $orderinfo['create_time']}
                        <div>
                            {if $orderinfo['order_status']<0}
                                已取消
                            {else}
                                审核中...
                            {/if}
                        </div>
                    {/if}
                </li>
                <li{if $orderinfo['create_time2']&&!$orderinfo['create_time3']} class="active"{/if}>
                    <span>3</span>

                    <p>交易签约</p>
                    {if $orderinfo['create_time3']}
                        <div class="order_date2">{date('Y-m-d H:i', $orderinfo['create_time3'])}</div>
                    {elseif $orderinfo['create_time2']}
                        <div>
                            {if $orderinfo['order_status']<0}
                                已取消
                            {else}
                                签约中...
                            {/if}
                        </div>
                    {/if}
                </li>
                <li{if $orderinfo['create_time3']&&!$orderinfo['create_time4']} class="active"{/if}>
                    <span>4</span>

                    <p>订单支付</p>
                    {if $orderinfo['create_time4']}
                        <div class="order_date3">{date('Y-m-d H:i', $orderinfo['create_time4'])}</div>
                    {elseif $orderinfo['create_time3']}
                        <div>
                            {if $orderinfo['order_status']<0}
                                已取消
                            {else}
                                付款中...
                            {/if}
                        </div>
                    {/if}
                </li>
                <li{if $orderinfo['create_time4']} class="active"{/if}>
                    <span>5</span>

                    <p>订单结算</p>
                    {if $orderinfo['create_time5']}
                        <div class="order_date4">{date('Y-m-d H:i', $orderinfo['create_time5'])}</div>
                    {elseif $orderinfo['create_time4']}
                        <div>
                            {if $orderinfo['order_status']<0}
                                已取消
                            {else}
                                结算中...
                            {/if}
                        </div>
                    {/if}
                </li>
            </ul>
        </div>
    </div>
    <div class="wrap clearfix mt45">
        <div class="booking">
            {if $_REQUEST['tab'] != 7}
            <div class="s_left_c mt0">
                <div class="pull-left" style="padding-top: 8px">
                    <ul class="nav nav-pills" id="nav_tabs">
                        <li>
                            <a href="?tab=1">预定信息</a>
                        </li>
                        {if $orderinfo['create_time2']}
                            <li>
                                <a href="?tab=2">合同详情</a>
                            </li>
                        {else}
                            <li class="disabled">
                                <a>合同详情</a>
                            </li>
                        {/if}
                        {if $orderinfo['create_time3']}
                            <li>
                                <a href="?tab=3">支付详情</a>
                            </li>
                        {else}
                            <li class="disabled">
                                <a>支付详情</a>
                            </li>
                        {/if}
                        {if $orderinfo['create_time4']}
                            <li>
                                <a href="?tab=4">交易结算</a>
                            </li>
                        {else}
                            <li class="disabled">
                                <a>交易结算</a>
                            </li>
                        {/if}
                        {*<li>*}
                            {*<a href="?tab=5">聊天记录</a>*}
                        {*</li>*}
                        {if $_REQUEST['tab']==6}
                            <li>
                                <a href="?tab=6">修改合同细节</a>
                            </li>
                        {/if}
                    </ul>
                    <script>
                        $('#nav_tabs li').eq({$_REQUEST['tab']-1}).addClass('active');
                    </script>
                </div>
                <div class="pull-right xgb">
                    {if $orderinfo['order_status']>=0}
                        {*<a href="?tab=5#form" class="active fl">发消息</a>*}
                        {if !$orderinfo['create_time2']}
                            {if $orderinfo['is_vendor']}
                                <a href="{$_root}order_operate?order_no={$orderinfo['order_no']}&action=pending" class="gra fl">通过</a>
                                <a href="{$_root}order_operate?order_no={$orderinfo['order_no']}&action=cancel" class="red fl">放弃</a>
                            {else}
                                <a href="{$_root}order_operate?order_no={$orderinfo['order_no']}&action=cancel" class="red fr">取消订单</a>
                            {/if}
                        {elseif !$orderinfo['create_time3']&&Web_Account::subAccountHasAuth('签约',21)}
                            <a href="{$_root}order_operate?order_no={$orderinfo['order_no']}&action=vendor_cancel" class="red fr">取消订单</a>
                            {if $orderinfo['is_vendor']}
                                <a href="?tab=6" class="gra fr">修改合同细节</a>
                            {/if}
                        {elseif !$orderinfo['create_time4']}
                        {elseif !$orderinfo['create_time5']}
                        {/if}
                    {/if}
                </div>
                <div class="clearfix"></div>
            </div>
            {/if}
            {if $_REQUEST['tab'] == 2}
                {include file="inc/order-info-3.tpl"}
            {elseif $_REQUEST['tab'] == 3}
                {include file="inc/order-info-4.tpl"}
            {elseif $_REQUEST['tab'] == 4}
                {include file="inc/order-info-5.tpl"}
            {elseif $_REQUEST['tab'] == 5}
                {include file="inc/order-info-message.tpl"}
            {elseif $_REQUEST['tab'] == 6}
                {include file="inc/order-info-3-form.tpl"}
            {elseif $_REQUEST['tab'] == 7}
                {include file="inc/order-info-7.tpl"}
            {else}
                {include file="inc/order-info-2.tpl"}
            {/if}
        </div>
    </div>
</div>
{include file="inc/html_footer.tpl"}
</body>
</html>