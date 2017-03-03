<!DOCTYPE html>
<html>
<head>
    {include file="Web_Static::v2.0/html_goto_mobile.tpl" url="m/user_center/"}
    {include 'Web::inc/html_head.tpl'}
    <link rel="stylesheet" type="text/css" href="css/register.v2.0/register-1.css">
</head>
<body>
<!--头部  -->
{include 'Web::inc/header_nav.tpl'}
<div class="content ">
    <div class="wrap con clearfix banner_wrap">
        <div class="register_person">
            <div class="clear"></div>
            <div class="reg_body">
                <div class="clear"></div>
                <div class="reg_form">
                    <div class="container-fluid">
                        <div class="login_header">
                            注册云&nbsp;·&nbsp;space通行证
                        </div>
                        <form action="register" method="post">
                            <input type="hidden" name="action" value="register"/>
                            <div class="container-fluid">
                                <div class="row">
                                    <div class="col-md-4 p left">用户名</div>
                                    <div class="col-md-8 right"><input type="text" name="username"  data-url="{$_root}static/api/account/check/name.jsonp" class="input js-username"></div>
                                </div>
                                <div class="info-content js-info-name"><p></p></div>
                            </div>
                            <div class="container-fluid">
                                <div class="row">
                                    <div class="col-md-4 p left">手机号</div>
                                    <div class="col-md-8 right">
                                        <input type="text" name="phone" class="input js-phone-num" data-url="{$_root}static/api/account/check/phone.jsonp" data-is-ready="false">
                                    </div>
                                </div>
                                <div class="info-content js-info-phone"><p></p></div>
                            </div>
                            <div class="clear"></div>
                            <div class="container-fluid">
                                <div class="row">
                                    <div class="auth_code" id="auth_code">
                                        <div class="col-md-4 p left">验证码</div>
                                        <div class="col-md-8 right">
                                            <div style="float: right; width: 37%;">
                                                <button type="button" class="js-send verify-code-send"
                                                        yun="identify-code.v1.0/identify-code.v1.0.js::sendCode@click" yun-phone=".js-phone-num"
                                                        yun-second="60" disabled="disabled" style="color:#fff;background:rgb(224, 224, 224)">
                                                    {*rgb(59, 213, 187)*}
                                                    发送验证码
                                                </button>
                                            </div>
                                            <div style="float: left; width: 60%;">
                                                <input type="text" name="auth_code" class="input js-verify-code" data-url="{$_root}static/api/common/check/auth/code.jsonp" style="width: 100%;" data-is-ready="false"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="info-content js-info-code"><p></p></div>
                            </div>
                            <div class="clear"></div>
                            <div class="container-fluid">
                                <div class="row">
                                    <div class="col-md-4 p left">输入密码</div>
                                    <div class="col-md-8 right"><input type="password" name="password" class="input js-new-pass-word" data-is-ready="false">
                                    </div>
                                </div>
                                <div class="info-content js-info-new-pass"><p></p></div>
                            </div>
                            <div class="container-fluid">
                                <div class="row">
                                    <div class="col-md-4 p left">确认密码</div>
                                    <div class="col-md-8 right"><input type="password" name="rpassword" class="input js-repeat-pass-word" data-is-ready="false">
                                    </div>
                                </div>
                                <div class="info-content js-info-repeat-pass"><p></p></div>
                            </div>

                            <div class=" checkbox" style="padding-left: 32px; padding-right: 10px;">
                                <input type="checkbox" name="tnc" value="1" id = "tnc" class="js-check-protocol" data-is-ready="false" checked />
                                <label for="tnc">我已阅读并同意
                                    <a href="{$_root}yunspace/agreement" target="_blank">《云&nbspspace&nbsp通行证注册协议》</a></label>
                            </div>

                            <div class="form_submit">
                                <button type="submit" name="submit" class="js-btn-register" disabled="disabled" style="background:#e0e0e0;">
                                    免费注册
                                </button>
                            </div>
                            <p style="height: 28px;line-height: 28px;text-align: center;">
                                已经有云SPACE的账户，点击<a href="login" style=" padding-left: 10px; color: #39d6bb !important;font-weight: 600;">返回登录</a></p>
                        </form>
                    </div>
                </div>
            </div>
            <div class="clear"></div>
        </div>
    </div>
</div>
<!-- 尾部 -->
{include file="Web_Static::v2.0/html_footer.tpl"}
{static "register.v2.0/register.js"}
{static "core/yunspace.js"}
</body>
</html>