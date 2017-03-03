<!DOCTYPE html>
<html>
<head>
    {include 'Web::inc/html_head.tpl'}
    <link rel="stylesheet" type="text/css" href="css/login.v2.0/reset-password.css">
</head>
<body>
<!--头部  -->
{include 'Web::inc/header_nav.tpl'}
<div class="reset-content">
    <div class="process-nav">
        <div class="nav-content icon1-act">
            <p class="active">身份验证</p>
        </div>
        <div class="process-arrow js-icon2-arrow">>>>>></div>
        <div class="nav-content icon2 js-icon2-p">
            <p>修改密码</p>
        </div>
        <div class="process-arrow">>>>>></div>
        <div class="nav-content icon3">
            <p>修改完成</p>
        </div>
    </div>
    <div class="form-content">
        <div class="nav-tab js-nav-tab-verify active">
            <div class="content-row">
                <div class="left">手机号</div>
                <div class="right">
                    <input type="text" id="js-phone-num" class="input" placeholder="请输入注册时用的手机号"
                           data-url="{$_root}user_center/forget/forget_step1" data-is-ready="false"/>
                </div>
            </div>
            <div class="info-content js-info-phone"><p></p></div>
            <div class="content-row">
                <div class="left">手机验证码</div>
                <div class="right">
                    <div class="verify-code-input">
                        <input type="text" id="js-verify-code" class="input"
                               data-url="{$_root}user_center/forget/forget_step2?action=code_new" data-is-ready="false"/>
                    </div>
                    <button class="js-send verify-code-send"
                            yun="identify-code.v1.0/identify-code.v1.0.js::sendCode@click" yun-phone="#js-phone-num"
                            yun-second="60" disabled="disabled">
                        发送验证码
                    </button>
                </div>
            </div>
            <div class="info-content js-info-code"><p></p></div>
            <button class="next-step js-next-step" disabled="disabled"
                    data-url="{$_root}user_center/forget/forget_step2?action=next_new">下一步
            </button>
        </div>
        <div class="nav-tab js-nav-tab-finish">
            <form action="{$_root}user_center/forget/forget_step3_new">
                <div class="content-row">
                    <div class="left">输入新密码</div>
                    <div class="right">
                        <input type="password" name="password" class="input js-new-pass-word" data-is-ready="false"/>
                    </div>
                </div>
                <div class="info-content js-info-new-pass"><p></p></div>
                <div class="content-row">
                    <div class="left">确认新密码</div>
                    <div class="right">
                        <input type="password" class="input js-repeat-pass-word" data-is-ready="false"/>
                    </div>
                </div>
                <div class="info-content js-info-repeat-pass"><p></p></div>
                <button class="next-step js-finish" type="submit" disabled="disabled">完成修改密码</button>
            </form>
        </div>
    </div>
    <a href="login" class="back-to-login">
        返回登录页面
    </a>
</div>
{include file="Web_Static::v2.0/html_footer.tpl"}
{static "login.v2.0/reset-password.js"}
{static "core/yunspace.js"}
</body>
</html>