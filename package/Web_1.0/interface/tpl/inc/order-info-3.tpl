<div class="s_left_c mt-1">
<div class="clearfix">
    <div class="fl deal_info jia">
        <div class="bor">
            <p>
                <font>甲方: </font><span>{$orderinfo['order_conform']['供应商名称']}</span>
            </p>

            <p>
                <font>签约授权代表: </font><span>{$orderinfo['order_conform']['供应商签约代表']|default:'未定义'}</span>
            </p>

            {if $orderinfo['order_conform']['vendor_signing']}
                <p>
                    <font>签约方式: </font><span>交易密码签约</span>
                </p>
                <p>
                    <font>签约日期: </font><span>{date('Y.m.d',$orderinfo['order_conform']['vendor_signing'])}</span>
                </p>
            {else}
                {if $orderinfo['is_vendor']&&Web_Account::subAccountHasAuth('签约',21)}
                    <form action="../order_operate?order_no={$orderinfo['order_no']}&action=vendor_signing" method="post" style="margin: 0;padding: 0">

                        {if $orderinfo['order_conform']['供应商签约代表']}
                            <p class="winput">
                                <font>交易密码: </font><span><input class="inp" placeholder="请输入密码" type="password" name="password2"></span>
                            </p>
                            <p class="conf">
                                <a href="javascript:void(0);" onclick="$(this).parents('form').submit()">确认签约</a>
                            </p>
                        {else}
                            <p class="winput">
                                <font>交易密码: </font><span>请先确认供应商签约代表</span>
                            </p>
                            <p class="conf">
                                <a href="?tab=6">修改合同细节</a>
                            </p>
                        {/if}
                    </form>
                {else}
                    <p>
                        <font>签约状态: </font><span>未签约</span>
                    </p>
                {/if}
            {/if}
        </div>
    </div>
    <div class="fr deal_info yi">
        <div class="bor">
            <p>
                <font>乙方: </font><span>{$orderinfo['order_conform']['买家名称']}</span>
            </p>

            <p>
                <font>签约授权代表: </font><span>{$orderinfo['order_conform']['买家签约代表']|default:'未定义'}</span>
            </p>
            {if $orderinfo['order_conform']['buyer_signing']}
                <p>
                    <font>签约方式: </font><span>交易密码签约</span>
                </p>
                <p>
                    <font>签约日期: </font><span>{date('Y.m.d',$orderinfo['order_conform']['buyer_signing'])}</span>
                </p>
            {else}

                {if $orderinfo['order_conform']['vendor_signing']}
                    {if $orderinfo['is_buyer']&&Web_Account::subAccountHasAuth('签约',1)}
                        <form action="../order_operate?order_no={$orderinfo['order_no']}&action=buyer_signing" method="post" style="margin: 0;padding: 0">

                            {if $orderinfo['order_conform']['买家签约代表']}
                                <p class="winput">
                                    <font>交易密码: </font><span><input class="inp" placeholder="请输入密码" type="password" name="password2"></span>
                                </p>
                                <p class="conf">
                                    <a href="javascript:void(0);" onclick="$(this).parents('form').submit()">确认签约</a>
                                </p>
                            {else}
                                <p class="winput">
                                    <font>交易密码: </font><span>请先实名认证</span>
                                </p>
                                <p class="conf">
                                    <a href="{$_root}user_center/user_admin/account_identity" target="_blank">进行实名认证</a>
                                </p>
                            {/if}
                        </form>
                    {else}
                        <p>
                            <font>签约状态: </font><span>未签约</span>
                        </p>
                    {/if}
                {else}
                    <p>
                        <font>签约状态: </font><span>等待供应商签约</span>
                    </p>
                    {if $orderinfo['is_buyer']&&!$orderinfo['order_conform']['买家签约代表']}
                        <p class="conf">
                            <a href="{$_root}user_center/user_admin/account_identity" target="_blank">进行实名认证</a>
                        </p>
                    {/if}
                {/if}
            {/if}
        </div>
    </div>
</div>
<div class="allt border1">
    <h1>{$orderinfo['order_conform']['协议标题']}</h1>

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
                <td>{$orderinfo['order_conform']['供应商名称']}</td>
                <td>{$orderinfo['order_conform']['买家名称']}</td>
            </tr>
            <tr>
                <td>代表</td>
                <td>{$orderinfo['order_conform']['供应商签约代表']}</td>
                <td>{$orderinfo['order_conform']['买家签约代表']}</td>
            </tr>
            <tr>
                <td>地址</td>
                <td>{$orderinfo['order_conform']['供应商地址']}</td>
                <td>{$orderinfo['order_conform']['买家地址']}</td>
            </tr>
            <tr>
                <td>电话</td>
                <td>{$orderinfo['order_conform']['供应商电话']}</td>
                <td>{$orderinfo['order_conform']['买家电话']}</td>
            </tr>
            <tr>
                <td>传真</td>
                <td>{$orderinfo['order_conform']['供应商传真']}</td>
                <td>{$orderinfo['order_conform']['买家传真']}</td>
            </tr>
            </tbody>
        </table>
    </div>
    <!--    第二个表格 -->
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

    <div class="jyyd jym">支付节点</div>
    <!--    第三个表格 -->
    <div class="table-responsive mytable">
        <table class="table table-bordered">
            <thead>
            <tr class="active">
                <th width="35%">支付节点</th>
                <th width="10%">支付比例</th>
                <th width="25%">支付总计</th>
                <th width="25%">支付期限</th>
                <th width="5%">结算</th>
            </tr>
            </thead>
            <tbody>
            {foreach $orderinfo['order_conform']['支付节点'] as $v}
                <tr>
                    <td>{$v['名称']}</td>
                    <td>{$v['比例']}%</td>
                    <td>{$v['金额']}元</td>
                    <td>{$v['期限']}</td>
                    <td>{if $v['结算']}<i class="fa fa-check"></i> {/if}</td>
                </tr>
            {/foreach}
            </tbody>
        </table>
    </div>
    {if !empty($orderinfo['order_conform']['订单外款项'])}
        <div class="jyyd jym">订单外款项</div>
        <!--    第三个表格 -->
        <div class="table-responsive mytable">
            <table class="table table-bordered">
                <thead>
                <tr class="active">
                    <th width="35%">款项名目</th>
                    <th width="30%">支付金额</th>
                    <th width="35%">支付期限</th>
                </tr>
                </thead>
                <tbody>
                {foreach $orderinfo['order_conform']['订单外款项'] as $v}
                    <tr>
                        <td>{$v['名称']}</td>
                        <td>{$v['金额']}元</td>
                        <td>{$v['期限']}</td>
                    </tr>
                {/foreach}
                </tbody>
            </table>
        </div>
    {/if}
    <div class="jyyd jym">附件文件</div>
    <div>
        {foreach $orderinfo['order_conform']['附件'] as $v}
            <a class="fujian" href="{$v['path']}" target="_blank"><i class="fa fa-paperclip"></i><span>{$v['name']}</span></a>
        {/foreach}
    </div>
</div>

</div>