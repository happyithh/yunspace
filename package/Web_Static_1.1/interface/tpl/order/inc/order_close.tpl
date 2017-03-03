{*签约前订单取消--单方面*}
{if $orderinfo['order_status']==-1}
    <div class="order-comn order-confirm order-conf">
        <h1 style="text-align: center"><span class="black" style="font-size: 18px;">当前状态：</span>交易关闭</h1>
        <p style="text-align: center;">关闭类型：
            {if $orderinfo['order_close_info']['is_buyer']}
                <span>买家取消订单</span>
            {elseif $orderinfo['order_close_info']['is_vendor']}
                {if $orderinfo['create_time2']}
                    <span>商户取消订单</span>
                {else}
                    <span>订单未通过审核</span>
                {/if}
            {/if}
        </p>
        <p style="text-align: center;">原因：<span>{$orderinfo['order_close_info']['reason']}</span></p>
        <p style="text-align: center;">提示：<span>订单取消后，如需采购方退款，请线下协商退款事宜</span></p>
    </div>
{*{elseif $orderinfo['order_status']==110}*}
{elseif $orderinfo['order_close_info']['buyer_cancel_time'] && !$orderinfo['order_close_info']['vendor_refuse_time']}
{*签约后买家取消订单*}
    <div class="order-comn order-confirm order-conf">
        <h1 style="text-align: center"><span class="black" style="font-size: 18px;">当前状态：</span>采购方取消订单，待商户确认</h1>
        <p style="text-align: center;">关闭类型：<span>采购方取消订单</span></p>
        <p style="text-align: center;">原因：<span>{$orderinfo['order_close_info']['reason']}</span></p>
        <p style="text-align: center;">提示：<span>订单取消后，如需采购方退款，请线下协商退款事宜</span></p>
        {if $orderinfo['is_vendor']}
            <div class="btn-wrp clearfix" style="margin-bottom: 60px;">
                <a class="btn-confirm confirm_cancel_order" href="javascript:;">取消订单</a>
                {*<a class="fr blue btn-code js-refuse-cancel" data-status="120"  href="javascript:;">拒绝取消，我要申诉</a>*}
            </div>
        {/if}
    </div>
{*{elseif $orderinfo['order_status']==115}*}
{elseif $orderinfo['order_close_info']['vendor_cancel_time'] && !$orderinfo['order_close_info']['buyer_refuse_time']}
{*签约后卖家取消订单*}
    <div class="order-comn order-confirm order-conf">
        <h1 style="text-align: center"><span class="black" style="font-size: 18px;">当前状态：</span>商户取消订单，待采购方确认</h1>
        <p style="text-align: center;">关闭类型：<span>商户取消订单</span></p>
        <p style="text-align: center;">原因：<span>{$orderinfo['order_close_info']['reason']}</span></p>
        <p style="text-align: center;">提示：<span>订单取消后，如需采购方退款，请线下协商退款事宜</span></p>
        {if $orderinfo['is_buyer']}
            <div class="btn-wrp clearfix" style="margin-bottom: 60px;">
                <a class="btn-confirm confirm_cancel_order" href="javascript:;">确认取消</a>
                {*<a class="fr blue btn-code js-refuse-cancel" data-status="125"  href="javascript:;">拒绝取消，我要申诉</a>*}
            </div>
        {/if}
    </div>
{*{elseif $orderinfo['order_status']==120}*}
{elseif $orderinfo['order_close_info']['vendor_refuse_time']}
{*签约后卖家拒绝取消订单*}
    <div class="order-comn order-confirm order-conf">
        <h1 style="text-align: center"><span class="black" style="font-size: 18px;">当前状态：</span>采购方取消订单，商户拒绝，待云Space客服调解</h1>
        <p style="text-align: center;">采购方取消原因：<span>{$orderinfo['order_close_info']['reason']}</span></p>
        {*<p style="text-align: center;">商户拒绝原因： <span>{$orderinfo['order_close_info']['refuse_cancel_reason']}</span></p>*}
    </div>
{*{elseif $orderinfo['order_status']==125}*}
{elseif $orderinfo['order_close_info']['buyer_refuse_time']}
{*签约后买家拒绝取消订单*}
    <div class="order-comn order-confirm order-conf">
        <h1 style="text-align: center"><span class="black" style="font-size: 18px;">当前状态：</span>商户取消订单，采购方拒绝，待云Space客服调解</h1>
        <p style="text-align: center">商户取消原因：<span>{$orderinfo['order_close_info']['reason']}</span></p>
        {*<p style="text-align: center">采购方拒绝原因： <span>{$orderinfo['order_close_info']['refuse_cancel_reason']}</span></p>*}
    </div>
{/if}