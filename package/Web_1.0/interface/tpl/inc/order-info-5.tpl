<div class="s_left_c mt-1">
    <div class="table-responsive mytable">
        <table class="table table-bordered">
            <tbody>
            <tr>
                <td width="20%">服务名称</td>
                <td style="text-align: left">{$orderinfo['order_conform']['服务名称']}</td>
            </tr>
            <tr>
                <td>服务内容</td>
                <td style="text-align: left">{nl2br($orderinfo['order_conform']['服务内容'])}</td>
            </tr>
            <tr>
                <td>备注</td>
                <td style="text-align: left">{nl2br($orderinfo['order_conform']['备注'])}</td>
            </tr>
            </tbody>
        </table>

    </div>
    <div class="jyyd jym">订单金额与结算</div>
    <!--    第三个表格 -->
    <div class="table-responsive mytable">
        <table class="table table-bordered">
            <thead>
            <tr class="active">
                <th width="20%">交易单价</th>
                <th width="15%">交易数量</th>
                <th width="25%">交易总计</th>
                <th width="20%">交付时间</th>
                <th width="20%">结算时间</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>{$orderinfo['order_conform']['交易单价']}元
                </td>
                <td>{$orderinfo['order_conform']['交易数量']}</td>
                <td>{$orderinfo['order_conform']['交易总计']}元
                </td>
                <td>{$orderinfo['order_conform']['交付时间']}</td>
                <td>{$orderinfo['order_conform']['结算时间']}</td>
            </tr>
            </tbody>
        </table>
    </div>

    <div class="jyyd jym">支付详情</div>
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
    <div class="jyyd jym">附件文件</div>
    <div>
        {foreach $orderinfo['order_conform']['附件'] as $v}
            <a class="fujian" href="{$v['path']}" target="_blank"><i class="fa fa-paperclip"></i><span>{$v['name']}</span></a>
        {/foreach}
    </div>
    {if $orderinfo['order_complete']}
        <div class="jyyd jym">结算与评价</div>
        <!--    第三个表格 -->
        <div class="table-responsive mytable">
            <table class="table table-bordered">
                <tbody>
                <tr>
                    <td width="20%">订单评价</td>
                    <td style="text-align: left">
                        {for $i=1 to $orderinfo['order_complete']['订单评价']}
                            <i class="fa fa-star"></i>
                        {/for}
                    </td>
                </tr>
                <tr>
                    <td>问题意见</td>
                    <td style="text-align: left">{$orderinfo['order_complete']['问题意见']|default:'无'}</td>
                </tr>
                <tr>
                    <td>订单金额</td>
                    <td style="text-align: left">{($orderinfo['order_complete']['订单金额'])}
                        元
                    </td>
                </tr>
                <tr>
                    <td>订单外金额</td>
                    <td style="text-align: left">{$orderinfo['order_price_settle']  - $orderinfo['order_price_settle_in']}
                        元
                    </td>
                </tr>
                <tr>
                    <td>待结算金额</td>
                    <td style="text-align: left">{$orderinfo['order_price_settle_in']}
                        元
                    </td>
                </tr>
                <tr>
                    <td>结算金额</td>
                    <td style="text-align: left">{($orderinfo['order_complete']['结算金额'])}
                        元
                    </td>
                </tr>
                <tr>
                    <td>实付金额</td>
                    <td style="text-align: left">{$orderinfo['order_price'] - $orderinfo['order_price_settle_in'] +($orderinfo['order_complete']['结算金额'])}
                        元
                    </td>
                </tr>
                <tr>
                    <td>退还金额</td>
                    <td style="text-align: left">{$orderinfo['order_price_settle'] -($orderinfo['order_complete']['结算金额'])}
                        元
                    </td>
                </tr>
                <tr>
                    <td>发票</td>
                    <td style="text-align: left">{nl2br($orderinfo['order_complete']['确认已收到发票']|default:'无')}
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
    {/if}
    {if !$orderinfo['create_time5']}
        {if $orderinfo['is_buyer']&&Web_Account::subAccountHasAuth('结算',1)}
            <div class="paytip">
                <p>
                    <i class="fa fa-lightbulb-o"></i>
                    <span>提示：担保交易的金额将在交易结算后全部划转至交易对方账户。</span>
                </p>
            </div>
            <div class="allpay">
                <button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal">
                    交易结算
                </button>
            </div>
            {include file="inc/order-info-5-buyer.tpl"}
        {elseif $orderinfo['is_vendor']&&Web_Account::subAccountHasAuth('结算',21)&&!empty($orderinfo['order_complete'])}
            <div class="allpay">
                <button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal">
                    确认结算信息
                </button>
            </div>
            {include file="inc/order-info-5-vendor.tpl"}
        {/if}
    {/if}
</div>