<div class="s_left_c mt0 advance_content">

    <div class="row">
        <div class="col-md-4 order_content_topic">预定套餐：</div>
        <div class="col-md-8">{$orderinfo['order_title']}</div>
        <div class="col-md-4 order_content_topic">服务商户：</div>
        <div class="col-md-8">{$orderinfo['vendor_name']}</div>
        <div class="col-md-4 order_content_topic">采购方：</div>
        <div class="col-md-8">{$orderinfo['buyer_fullname']}</div>
        <div class="col-sm-4 order_content_topic">套餐价：</div>
        <div class="col-sm-8">
            ¥{$productSet['detail']['套餐价']}
            {if $productSet['detail']['计价单位']}
                /{$productSet['detail']['计价单位']}
            {/if}
        </div>
        {if $productSet['detail']['计价单位'] && $orderinfo['order_detail']['order_number']}
            <div class="col-sm-4 order_content_topic">预订数量：</div>
            <div class="col-sm-8">{$orderinfo['order_detail']['order_number']}{$productSet['detail']['计价单位']}</div>
        {/if}
        <div class="col-md-4 order_content_topic">预定总价：</div>
        <div class="col-md-8">¥{$orderinfo['order_price']}</div>
        {if $orderinfo['start_time']}
            <div class="col-md-4 order_content_topic">预定档期：</div>
            <div class="col-md-8">
                {date('Y-m-d',$orderinfo['start_time'])} —— {date('Y-m-d',$orderinfo['end_time'])}
            </div>
        {/if}
        <div class="col-md-4 order_content_topic">下单时间：</div>
        <div class="col-md-8">{date('Y-m-d H:i:s',$orderinfo['create_time'])}</div>
        <div class="col-md-4 order_content_topic">预定备注：</div>
        <div class="col-md-8">{if $orderinfo['remark']}{$orderinfo['remark']}{else}暂无备注{/if}</div>
        <div class="col-md-4 order_content_topic">订单合约：</div>
        <div class="col-md-8"><a href="#" data-toggle="modal" data-target=".bs-example-modal-lg"> 《云空间超值套餐服务协议》</a></div>
        {if $orderinfo['order_status']==-1 || $orderinfo['order_status']==-2}
            <div class="col-md-4 order_content_topic">取消原因：</div>
            <div class="col-md-8">{$orderinfo['order_close_info']['reason']}</div>
        {elseif $orderinfo['order_status']==-3}
            <div class="col-md-4 order_content_topic" style="color: #00c3c3;">拒绝原因：</div>
            <div class="col-md-8" style="color: #00c3c3;">{$orderinfo['order_close_info']['reason']}</div>
        {/if}
    </div>
    {if $orderinfo['order_status']>=0 && !$orderinfo['create_time2'] && $orderinfo['is_vendor']}
        <form action="{$_root}product_set_order_operate" method="post">
            <div class="verify">
                {if $orderinfo['vendor_attr']['identity']}
                    <div class="verify_left">
                        <a href="{$_root}product_set_order_operate?order_no={$orderinfo['order_no']}&action=pending" class="btn btn-pass btn-primary">审核通过</a>
                    </div>
                    <div class="verify_right">
                        <input type="text" class="form-control refuse_input" id="exampleInputEmail1" name="refuse_reason" placeholder="请填写拒绝理由" >
                        <input type="hidden" name="order_no" value="{$orderinfo['order_no']}" >
                        <input type="hidden" name="action" value="refuse" >
                        <button type="submit" class="btn btn_refuse">拒绝</button>
                    </div>
                {else}
                    <div class="verify_left">
                        <a href="http://{Core::$urls['host']}/user_center/user_admin/account_identity" class="btn btn-primary">点此实名认证</a>
                    </div>
                {/if}
                <div class="clearfix"></div>
            </div>
        </form>
    {/if}
</div>