<div class="booking">

    <div class="s_left_c mt-1">
        <div class="table-responsive mytable">
            <table class="table table-bordered">
                <thead>

                {$_order['payment']}
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
                    <td>{$_order['order_conform']['交易单价']}元
                    </td>
                    <td>{$_order['order_conform']['交易数量']}</td>
                    <td>{$_order['order_conform']['交付时间']}</td>
                    <td>{$_order['order_conform']['结算时间']}</td>
                    <td>{$_order['order_conform']['交易总计']}元
                    </td>

                </tr>
                </tbody>
            </table>
        </div>

        <div class="table-responsive mytable">
            <table class="table table-bordered">
                <thead>
                <tr class="active">
                    <th width="20%">支付节点</th>
                    <th width="15%">支付比例</th>
                    <th width="25%">支付总计</th>
                    <th width="20%">支付期限</th>
                    <th width="20%">操作/状态</th>
                </tr>
                </thead>
                <tbody>

                {foreach $_order['order_conform']['支付节点'] as $v}
                    <tr>
                        <td>{$v['名称']}</td>
                        <td>{$v['比例']}%</td>
                        <td>{$v['金额']}元</td>
                        <td>{$v['期限']}</td>
                        <td>{$v['']}</td>

                    </tr>
                {/foreach}
                {*<tr>*}
                    {*<td>1. 首付款</td>*}
                    {*<td>30%</td>*}
                    {*<td>2015-03-13</td>*}
                    {*<td>3000 元</td>*}
                    {*<td>*}
                        {*<a href="/pros/yunspace/order_pay?payment=%2Bi1xsPDx0omqUo8IWgKDuw%3D%3D" class="btn btn-primary btn-sm" target="_blank">立即支付</a>*}
                    {*</td>*}
                {*</tr>*}
                {*<tr>*}
                    {*<td>2. 尾款</td>*}
                    {*<td>70%</td>*}
                    {*<td>2015-03-13</td>*}
                    {*<td>7000 元</td>*}
                    {*<td>*}
                        {*等待付款*}
                    {*</td>*}
                {*</tr>*}
                </tbody>
            </table>
        </div>
    </div>
</div>