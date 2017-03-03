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
                                <h4>自动提现</h4>
                            </div>
                        </div>

                        <!----正文内容--->
                        <div class="wd">
                            <div class="wd_b">
                                <form class="form-horizontal" style="padding-top: 30px;" action="?" method="get">
                                    <input type="hidden" name="is_submit" value="1">
                                    <input type="hidden" name="action" value="auto_cash">
                                    <div class="form-group">
                                        <label for="inputEmail3" class="col-sm-2 control-label">选择银行卡</label>
                                        <div class="col-sm-4">
                                            <div class="wd_b1_b">
                                                {foreach $account['bank_account'] as $k=>$v}
                                                    {if $v[0]==$account['account_name']}
                                                        <p>
                                                            <label>
                                                                <input type="radio" name="bank" value="{$k}" {if $k==md5($auto_info['bank_account_no'])}checked{/if} />
                                                                &nbsp;&nbsp;&nbsp;&nbsp;<img src="{$___urls["assets"]}bank_logo/bank_{strtolower($v[1])}.gif">&nbsp;&nbsp;&nbsp;&nbsp;{$banks[$v[1]]}
                                                                尾号{substr($v[2],-4)}
                                                                &nbsp;&nbsp;&nbsp;&nbsp;
                                                                {if $v[3]}
                                                                    城市[{$v[3]}]
                                                                {/if}
                                                                {if $v['pup_no']}
                                                                    &nbsp;&nbsp;&nbsp;&nbsp;银联商户号{$v['pup_no']}
                                                                {/if}
                                                            </label>
                                                        </p>
                                                    {/if}
                                                {/foreach}
                                                <div class="wd_b2">
                                                    <a href="?action=new_card">添加银行卡</a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="inputEmail3" class="col-sm-2 control-label">开户行所属城市</label>

                                        <div class="col-sm-4">
                                            <input class="form-control" type="text" placeholder="选择的银行卡已填写城市时，此选项可忽略" name="bank_city"/>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="inputEmail3" class="col-sm-2 control-label">交易密码</label>

                                        <div class="col-sm-4">
                                            <input class="form-control" type="password" placeholder="输入交易密码" name="password2"/>
                                        </div>
                                    </div>
                                    {if !$account['auto_info']}
                                    <div class="form-group">
                                        <label for="inputEmail3" class="col-sm-2 control-label">到账时间</label>

                                        <div class="col-sm-7">
                                            <div style="padding-top: 10px;">
                                                {if date('w')==5}
                                                    {date("Y年m月d日 20:00前",strtotime('+3 day'))}
                                                {elseif date('w')==6}
                                                    {date("Y年m月d日 20:00前",strtotime('+3 day'))}
                                                {elseif date('w')==0}
                                                    {date("Y年m月d日 20:00前",strtotime('+2 day'))}
                                                {elseif date('H')>14}
                                                    {date("Y年m月d日 20:00前",strtotime('+2 day'))}
                                                {else}
                                                    {date("Y年m月d日 20:00前",strtotime('+1 day'))}
                                                {/if}
                                            </div>
                                        </div>
                                    </div>
                                    {/if}
                                    <div class="form-group">
                                        <div class="col-sm-offset-2 col-sm-10">
                                            <button type="submit" class="btn btn-default">
                                                 提交
                                            </button>
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