<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    {include file="Web_Static::inc/head_meta.tpl"}
    {static "v4.0/common.css"}
    {static "about/about.css"}
</head>
<body yun="about/feedback.js::joinSubmit">
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
            <h2>意见反馈</h2>
        </div>

        <div class="feedback-wrap">
            <input type="hidden" name="fedbak" id="fedbak" value="15">
            <div>
                <textarea id="feedback" name="data[意见反馈]" rows="12" placeholder="您的意见，对我们而言十分宝贵，请畅所欲言！" style="max-width:797px"></textarea>
                <div class="contact-number clearfix">
                    <input id="contact" name="data[联系方式]" class="fl" type="text" placeholder="请留下您的联系方式：手机号码/QQ/微信/邮箱">
                    <button class="fr btn js-feedback-btn">提交</button>
                </div>
            </div>
        </div>

    </div><!--about-content-end-->
</div><!--wrapper-end-->

<!--弹窗-->
<div class="pop-status hide">
    <a href="javascript:;" class="icon-close js-close"></a>
    <div class="pop-status-success hide">
        <h1><i class="icon-state icon-state-success"></i><span>提交成功！</span></h1>
        <p>感谢您提出的宝贵意见</p>
    </div>
    <div class="pop-status-error hide">
        <h1><i class="icon-state icon-state-error"></i><span>提交失败！</span></h1>
        <p>必要字段没有填写</p>
    </div>
</div>
<div class="pop-bg hide"></div>

{include file="Web_Static::inc/html_footer.tpl"}
{include file="Web_Static::inc/public_space.tpl"}
</body>

</html>