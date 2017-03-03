<link href="plugins/ionicons-master/css/ionicons.min.css" rel="stylesheet">
<link href="css/login-register.css" rel="stylesheet">
<script src='js/login-register.js'></script>
<div class="cover-login"></div>

<div class="login-modal">
    <div class="l-m-con">
        <div class="l-m-c-header">
            <p class="i-p">登录</p>
            <p class="i-close"><span class="ion-close"></span></p>
        </div>
        <div class="login-form">
            <form action="{$_home}user_center/login" yun="form-validate/form-validate.js::formSubmit" data-validate='true' data-id="0" method="post">
                <input type="hidden" name="islogin" value="islogin"/>
                <input type="hidden" name="url_back" value="{$url_back}">
                <div class="l-f-header">
                    <p class="l-f-h-title">登录云·SPACE</p>
                    <a href="javascript:;" class="l-f-h-method phone-login" data-id="1" data-me="0">手机动态码登录&nbsp; <span class="ion-android-phone-portrait"></span></a>
                </div>
                <div class="l-f-input">
                    <input type="text" name="username"  placeholder="请输入通行账号" data-validate='true'>
                </div>
                <div class="l-f-input">
                    <input type="password" name="password" placeholder="请输入密码" data-validate='true'>
                </div>
                <div class="l-f-footer">
                    <input type="checkbox" class="agree-input" style="display: none">
                    <div class="checkbox"><span></span></div>
                    <p>记住用户名</p>
                    <a href="/user_center/reset_password" target="_blank">忘记密码?</a>
                </div>
                <div class="l-f-submit">
                    <button class="l-f-s-btn" style="background: #3bd5bb">登录</button>
                </div>
            </form>
            {*<p class="l-f-tip">您还没有云·SPACE通行账号？&nbsp;&nbsp;<a href="javascript:;" class="register-fast" data-id="2" data-me="0">免费注册</a></p>*}
        </div>
    </div>
</div>

<div class="login-modal">
    <div class="l-m-con">
        <div class="l-m-c-header">
            <p class="i-p">登录</p>
            <p class="i-close"><span class="ion-close"></span></p>
        </div>
        <div class="login-form">
            <form action="{$_home}user_center/login" yun="form-validate/form-validate.js::formSubmit" data-validate='true' data-id="0" method="post">
                <input type="hidden" name="islogin" value="quick_login"/>
                <input type="hidden" name="url_back" value="{$url_back}">
                <div class="l-f-header">
                    <p class="l-f-h-title">登录云·SPACE</p>
                    <a href="javascript:;" class="l-f-h-method login-normal" data-id="0" data-me="1">普通方式登录&nbsp; <span class="ion-android-person"></span></a>
                </div>
                <div class="l-f-input" style="position: relative;border: 0px;">
                    <span class="ion-android-phone-portrait i-code"></span>
                    <input type="text"  name="phone" class="login-code phone-fast" placeholder="请输入手机号" style="padding-left: 8%;"
                           yun="form-validate/form-validate.js::typeValidate@keyup" yun-length="11"
                           yun-type="phone" yun-error="" yun-style="position:absolute,right:35%,color:#ff0000,font-size:20px,lineHeight:48px"
                           data-validate="true"/>
                    <button class="fast-send-code" type="button" yun="identify-code.v1.0/identify-code.v1.0.js::sendCode@click"
                       yun-second="60" yun-phone=".phone-fast">发送验证码</button>
                </div>

                <div class="l-f-input" style="position: relative;">
                    <span class="ion-android-unlock i-code"></span>
                    <input type="text" name="auth_code"  placeholder="请输入动态密码" style="padding-left: 8%;"
                           yun="form-validate/form-validate.js::typeValidate@keyup"
                           yun-type="code" yun-error="" yun-style=""
                            yun-phone=".phone-fast" data-validate="true">
                    <span class="ion-close tip none" style="position:absolute;right:2%;top:0px;color:#ff0000;font-size:20px;line-height:48px;"></span>
                </div>
                <div class="l-f-footer">
                    <input type="checkbox" class="agree-input" style="display: none">
                    <div class="checkbox"><span></span></div>
                    <p>记住用户名</p>
                    <a href="/user_center/reset_password" target="_blank">忘记密码?</a>
                </div>
                <div class="l-f-submit">
                    <button class="l-f-s-btn fast-login2" style="background: rgb(224, 224, 224)" disabled >快捷下单</button>
                </div>
            </form>
            <p class="l-f-tip" style="line-height:20px;font-size: 10px;margin-top: 20px;">提示：未注册云·SPACE通行账号手机号，登录时将自动注册，且代表您已阅读并同意&nbsp;&nbsp;<a href="/yunspace/agreement" target="_blank">《云·SPACE通行注册协议》</a></p>
        </div>
    </div>
</div>

<div class="login-modal" style="width:570px;height:680px;margin-left: -285px;margin-top: -360px;">

</div>


