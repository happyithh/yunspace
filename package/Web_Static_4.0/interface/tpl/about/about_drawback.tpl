<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    {include file="Web_Static::inc/head_meta.tpl"}
    {static "v4.0/common.css"}
    {static "about/about.css"}
</head>
<body>
{include file="Web_Static::inc/header_1.tpl"}
<div class="about-location">
    <div class="wrapper">
        <div class="crumb">
            <a href="{$_home}">首页</a>&gt;<a href="{$_root}about" class="active">关于我们</a>
        </div>
    </div>
</div>
<div class="about_banner"></div>
<div class="wrapper about-wrapper clearfix">
    {include file="Web_Static::about/inc/left_nav.tpl"}

    <div class="about-content fr">
        <div class="about-title">
            <h2>退款说明</h2>
        </div>

        <h5>●&nbsp;退款流程说明</h5>
        <p>1. 如因商品质量问题、不符合交付标准、取消订单、使用异常等原因，您的订单需要进行退款，那么请您在取消订单或交易结算时写明详细的原因，等待供应商进行确认后，我司会直接通过线上交易系统将您需要退回的款项支付到您当前支付订单的该银行账号。</p>
        <p>2. 具体退款到账时间:
           <br>退款到账时间一般为：<span class="orange">1-3个工作日</span></p>

        <h5>●&nbsp;退款查询</h5>
        <p>退款申请提交待供应商确认后，将会有短信告知您。请您在1-3个工作日内查询您的云SPACE账户和银行卡账户情况，如有异常情况，请拨打客服热线咨询。</p>

        <h5>●&nbsp;退款须知</h5>
        <p>1. 退款账号规则：
            <br>我司不支持退款至非当前交易支付账号的其他账号进行退款。</p>
        <p>2. 退款手续费问题：
            <br>我司退款不存在手续费用，请您在查询银行卡账户时详细核对收到的退款金额，并且可以查询我司账户内的订单详情查看实际支付和退款的金额。</p>


    </div><!--about-content-end-->
</div><!--wrapper-end-->
{include file="Web_Static::inc/html_footer.tpl"}
{include file="Web_Static::inc/public_space.tpl"}
</body>

</html>