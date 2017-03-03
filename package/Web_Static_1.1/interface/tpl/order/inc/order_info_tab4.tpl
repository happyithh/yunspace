{if $orderinfo['is_buyer']}
{*-----------------用户-----------------*}
    <!--订单支付-->
    {include "Web_Static::order/inc/conform_list_pay.tpl"}
    {*<div class="pay-p-wp">*}
        {*<p>如果不想继续，您可 <a href="javascript:;" data-status="110" class="blue js-cancel" style="text-decoration: underline;">取消订单</a></p>*}
    {*</div>*}

    <div class="hvpay-details" style="margin-bottom: 50px;">
        <div class="hvpay-details-title hdt1 clearfix">
            <p class="title">已支付<strong class="magenta">￥{$orderinfo['order_price_pay']}</strong></p>
            <a href="javascript:;" class="js-hvpay-btndown hvpay-details-btn bg-greenline">查看详情<span class="icon-downup icon-down"></span></a>
        </div>
        <div class="hvpay-details-title hdt2 clearfix hide">
            <p class="title">已支付明细</p>
            <a href="javascript:;" class="js-hvpay-btnup hvpay-details-btn bg-grayline">查看详情<span class="icon-downup icon-up"></span></a>
        </div>

        <div class="hvpay-table-wrap hide">
            {*订单已支付列表*}
            {include "Web_Static::order/inc/order_payment_list.tpl"}
        </div><!--hvpay-table-wrap-end-->
    </div>

    {*订单评价*}
    {include "Web_Static::order/inc/order_info_evaluate.tpl"}

{else}

{*-----------------商户-----------------*}
<!--订单支付-->
    <div class="ormd-moneyacct order-cont clearfix">
        <div class="fl ormd-moneyacct-acct">
            <span class="tit">该订单在线上支付的收款账号:</span>
            <select class="change_cash">
                <option value="" {if !$orderinfo['order_detail']['bank_cash']}selected{/if}>&nbsp;&nbsp;我的钱包</option>
                {foreach $bank_info['bank_account'] as $k=>$v}
                    <option value="{$k}" {if $orderinfo['order_detail']['bank_cash'] == $k}selected{/if}>【{$v['4']}】&nbsp;&nbsp;尾号{substr($v[2],-4)}</option>
                {/foreach}
            </select>
            <a href="{$_root}user_center/user_admin/money?action=new_card" target="_blank" class="addbankcard">添加银行卡</a>
        </div>
        {if $orderinfo['order_status'] != 90}
            <div class="addcontract">
                <input type="button" class="addcontract-btn js-addcontract-btn bg-magenta js-upld-submit-m" value="新增合同">
            </div>
        {/if}
    </div>
    {include "Web_Static::order/inc/conform_list_pay.tpl"}
    {*<div class="pay-p-wp">*}
        {*<p>如果不想继续，您可 <a href="javascript:;" data-status="115" class="blue js-cancel" style="text-decoration: underline;">取消订单</a></p>*}
    {*</div>*}

    <div class="hvpay-details" style="margin-bottom: 50px;">
    <div class="hvpay-details-title hdt1 clearfix">
        <p class="title">已支付<strong class="magenta">￥{$orderinfo['order_price_pay']}</strong></p>
        <a href="javascript:;" class="js-hvpay-btndown hvpay-details-btn bg-greenline">查看详情<span class="icon-downup icon-down"></span></a>
    </div>
    <div class="hvpay-details-title hdt2 clearfix hide">
        <p class="title">已支付明细</p>
        <a href="javascript:;" class="js-hvpay-btnup hvpay-details-btn bg-grayline">查看详情<span class="icon-downup icon-up"></span></a>
    </div>
    <div class="hvpay-table-wrap hide">
        {*订单已支付列表*}
        {include "Web_Static::order/inc/order_payment_list.tpl"}
    </div><!--hvpay-table-wrap-end-->
</div>

<!--评价状态-->
    {include "Web_Static::order/inc/order_info_evaluate.tpl"}

{/if}















