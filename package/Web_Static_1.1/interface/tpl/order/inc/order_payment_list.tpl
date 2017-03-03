{if $orderinfo['is_buyer']}
    {foreach $paymentInfo as $k=>$v}
        <table class="hvpay-details-table" cellpadding="0" cellspacing="0">
            <tr>
                <th width="28%">支付方式：
                    <strong class="green">{$v['payment_method']}</strong>
                </th>
                <th width="45%" style="color: #666;">
                    支付时间：{date('Y-m-d H:i:s',$v['create_time'])}
                </th>
                <th width="27%"></th>
            </tr>
            <tr>
                <td>支付金额：{$v['payment_amount']}</td>
                <td>支付备注：{$v['payment_title']}</td>
                <td></td>
            </tr>
            <tr>
                <td>付款方：{$v['payment_info']['付款对象']}</td>
                <td>收款方：{$v['payment_info']['收款对象']}</td>
                {if $v['payment_status'] != 1}
                    <td><a href="javascript:;" class="bg-magenta td-hvpay js-l-paybtn" data-pid="{$v['payment_id']}">修改支付信息</a></td>
                {/if}
            </tr>
            <tr>
                <td>支付状态：
                    {if $v['payment_status']==-1}
                        待确认
                    {elseif $v['payment_status']==2}
                        已拒绝
                    {elseif $v['payment_status']==1}
                        已支付
                    {/if}
                    {if $v['payment_method']=="线下支付"}
                        <a href="javascript:;" class="blue td-lok js-show-transfer-pay">查看支付凭证</a>
                        {foreach $v['payment_info']['media'] as $k1=>$v1}
                            <p class = "transfer-pay-name" style="display: none;" >{$v1['name']}</p>
                            <p class = "transfer-pay-path" style="display: none;">{$v1['path']}</p>
                        {/foreach}
                    {/if}
                </td>
                <td></td>
                {if $v['payment_status']!=1}
                    <td><a href="javascript:;" class="payonline-delete green" data-payId="{$v['payment_id']}" data-amount="{$v['amount']}">删除支付信息</a></td>
                {/if}
            </tr>
            {if $v['payment_status']==2}
                <tr>
                    <td colspan="2">拒绝理由：{$v['refuse_reason']}</td>
                </tr>
            {/if}
        </table>
    {/foreach}

{else}


    {foreach $paymentInfo as $k=>$v}
        <table class="hvpay-details-table" cellpadding="0" cellspacing="0">
            <tr>
                <th width="28%">支付方式：
                    <strong class="green">{$v['payment_method']}</strong>
                </th>
                <th width="45%" style="color: #666;">
                    支付时间：{date('Y-m-d H:i:s',$v['create_time'])}
                </th>
                <th width="27%"></th>
            </tr>
            <tr>
                <td>支付金额：{$v['payment_amount']}</td>
                <td>支付备注：{$v['payment_title']}</td>
                <td></td>
            </tr>
            <tr>
                <td>付款方：{$v['payment_info']['付款对象']}</td>
                <td>收款方：{$v['payment_info']['收款对象']}</td>
                {if $v['payment_status']==-1}
                    <td><a href="javascript:;" class="bg-magenta td-hvpay confirm-transfer" data-pid="{$v['payment_id']}">确认已支付</a></td>
                {/if}
            </tr>

            <tr>
                <td>支付状态：
                    {if $v['payment_status']==-1}
                        待确认
                    {elseif $v['payment_status']==2}
                        已拒绝
                    {elseif $v['payment_status']==1}
                        已支付
                    {/if}
                    {if $v['payment_method']=="线下支付"}
                        <a href="javascript:;" class="blue td-lok js-show-transfer-pay">查看支付凭证</a>
                        {foreach $v['payment_info']['media'] as $k1=>$v1}
                            <p class = "transfer-pay-name" style="display: none;" >{$v1['name']}</p>
                            <p class = "transfer-pay-path" style="display: none;">{$v1['path']}</p>
                        {/foreach}
                    {/if}
                </td>
                <td></td>
                {if $v['payment_status']==-1}
                    <td><a href="javascript:;" class="refuse-transfer-submit green" data-pid="{$v['payment_id']}">拒绝确认</a></td>
                {/if}
            </tr>
            {if $v['payment_status']==2}
                <tr>
                    <td colspan="2">拒绝理由：{$v['refuse_reason']}</td>
                </tr>
            {/if}
        </table>
    {/foreach}
{/if}