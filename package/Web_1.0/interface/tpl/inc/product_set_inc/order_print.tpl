<h1 align="center"><strong>《{$data['order_title']}》</strong></h1>
<div style="height: 50px;border-bottom: 2px solid #24252f;line-height: 50px;margin-bottom: 15px;font-size: 18px;">&nbsp;&nbsp;订单信息</div>
<div>
    <div>
        <h3>基本信息</h3>
        <div>订单号：{$data['order_no']}</div>
        <div>创建时间：{date('Y-m-d H:i:s',$data['create_time'])}</div>
        <div>商品名称：{$data['order_title']}&nbsp;&nbsp;&nbsp;&nbsp;<a href="{$_root}set_info/{$data['product_set_id']}.html">点此查看套餐详情</a></div>
        <div>服务商：{$data['vendor_name']}&nbsp;&nbsp;&nbsp;&nbsp;<a href="{$_root}vendor_info/{$data['vendor_id']}.html">点此查看供应商详情</a></div>
        <div>采购方：{$data['buyer_fullname']}</div>
        <div>套餐价：¥{$set_info['detail']['套餐价']}
            {if $set_info['detail']['计价单位']}
                /{$set_info['detail']['计价单位']}
            {/if}
        </div>
        {if $data['order_detail']['order_number'] && $set_info['detail']['计价单位']}
            <div>预订数量：{$data['order_detail']['order_number']}{$set_info['detail']['计价单位']}</div>
        {/if}
        <div>订单金额：¥{$data['order_price']}</div>
        <div>发票信息：
            {if $data['order_detail']['ticket']}
                {$data['buyer_fullname']}{if $data['order_detail']['ticket']==1}(已寄出){else}(未寄出){/if}
            {else}
                未开发票
            {/if}
        </div>
        <div>咨询投诉：400-056-0599</div>
        <div>
            <h3>套餐详情</h3>
            <table border="1" style="text-align: center;padding: 5px;">
            <tr>
                <td>套餐类别</td>
                <td>{$set_info['category_name']}</td>
            </tr>
            <tr>
                <td>版本</td>
                <td>{$set_info['version']}</td>
            </tr>
            <tr>
                <td>标签</td>
                <td>{$set_info['attr_index']['标签']}</td>
            </tr>
            <tr>
                <td>人数</td>
                <td>{$set_info['attr_index']['人数']}</td>
            </tr>
            <tr>
                <td>城市</td>
                <td>{$set_info['attr_index']['城市']}</td>
            </tr>
            <tr>
                <td>天数</td>
                <td>{$set_info['attr_index']['天数']}</td>
            </tr>
            <tr>
                <td>地址</td>
                <td>{$set_info['addr']}</td>
            </tr>
            <tr>
                <td>有效期</td>
                <td>{$set_info['attr_index']['开始时间']} -- {$set_info['attr_index']['结束时间']}</td>
            </tr>
            <tr>
                <td>工作日</td>
                <td>
                    {if !$set_info['attr_index']||$set_info['attr_index']['工作日可选']}工作日可选{/if}
                    &nbsp;&nbsp;
                    {if $set_info['attr_index']['节假日可选']}节假日可选{/if}
                </td>
            </tr>
            <tr>
                <td>市场价和套餐价</td>
                <td>
                    {if $set_info['detail']['市场价']}
                        市场价：¥{$set_info['detail']['市场价']}
                    {/if}
                    &nbsp;&nbsp;
                    {if $set_info['detail']['套餐价']}
                        套餐价：¥{$set_info['detail']['套餐价']}
                    {/if}
                </td>
            </tr>
            {if $set_info['detail']['计价单位']}
            <tr>
                <td>计价单位</td>
                <td>{$set_info['detail']['计价单位']}</td>
            </tr>
            <tr>
                <td>计价上限/下限</td>
                <td>{$set_info['detail']['计价上限']}{$set_info['detail']['计价单位']} ~ {$set_info['detail']['计价下限']}{$set_info['detail']['计价单位']}</td>
            </tr>
            {/if}
            <tr>
                <td>服务清单</td>
                <td>{$set_info['detail']['清单']}</td>
            </tr>
            <tr>
                <td>套餐简介</td>
                <td>{$set_info['des']}</td>
            </tr>
            <tr>
                <td>服务详情</td>
                <td>{$set_info['detail_des']}</td>
            </tr>
            </table>
        </div>
        {if $payment_info}
        <div>
            <h3>支付信息</h3>

            <table border="1" style="text-align: center;padding: 5px;">
                <tr>
                    <td style="width:70px;">支付类别</td>
                    <td style="width:70px;">支付方式</td>
                    <td style="width:70px;">支付金额</td>
                    <td style="width:300px;">支付详情</td>
                </tr>
                {foreach $payment_info as $key=>$value}
                    <tr>
                        <td>{$data['payment'][$value['payment_id']]['payment_detail']['payment_title']}</td>
                        <td>{$value['payment_method']}</td>
                        <td>￥{$value['payment_amount']}</td>
                        <td>
                            {if $value['payment_method']=='银行转账'}
                                收款对象：{$data['payment']['target_bank_info']['account_name']|default:'尚未绑定银行卡'}}<br/>
                                收款账户：
                                {if $data['payment']['target_bank_info']['bank_card']}
                                    {$data['payment']['target_bank_info']['bank_name']}<span>卡号：{substr({$data['payment']['target_bank_info']['bank_card']},0,4)}****{substr({$data['payment']['target_bank_info']['bank_card']},-4)}</span>
                                {else}
                                尚未绑定银行卡
                                {/if}
                                <br/>
                            {/if}
                            {foreach $value['payment_info'] as $k=>$v}
                                {if $k=='账户余额'}
                                    {if $data['is_vendor']}
                                        {$k}:{$v}<br/>
                                    {/if}
                                {else}
                                    {$k}:{$v}<br/>
                                {/if}
                            {/foreach}
                        </td>
                    </tr>
                {/foreach}
            </table>
        </div>
        {else}
            <div>支付信息：未支付</div>
        {/if}
</div>