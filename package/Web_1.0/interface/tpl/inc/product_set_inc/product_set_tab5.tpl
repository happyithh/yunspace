   <div class="s_left_c mt-1">
        <link rel="stylesheet" href="css/money.css"/>
        <div class="money_a">
            <div class="top_a">
                <div class="fl"><h4>选择支付方式</h4></div>
            </div>
            <!----正文内容--->
            <div class="ch">
                <div class="pay_content">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h5 class="pay_title">支付名目：
                                {if intval($payment['payment_detail']['payment_title'])==1}
                                    定金
                                {elseif intval($payment['payment_detail']['payment_title'])==2}
                                    尾款
                                {elseif intval($payment['payment_detail']['payment_title'])==3}
                                    全款
                                {/if}
                            </h5>
                            <h5 class="pay_state">支付进行中...</h5>
                            <div class="clearfix"></div>
                        </div>
                        <div class="panel-body">
                            <div class="row">
                                <div class="col-md-2 choose">收款对象：</div>
                                <div class="col-md-8 choose">{$payment['payment_detail']['target_bank_info']['account_name']|default:'未绑定银行卡'}</div>
                                <div class="col-md-2 price_m choose">￥{$payment['amount']}</div>
                            </div>
                            <div class="row">
                                <div class="col-md-2 choose">收款账户：</div>
                                <div class="col-md-10 choose">
                                    {if $payment['payment_detail']['target_bank_info']['bank_card']}
                                        {$payment['payment_detail']['target_bank_info']['bank_name']}<span>卡号：{substr({$payment['payment_detail']['target_bank_info']['bank_card']},0,4)}****{substr({$payment['payment_detail']['target_bank_info']['bank_card']},-4)}
                                    {else}
                                        <span>未绑定银行卡</span>
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
                            <input type="radio" name="payment_type" value="" id="pay_transfer" {if !$payment['payment_detail']['target_bank_info']['bank_card']}disabled {/if}>&nbsp;银行转账
                        </label>
                    </h5>
                </div>
                <!----需要隐藏的部分----->
                <form action="{$_route}balance_pay/{$payment['payment_id']}" method="post">
                    <div class="wd_b1" style="padding-top: 20px; padding-left: 20px;display: none;">
                        <div class="fl wd_b1_a" style="text-align: left; width:70px; ">
                            支付密码：
                        </div>
                        <div class="con_b4">
                            <input name="password2" type="password" placeholder="输入支付密码"/><a href="#">忘记密码？</a>
                        </div>
                        <div class="wd_b5" style="margin-left: 90px;">
                            <button type="submit">立即付款</button>
                        </div>
                        <div class="clear"></div>
                    </div>
                </form>
                <!----银行转账----->
                <form action="{$_route}transfer_pay/{$payment['payment_id']}" method="post" enctype="multipart/form-data">
                    <div class="ch_c pay_transfer" style="display: none;">
                        <div class="row">
                            <div class="col-md-2">收款对象：</div>
                            <div class="col-md-10"><span>{$payment['payment_detail']['target_bank_info']['account_name']|default:'未绑定银行卡'}</span></div>
                        </div>
                        <div class="row">
                            <div class="col-md-2">收款账户：</div>
                            <div class="col-md-10">
                                {if $payment['payment_detail']['target_bank_info']['bank_card']}
                                    <span>{$payment['payment_detail']['target_bank_info']['bank_name']}</span>&nbsp;&nbsp;&nbsp;
                                    <span>卡号：{$payment['payment_detail']['target_bank_info']['bank_card']}</span>
                                {else}
                                    <span>未绑定银行卡</span>
                                {/if}
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-2">付款对象：</div>
                            <div class="col-md-10">
                                <input class="form-control" type="text" name="buyer_full_name" value="{$paymentInfo['payment_info']['付款对象']}">
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-2">付款银行：</div>
                            <div class="col-md-10">
                                <input class="form-control" type="text" name="buyer_bank_name" placeholder="请完整填写银行及支行信息" value="{$paymentInfo['payment_info']['付款银行']}">
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-2">付款账户：</div>
                            <div class="col-md-10">
                                <input class="form-control" type="text" name="buyer_account_name" placeholder="输入付款账户名称" value="{$paymentInfo['payment_info']['付款账户']}">
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-2">交易流水号：</div>
                            <div class="col-md-10">
                                <input class="form-control" type="text" name="payment_no" placeholder="输入交易流水号" value="{$paymentInfo['payment_no']}">
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-2">转账截图：</div>
                            <div class="col-md-10">
                                {if $paymentInfo['payment_img']}
                                    <a target="_blank" href="{Page_Site_Global::displayMedia($paymentInfo['payment_img'],768,0,1)}">
                                        <img src="{Page_Site_Global::displayMedia($paymentInfo['payment_img'],100,0,1)}"/>
                                    </a>
                                {/if}
                                <input type="file" name="transfer_img">
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-2">交易密码：</div>
                            <div class="col-md-10">
                                <input class="form-control" type="password" name="password2" placeholder="输入支付密码">
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-10 col-md-offset-2">
                                <button type="submit" class="btn btn-success">确认已转帐</button>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-10 col-md-offset-2">
                                <input type="checkbox" name="transfer_agreement" value="1">&nbsp;
                                 我已阅读<a href="" data-toggle="modal" data-target=".bs-example-modal-lg">《云space转账协议》</a>
                            </div>
                        </div>
                        <div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
                            {include file="inc/transfer_agreement.tpl"}
                        </div>
                    </div>
                </form>
                <!----使用其他方式付款----->
                <form action="{$_route}pay/{$payment['payment_id']}" method="post" target="_blank">
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
                                        <img src="{$_assets}bank_logo/{$v}">
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
                                        <img src="{$_assets}bank_logo/{$v}">
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
            </div>
        </div>
    </div>
<script>
    $(document).ready(function(){
        $('#pay_online').attr('checked',true);
        $('.pay_online').show();
        $('.pay_transfer').hide();
        $('.wd_b1').hide();
    })
    $("#pay_balance").click(function () {
        $('.wd_b1').show();
        $('.pay_online').hide();
        $('.pay_transfer').hide();
    })
    $("#pay_online").click(function () {
        $('.pay_online').show();
        $('.pay_transfer').hide();
        $('.wd_b1').hide();
    })
    $("#pay_transfer").click(function () {
        $('.pay_transfer').show();
        $('.pay_online').hide();
        $('.wd_b1').hide();
    })
</script>