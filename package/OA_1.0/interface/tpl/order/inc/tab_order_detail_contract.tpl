<div class="booking">

    <div class="s_left_c mt-1">
        <div class="container-fluid">
        <div class="row">
            <div class="col-md-6 deal_info" style="padding-left: 0px;">

                <div class="bor">
                    <p>
                        <font>甲方:</font><span>{nl2br($_order['order_conform']['供应商名称'])}</span>
                    </p>

                    <p>
                        <font>签约授权代表:</font><span>{nl2br($_order['order_conform']['供应商签约代表'])|default:'未定义'}</span>
                    </p>

                    <p>
                        <font>签约方式:</font><span>交易密码签约</span>
                    </p>
                    <p>
                        <font>签约日期:</font><span>{Date('Y.m.d',$_order['order_conform']['vendor_signing'])}</span>
                    </p>
                </div>
            </div>

            <div class="col-md-6 deal_info" style="padding: 0px;">

                <div class="bor">
                    <p>
                        <font>乙方:</font><span></span>
                    </p>

                    <p>
                        <font>签约授权代表:</font><span></span>
                    </p>
                    <p>
                        <font>签约方式:</font><span></span>
                    </p>
                    <p>
                        <font>签约日期:</font><span>{Date('Y.m.d',$_order['order_conform']['buyer_signing'])}</span>
                    </p>
                </div>
            </div>
            </div>
        </div>

        <div class="allt border1">
            <h1>{nl2br($_order['order_conform']['协议标题'])}</h1>

            <div class="table-responsive mytable">
                <table class="table table-bordered">
                    <thead>
                    <tr>
                        <th width="20%">签约方</th>
                        <th width="40%">甲方</th>
                        <th>乙方</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>公司名称</td>
                        <td>{$_order['order_conform']['供应商名称']}</td>
                        <td>{$_order['order_conform']['买家名称']}</td>
                    </tr>
                    <tr>
                        <td>代表</td>
                        <td>{$_order['order_conform']['供应商签约代表']|default:'未定义'}</td>
                        <td>{nl2br($_order['order_conform']['买家签约代表'])}</td>
                    </tr>
                    <tr>
                        <td>地址</td>
                        <td>{nl2br($_order['order_conform']['供应商地址'])}</td>
                        <td>{nl2br($_order['order_conform']['买家地址'])}</td>
                    </tr>
                    <tr>
                        <td>电话</td>
                        <td>{$_order['order_conform']['供应商电话']}</td>
                        <td>{$_order['order_conform']['买家电话']}</td>
                    </tr>
                    <tr>
                        <td>传真</td>
                        <td>{$_order['order_conform']['供应商传真']}</td>
                        <td>{$_order['order_conform']['买家传真']}</td>
                    </tr>
                    </tbody>
                </table>
            </div>

            <div class="table-responsive mytable">
                <table class="table table-bordered">
                    <tbody>
                    <tr>
                        <td width="20%">服务名称</td>
                        <td style="text-align: left">{nl2br($_order['order_conform']['服务名称'])}</td>
                    </tr>
                    <tr>
                        <td>服务内容</td>
                        <td style="text-align: left">
                            {nl2br($_order['order_conform']['服务内容'])}
                        </td>
                    </tr>
                    <tr>
                        <td>备注</td>
                        <td style="text-align: left">
                            {nl2br($_order['order_conform']['备注'])}
                        </td>
                    </tr>
                    </tbody>
                </table>

            </div>
            <div class="jyyd jym">订单金额与结算</div>

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
                        <td>{$_order['order_conform']['交易单价']}元
                        </td>
                        <td>{$_order['order_conform']['交易数量']}</td>
                        <td>{$_order['order_conform']['交易总计']}元
                        </td>
                        <td>{$_order['order_conform']['交付时间']}</td>
                        <td>{$_order['order_conform']['结算时间']}</td>
                    </tr>
                    </tbody>
                </table>
            </div>

            <div class="jyyd jym">支付节点</div>

            <div class="table-responsive mytable">
                <table class="table table-bordered">
                    <thead>
                    <tr class="active">
                        <th width="35%">支付节点</th>
                        <th width="10%">支付比例</th>
                        <th width="30%">支付总计</th>
                        <th width="25%">支付期限</th>
                    </tr>
                    </thead>
                    <tbody>
                    {foreach $_order['order_conform']['支付节点'] as $v}
                        <tr>
                            <td>{$v['名称']}</td>
                            <td>{$v['比例']}%</td>
                            <td>{$v['金额']}元</td>
                            <td>{$v['期限']}</td>
                        </tr>
                    {/foreach}
                    </tbody>
                </table>
            </div>
            <div class="jyyd jym">附件文件</div>
            <div>

                {foreach $_order['order_conform']['附件'] as $v}
                    <a class="fujian" href="{$v['path']}" target="_blank"><i class="fa fa-paperclip"></i><span>{$v['name']}</span></a>
                {/foreach}
            </div>
        </div>

    </div>
</div>