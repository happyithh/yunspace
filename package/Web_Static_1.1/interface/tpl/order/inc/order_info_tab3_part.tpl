{if $orderinfo['is_buyer']}
    <!--订单支付-->
    {include "Web_Static::order/inc/conform_list_pay.tpl"}

    <div class="pay-p-wp">
        {*<p>订单多久一直不操作，订单即关闭</p>*}
        <p>如果不想继续，您可 <a href="javascript:;" data-status="110" class="blue js-cancel" style="text-decoration: underline;">取消订单</a></p>
    </div>

    <div class="order-comn order-pay">
        <h1 style="text-align: center">已部分支付，供应商准备中...</h1>

            {if !$orderinfo['evaluate']}
                <h2 style="text-align: center">活动结束后，记得对供应商进行评价哦！
                    <a href="?handle_evaluate=1#js-evaluate-show" style="color:#2284e9;" class="goeval">去评价&gt;&gt;</a>
                </h2>
            {else}
                <h2 style="text-align: center">您的评价为我们挑选到更好的供应商添砖加瓦，我们的未来服务质量需要您的参与 </h2>
            {/if}

        <div class="order-money">还需支付金额:<span class="green">￥{sprintf('%.2f',($orderinfo['order_price'] - $orderinfo['order_price_pay']))}</span></div>
        <div class="order-totalmoney clearfix">
            <p class="fl">交易总额：￥{$orderinfo['order_price']}</p>
            <p class="fr">已支付：<span class="green">￥{$orderinfo['order_price_pay']}</span></p>
        </div>
        <div class="order-pay-btn clearfix">
            <div class="fl paybtn">
                {*<input class="bg-magenta onl-paybtn js-onl-paybtn" type="submit" value="线上支付">*}
                <input class="bg-magenta onl-paybtn js-onl-paybtn" data-identity="{if $orderinfo['order_conform']['买家名称'] =='未认证'}0{else}1{/if}" type="button" value="线上支付">
                <p>（通过云SPACE平台支付，免手续费）</p>
            </div>
            <div class="fr paybtn">
                <input class="bg-green l-paybtn js-l-paybtn" type="button" data-pid="0" value="线下支付">
                <p>（上传支付凭证即可）</p>
            </div>
        </div>
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

    <div class="pay-p-wp">
        {*<p>订单多久一直不操作，订单即关闭</p>*}
        <p>如果不想继续，您可 <a href="javascript:;" data-status="115" class="blue js-cancel" style="text-decoration: underline;">取消订单</a></p>
    </div>

    <!--部分支付-->
    <div class="order-comn order-confirm">
        <h1 style="text-align: center;">已部分支付，待采购方全额支付...</h1>
        {if !$orderinfo['evaluate']}
            <h2 style="text-align: center">采购方评价后，您才可获得信用评价哦！</h2>
        {else}
            <h2 style="text-align: center">采购方已评价！</h2>
        {/if}
        <div class="order-money">采购方还需支付金额：<span class="green">￥{sprintf('%.2f',($orderinfo['order_price'] - $orderinfo['order_price_pay']))}</span></div>
        <div class="order-totalmoney clearfix">
            <p class="fl">交易总额：￥{$orderinfo['order_price']}</p>
            <p class="fr">已支付：<span class="green">￥{$orderinfo['order_price_pay']}</span></p>
        </div>
    </div><!--order-confirm-end-->

{/if}