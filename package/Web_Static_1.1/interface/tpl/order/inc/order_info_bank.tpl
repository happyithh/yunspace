   <div class="s_left_c mt-1">
        <link rel="stylesheet" href="css/order_user/money.css"/>
        <div class="money_a">
            <div class="top_a">
                <div class="fl"><h4>选择支付方式</h4></div>
            </div>
            <!----正文内容--->
            <div class="ch">
                <div class="pay_content">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h5 class="pay_title">支付备注：
                                {$payment['payment_detail']['payment_title']}
                            </h5>
                            <h5 class="pay_state green">支付进行中...</h5>
                            <div class="clearfix"></div>
                        </div>
                        <div class="panel-body">
                            <div class="row clearfix">
                                <div class="fl col-md-2 choose">收款对象：</div>
                                <div class="fl col-md-8 choose">{$payment['payment_detail']['getpay_account_name']}</div>
                                <div class="fl col-md-2 price_m choose">￥{$payment['amount']}</div>
                            </div>
                            <div class="row clearfix">
                                <div class="fl col-md-2 choose">收款账户：</div>
                                <div class="fl col-md-10 choose">
                                    {if $payment['target']}
                                        {$payment['target']}
                                    {else}
                                        <span>服务方【我的钱包】</span>
                                    {/if}
                                </div>
                            </div>
                        </div>
                    </div>
                    <h5>
                        <strong>账户余额： ￥{$account['balance']}</strong>
                    </h5>
                    <h5>
                        <strong>支付方式：</strong>
                        
                        <label>
                            <input type="radio" name="payment_type" id="pay_balance" value="" {if $account['balance']<$payment['amount']}disabled {/if}>&nbsp;钱包余额
                        </label>
                        &nbsp;&nbsp;&nbsp;&nbsp;
                        <label>
                            <input type="radio" name="payment_type" value="" id="pay_online">&nbsp;在线支付
                        </label>
                        &nbsp;&nbsp;&nbsp;&nbsp;
                        <label>
                            <input type="radio" name="payment_type" value="" id="pay_wechat">&nbsp;微信支付
                        </label>
                    </h5>
                </div>
                <!----余额支付----->
                <input type="hidden" name="payment_id" class="account_payment_id" value="{$payment['payment_id']}">
                <div class="wd_b1" style="display: none;">
                    <div class="fl wd_b1_a" style="text-align: left; width:70px; ">
                        支付密码：
                    </div>
                    <div class="con_b4">
                        <input class="account_password2 ipt-txt" name="password2_bank" type="password" placeholder="输入支付密码"/>
                        <span class="warning pay_warning"></span>
                    </div>
                    <div class="wd_b5" style="margin-left: 90px;">
                        <button class="account_pay">立即付款</button>
                    </div>
                    <div class="clear"></div>
                </div>
                <!----在线支付----->
                <form action="{$_route}online_pay/{$payment['payment_id']}" method="post" target="_blank">
                <div class="ch_c pay_online" style="display: none;">
                    <p><b>温馨提示：</b>为避免订单失效，请确保复核人员在订单发送银行后两日内登录企业网银完成复核！
                    </p>

                    <div class="ch_ca">
                        <b>企业网银</b>
                        <ul {$j=0}>
                            {foreach $banks['b2b'] as $k=>$v}
                                <li>
                                    <label class="radio-inline ">
                                        <input data-bank='{$j++}' type="radio" name="bank" value="{$k}" checked/>
                                        <img src="{Core::getAssetsUrls('Web_1.0')}/bank_logo/{$v}">
                                    </label>
                                </li>
                            {/foreach}
                        </ul>
                        <div class="clear"></div>
                    </div>
                    <div class="ch_ca" style=" padding-top: 15px; border: 0px;">
                        <b style="color: #2c99ff;">个人银行卡</b>
                        <ul>
                            {foreach $banks['b2c'] as $k=>$v}
                                <li>
                                    <label class="radio-inline">
                                        <input type="radio" name="bank" value="{$k}" checked/>
                                        <img src="{Core::getAssetsUrls('Web_1.0')}/bank_logo/{$v}">
                                    </label>
                                </li>
                            {/foreach}
                        </ul>
                        <div class="clear"></div>
                    </div>
                    <div class="wd_b5" style="margin-left: 0px;">
                        <button type="submit">下一步</button>
                    </div>
                    <div class="clear"></div>
                </div>
                </form>
                <div class="clear"></div>
                <!----微信支付----->
                <div class="pay_wechat" style="display: none;">
                    <div class="wechat_w1">
                        <span class="wechat_note1">扫描下面二维码支付</span>
                        <iframe style="border: none;width: 220px;height: 220px;" src="{$_root}wechat_code?body={$orderinfo['order_title']}&out_trade_no={$payment['payment_id']}&total_fee={$payment['amount']}"></iframe>
                        <span class="wechat_note2">(支付完成之后，关闭或刷新页面即可)</span>
                    </div>
                    <div class="clear"></div>
                </div>
            </div>
        </div>
    </div>
<script>
    $(document).ready(function(){
        $('#pay_online').attr('checked',true);
        $('.pay_online').show();
        $('.pay_wechat').hide();
        $('.wd_b1').hide();
    });
    $("#pay_balance").click(function () {
        $('.wd_b1').show();
        $('.pay_online').hide();
        $('.pay_wechat').hide();
    });
    $("#pay_online").click(function () {
        $('.pay_online').show();
        $('.pay_wechat').hide();
        $('.wd_b1').hide();
    });
    $("#pay_wechat").click(function () {
        $('.pay_wechat').show();
        $('.pay_online').hide();
        $('.wd_b1').hide();
    });
</script>