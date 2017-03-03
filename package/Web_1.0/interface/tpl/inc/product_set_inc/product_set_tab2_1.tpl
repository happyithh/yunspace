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
                {if $paymentInfo[$orderinfo['payment'][2]['payment_id']]['payment_status']==-1}
                    <h5 class="pay_state1">待确认</h5>
                {elseif $paymentInfo[$orderinfo['payment'][2]['payment_id']]['payment_status']==2}
                    <h5 class="pay_state1">未通过</h5>
                {else}
                    <h5 class="pay_state1">待支付</h5>
                {/if}
            {else}
                <h5 class="pay_state">已支付</h5>
            {/if}
                {if $orderinfo['create_time3']}
                    <h5 class="pay_time">
                        {date('Y-m-d H:i:s',$orderinfo['create_time3'])}
                    </h5>
                {elseif $orderinfo['is_buyer'] && !$paymentInfo[$orderinfo['payment'][2]['payment_id']]['payment_info']}
                  <h5 class="pay_time">
                    <a href="{$_root}product_set_order_pay/bank/{$orderinfo['payment'][2]['payment_id']}" class="btn btn-primary pay_btn">支付全款</a>
                  </h5>
                {elseif $orderinfo['is_buyer'] && $paymentInfo[$orderinfo['payment'][2]['payment_id']]['payment_status']==2}
                  <h5 class="pay_time">
                    <a href="{$_root}product_set_order_pay/bank/{$orderinfo['payment'][2]['payment_id']}" class="btn btn-primary pay_btn">修改转账信息</a>
                  </h5>
                {elseif $orderinfo['is_vendor'] && $paymentInfo[$orderinfo['payment'][2]['payment_id']]['payment_status']==-1}
                  <h5 class="pay_time">
                    <a href="{$_root}product_set_order_pay/confirm_pay/{$orderinfo['payment'][2]['payment_id']}" class="btn btn-primary pay_btn">确认全款</a>
                  </h5>
                  <h5 class="pay_time">
                    <a href="{$_root}product_set_order_pay/not_confirm_pay/{$orderinfo['payment'][2]['payment_id']}" class="btn btn-danger pay_btn">未收到全款</a>
                  </h5>
                {/if}
            <div class="clearfix"></div>
        </div>
        <div class="panel-body">
            <div class="table-responsive">
                <table class="pay_table">
                    <tr>
                        <td class="pay_t"><strong>收款对象：</strong></td>
                        <td class="pay_c">{$orderinfo['payment']['target_bank_info']['account_name']|default:'尚未绑定银行卡'}</td>
                        <td cospan="4" class="pay_p" align="right">￥{$orderinfo['order_price']}</td>
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
                    {if $paymentInfo[$orderinfo['payment'][2]['payment_id']]['payment_info'] || $orderinfo['order_price_pay']}
                        <tr>
                            <td><strong>付款方式：</strong></td>
                            <td>
                                {$paymentInfo[$orderinfo['payment'][2]['payment_id']]['payment_method']}
                            </td>
                        </tr>
                        {if $paymentInfo[$orderinfo['payment'][2]['payment_id']]['payment_method']=='银行转账'}
                            {foreach $paymentInfo[$orderinfo['payment'][2]['payment_id']]['payment_info'] as $k=>$v}
                                <tr>
                                    <td><strong>{$k}</strong></td>
                                    <td>{$v}</td>
                                </tr>
                            {/foreach}
                        {/if}
                        {if $paymentInfo[$orderinfo['payment'][2]['payment_id']]['payment_img']}
                            <tr>
                                <td><strong>转账截图：</strong></td>
                                <td>
                                    <a target="_blank" href="{Page_Site_Global::displayMedia($paymentInfo[$orderinfo['payment'][2]['payment_id']]['payment_img'],768,0,1)}">
                                        <img src="{Page_Site_Global::displayMedia($paymentInfo[$orderinfo['payment'][2]['payment_id']]['payment_img'],100,0,1)}"/>
                                    </a>
                                </td>
                            </tr>
                        {/if}
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
                        {elseif $paymentInfo[$orderinfo['payment'][2]['payment_id']]['payment_status']==-1}
                            <span class="btn btn-success pay_btn">待确认</span>
                        {elseif $paymentInfo[$orderinfo['payment'][2]['payment_id']]['payment_status']==2}
                            <span class="btn btn-danger pay_btn">未通过</span>
                            <a href="{$_root}product_set_order_pay/bank/{$orderinfo['payment'][2]['payment_id']}" class="btn btn-success pay_btn">修改转账信息</a>
                        {/if}
                    {elseif $orderinfo['is_vendor'] && $paymentInfo[$orderinfo['payment'][2]['payment_id']]['payment_status']==-1}
                        <a href="{$_root}product_set_order_pay/confirm_pay/{$orderinfo['payment'][2]['payment_id']}" class="btn btn-success pay_btn">确认已支付全款</a>
                        <a href="{$_root}product_set_order_pay/not_confirm_pay/{$orderinfo['payment'][2]['payment_id']}" class="btn btn-danger pay_btn">未收到全款</a>
                    {/if}
                </div>
            </div>
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h5 class="pay_title">支付名目：交易定金</h5>
                    {if $orderinfo['order_price_pay']==0}
                        {if $paymentInfo[$orderinfo['payment'][0]['payment_id']]['payment_status']==-1 || $paymentInfo[$orderinfo['payment'][2]['payment_id']]['payment_status']==-1}
                            <h5 class="pay_state1">待确认</h5>
                        {elseif $paymentInfo[$orderinfo['payment'][0]['payment_id']]['payment_status']==2 || $paymentInfo[$orderinfo['payment'][2]['payment_id']]['payment_status']==2}
                            <h5 class="pay_state1">未通过</h5>
                        {else}
                            <h5 class="pay_state1">待支付</h5>
                        {/if}
                    {else}
                        <h5 class="pay_state">已支付</h5>
                    {/if}

                        {if $orderinfo['create_time3']}
                            <h5 class="pay_time">
                                {date('Y-m-d H:i:s',$orderinfo['create_time3'])}
                            </h5>
                        {elseif $orderinfo['is_buyer'] && !$paymentInfo[$orderinfo['payment'][0]['payment_id']]['payment_info'] && !$paymentInfo[$orderinfo['payment'][2]['payment_id']]['payment_info']}
                             <h5 class="pay_time">
                                <a href="{$_root}product_set_order_pay/bank/{$orderinfo['payment'][0]['payment_id']}" class="btn btn-primary pay_btn">支付定金</a>
                             </h5>
                        {elseif $orderinfo['is_buyer'] && $paymentInfo[$orderinfo['payment'][0]['payment_id']]['payment_status']==2}
                            <h5 class="pay_time">
                                <a href="{$_root}product_set_order_pay/bank/{$orderinfo['payment'][0]['payment_id']}" class="btn btn-primary pay_btn">修改转账信息</a>
                            </h5>
                        {elseif $orderinfo['is_vendor'] && $paymentInfo[$orderinfo['payment'][0]['payment_id']]['payment_status']==-1}
                            <h5 class="pay_time">
                                <a href="{$_root}product_set_order_pay/confirm_pay/{$orderinfo['payment'][0]['payment_id']}" class="btn btn-primary pay_btn">确认定金</a>
                            </h5>
                            <h5 class="pay_time">
                                <a href="{$_root}product_set_order_pay/not_confirm_pay/{$orderinfo['payment'][0]['payment_id']}" class="btn btn-danger pay_btn">未收到定金</a>
                            </h5>
                        {/if}
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
                            {if $paymentInfo[$orderinfo['payment'][0]['payment_id']]['payment_info']}
                                <tr>
                                    <td><strong>付款方式：</strong></td>
                                    <td>
                                        {if $paymentInfo[$orderinfo['payment'][0]['payment_id']]['payment_method']}
                                            {$paymentInfo[$orderinfo['payment'][0]['payment_id']]['payment_method']}
                                        {elseif $paymentInfo[$orderinfo['payment'][2]['payment_id']]['payment_method']}
                                            {$paymentInfo[$orderinfo['payment'][2]['payment_id']]['payment_method']}
                                        {/if}
                                    </td>
                                </tr>
                                    {if $paymentInfo[$orderinfo['payment'][0]['payment_id']]['payment_method']=='银行转账' || $paymentInfo[$orderinfo['payment'][2]['payment_id']]['payment_method']=='银行转账'}
                                        {foreach $paymentInfo[$orderinfo['payment'][0]['payment_id']]['payment_info'] as $k=>$v}
                                            <tr>
                                                <td><strong>{$k}</strong></td>
                                                <td>{$v}</td>
                                            </tr>
                                        {/foreach}
                                    {/if}
                                {if $paymentInfo[$orderinfo['payment'][0]['payment_id']]['payment_img']}
                                    <tr>
                                        <td><strong>转账截图：</strong></td>
                                        <td>
                                            <a target="_blank" href="{Page_Site_Global::displayMedia($paymentInfo[$orderinfo['payment'][0]['payment_id']]['payment_img'],768,0,1)}">
                                                <img src="{Page_Site_Global::displayMedia($paymentInfo[$orderinfo['payment'][0]['payment_id']]['payment_img'],100,0,1)}"/>
                                            </a>
                                        </td>
                                    </tr>
                                {/if}
                            {elseif $paymentInfo[$orderinfo['payment'][2]['payment_id']]['payment_info']}
                                <tr>
                                    <td><strong>付款方式：</strong></td>
                                    <td>
                                        {if $paymentInfo[$orderinfo['payment'][0]['payment_id']]['payment_method']}
                                            {$paymentInfo[$orderinfo['payment'][0]['payment_id']]['payment_method']}
                                        {elseif $opaymentInfo[$orderinfo['payment'][2]['payment_id']]['payment_method']}
                                            {$paymentInfo[$orderinfo['payment'][2]['payment_id']]['payment_method']}
                                        {/if}
                                    </td>
                                </tr>
                                {if $paymentInfo[$orderinfo['payment'][0]['payment_id']]['payment_method']=='银行转账' || $paymentInfo[$orderinfo['payment'][2]['payment_id']]['payment_method']=='银行转账'}
                                    {foreach $paymentInfo[$orderinfo['payment'][2]['payment_id']]['payment_info'] as $k=>$v}
                                        <tr>
                                            <td><strong>{$k}</strong></td>
                                            <td>{$v}</td>
                                        </tr>
                                    {/foreach}
                                {/if}

                                {if $paymentInfo[$orderinfo['payment'][2]['payment_id']]['payment_img']}
                                    <tr>
                                        <td><strong>转账截图：</strong></td>
                                        <td>
                                            <a target="_blank" href="{Page_Site_Global::displayMedia($paymentInfo[$orderinfo['payment'][2]['payment_id']]['payment_img'],768,0,1)}">
                                                <img src="{Page_Site_Global::displayMedia($paymentInfo[$orderinfo['payment'][2]['payment_id']]['payment_img'],100,0,1)}"/>
                                            </a>
                                        </td>
                                    </tr>
                                {/if}
                            {elseif $orderinfo['order_price_pay']}
                                <tr>
                                    <td><strong>付款方式：</strong></td>
                                    <td>
                                        {if $paymentInfo[$orderinfo['payment'][0]['payment_id']]['payment_method']}
                                            {$paymentInfo[$orderinfo['payment'][0]['payment_id']]['payment_method']}
                                        {elseif $opaymentInfo[$orderinfo['payment'][2]['payment_id']]['payment_method']}
                                            {$paymentInfo[$orderinfo['payment'][2]['payment_id']]['payment_method']}
                                        {/if}
                                    </td>
                                </tr>
                                <tr>
                                    <td><strong>付款对象：</strong></td>
                                    <td>{$orderinfo['payment']['buyer_bank_info']['account_name']}</td>
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
                        {if $orderinfo['order_price_pay']!=$orderinfo['order_price']}
                            {if $paymentInfo[$orderinfo['payment'][1]['payment_id']]['payment_status']==-1 || $paymentInfo[$orderinfo['payment'][2]['payment_id']]['payment_status']==-1}
                                <h5 class="pay_state1">待确认</h5>
                            {elseif $paymentInfo[$orderinfo['payment'][1]['payment_id']]['payment_status']==2 || $paymentInfo[$orderinfo['payment'][2]['payment_id']]['payment_status']==2}
                                <h5 class="pay_state1">未通过</h5>
                            {else}
                                <h5 class="pay_state1">待支付</h5>
                            {/if}
                        {else}
                            <h5 class="pay_state">已支付</h5>
                        {/if}
                            {if $orderinfo['create_time4']}
                                <h5 class="pay_time">
                                    {date('Y-m-d H:i:s',$orderinfo['create_time4'])}
                                </h5>
                            {elseif $orderinfo['is_buyer'] && !$paymentInfo[$orderinfo['payment'][1]['payment_id']]['payment_info'] && !$paymentInfo[$orderinfo['payment'][2]['payment_id']]['payment_info']}
                                <h5 class="pay_time">
                                    <a href="{$_root}product_set_order_pay/bank/{$orderinfo['payment'][1]['payment_id']}" class="btn btn-primary pay_btn">支付尾款</a>
                                </h5>
                            {elseif $orderinfo['is_buyer'] && $paymentInfo[$orderinfo['payment'][1]['payment_id']]['payment_status']==2}
                                <h5 class="pay_time">
                                    <a href="{$_root}product_set_order_pay/bank/{$orderinfo['payment'][1]['payment_id']}" class="btn btn-primary pay_btn">修改转账信息</a>
                                </h5>
                            {elseif $orderinfo['is_vendor'] && $paymentInfo[$orderinfo['payment'][1]['payment_id']]['payment_status']==-1}
                                <h5 class="pay_time">
                                    <a href="{$_root}product_set_order_pay/confirm_pay/{$orderinfo['payment'][1]['payment_id']}" class="btn btn-primary pay_btn">确认尾款</a>
                                </h5>
                                <h5 class="pay_time">
                                    <a href="{$_root}product_set_order_pay/not_confirm_pay/{$orderinfo['payment'][1]['payment_id']}" class="btn btn-danger pay_btn">未收到尾款</a>
                                </h5>
                            {/if}
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
                                {if  $paymentInfo[$orderinfo['payment'][1]['payment_id']]['payment_method']=='账户支付' || $paymentInfo[$orderinfo['payment'][1]['payment_id']]['payment_method']=='在线支付' || $paymentInfo[$orderinfo['payment'][2]['payment_id']]['payment_method']=='账户支付' || $paymentInfo[$orderinfo['payment'][2]['payment_id']]['payment_method']=='在线支付'}
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
                                {if $paymentInfo[$orderinfo['payment'][1]['payment_id']]['payment_info']}
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
                                    {if $paymentInfo[$orderinfo['payment'][1]['payment_id']]['payment_method']=='银行转账' || $paymentInfo[$orderinfo['payment'][2]['payment_id']]['payment_method']=='银行转账'}
                                        {foreach $paymentInfo[$orderinfo['payment'][1]['payment_id']]['payment_info'] as $k=>$v}
                                            <tr>
                                                <td><strong>{$k}</strong></td>
                                                <td>{$v}</td>
                                            </tr>
                                        {/foreach}
                                    {/if}

                                    {if $paymentInfo[$orderinfo['payment'][1]['payment_id']]['payment_img']}
                                        <tr>
                                            <td><strong>转账截图：</strong></td>
                                            <td>
                                                <a target="_blank" href="{Page_Site_Global::displayMedia($paymentInfo[$orderinfo['payment'][1]['payment_id']]['payment_img'],768,0,1)}">
                                                    <img src="{Page_Site_Global::displayMedia($paymentInfo[$orderinfo['payment'][1]['payment_id']]['payment_img'],100,0,1)}"/>
                                                </a>
                                            </td>
                                        </tr>
                                    {/if}
                                {elseif $paymentInfo[$orderinfo['payment'][2]['payment_id']]['payment_info']}
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
                                    {if $paymentInfo[$orderinfo['payment'][1]['payment_id']]['payment_method']=='银行转账' || $paymentInfo[$orderinfo['payment'][2]['payment_id']]['payment_method']=='银行转账'}
                                        {foreach $paymentInfo[$orderinfo['payment'][2]['payment_id']]['payment_info'] as $k=>$v}
                                            <tr>
                                                <td><strong>{$k}</strong></td>
                                                <td>{$v}</td>
                                            </tr>
                                        {/foreach}
                                    {/if}

                                    {if $paymentInfo[$orderinfo['payment'][2]['payment_id']]['payment_img']}
                                        <tr>
                                            <td><strong>转账截图：</strong></td>
                                            <td>
                                                <a target="_blank" href="{Page_Site_Global::displayMedia($paymentInfo[$orderinfo['payment'][2]['payment_id']]['payment_img'],768,0,1)}">
                                                    <img src="{Page_Site_Global::displayMedia($paymentInfo[$orderinfo['payment'][2]['payment_id']]['payment_img'],100,0,1)}"/>
                                                </a>
                                            </td>
                                        </tr>
                                    {/if}
                                {elseif $orderinfo['order_price_pay']==$orderinfo['order_price']}
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
                                    <tr>
                                        <td><strong>付款对象：</strong></td>
                                        <td>{$orderinfo['payment']['buyer_bank_info']['account_name']}</td>
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