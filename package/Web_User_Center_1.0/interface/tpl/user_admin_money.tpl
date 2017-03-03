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
                    <!---内容开始--->
                    <div class="money_a">
                        <div class="top_a">
                            <div class="fl"><h4>钱包账户</h4>
                            </div>
                            <span>账户名：{$account['account_name']}</span>
                        </div>
                        {if $auto_info}
                            <div class="top_b">
                                <div class="top_b_1">
                                    <div class="b_a">自动提现信息：</div>
                                    <div class="b_b">
                                        <div class="fl b_b1">
                                            提现银行卡:{$auto_info['bank_account_no']}
                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            {if $auto_info['pup_no']}
                                            银联商户号：{$auto_info['pup_no']}
                                            {/if}
                                        </div>
                                        <div class="fl b_b2">
                                            <a style="background:#f54545; margin-left: 15px; " href="?action=close_auto_cash&auto_id={$auto_info['id']}">关闭自动提现</a>
                                            <a style="background:#2c99ff; margin-left: 15px; " href="?action=auto_cash&auto_id={$auto_info['id']}">更换自动提现</a>
                                        </div>
                                    </div>
                                    <div class="clear"></div>
                                </div>
                            </div>
                        {/if}
                        <!---正文内容--->
                        <div class="top_b">
                            <div class="top_b_1">
                                <div class="b_a">账户余额：</div>
                                <div class="b_b">
                                    <div class="fl b_b1">
                                        <span>{$account['balance']}</span>元
                                    </div>
                                    <div class="fl b_b2">
                                        {*<a href="{$_root}user_center/user_admin/money_detail">账户收支明细</a>*}
                                        <a href="?action=cash" style="background:#f54545; margin-left: 15px; ">账户提现</a>
                                        {*<a href="?action=new_card" style="background:#666; margin-left: 15px; ">添加银行卡</a>*}
                                        <a href="?action=my_card" style="background:#2c99ff; margin-left: 15px; ">我的银行卡</a>
                                        {if !$auto_info}
                                            {*<a href="?action=auto_cash" style="background:#666; margin-left: 15px; ">开启自动提现</a>*}
                                        {/if}
                                    </div>
                                </div>
                                <div class="clear"></div>
                            </div>
                        </div>

                        <!----正文内容--->
                        <div class="sz">
                            <div class="sz_a">
                                <div class="sz_a1">
                                    <div class=" sz_a1a form-inline  pull-left">
                                        <form action="" id="changeDate" method="post">
                                            <select class="form-control" name="datetime" onchange="changeDate(this)">
                                                {foreach $dates as $v}
                                                    <option value="{$v}" {if $_REQUEST['datetime']==$v}selected="selected" {/if}>
                                                        {$v}
                                                    </option>
                                                {/foreach}
                                            </select>
                                        </form>
                                        <script>
                                            function changeDate(obj) {
                                                $('#changeDate').submit();
                                            }
                                        </script>
                                    </div>
                                    <div class="sz_a1b pull-right">
                                        <span>
                                            收入: &nbsp;&nbsp;<b style="color:#2c99ff; ">{$total_amount[0]}</b>&nbsp;&nbsp;元 &nbsp;&nbsp;&nbsp;&nbsp;
                                            支出： &nbsp;&nbsp;<b style="color: #f54545">{$total_amount[1]}</b>&nbsp;&nbsp;元
                                        </span>
                                    </div>
                                    <div class="clear"></div>
                                </div>
                                <div class="table-responsive" style="border: 0px;">
                                    <div class="portlet-body clear">
                                        <table class="table table-striped table-bordered table-advance table-hover">
                                            <thead>
                                            <tr>
                                                <th>类型</th>
                                                <th>订单号</th>
                                                <th>项目名称</th>
                                                <th>收入</th>
                                                <th>支出</th>
                                                <th>操作时间</th>
                                                <th>明细操作
                                                </th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            {foreach $account_detail as $v}
                                                <tr {if $v['confirm_time']<0} class="danger"{/if}>
                                                    {if $v['amount']>0}
                                                        <td>
                                                            {if $v['category']=='支付'}
                                                                收款
                                                            {else}
                                                                {$v['category']}
                                                            {/if}
                                                        </td>
                                                    {else}
                                                        <td>{$v['category']}</td>
                                                    {/if}
                                                    <td>
                                                        {$v['detail']['order_no']|default:'-'}
                                                    </td>
                                                    {if $v['category']=='提现'}
                                                        <td>提现到: 【{$v['detail']['bank_name']} (*****{substr($v['detail']['bank_account_no'],-4)})】</td>
                                                    {else}
                                                        <td title="{$v['detail']['payment_title']}">
                                                            {$v['detail']['payment_title']|default:'-'}
                                                            {if $v['confirm_time']<0}
                                                                {if $v['amount']>0}
                                                                    <span class="label label-danger">
                                                                 收款异常
									                            </span>
                                                                {else}
                                                                    <span class="label label-danger">
                                                                 付款异常
									                            </span>
                                                                {/if}
                                                            {/if}
                                                        </td>
                                                    {/if}
                                                    {if $v['confirm_time']<0}
                                                        <td>
                                                            <s>{if $v['amount']>0}{$v['amount']}元{/if}</s>
                                                        </td>
                                                        <td>
                                                            <s>{if $v['amount']<0}{$v['amount']}元{/if}</s>
                                                        </td>
                                                    {else}
                                                        <td>{if $v['amount']>0}{$v['amount']}元{/if}</td>
                                                        <td>{if $v['amount']<0}{$v['amount']}元{/if}</td>
                                                    {/if}
                                                    <td>
                                                        {date("Y-m-d H:i",$v['create_time'])}
                                                    </td>
                                                    <td>
                                                        {if $v['detail']['order_no']}
                                                            <a href="{$_root}order_info/{$v['detail']['order_no']}" target="_blank" class="btn btn-xs btn-info">查看订单</a>
                                                        {else}
                                                            <a href="?action=detail_info&order_no={$v['order_no']}" class="btn btn-xs btn-default">查看详情</a>
                                                        {/if}
                                                    </td>
                                                </tr>
                                            {/foreach}
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
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