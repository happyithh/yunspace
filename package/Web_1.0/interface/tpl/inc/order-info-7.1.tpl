<form action="{$_root}order_pay/pay/{$payment['payment_id']}" method="post" target="_blank">
    <div class="s_left_c mt-1">
        <link rel="stylesheet" href="css/money.css"/>
        <div class="money_a">
            <div class="top_a">
                <div class="fl"><h4>选择支付方式</h4></div>
            </div>
            <!----正文内容--->
            <div class="ch">
                <div class="ch_b">
                    <div class="fl">
                        <h4>{$orderinfo['order_title']}
                            [{$payment['payment_detail']['payment_title']}
                            ]</h4></div>
                    <div class="fr"><h5>
                            <span>{$payment['amount']}</span>元
                        </h5>
                    </div>
                    <div class="clear"></div>
                </div>
                <div class="ch_c">
                    <p>
                        <b>账户余额</b>&nbsp;&nbsp;（ {$account['balance']}
                        ）
                    </p>
                    {if $account['balance']>0}
                        <p>
                            <label>
                                <input type="radio" name="balance" value="balance" class="bank" id="cek"/>
                                &nbsp;&nbsp;&nbsp;&nbsp;使用账户余额付款&nbsp; {if $account['balance']>$payment['amount']} {$payment['amount']}{else}{$account['balance']}{/if}
                                &nbsp;元。
                                {if $account['balance']<$payment['amount']}
                                    剩余&nbsp;&nbsp;
                                    <b style="color: #f54545;">{$payment['amount']-$account['balance']}</b>
                                    &nbsp;&nbsp;元可选择其他付款方式付款。
                                {/if}
                            </label>
                        </p>
                    {/if}
                </div>
                <!----需要隐藏的部分----->
                <div class="wd_b1" style="padding-top: 20px; padding-left: 20px;display: none;">
                    <div class="fl wd_b1_a" style="text-align: left; width:70px; ">
                        支付密码：
                    </div>
                    <div class="con_b4">
                        <input type="text" value="输入密码"/><a href="#">忘记密码？</a>
                    </div>
                    <div class="wd_b5" style="margin-left: 90px;">
                        <a href="{$_root}user_center/user_admin/money_choice">立即付款</a>
                    </div>
                    <div class="clear"></div>
                </div>
                <!----使用其他方式付款----->
                <div class="ch_c">
                    <p><b>温馨提示：</b>为避免订单失效，请确保复核人员在订单发送银行后两日内登录企业网银完成复核！
                    </p>

                    <div class="ch_ca">
                        <b>企业网银</b>
                        <ul {$j=0}>
                            {foreach $banks['b2b'] as $k=>$v}
                                <li>
                                    <label class="radio-inline ">
                                        <input data-bank='{$j++}' onclick="b2bBank(this)" type="radio" name="bank" value="{$k}" checked/>
                                        <img src="{$_assets}bank_logo/{$v}">
                                    </label>
                                </li>
                            {/foreach}
                        </ul>
                        <div class="clear"></div>
                    </div>
                    <div class="alert alert-warning alert-warning1 hidden" role="alert" {$i=0}>
                        {foreach $banks['des'] as $k=>$v}
                            {if $i==0}
                                <div class="b2bDes{$i++}">{nl2br($v)}</div>
                            {else}
                                <div style="display: none" class="b2bDes{$i++}">{nl2br($v)}</div>
                            {/if}
                        {/foreach}

                    </div>
                    <div class="ch_ca" style=" padding-top: 15px; border: 0px;">
                        <b style="color: #2c99ff;">个人银行卡</b>
                        <ul>
                            {foreach $banks['b2c'] as $k=>$v}
                                <li>
                                    <label class="radio-inline"><input type="radio" name="bank" value="{$k}" checked/><img src="{$_assets}bank_logo/{$v}"></label>
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

                <div class="clear"></div>
            </div>
        </div>
    </div>
</form>
<script>
    //b2b提示信息
    function b2bBank(o) {
        var i = $(o).attr('data-bank');
        if ($(".b2bDes" + i).size()) {
            $(".alert-warning1").removeClass('hidden').show();
            $(".b2bDes" + i).show().siblings().hide();
        } else {
            $(".alert-warning1").hide();
        }
    }
    ;
    $("input[name='sex']").click(function () {
        if ($(".bank").is(":checked")) {
            $('.wd_b1').show();
        } else {
            $('.wd_b1').hide();
        }
    })
</script>