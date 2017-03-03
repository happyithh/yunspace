<div class="hvpay-details">
    <div class="order-title">未支付明细</div>
{if $orderinfo['is_buyer']}
    {foreach $not_pay as $k=>$v}
        <table class="hvpay-details-table" cellpadding="0" cellspacing="0">
            <tr>
                <th width="28%">支付状态：
                    <strong class="green">未支付</strong>
                </th>
                <th width="45%" style="color: #666;"></th>
                <th width="27%"></th>
            </tr>
            <tr>
                <td>支付金额：{$v['amount']}</td>
                <td>支付备注：{$v['payment_detail']['payment_title']}</td>
                <td>
                    <a target="_blank" href="{$_root}order_pay_new/bank/{$v['payment_id']}" style="display: inline-block;height:20px;line-height:20px;width: 95px;text-align: center" class="bg-magenta td-hvpay">立即支付</a>
                </td>
                {*{if $v['payment_status'] != 1}*}
                    {*<td><a href="javascript:;" class="bg-magenta td-hvpay js-l-paybtn" data-pid="{$v['payment_id']}">修改支付信息</a></td>*}
                {*{/if}*}
            </tr>
            <tr>
                <td>付款方：{$v['payment_detail']['pay_account_name']}</td>
                <td>收款方：{$v['payment_detail']['getpay_account_name']}</td>
                {if $v['payment_status']!=1}
                    <td><a href="javascript:;" class="payonline-delete green" data-payId="{$v['payment_id']}" data-amount="{$v['amount']}">删除支付信息</a></td>
                {/if}
            </tr>

        </table>
    {/foreach}

{else}

    {foreach $not_pay as $k=>$v}
        <table class="hvpay-details-table" cellpadding="0" cellspacing="0">
            <tr>
                <th width="28%">支付状态：
                    <strong class="green">未支付</strong>
                </th>
                <th width="45%" style="color: #666;"></th>
                <th width="27%"></th>
            </tr>
            <tr>
                <td>支付金额：{$v['amount']}</td>
                <td>支付备注：{$v['payment_detail']['payment_title']}</td>
                <td></td>
            </tr>
            <tr>
                <td>付款方：{$v['payment_detail']['pay_account_name']}</td>
                <td>收款方：{$v['payment_detail']['getpay_account_name']}</td>
                <td></td>
            </tr>
        </table>
    {/foreach}
{/if}
</div>