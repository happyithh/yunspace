<!DOCTYPE html>
<html>
<head>
    {include file="Web_Static::v2.0/html_goto_mobile.tpl" url="m/user_center/"}
    {include 'Web::inc/html_head.tpl'}
    <link rel="stylesheet" type="text/css" href="css/login.v2.0/login.css">
    <link rel="stylesheet" type="text/css" href="plugins/ionicons-master/css/ionicons.min.css">
</head>
<body>
<!--头部  -->
{include 'Web::inc/header_nav.tpl'}
<div class="container login_outside">
    <div class="row con clearfix banner_wrap">
        <div class="login_body">
            <div class="login_banner col-md-8">
                <img src="img/login.v2.0/login_bg.jpg" class="img-responsive">
            </div>
            <div class="login_form col-md-4" style="position:relative;">
                <div class="div_tabs" >
                    <div>
                        <div class="login_header">
                            <h3 style="text-align: left;padding-left: 20px;padding-right:20px">登录云&nbsp·&nbspspace
                                <a href="javascript:;" class="phone-login" style="font-size: 13px;float: right;line-height: 20px;padding-top: 11.5px;color:#666">手机动态码登录
                                    <span class="ion-iphone" style="font-size: 17px;line-height: 22px;color:#2bb8aa"></span>
                                </a>
                            </h3>
                        </div>
                        <form action="{$_home}login" method="post">
                            <input type="hidden" name="islogin" value="islogin"/>
                            <input type="hidden" name="url_back" value="{$url_back}">
                            <div class="form-group form-group-log">
                                <input class="form-control form-log" type="text" name="username" value="{$re_username}"
                                       placeholder="请输入通行证账号"/>
                            </div>
                            <div class="form-group form-group-log">
                                <input class="form-control form-log" type="password" name="password"
                                       placeholder="请输入密码"/>
                            </div>
                            <div class="login-or-remember">
                                <div class="remember-username">
                                    <label onselectstart="return false"><input type="checkbox" name="remember" value="1" {if $re_username}checked="checked" {/if}>记住用户名</label>
                                </div>
                                <div class="forget-password">
                                    <a href="reset_password">忘记密码?</a>
                                </div>
                            </div>
                            <div class="clear"></div>
                            <div class="form-group form-group-log">
                                <button type="submit" class="butt_2">
                                    登录
                                </button>
                            </div>
                        </form>
                        <div class="show-and-register">还没有云space通行证账号？<a href="register">免费注册</a></div>
                    </div>
                </div>
                <div class="div_tabs" style="display: none">
                    <div>
                        <div class="login_header">
                            <h3 style="text-align: left;padding-left: 20px;padding-right:20px">登录云&nbsp·&nbspspace
                                <a href="javascript:;" class="common-login" style="font-size: 13px;float: right;line-height: 20px;padding-top: 11.5px;color:#666">普通方式登录
                                    <span class="ion-ios-person" style="font-size: 18px;line-height: 22px;color:#2bb8aa;"></span>
                                </a>
                            </h3>
                        </div>
                        <form action="" method="post"  data-validate='true'yun="form-validate/form-validate.js::formSubmit">
                            <input type="hidden" name="islogin" value="quick_login"/>
                            <input type="hidden" name="url_back" value="{$url_back}">

                            <div class="p-l-input">
                                <div class="p-l-i-con" style="position: relative">
                                    <p><span class="ion-android-phone-portrait"></span></p>
                                    <input type="text" name="phone" yun="form-validate/form-validate.js::typeValidate@keyup" class="fast-phone"
                                           yun-type="phone" yun-error="" yun-style="position:absolute,right:5px,color:#666666,font-size:20px,lineHeight:44px"
                                           data-validate="true">
                                </div>
                            </div>
                            <div class="p-l-input">
                                <div class="p-l-i-con">
                                    <p><span class="ion-ios-unlocked"></span></p>
                                    <input type="text" name="auth_code" data-validate="true" class="code-phone">
                                    <a href="javascript:;" class="send-code-phone" yun="identify-code.v1.0/identify-code.v1.0.js::sendCode@click"
                                       yun-second="60" yun-phone=".fast-phone">发送验证码</a>
                                </div>
                            </div>

                            <div class="login-or-remember">
                                <div class="remember-username">
                                    <label onselectstart="return false"><input type="checkbox" name="remember" value="1" {if $re_username}checked="checked" {/if}>记住用户名</label>
                                </div>
                                <div class="forget-password">
                                    <a href="reset_password">忘记密码?</a>
                                </div>
                            </div>
                            <div class="clear"></div>
                            <div class="form-group form-group-log">
                                <button type="submit" class="butt_2">
                                    登录
                                </button>
                            </div>
                        </form>
                        <div class="show-and-register">还没有云space通行证账号？<a href="register">免费注册</a></div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>
<script>
    $(".phone-login").on("click",function(){
        $(".div_tabs").first().hide();
        $(".div_tabs").eq(1).show();
    });
    $(".common-login").on("click",function(){
        $(".div_tabs").eq(1).hide();
        $(".div_tabs").first().show();
    });
</script>
{static "core/yunspace.js"}
<div style="margin-top:50px;" class="mt50"></div>
{include file="Web_Static::v2.0/html_footer.tpl"}
</body>
</html>