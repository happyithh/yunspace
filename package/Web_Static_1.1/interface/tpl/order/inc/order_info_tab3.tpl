{*----------------------不同支付进度加载不同的说明模板----------------------------------*}

{if $orderinfo['order_price']==$orderinfo['order_price_pay']}
    {*订单全部支付*}
    {include "Web_Static::order/inc/order_info_tab3_all.tpl"}
{elseif $orderinfo['order_price_pay']}
    {*订单部分支付*}
    {include "Web_Static::order/inc/order_info_tab3_part.tpl"}
{else}
    {*订单未支付*}
    {include "Web_Static::order/inc/order_info_tab3_not.tpl"}
{/if}


{*----------------------已支付列表信息----------------------------------*}

{if $paymentInfo}
    <div class="hvpay-details">
        <div class="order-title">已支付明细</div>
            {*订单已支付列表*}
            {include "Web_Static::order/inc/order_payment_list.tpl"}
    </div>
{/if}


{*----------------------未支付列表信息----------------------------------*}
{if $not_pay}
    {include "Web_Static::order/inc/not_pay_payment_list.tpl"}
{/if}

{*----------------------加载评价框----------------------------------*}
{if $orderinfo['evaluate'] || ($orderinfo['is_buyer'] && $_REQUEST['handle_evaluate']==1)}
    {include "Web_Static::order/inc/order_info_evaluate.tpl"}
{/if}








