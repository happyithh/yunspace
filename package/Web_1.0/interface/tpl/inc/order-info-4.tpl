<div class="s_left_c mt-1">
    <div class="table-responsive mytable">
        <h3>{$orderinfo['order_conform']['协议标题']}</h3>
        <table class="table table-bordered">
            <thead>
            <tr class="active">
                <th width="20%">交易单价</th>
                <th width="15%">交易数量</th>
                <th width="25%">交付时间</th>
                <th width="20%">结算时间</th>
                <th width="20%">交易总计</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>{$orderinfo['order_conform']['交易单价']}元
                </td>
                <td>{$orderinfo['order_conform']['交易数量']}</td>
                <td>{$orderinfo['order_conform']['交付时间']}</td>
                <td>{$orderinfo['order_conform']['结算时间']}</td>
                <td>{$orderinfo['order_conform']['交易总计']}元
                </td>
            </tr>
            </tbody>
        </table>
    </div>
    <!--    第三个表格 -->
    <div class="table-responsive mytable">
        <table class="table table-bordered">
            <thead>
            <tr class="active">
                <th width="20%">支付节点</th>
                <th width="15%">支付比例</th>
                <th width="25%">支付期限</th>
                <th width="20%">支付总计</th>
                <th width="5%">结算</th>
                <th width="15%">操作/状态</th>
            </tr>
            </thead>
            <tbody>
            {foreach $orderinfo['payment'] as $k=>$v}
                <tr>
                    <td>{$v['payment_detail']['payment_title']}</td>
                    {if $v['payment_detail']['payment_percent']}
                        <td>{$v['payment_detail']['payment_percent']/100}
                            %
                        </td>
                    {else}
                        <td>-</td>
                    {/if}
                    <td>{date('Y-m-d', $v['payment_detail']['payment_deadline'])}</td>
                    <td>{$v['amount']}
                        元
                    </td>
                    <td>
                        {if $v['payment_detail']['is_settle']}<i class="fa fa-check"></i>{/if}
                    </td>
                    <td>
                        {if $v['payment_time']}
                            已付款
                        {else}
                            {if $orderinfo['is_buyer']&&(!$orderinfo['payment'][$k-1]||$orderinfo['payment'][$k-1]['payment_time']||!$v['payment_detail']['payment_percent'])}
                                {if Web_Account::subAccountHasAuth('支付',1)}
                                    <a href="{$_root}order_pay/bank/{$v['payment_id']}" class="btn btn-primary btn-sm">立即支付</a>
                                {else}
                                    <a href="javascript:void(0)" class="btn btn-primary btn-sm disabled">立即支付</a>
                                {/if}
                            {else}
                                等待付款
                            {/if}
                        {/if}
                    </td>
                </tr>
            {/foreach}
            </tbody>
        </table>
    </div>
</div>