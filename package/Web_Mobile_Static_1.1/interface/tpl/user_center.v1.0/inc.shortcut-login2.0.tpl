<style>
    .none{
        display: none;
    }

</style>
<div class="header padding-small">
    <div class="logo">
        <img src="img/user_center.v1.0/mobile_logo.png" alt="logo"
             class="img-responsive logo_img"/>
    </div>
</div>
<div class="footer margin-small">
    <form action="{$_root}static/api/analysis/login/dwz.json"   data-validate='true' method="post">
        {*<input type="hidden" name="url_back" value="{$url_back}">*}
        <input type="hidden" name="account_id" value="{$account_id}">
        <input type="hidden" name="action_login" value="quick_login"/>
        <div class="form_input  background1"  style="position:relative;">
            <p style="display: block;position: absolute;left:4px;top:16px;"><span class="ion-unlocked" style="font-size: 16px;color:#ddd"></span></p>
            <input type="text"  class="input col-6 " name="auth_code" placeholder="手机校验码" style="width: 60%!important;float:left"

                   yun-type="code" yun-error="" yun-style="position:absolute,right:32%,color:#666666,font-size:20px,lineHeight:50px" yun-phone=".fast-phone"
                   data-validate="true"/>
            {*<span class="ion-close" style="position: absolute;right:32%;line-height: 50px;font-size: 20px;color:#666;display: none;"></span>*}
            {*<button type="button" class=" send_code col-3 " style="float:left"  yun="identify-code.v1.0/identify-code.v1.0.js::sendCode@click"*}
                    {*yun-second="60" yun-phone=".fast-phone">发送验证码</button>*}
            <span class="ion-close tip none" style="position:absolute;right:32%;color:#666666;font-size:20px;line-height:50px;"></span>
        </div>
        <p class="block js-warning1" style="color:#c04e6e"></p>
        <div  class="form_btn margin-top1">
            <button type="submit"  class="form_button block background fast-login"  style="font-size: 18px;">进&nbsp;入&nbsp;查&nbsp;看</button>
        </div>
    </form>
    <div class="link">
        <p class="link_a" id="login-panel" style="line-height: 25px;padding: 20px;width:auto;font-size: 12px;">
           由于登录超时，查看短信中验证码，请输入短信中校验码登录
        </p>
    </div>
</div>
{*<div class="modal absolute js-modal1">*}
{*<p class="block modal-title js-modal-title">注册成功！！</p>*}
{*<a href="javascript:;" class="block ok js-ok">确定</a>*}
{*</div>*}
<div class="cover-agreement"></div>
<div class="agreement">
    <div class="agreement-content">
        <p class="close-agreement"><span class="ion-close-round"></span></p>
        {include 'user_center.v1.0/inc.agreement.tpl'}
    </div>



</div>
{static "core/yunspace.js"}
