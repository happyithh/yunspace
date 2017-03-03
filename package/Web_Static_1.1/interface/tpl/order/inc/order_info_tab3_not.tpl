{if $orderinfo['is_buyer']}
    <!--订单支付-->
    {include "Web_Static::order/inc/conform_list_pay.tpl"}
    <div class="pay-p-wp">
        {*<p>订单多久一直不操作，订单即关闭</p>*}
        {*<p>如果不想继续，您可 <a href="" class="blue" style="text-decoration: underline;">取消订单</a></p>*}
        <p>如果不想继续，您可 <a href="javascript:;" data-status="110" class="blue js-cancel" style="text-decoration: underline;">取消订单</a></p>

    </div>
    <div class="order-comn order-pay">
        <h1 style="text-align: center">合同已签约，等待您支付...</h1>
        <h2 style="text-align: center">线上支付更省钱哦，算盘打起来吧...</h2>
        <div class="order-money">交易金额：<span class="green">￥{$assigned_conform['total_amount']}</span></div>
        <div class="order-pay-btn clearfix">
            <div class="fl paybtn">
                {*<input class="bg-magenta onl-paybtn js-onl-paybtn" data-identity="{if $smarty.session.user['attr']['identity']}1{else}0{/if}" type="button" value="线上支付">*}
                <input class="bg-magenta onl-paybtn js-onl-paybtn" data-identity="{if $orderinfo['order_conform']['买家名称'] =='未认证'}0{else}1{/if}" type="button" value="线上支付">
                <p>（通过云SPACE平台支付，免手续费）</p>
            </div>
            <div class="fr paybtn">
                <input class="bg-green l-paybtn js-l-paybtn" type="button" data-pid="0" value="线下支付">
                <p>（上传支付凭证即可）</p>
            </div>
            <div class="pay-transfer">

            </div>
        </div>
    </div><!--order-confirm-end-->
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

    <!--等待支付-->
    <div class="order-comn order-confirm">
        <h1 style="text-align: center;">合同已签约，等待采购方支付...</h1>
        <div class="order-money">交易金额：<span class="green">￥{$assigned_conform['total_amount']}</span></div>
        <p>您还可拨打服务热线 <span class="green">400-056-0599</span> 咨询</p>
        <p>如果不想继续，您可 <a href="javascript:;" data-status="115" class="blue js-cancel" style="text-decoration: underline;">取消订单</a></p>
    </div><!--order-confirm-end-->

{/if}