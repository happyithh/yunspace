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

        <div class="page-content">
            <h3 class="page-title">云服务-我的钱包</h3>

            <div class="portlet">
                <div class="portlet-body util-btn-margin-bottom-5" style="border-bottom:1px solid #e4e4e4">
                    <!----内容开始--->
                    <div class="money_a">
                        <div class="top_a">
                            {if !empty($banks_info)}
                            <div class="fl"><h4>修改银行卡</h4>
                                {else}
                            <div class="fl"><h4>添加银行卡</h4>
                                {/if}
                            </div>
                        </div>
                        <!----正文内容--->
                        <div class="wd_b">
                            <form class="form-horizontal" style="padding-top: 30px;" action="?action=new_card" method="post">
                                <input type="hidden" name="is_submit" value="1">
                                <input type="hidden" name="action" value="new_card">
                                <input type="hidden" name="edit_bank_account" value="{$banks_info[4]}">
                                <div class="form-group">
                                    <label for="inputEmail3" class="col-sm-2 control-label">开户名称</label>

                                    <div class="col-sm-4">
                                        <input class="form-control" type="text" readonly value="{$account['account_name']}"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="inputEmail3" class="col-sm-2 control-label">开户银行</label>

                                    <div class="col-sm-4">
                                        <select class="form-control" name="bank">
                                            {foreach $banks as $k=>$v}
                                                <option value="{$k}" {if $k==$banks_info[1]}selected{/if}>{$v}</option>
                                            {/foreach}
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="inputEmail3" class="col-sm-2 control-label">银行卡卡号</label>

                                    <div class="col-sm-7">
                                        <input class="form-control" type="text" placeholder="输入银行卡号" name="bank_account"/ value="{$banks_info[2]}">
                                        {*<br/>输入卡号后会自动识别银行卡类型和种类*}
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="inputEmail3" class="col-sm-2 control-label">开户行所属城市</label>

                                    <div class="col-sm-7">
                                        <input class="form-control" type="text" placeholder="输入开户银行卡所属城市" value="{$banks_info[3]}" name="bank_city"/>
                                        {*<br/>输入卡号后会自动识别银行卡类型和种类*}
                                    </div>
                                </div>
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
{include 'Web_User_Center::inc/footer_inbox.tpl'}
{include 'Web_User_Center::inc/footer_script.tpl'}

</body>
</html>