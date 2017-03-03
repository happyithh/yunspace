
{if ($orderinfo['start_time']-10*24*3600) < time()}
    <div class="s_left_c mt0">
        <div class="pay_content">
            <div class="row pay_summary">
                <div class="col-md-10">温馨提示：1.我司线上支付合作方为第三方支付机构：银联在线，汇付天下。预订人在订单支付时，银行端显示的支付对象应为：上海银联电子支付服务有限公司，上海汇付数据服务有限公司。</div>
            </div>
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h5 class="pay_title">支付名目：交易全款</h5>
                    {if $orderinfo['order_price_pay']==0}
                        <h5 class="pay_state1">待支付</h5>
                    {else}
                        <h5 class="pay_state">已支付</h5>
                    {/if}
                    <h5 class="pay_time" data-pi="{$orderinfo['payment'][2]['payment_id']}">
                        {if $orderinfo['create_time3']}
                            {date('Y-m-d H:i:s',$orderinfo['create_time3'])}
                        {elseif $orderinfo['is_buyer']}
                            <a href="{$_root}product_set_order_pay/bank/{$orderinfo['payment'][2]['payment_id']}" class="btn btn-primary pay_btn">支付全款</a>
                        {/if}
                    </h5>
                    <div class="clearfix"></div>
                </div>
                <div class="panel-body">
                    {*{if $orderinfo['order_no']=='S000002571508120000002265'}*}
                        {*S000002571508120000002265*}
                        {*<div style="border: 1px solid #eee;text-align: center;padding: 5px;" >*}
                            {*<span>扫码使用微信支付</span>*}
                            {*<br/>*}
                            {*<img src="img/set_pay/pay_img.png">*}
                            {*<iframe style="border: none;width: 220px;height: 220px;" src="{$_root}wechat_code/"></iframe>*}
                        {*</div>*}
                    {*{/if}*}
                    <div class="table-responsive">
                        <table class="pay_table">
                            <tr>
                                <td class="pay_t"><strong>收款对象：</strong></td>
                                <td class="pay_c">{$orderinfo['payment']['target_bank_info']['account_name']|default:'尚未绑定银行卡'}</td>
                                <td cospan="4" class="pay_p" align="right">￥{$orderinfo['order_price']}</td>
                            </tr>
                            {if $paymentInfo[$orderinfo['payment'][2]['payment_id']]['payment_method']=='账户支付' || $paymentInfo[$orderinfo['payment'][2]['payment_id']]['payment_method']=='在线支付'}
                                {if $orderinfo['is_vendor']}
                                    <tr>
                                        <td><strong>账户余额：</strong></td>
                                        <td>￥{$orderinfo['payment']['target_bank_info']['balance']}</td>
                                    </tr>
                                {/if}
                            {else}
                                <tr>
                                    <td><strong>收款账户：</strong></td>

                                    <td>
                                        {if $orderinfo['payment']['target_bank_info']['bank_card']}
                                            {$orderinfo['payment']['target_bank_info']['bank_name']}<span>卡号：{substr({$orderinfo['payment']['target_bank_info']['bank_card']},0,4)}****{substr({$orderinfo['payment']['target_bank_info']['bank_card']},-4)}</span>
                                        {else}
                                            尚未绑定银行卡
                                        {/if}
                                    </td>
                                </tr>
                            {/if}
                            {if $orderinfo['order_price_pay']}
                                <tr>
                                    <td><strong>付款对象：</strong></td>
                                    <td>{$orderinfo['payment']['buyer_bank_info']['account_name']}</td>
                                </tr>
                                <tr>
                                    <td><strong>付款方式：</strong></td>
                                    <td>
                                        {$paymentInfo[$orderinfo['payment'][2]['payment_id']]['payment_method']}
                                    </td>
                                </tr>
                            {/if}
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
{else}
    <div class="s_left_c mt0">
        <div class="pay_content">
            <div class="row pay_summary">
                <div class="col-md-10">温馨提示：1.我司线上支付合作方为第三方支付机构：银联在线，汇付天下。预订人在订单支付时，银行端显示的支付对象应为：上海银联电子支付服务有限公司，上海汇付数据服务有限公司。</div>
                <div class="col-md-2">
                    {if $orderinfo['is_buyer']}
                        {if $orderinfo['create_time4']}
                            <span class="btn btn-success pay_btn">已支付</span>
                        {elseif $orderinfo['create_time3'] && !$orderinfo['create_time4']}
                            <a href="{$_root}product_set_order_pay/bank/{$orderinfo['payment'][1]['payment_id']}" class="btn btn-success pay_btn">支付尾款</a>
                        {else}
                            <a href="{$_root}product_set_order_pay/bank/{$orderinfo['payment'][2]['payment_id']}" class="btn btn-success pay_btn">全款支付</a>
                        {/if}
                    {/if}
                </div>
            </div>
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h5 class="pay_title">支付名目：交易定金</h5>
                    {if $orderinfo['order_price_pay']==0}
                        <h5 class="pay_state1">待支付</h5>
                    {else}
                        <h5 class="pay_state">已支付</h5>
                    {/if}
                    <h5 class="pay_time">
                        {if $orderinfo['create_time3']}
                            {date('Y-m-d H:i:s',$orderinfo['create_time3'])}
                        {elseif $orderinfo['is_buyer']}
                            <a href="{$_root}product_set_order_pay/bank/{$orderinfo['payment'][0]['payment_id']}" class="btn btn-primary pay_btn">支付定金</a>
                        {/if}
                    </h5>
                    <div class="clearfix"></div>
                </div>
                <div class="panel-body">
                    <div class="table-responsive">
                        <table class="pay_table">
                            <tr>
                                <td class="pay_t"><strong>收款对象：</strong></td>
                                <td class="pay_c">{$orderinfo['payment']['target_bank_info']['account_name']|default:'尚未绑定银行卡'}</td>
                                <td cospan="4" class="pay_p" align="right">￥{$orderinfo['order_price']*0.3}</td>
                            </tr>
                            {if $paymentInfo[$orderinfo['payment'][0]['payment_id']]['payment_method']=='账户支付' || $paymentInfo[$orderinfo['payment'][0]['payment_id']]['payment_method']=='在线支付' || $paymentInfo[$orderinfo['payment'][2]['payment_id']]['payment_method']=='账户支付' || $paymentInfo[$orderinfo['payment'][2]['payment_id']]['payment_method']=='在线支付'}
                                {if $orderinfo['is_vendor']}
                                    <tr>
                                        <td><strong>账户余额：</strong></td>
                                        <td>￥{$orderinfo['payment']['target_bank_info']['balance']}</td>
                                    </tr>
                                {/if}
                            {else}
                                <tr>
                                    <td><strong>收款账户：</strong></td>

                                    <td>
                                        {if $orderinfo['payment']['target_bank_info']['bank_card']}
                                            {$orderinfo['payment']['target_bank_info']['bank_name']}<span>卡号：{substr({$orderinfo['payment']['target_bank_info']['bank_card']},0,4)}****{substr({$orderinfo['payment']['target_bank_info']['bank_card']},-4)}</span>
                                        {else}
                                            尚未绑定银行卡
                                        {/if}
                                    </td>
                                </tr>
                            {/if}
                            {if $orderinfo['order_price_pay']}
                                <tr>
                                    <td><strong>付款对象：</strong></td>
                                    <td>{$orderinfo['payment']['buyer_bank_info']['account_name']}</td>
                                </tr>
                                <tr>
                                    <td><strong>付款方式：</strong></td>
                                    <td>
                                        {if $paymentInfo[$orderinfo['payment'][0]['payment_id']]['payment_method']}
                                            {$paymentInfo[$orderinfo['payment'][0]['payment_id']]['payment_method']}
                                        {else}
                                            {$paymentInfo[$orderinfo['payment'][2]['payment_id']]['payment_method']}
                                        {/if}
                                    </td>
                                </tr>
                            {/if}
                        </table>
                    </div>
                </div>
            </div>
            <div class="pay_content">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h5 class="pay_title">支付名目：交易尾款</h5>
                        {if $orderinfo['order_price_pay'] == $orderinfo['order_price']}
                            <h5 class="pay_state">已支付</h5>
                        {else}
                            <h5 class="pay_state1">待支付</h5>
                        {/if}
                        <h5 class="pay_time" style="margin-top: 0px; margin-bottom: 0px;">
                            {if $orderinfo['create_time4']}
                                {date('Y-m-d H:i:s',$orderinfo['create_time4'])}
                            {elseif $orderinfo['is_buyer']}
                                <a href="{$_root}product_set_order_pay/bank/{$orderinfo['payment'][1]['payment_id']}" class="btn btn-primary pay_btn">支付尾款</a>
                            {/if}
                        </h5>
                        <div class="clearfix"></div>
                    </div>
                    <div class="panel-body">
                        <div class="table-responsive">
                            <table class="pay_table">
                                <tr>
                                    <td class="pay_t"><strong>收款对象：</strong></td>
                                    <td class="pay_c">{$orderinfo['payment']['target_bank_info']['account_name']|default:'尚未绑定银行卡'}</td>
                                    <td colspan="4" class="pay_p" align="right">￥{$orderinfo['order_price']*0.7}</td>
                                </tr>
                                {if $paymentInfo[$orderinfo['payment'][1]['payment_id']]['payment_method']=='账户支付' || $paymentInfo[$orderinfo['payment'][1]['payment_id']]['payment_method']=='在线支付' || $paymentInfo[$orderinfo['payment'][2]['payment_id']]['payment_method']=='账户支付' || $paymentInfo[$orderinfo['payment'][2]['payment_id']]['payment_method']=='在线支付'}
                                    {if $orderinfo['is_vendor']}
                                        <tr>
                                            <td><strong>账户余额：</strong></td>
                                            <td>￥{$orderinfo['payment']['target_bank_info']['balance']}</td>
                                        </tr>
                                    {/if}
                                {else}
                                    <tr>
                                        <td><strong>收款账户：</strong></td>

                                        <td>
                                            {if $orderinfo['payment']['target_bank_info']['bank_card']}
                                                {$orderinfo['payment']['target_bank_info']['bank_name']}<span>卡号：{substr({$orderinfo['payment']['target_bank_info']['bank_card']},0,4)}****{substr({$orderinfo['payment']['target_bank_info']['bank_card']},-4)}</span>
                                            {else}
                                                尚未绑定银行卡
                                            {/if}
                                        </td>
                                    </tr>
                                {/if}

                                {if $orderinfo['order_price_pay'] == $orderinfo['order_price']}
                                    <tr>
                                        <td><strong>付款对象：</strong></td>
                                        <td>{$orderinfo['payment']['buyer_bank_info']['account_name']}</td>
                                    </tr>
                                    <tr>
                                        <td><strong>付款方式：</strong></td>
                                        <td>
                                            {if $paymentInfo[$orderinfo['payment'][1]['payment_id']]['payment_method']}
                                                {$paymentInfo[$orderinfo['payment'][1]['payment_id']]['payment_method']}
                                            {elseif $paymentInfo[$orderinfo['payment'][2]['payment_id']]['payment_method']}
                                                {$paymentInfo[$orderinfo['payment'][2]['payment_id']]['payment_method']}
                                            {/if}
                                        </td>
                                    </tr>
                                {/if}
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
{/if}