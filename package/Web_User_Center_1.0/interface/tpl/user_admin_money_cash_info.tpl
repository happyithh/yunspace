<!DOCTYPE html>
<!--[if IE 8]>
<html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]>
<html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en" class="no-js">
<!--<![endif]-->
<head>
    {if Core::$package['name']=='Web_Vendor_Center'}
        {include 'Web_User_Center::inc/html_head.tpl' theme='blue'}
    {else}
        {include 'Web_User_Center::inc/html_head.tpl'}
    {/if}
    <link rel="stylesheet" href="css/money.css"/>
</head>
<body>
{if Core::$package['name']=='Web_Vendor_Center'}
    {include 'Web_User_Center::inc/header_top.tpl' color='#0b679e'}
{else}
    {include 'Web_User_Center::inc/header_top.tpl'}
{/if}
<div class="clearfix"></div>
<div class="page-container">
    {if Core::$package['name']=='Web_Vendor_Center'}
        {include 'Web_Vendor_Center::inc/header_nav.tpl'}
    {else}
        {include 'inc/header_nav.tpl'}
    {/if}
    <div class="page-content-wrapper">

        <div class="page-content" style="min-height: 973px">
            <h3 class="page-title">云服务-我的钱包</h3>

            <div class="portlet">
                <div class="portlet-body util-btn-margin-bottom-5" style="border-bottom:1px solid #e4e4e4">
                    <!----内容开始--->
                    <div class="money_a">
                        <div class="top_a">
                            <div class="fl">
                                <h4>
                                    提现信息
                                </h4>
                            </div>
                        </div>
                        <!----正文内容--->
                        <div class="wd">
                            <div class="wd_b">
                                <form class="form-horizontal" style="padding-top: 30px;" action="?" method="post">
                                    <input type="hidden" name="is_submit" value="1">
                                    <input type="hidden" name="action" value="cash">

                                    <div class="form-group">
                                        <label for="inputEmail3" class="col-sm-2 control-label">银行卡信息</label>

                                        <div class="col-sm-4">
                                            <div class="wd_b1_b">
                                                <p>
                                                    <label>
                                                        [{$payment['payment_detail']['bank_account']}
                                                        ]
                                                        &nbsp;&nbsp;&nbsp;&nbsp;<img src="{$___urls["assets"]}bank_logo/bank_{strtolower($payment['payment_detail']['bank_id'])}.gif">&nbsp;&nbsp;&nbsp;&nbsp;{$banks[$account['bank_account'][$_REQUEST['bank']][1]]}
                                                        尾号
                                                        **{substr($payment['payment_detail']['bank_account_no'],-4)}
                                                    </label>
                                                </p>
                                            </div>
                                        </div>

                                    </div>
                                    <div class="form-group">
                                        <label for="inputEmail3" class="col-sm-2 control-label">提现金额</label>

                                        <div class="col-sm-4">
                                            <div style="padding-top: 10px;">
                                                {Finance_Account::amountFormat($payment['amount'])}
                                                元
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="inputEmail3" class="col-sm-2 control-label">操作时间</label>

                                        <div class="col-sm-7">
                                            <div style="padding-top: 10px;">
                                                {date("Y年m月d日 H:i", $payment['create_time'])}
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="inputEmail3" class="col-sm-2 control-label">到账时间</label>

                                        <div class="col-sm-7">
                                            <div style="padding-top: 10px;">
                                                {if date('w',$payment['create_time'])==5}
                                                    {date("Y年m月d日 20:00前",$payment['create_time'] + 86400*3)}
                                                {elseif date('w',$payment['create_time'])==6}
                                                    {date("Y年m月d日 20:00前",$payment['create_time'] + 86400*3)}
                                                {elseif date('w',$payment['create_time'])==0}
                                                    {date("Y年m月d日 20:00前",$payment['create_time'] + 86400*2)}
                                                {elseif date('H',$payment['create_time'])>14}
                                                    {date("Y年m月d日 20:00前",$payment['create_time'] + 86400*2)}
                                                {else}
                                                    {date("Y年m月d日 20:00前",$payment['create_time']+86400)}
                                                {/if}
                                            </div>
                                        </div>
                                    </div>
                                    {if $_REQUEST['is_submit']}
                                        <div class="form-group">
                                            <label for="inputEmail3" class="col-sm-2 control-label">交易密码</label>

                                            <div class="col-sm-4">
                                                <input class="form-control" type="password" placeholder="输入交易密码" name="password2"/>
                                            </div>
                                        </div>
                                    {/if}
                                    <div class="form-group">
                                        <div class="col-sm-offset-2 col-sm-10">
                                            <button type="button" class="btn" onclick="window.history.go(-1)">
                                                返回
                                            </button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
{include 'Web_User_Center::inc/footer_inbox.tpl'}
{include 'Web_User_Center::inc/footer_script.tpl'}
</body>
</html>