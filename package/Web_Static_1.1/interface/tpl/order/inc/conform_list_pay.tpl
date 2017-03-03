<table class="order-table order-sign-table" cellpadding="0" cellspacing="0">
    <tr>
        <th width="29%">合同名称</th>
        <th width="15%">金额</th>
        <th width="21%">状态</th>
        <th width="35%">操作</th>
    </tr>
    {foreach $all_conform['data'] as $k=>$v}
        <tr>
            <td>{$v['conform_title']}</td>
            <td>
                {if $v['conform_amount']>0}
                    <span class="magenta">￥<span class="conform_amount">{$v['conform_amount']}</span></span>
                {else}
                    <span class="blue">￥<span class="conform_amount">{$v['conform_amount']}</span></span>
                {/if}
            </td>
            <td>
                {if $v['status']==0}
                    {if $orderinfo['is_buyer']}
                        <span class="magenta">待签约</span>
                    {else}
                        <span class="magenta">等待采购方确认合同</span>
                    {/if}
                {elseif $v['status']==-1}
                    {if $orderinfo['is_buyer']}
                        <span class="refuse_sign_color">已拒绝<span class="waiting_sign_color"><br/>
                    {else}
                        <span class="refuse_sign_color">采购方拒绝签约</span><br/>
                    {/if}
                    {*<span class="hide hide_refuse_reason">拒绝原因：{$v['refuse_reason']}</span>*}
                    {*<a href="javascript:;" class="rf-reason js-refuse-conform-reason">查看拒绝理由</a>*}
                {elseif $v['status']==1}
                    <span>已签约</span>
                {/if}
            </td>
            <td style="display:none;text-align: left">
                {foreach $v['conform_path'] as $k1=>$v1}
                    <p class = "js-conform-name">{$v1['name']}</p>
                    <p class = "js-conform-path">{$v1['path']}</p>
                {/foreach}
            </td>
            <td>
                <a class="btn dlod-btn download_conform" href="javascript:;">下载合同</a>
                {if $orderinfo['is_buyer'] && $v['status']==0}
                    <a class="btn confirm-btn js-confirm-btn" data-conform-id="{$v['id']}" href="javascript:;">确认合同</a>
                    <a class="btn refuse-btn js-refuse-conform" href="javascript:;" data-conform-id="{$v['id']}">拒绝确认</a>
                {/if}
                {if $orderinfo['is_vendor'] && $v['status'] !=1}
                    <a class="btn confirm-btn js-ormc-reupldbtn" href="javascript:;" data-conform-id="{$v['id']}">重新上传</a>
                    <a class="btn refuse-btn js-delete-conform" href="javascript:;" data-cid="{$v['id']}" data-title="{$v['conform-title']}">删除合同</a>
                {/if}
            </td>
        </tr>
    {/foreach}
</table>
<div class="fr order-total-money clearfix">
    {if $assigned_conform['total_amount']}
        已签约<strong class="magenta">￥{$assigned_conform['total_amount']|default:'0'}</strong>
    {/if}
    {if ($all_conform['total_amount']-$assigned_conform['total_amount']) !=0}
        未签约<strong class="green">￥{($all_conform['total_amount']-$assigned_conform['total_amount'])|default:'0'}</strong>
    {/if}
    总计<strong class="magenta">￥{$all_conform['total_amount']}</strong>
</div>
