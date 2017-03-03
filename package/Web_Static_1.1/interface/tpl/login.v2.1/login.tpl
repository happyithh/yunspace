<!DOCTYPE html>
<html>
<head>
    {include file="Web_Static::v2.0/html_goto_mobile.tpl" url="m/user_center/" not_m='1'}
    {include 'Web::inc/html_head.tpl'}
    {static "login.v2.1/login.css"}
    <link rel="stylesheet" type="text/css" href="plugins/ionicons-master/css/ionicons.min.css">
</head>
<body>
<!--头部  -->
{include file="Web_Static::v2.0/html_header3.1.tpl"}
<div class="container login_outside">
    <div class="row con clearfix banner_wrap">
        <div class="login_body">
            <div class="login_banner col-md-8">
                <img src="img/login.v2.0/login_bg.jpg" class="img-responsive">
            </div>
            <div class="login_form col-md-4" style="position:relative;">
                <div class="div_tabs login-method">
                    <div>
                        <div class="login_header">
                            <h3 class="login-space" >登录云&nbsp·&nbspspace
                            </h3>
                            <a href="javascript:;" class="phone-link phone-login">手机动态码登录&nbsp;<span class="ion-android-phone-portrait"></span></a>
                        </div>
                        <form action="{$_home}login" method="post">
                            <input type="hidden" name="islogin" value="islogin"/>
                            <input type="hidden" name="url_back" value="{$url_back}">
                            <div class="form-group form-group-log">
                                <input class="form-log" type="text" name="username" value="{$re_username}"
                                       placeholder="请输入通行证账号"/>
                            </div>
                            <div class="form-group form-group-log">
                                <input class="form-log" type="password" name="password"
                                       placeholder="请输入密码"/>
                            </div>
                            <div class="login-or-remember">
                                <div class="remember-username">
                                    <label onselectstart="return false"  style="color:#b8b8b8"><input type="checkbox" name="remember" value="1" {if $re_username}checked="checked" {/if}><span class="txt">记住用户名</span></label>
                                </div>
                                <div class="forget-password">
                                    <a href="reset_password"  style="color:#b8b8b8">忘记密码?</a>
                                </div>
                            </div>
                            <div class="clear"></div>
                            <div class="form-group form-group-log">
                                <button type="submit" class="butt_2">
                                    登录
                                </button>
                            </div>
                        </form>
                        <div class="show-and-register" style="font-size: 13px;">还没有云space通行证账号？<a href="register">免费注册</a></div>
                    </div>
                </div>
                <div class="div_tabs login-method  login-active">
                    <div>
                        <div class="login_header">
                            <h3 class="login-space" >登录云&nbsp·&nbsp;SPACE
                            </h3>
                            <a href="javascript:;" class="phone-link normal-login">普通方式登录&nbsp;<span class="ion-android-person"></span></a>
                        </div>
                        <form action="{$_home}login" method="post" yun="form-validate/form-validate.js::formSubmit" data-validate='true'>
                            <input type="hidden" name="islogin" value="quick_login"/>
                            <input type="hidden" name="url_back" value="{$url_back}">
                            <div class="phone-input">
                                <div class="p-icon"><span class="ion-android-phone-portrait"></span></div>
                                <input type="text"  name="phone"  class="p-input1 fast-phone" placeholder="请填写手机号码" yun="form-validate/form-validate.js::typeValidate@keyup" class="fast-phone"
                                       yun-type="phone" yun-error="" yun-style="position:absolute,right:25px,color:#666666,font-size:20px,lineHeight:46px"
                                       data-validate="true">
                            </div>
                            <style>
                                .none{
                                    display: none;
                                }
                            </style>
                            <div class="phone-input" style="position:relative">
                                <div class="p-icon"><span class="ion-android-unlock"></span></div>
                                <input type="text" name="auth_code"  class="p-input2 " placeholder="请填写验证码"
                                       yun="form-validate/form-validate.js::typeValidate@keyup"
                                       yun-type="code" yun-error=""
                                       yun-style="position:absolute,right:37%,color:#666666,font-size:20px,lineHeight:46px" yun-phone=".fast-phone">
                                <span class="ion-close tip  none" style="position:absolute;right:37%;color:#666666;font-size:20px;line-height:46px;"></span>
                                <button type="button" class="phone-code" yun="identify-code.v1.0/identify-code.v1.0.js::sendCode@click"
                                        yun-second="60" yun-phone=".p-input1">发送验证码</button>
                            </div>
                            <div class="login-or-remember">
                                <div class="remember-username">
                                    <label onselectstart="return false"  style="color:#b8b8b8"><input type="checkbox" name="remember" value="1" {if $re_username}checked="checked" {/if}><span class="txt">记住用户名</span></label>
                                </div>
                                <div class="forget-password">
                                    <a href="reset_password"  style="color:#b8b8b8">忘记密码?</a>
                                </div>
                            </div>
                            <div class="clear"></div>
                            <div class="form-group form-group-log">
                                <button type="submit" class="butt_2 fast-login1"  style="background: #e0e0e0" disabled>
                                    登录
                                </button>
                            </div>
                        </form>
                        <div class="show-and-register" style="font-size: 13px;">还没有云space通行证账号？<a href="register">免费注册</a></div>
                        <div class="show-and-register" style="margin-top: 10px;color:#666">提示：未注册的手机号，登录时将自动注册云SPACE账号，且代表您已阅读并同意 <a href="/yunspace/agreement" style="color:#3bd3ba!important;">《云SPACE通行证注册协议》</a></div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>

{static "core/yunspace.js"}
<script src="js/login.v2.1/login.js"></script>
{*{static "login.v2.1/login.js"}*}
<div style="margin-top:50px;" class="mt50"></div>
{include file="Web_Static::v2.0/form.tpl"}
{include file="Web_Static::v2.0/html_footer.tpl"}
{static "core/yunspace.js"}
</body>
</html>