{if $orderinfo['is_buyer']}
    <!--订单支付-->
    {include "Web_Static::order/inc/conform_list_pay.tpl"}

    <div class="order-comn order-pay">
        <h1 style="text-align: center">
            {if $orderinfo['evaluate']}
                已全额支付啦，您已评价过供应商
            {else}
                已全额支付啦，活动结束后可评价供应商哦！
            {/if}
        </h1>
        <h4 style="text-align: center;">您的评价为我们挑选到更好的供应商添砖加瓦，我们的未来服务质量需要您的参与！</h4>
        {if !$orderinfo['evaluate']}
            <a  class="bg-green l-payallbtn" href="?tab=4">评价供应商</a>
        {/if}
    </div><!--order-comn-end-->
{else}
    <div class="ormd-moneyacct order-cont clearfix">
        <div class="fl ormd-moneyacct-acct">
            <span class="tit">该订单在线上支付的收款账号:</span>
            <select class="change_cash">
                <option value="" {if !$orderinfo['order_detail']['bank_cash']}selected{/if}>&nbsp;&nbsp;我的钱包</option>
                {foreach $bank_info['bank_account'] as $k=>$v}
                    <option value="{$k}" {if $orderinfo['order_detail']['bank_cash'] == $k}selected{/if}>【{$v['4']}】&nbsp;&nbsp;尾号{substr($v[2],-4)}</option>
                {/foreach}
            </select>
            <a href="{$_root}user_center/user_admin/money?action=new_card" target="_blank" class="addbankcard">添加银行卡</a>
        </div>
        <div class="addcontract">
            {*<input type="submit" class="addcontract-btn js-addcontract-btn bg-magenta" value="新增合同">*}
            <input type="button" class="addcontract-btn js-addcontract-btn bg-magenta js-upld-submit-m" value="新增合同">
        </div>
    </div>
    {include "Web_Static::order/inc/conform_list_pay.tpl"}

    {*<div class="pay-p-wp">*}
        {*<p>订单多久一直不操作，订单即关闭</p>*}
    {*</div>*}

    <div class="order-comn order-confirm">
        <h1 style="text-align: center;">已全部支付，等待您提供服务</h1>
        {if $orderinfo['evaluate']}
            <h2 style="text-align: center">采购方已评价！</h2>
        {else}
            <h2 style="text-align: center">活动结束后，记得让采购方评价哦！</h2>
        {/if}

        {if $orderinfo['order_status']==90}
            <h2 style="text-align: center">订单已完成</h2>
        {/if}
        {if $orderinfo['order_status']!=90}
            <a  class="bg-green l-payallbtn vendor_complete_order" href="javascript:;">完成订单</a>
        {/if}

    </div><!--order-confirm-end-->

{/if}