<!DOCTYPE html>
<html>
<head lang="en">
    {include "Web_Mobile_Static::v1.0/head_meta.tpl"}
    {include "Web_Mobile_Static::user_center.v1.0/inc.head_user.tpl"}
   <title>激活我的云·Space</title>
</head>
<body class="relative" >
<div class="cover absolute js-cover" style="width:100%"></div>
<div class="modal2 absolute js-modal1">
    <div class="modal-title2">
        <span class="icon ion-android-done icon-style"></span>&nbsp;注册成功，立即登录！！
    </div>
    <p class="block absolute close-reset js-close-register"><span class="icon ion-close-round"></span></p>
</div>
<div class="header">
    <div class="logo">
        <img src="img/user_center.v1.0/mobile_logo.png" alt="logo"
             class="img-responsive logo_img"/>
    </div>
</div>
<div class="footer">
        <div class="form_input">
            <input type="number" class="input js-register-phone" placeholder="手机号码"/>
        </div>
        <div class="form_input  relative background1" style="width:100%">
            <input type="number" class="input col-6 js-register-code" placeholder="验证码"/>
            <button type="button" class="absolute send_code col-3 js-register-send-code"  yun="identify-code.v1.0/identify-code.v1.0.js::sendCode@click" yun-id=".js-register-send-code" yun-phone=".js-register-phone" yun-second="60">发送验证码</button>
        </div>
        <p class="block js-warning3" style="color:#c04e6e"></p>
        <div class="form_btn margin-top1 register_submit">
            <a href="javascript:;" class="form_button block js-register" id="register-success" style="background-color: #5cb85c">激活我的云·Space</a>
        </div>

    {*<div class="link">*}
        {*<a href="javascript:;" class="link_a" id="back1">*}
            {*<span class="ion-ios-arrow-back" style="font-size:16px;"></span><span class="ion-ios-arrow-back"*}
                                                                                  {*style="font-size:16px;"></span>&nbsp;返回*}
        {*</a>*}
    {*</div>*}
</div>
<script src="js/wechat.v1.0/register_wechat.js"></script>
{static "core/yunspace.js"}
</body>
</html>