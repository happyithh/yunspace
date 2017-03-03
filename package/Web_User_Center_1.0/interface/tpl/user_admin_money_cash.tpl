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
                                    {if $_REQUEST['is_submit']}
                                        确认提现信息
                                    {else}
                                        提取余额到银行卡
                                    {/if}
                                </h4>
                            </div>
                             <span>
                                 余额: &nbsp;&nbsp;<b style="color:#2c99ff; ">{$account['balance']}</b>&nbsp;&nbsp;元 &nbsp;&nbsp;&nbsp;&nbsp;
                             </span>
                        </div>

                        <!----正文内容--->
                        <div class="wd">
                            <div class="wd_b">
                                <form class="form-horizontal" style="padding-top: 30px;" action="?" method="get">
                                    <input type="hidden" name="is_submit" value="1">
                                    <input type="hidden" name="action" value="cash">

                                    <div class="form-group">
                                        {if $_REQUEST['is_submit']}
                                            <label for="inputEmail3" class="col-sm-2 control-label">银行卡信息</label>
                                            <div class="col-sm-4">
                                                <div class="wd_b1_b">
                                                    <p>
                                                        <label>
                                                            <input type="hidden" name="bank" value="{$_REQUEST['bank']}" checked/>
                                                            [{$account['account_name']}
                                                            ]
                                                            &nbsp;&nbsp;&nbsp;&nbsp;<img src="{$___urls["assets"]}bank_logo/bank_{strtolower($account['bank_account'][$_REQUEST['bank']][1])}.gif">&nbsp;&nbsp;&nbsp;&nbsp;{$banks[$account['bank_account'][$_REQUEST['bank']][1]]}
                                                            尾号{substr($account['bank_account'][$_REQUEST['bank']][2],-4)}
                                                        </label>
                                                    </p>
                                                </div>
                                            </div>
                                        {else}
                                            <label for="inputEmail3" class="col-sm-2 control-label">选择银行卡</label>
                                            <div class="col-sm-4">
                                                <div class="wd_b1_b">
                                                    {foreach $account['bank_account'] as $k=>$v}
                                                        {if $v[0]==$account['account_name']}
                                                            <p>
                                                                <label>
                                                                    <input type="radio" name="bank" value="{$k}" checked/>
                                                                    &nbsp;&nbsp;&nbsp;&nbsp;<img src="{$___urls["assets"]}bank_logo/bank_{strtolower($v[1])}.gif">&nbsp;&nbsp;&nbsp;&nbsp;{$banks[$v[1]]}
                                                                    尾号{substr($v[2],-4)}
                                                                </label>
                                                            </p>
                                                        {/if}
                                                    {/foreach}
                                                    <div class="wd_b2">
                                                        <a href="?action=new_card">添加银行卡</a>
                                                        {*<a href="?action=card_manage" style="background:#fafafa; margin-left: 15px;  color: #333; ">管理银行卡</a>*}
                                                    </div>
                                                </div>
                                            </div>
                                        {/if}
                                    </div>
                                    <div class="form-group">
                                        <label for="inputEmail3" class="col-sm-2 control-label">提现金额</label>

                                        <div class="col-sm-4">
                                            {if $_REQUEST['is_submit']}
                                                <div style="padding-top: 10px;">
                                                    {Finance_Account::amountFormat($_REQUEST['amount'])}
                                                    元
                                                </div>
                                                <input type="hidden" name="amount" value="{$_REQUEST['amount']}"/>
                                            {else}
                                                <input class="form-control" type="text" placeholder="输入金额 (<{$account['balance']})" name="amount"/>
                                            {/if}
                                        </div>
                                    </div>
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
                                            <button type="submit" class="btn btn-default">
                                                {if $_REQUEST['is_submit']}
                                                    提交
                                                {else}
                                                    下一步
                                                {/if}
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