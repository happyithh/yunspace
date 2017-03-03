
<div class="cover none cover-one"></div>
<div class="person-code none person-code-one">
    <div class="person-code-relative">
        <div class="person-code-close">
            <a href="javascript:;" class="person-code-close-one"><img src="img/v4.0/close.png" alt=""></a>
        </div>
    </div>

    <div class="person-code-img clearfix  mr-none person-code-change-one none person-code-img-one ">
        <div class="pserson-code-title">
            <span>扫一扫</span>
        </div>
        <div>
            <p class="code-title">访问云SPACE移动版</p>
            <img src="img/yidong.png" alt="" width="100" height="100">
        </div>
    </div>
    <div class="person-code-img clearfix  mr-none person-code-change-one none person-code-img-one " >
        <div class="pserson-code-title">
            <span>扫一扫</span>
        </div>
        <div class="code-img code-img-change-one">
            <p class="code-title">微信订阅号<br>关注活动资讯</p>
            <img src="img/qrcode_info.png" alt="" width="100" height="100">
        </div>
        <div class="code-img code-img-change-one" style="margin-right:0px;">
            <p class="code-title">微信服务号<br>关注场地资源</p>
            <img src="img/qrcode_space.png" alt="" width="100" height="100">
        </div>
    </div>
    <div class="person-code-img clearfix person-code-change-two none person-code-img-one">
        <div class="pserson-code-title">
            <span>扫一扫</span>
        </div>
        {*<div class="code-img code-img-change-one">*}
            {*<p class="code-title">商业空间短租平台<br>一键租场地</p>*}
            {*<img src="img/hdcdzj.png" alt="" width="100" height="100">*}
        {*</div>*}
        <div class="code-img code-img-change-one" style="margin-right:0px;">
            <p class="code-title">云SPACE场地大师<br>空间场地管理App</p>
            <img src="img/ygj_new.png" alt="" width="100" height="100">
        </div>
    </div>
    <div class="person-code-img clearfix  mr-none person-code-change-one none person-code-img-one log-cont">
        <h1>登录
            {*<a href="{$_home}user_center/login"  >密码登录/注册</a>*}
        </h1>
        <div class="ipt ipt-numb clearfix">
            <span class="fl icon-c_lr icon-nmb"></span>
            <input class="fl" type="text" name="phone" id="phone" placeholder="手机号码">
        </div>
        <div class="ipt ipt-code clearfix">
            <span class="fl icon-c_lr icon-code"></span>
            <input class="fl" type="text" name="code" style="width: 150px;" id="code" placeholder="验证码">
            <button class="fr sendcode-btn " style="background: #6a96ef;color: #fff;">发送验证码</button>
            {*<button id="yzm_captcha" class="fr sendcode-btn_new" style="background: #6a96ef;color: #fff;width: 135px;">人机验证后发送验证码</button>*}
        </div>
        {*<div id="captcha"></div>*}
        {*<script src="http://static.geetest.com/static/tools/gt.js"></script>*}
        <p class="login_error_msg none" >错误信息</p>
        <a class="logreg-btn" href="javascript:;">登录</a>
        <div class="agreement">
            <input class="fl ipt-check" type="checkbox" value="1" name="checkbox" checked>
            <a class="fl text" href="{$_home}yunspace/agreement" target="_blank">同意《云SPACE通行证注册协议》</a>
        </div>
    </div>
</div>
{static "core/yunspace.js"}
{static "js/login.js"}
{*<script>*}
    {*var handler = function (captchaObj) {*}
        {*// 将验证码加到id为captcha的元素里*}
        {*captchaObj.bindOn("#yzm_captcha");*}
        {*captchaObj.onSuccess(function(){*}
            {*$("#yzm_captcha").hide();*}
            {*$("#origin_yzm_captcha").remove();*}
            {*$(".sendcode-btn").removeClass('hide');*}
            {*$(".sendcode-btn").css('display','block');*}
        {*});*}
        {*captchaObj.appendTo("#captcha");*}
    {*};*}
    {*$.ajax({*}
        {*// 获取id，challenge，success（是否启用failback）*}
        {*url:"http://{Core::$urls['host']}/static/api/common/start/cs.json?rand="+Math.round(Math.random()*100),*}
        {*type: "get",*}
        {*dataType: "json", // 使用jsonp格式*}
        {*success: function (data) {*}
            {*// 使用initGeetest接口*}
            {*// 参数1：配置参数，与创建Geetest实例时接受的参数一致*}
            {*// 参数2：回调，回调的第一个参数验证码对象，之后可以使用它做appendTo之类的事件*}
            {*initGeetest({*}
                {*gt: data.gt,*}
                {*challenge: data.challenge,*}
                {*product: "popup", // 产品形式*}
                {*offline: !data.success*}
            {*}, handler);*}
        {*}*}
    {*});*}
{*</script>*}