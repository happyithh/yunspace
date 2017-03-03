{if $orderinfo['is_buyer']}
    <!--订单签约-已接单-->
    {if !$all_conform['data']}
        <div class="order-comn order-confirm">
            <h1 style="text-align: center;">供应商已接单，稍后会联系您...</h1>

            <h2 style="text-align: center;">线下签约后，记得让供应商上传合同，在线确认哦！</h2>

            {*<p>订单多久一直不操作，订单即关闭</p>*}

            <p>如果不想继续，您可 <a href="javascript:;" data-status="-1" class="blue js-cancel" style="text-decoration: underline;">取消订单</a></p>

        </div>
        <!--order-confirm-end-->
    {else}
        <div class="order-comn order-sign">
            {*<h2 class="black" style="text-align: center;">线下签约</h2>*}

            <h1>供应商家已上传合同，等待您确认合同...</h1>

            <h2><span class="green">合同确认后不可修改</span>,但可上传附属合同/协议</h2>

            <p>您还可拨打服务热线 <span class="green">400-056-0599</span> 咨询</p>

            <p>如果不想继续，您可 <a href="javascript:;" data-status="-1" class="blue js-cancel" style="text-decoration: underline;">取消订单</a></p>
        </div>
        <!--order-confirm-end-->

        {include "Web_Static::order/inc/conform_list_pay.tpl"}

    {/if}

{else}
    {if !$all_conform['data']}
        <div class="order-comn order-confirm">
            <h1 style="text-align: center;">您已确认接单，快联系采购方签约吧！</h1>

            <h3 style="text-align: center;">线下签约后，记得上传合同让采购方确认哦！</h3>

            <div class="upld-submit-m">
                <input type="button" class="bg-green js-upld-submit-m" data-identity="{if $orderinfo['order_conform']['供应商名称'] =='未认证'}0{else}1{/if}" value="上传已签约合同">
            </div>
            <p>您还可拨打服务热线 <span class="green">400-056-0599</span> 咨询</p>

            <p>如果不想继续，您可 <a href="javascript:;" data-status="-1" class="blue js-cancel" style="text-decoration: underline;">取消订单</a></p>

        </div>
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
                <input type="button" class="addcontract-btn js-addcontract-btn bg-magenta js-upld-submit-m" value="新增合同">
            </div>
        </div>

        {include "Web_Static::order/inc/conform_list_pay.tpl"}
        <p class="hp-cancle">如果不想继续，您可 <a href="javascript:;" data-status="-1" class="blue js-cancel" style="text-decoration: underline;">取消订单</a></p>

    {/if}
{/if}



