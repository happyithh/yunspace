<!DOCTYPE html>
<!--[if IE 8]>
<html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]>
<html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en" class="no-js">
<!--<![endif]-->
<!-- BEGIN HEAD -->
<head>
    <title>{$title}</title>
    <meta content="" name="description"/>
    {include "Admin::inc/html_head.tpl"}
    <link href="style/css.css" rel="stylesheet"/>
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->

<body style="background:#FaFaFa !important">
<div class="portlet-body">
    <div style="padding: 10px 0">
        <div class="alert alert-block alert-info fade in">
            <h4 class="alert-heading">提现信息</h4>

            <p>
                用户名: {$detail['detail']['username']}

            </p>

            <p>
                手机: {$detail['detail']['phone']}

            </p>

            <p>
                开户名: {$detail['detail']['bank_account']}

            </p>

            <p>
                目标银行: {$detail['detail']['bank_name']} {$detail['detail']['bank_id']}
                (
                {******{substr($detail['detail']['bank_account_no'],-4)}*}
                {$detail['detail']['bank_account_no']}
                )
            </p>

            <p>
                金额:
                <b style="color: #f54545">{$detail['amount']}</b>元
            </p>
            {if $detail['confirm_time']<=0}
                <p>
                    账户余额:
                    <b style="color: #f54545">{Finance_Account::amountFormat($account['balance']+$detail['amount'])}</b>元
                </p>
                <p>
                    提现后账户余额: {$account['balance']}元
                </p>
                <p>
                    <a class="btn btn-primary" href="?id={$_REQUEST['id']}&action=submit_pass">通过</a>
                    <a class="btn btn-danger" href="?id={$_REQUEST['id']}&action=submit_reject">拒绝</a>
                </p>
            {else}
                <p>
                    账户余额:
                    <b style="color: #f54545"> {$account['balance']}</b>元
                </p>
            {/if}
        </div>
        <h4>
            近期收入:<b style="color:#2c99ff; ">{$total_amount[0]}</b>元;
            近期支出<b style="color: #f54545">{$total_amount[1]}</b>元
        </h4>
        <h4>近期账户明细 &nbsp;&nbsp; </h4>
        <table class="table table-striped table-bordered table-hover" id="data_table" style="word-break: break-all">
            <thead>
            <tr>
                <th>类型</th>
                <th>订单号</th>
                <th>项目名称</th>
                <th>收入</th>
                <th>支出</th>
                <th>时间</th>
            </tr>
            </thead>
            <tbody>
            {foreach $list as $k=>$v}
                {if $v['confirm_time']>0||$v['order_no']!=$detail['order_no']}
                    <tr {if $v['confirm_time']<0} class="danger"{/if} role="row">
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
                            <td>提现到:
                                【{$v['detail']['bank_name']}
                                (*****{substr($v['detail']['bank_account_no'],-4)}
                                )】
                            </td>
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
                    </tr>
                {/if}
            {/foreach}
            </tbody>
        </table>
    </div>
</div>
</body>
<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
<!-- BEGIN CORE PLUGINS -->
<script src="{$_assets}plugins/jquery-1.11.0.min.js"
        type="text/javascript"></script>
<script>
    function changeCity(o) {
        var href = window.location.href + '?';
        window.location = href.substr(0, href.indexOf('?')) + '?city=' + $(o).val() + '&t=' + (new Date()).valueOf();
    }
</script>
</body>
<!-- END BODY -->
</html>