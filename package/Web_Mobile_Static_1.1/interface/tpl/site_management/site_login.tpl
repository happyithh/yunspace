<!DOCTYPE html>
<html lang="en">
<head>
    {include "Web_Mobile_Static::site_management/inc.meta.tpl"}
    <link rel="stylesheet" href="plugins/font-awesome/css/font-awesome.min.css">
    {static "v1.0/global.css"}
    {static "site_management/site_login.css"}
    {static "site_management/footer.css"}
</head>
<body>
<div class="site_login">
    <header>
        <span>场地管理</span>
    </header>
    <section>
        <img src="img/site_management/logo.png" alt="">
    </section>
    <section>
        <span>空间场地管家</span>
    </section>
    <section>
            <div data-validate="true" class="site_login">
                <div class="login_input_group clear_float">
                    <div class="login_input">
                        {literal}
                            <input type="text" placeholder="请输入手机号码" class="phone js-register-phone"
                                    yun="form-validate/form-validate.js::typeValidate@keyup" data-error="请填写11位的手机号码" data-length="11"
                                   yun-type="phone"  yun-error="" data-validate="true" yun-style="fontSize:18px,position:absolute,right:35px,line-height:45px,color:#ff0000">
                        {/literal}
                    </div>
                </div>
                <div class="login_input_group clear_float">
                    <div class="login_input">
                        <input type="text" class="short js-register-code" placeholder="请输入验证码" data-error="请填写正确的验证码"
                               data-validate="true" yun-type="code" yun-phone=".phone"  yun="form-validate/form-validate.js::typeValidate@keyup" data-length="6">
                    </div>
                    <button type="button" class="send_code" yun-phone=".phone" yun="identify-code.v1.0/identify-code.v1.0.js::sendCode@click">发送验证码</button>
                </div>
                <div class="login_input_group" style="margin-top: 20px;">
                    <button class="login register_submit" yun="" yun-url="" yun-ajax="site_login" yun-form=".site_login" data-id="0" data-year_id="0" data-ticket_number="" data-year_title="" yun-error=".show-error">登&nbsp;录</button>
                </div>

                {*<div class="login_input_group" style="margin-top: 20px;">*}
                    {*<button class="login register_submit" yun="form-validate/form-validate.js::ajaxSubmit@click"*}
                            {*yun-url="" yun-ajax="site_login"*}
                            {*yun-form=".site_login" data-id="0" data-year_id="0" data-ticket_number="" data-year_title="" yun-error=".show-error">登&nbsp;录</button>*}
                {*</div>*}


            </div>
    </section>
    <section>
        {if !empty($_REQUEST['token'])}
            <a href="http://pre0.yunspace.com.cn/m/space_info_list/splist?token={$_REQUEST['token']}&user_id={$_REQUEST['user_id']}">我有空间场地要出租</a>
        {else}
            <a href="http://pre0.yunspace.com.cn/m/space_info_list/splist">我有空间场地要出租</a>
        {/if}
    </section>
</div>

<div class="site_error">
</div>
{*{include "Web_Mobile_Static::site_management/inc.footer.tpl"}*}
<script src="js/wechat.v1.0/register_wechat.js"></script>
{static "v1.0/jquery-1.11.1.min.js"}
{static "v1.0/velocity.js"}
{static "core/yunspace.js"}


</body>
</html>