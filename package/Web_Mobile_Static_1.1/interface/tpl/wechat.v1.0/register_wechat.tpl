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
            <button type="button" style="display: none;width: 35%;" class="absolute send_code col-3 js-register-send-code"  yun="identify-code.v1.0/identify-code.v1.0.js::sendCode@click" yun-id=".js-register-send-code" yun-phone=".js-register-phone" yun-second="60">②获取短信验证码</button>
            <button type="button" style="width: 35%;" id="yzm_captcha" class="absolute send_code col-3">①滑块拼图验证</button>
        </div>
        <div id="captcha"></div>
        <script src="http://static.geetest.com/static/tools/gt.js"></script>
        <p class="block js-warning3" style="color:#c04e6e"></p>
        <div class="form_btn margin-top1 register_submit">
            <a href="javascript:;" class="form_button block background2 js-register" id="register-success">激活我的云·Space</a>
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
<script>
    var handler = function (captchaObj) {
        captchaObj.onReady(function(){
            var elements_n = $('.gt_holder');
            if (elements_n.length > 0) {
                elements_n.first().css({ 'z-index' : 10 });
            }
            var elements = $('.gt_mask');
            if (elements.length > 0) {
                elements.first().css({ 'z-index' : 500 });
            }
        });
        // 将验证码加到id为captcha的元素里
        captchaObj.bindOn("#yzm_captcha");
        captchaObj.onSuccess(function(){
            $("#yzm_captcha").hide();
            $(".js-register-send-code").show();
        });
        captchaObj.appendTo("#captcha");
    };
    $.ajax({
        // 获取id，challenge，success（是否启用failback）
        url:"http://{Core::$urls['host']}/static/api/common/start/cs.json?rand="+Math.round(Math.random()*100),
        type: "get",
        dataType: "json", // 使用jsonp格式
        success: function (data) {
            // 使用initGeetest接口
            // 参数1：配置参数，与创建Geetest实例时接受的参数一致
            // 参数2：回调，回调的第一个参数验证码对象，之后可以使用它做appendTo之类的事件
            initGeetest({
                gt: data.gt,
                challenge: data.challenge,
                product: "popup", // 产品形式
                offline: !data.success
            }, handler);
        }
    });
</script>
</body>
</html>