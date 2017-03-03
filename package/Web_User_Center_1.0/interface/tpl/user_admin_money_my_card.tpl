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
                                    我的银行卡
                                </h4>
                            </div>
                        </div>

                        <!----正文内容--->
                        <div class="wd">
                            <div class="wd_b">
                                <form class="form-horizontal" style="padding-top: 30px;" action="?" method="get">
                                    <input type="hidden" name="is_submit" value="1">
                                    <input type="hidden" name="action" value="cash">

                                    <div class="form-group">
                                        <label for="inputEmail3" class="col-sm-2 control-label">我的银行卡</label>

                                        <div class="col-sm-4">
                                            <div class="wd_b1_b">
                                                {foreach $account['bank_account'] as $k=>$v}
                                                    <p>
                                                        <label>
                                                            <input type="radio" name="bank" value="{$k}"/>
                                                            &nbsp;&nbsp;&nbsp;&nbsp;<img
                                                                    src="{$___urls["assets"]}bank_logo/bank_{strtolower($v[1])}.gif">&nbsp;&nbsp;&nbsp;&nbsp;{$banks[$v[1]]}
                                                            尾号{substr($v[2],-4)}
                                                            <a href="?action=edit_card&bank_account={$v[2]}"
                                                               style="margin-left: 250px;padding: 5px 15px; background:#2c99ff; color: #ffffff;"
                                                               onclick="">修改</a>
                                                            <a href="?action=remove_card&bank_account={$v[2]}"
                                                               style="margin-left: 0px;padding: 5px 15px; background:#f54545; color: #ffffff;"
                                                               onclick="return confirm('您确定要删除吗？？')">删除</a>

                                                        </label>
                                                    </p>
                                                {/foreach}
                                                <div class="wd_b2">
                                                    <a href="?action=new_card">添加银行卡</a>
                                                    <a href="{Core::$urls['action']}" style="margin-left: 10px;padding:6px 50px;background:#fafafa;color:#000000">返回</a>
                                                    {*<a href="?action=card_manage" style="background:#fafafa; margin-left: 15px;  color: #333; ">管理银行卡</a>*}
                                                </div>
                                            </div>
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