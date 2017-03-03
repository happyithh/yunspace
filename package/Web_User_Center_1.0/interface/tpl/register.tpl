<!DOCTYPE html>
<html>
<head>
    {include file="Web_Static::v2.0/html_goto_mobile.tpl" url="m/user_center/"}
    {include 'Web::inc/html_head.tpl'}
    <link rel="stylesheet" type="text/css" href="css/register-1.css">

</head>
<body>
<!--头部  -->
{include 'Web::inc/header_nav1.tpl'}

<div class="content ">
    <div class="wrap con clearfix banner_wrap">
        <div class="register_person">
            <div class="reg_header ">
                <div class="one" style="background:#24252f;border-radius:18px;">1</div>
                <p>设置账户信息</p>
                <img src="images/u70_line.png" alt=""/>

                <div class="two">2</div>
                <p>注册成功</p>
            </div>
            <div class="clear"></div>
            <div class="reg_body">
                <div class="reg_page">
                    <a href="register">用户注册</a><a href="vendor_register" style="float:right;background: #ccc; border-radius: 2px; color: #ffffff;">供应商注册</a>
                </div>
                <div class="clear"></div>
                <div class="reg_form">
                    <div class="container-fluid">
                    <form action="register" method="post">
                        <div class="container-fluid">
                            <div class="row">
                                 <div class="col-md-4 p left">用户名</div>
                                 <div class="col-md-8 right"><input type="text" name="username" class="input"></div>
                            </div>
                        </div>
                        <div class="container-fluid">
                            <div class="row">
                                <div class="col-md-4 p left">手机号码</div>
                                <div class="col-md-8 right"><input type="text" name="phone" class="input"></div>
                            </div>
                        </div>

                        {*<div class="container-fluid">*}
                            {*<div class="row">*}
                                {*<div class="auth_code" id="auth_code">*}
                                    {*<div class="col-md-4 p left">图形验证码</div>*}
                                    {*<div class="col-md-8 right">*}
                                        {*<div style="float: right; width: 33%;"> <a href="javascript:void(0);" class="disabled" onclick="$(this).find('img').attr('src',$(this).find('img').attr('src')+'?1')" style="height: 45px;">*}
                                                {*<img src="{$_home}register/auth_code_img"></a></div>*}
                                        {*<div style="float: left; width: 67%;"> <input type="text" name="auth_code_img" class="input" style="width: 85%;"></div>*}
                                    {*</div>*}
                              {*</div>*}
                            {*</div>*}
                        {*</div>*}
                        <div class="clear"></div>
                        <div class="container-fluid">
                            <div class="row">
                                <div class="auth_code" id="auth_code">
                                    <div class="col-md-4 p left">手机验证码</div>
                                    <div class="col-md-8 right">
                                        <div style="float: right; width: 33%;"><a href="javascript:void(0);" id="send_sms" class="disabled" style="height: 45px;">发送验证码</a></div>
                                        <div style="float: left; width: 67%;"> <input type="text" name="auth_code" class="input" style="width: 85%;">
                                                        {literal}
                                                            <script type="text/javascript">
                                                                  var sms_interval;
                                                                  function start_sms_button(obj) {
                                                                   var count = 1;
                                                                   var sum = 60;
                                                                   obj.html('剩余' + parseInt(sum - count) + '秒');
                                                                   sms_interval = setInterval(function () {
                                                                     if (count > 30) {
                                                                       obj.removeClass('disabled');
                                                                       obj.attr('disabled', false);
                                                                       obj.html('发送验证码');
                                                                       clearInterval(sms_interval);
                                                                     } else {
                                                                        obj.html('剩余' + parseInt(sum - count) + '秒');
                                                                     }
                                                                        count++;
                                                                    }, 1000);
                                                                 }
                                    function IsMobile(mobile) {
                                        if (mobile.length == 0) {
                                            return false;
                                        }
                                        if (mobile.length != 11) {
                                            return false;
                                        }

                                        var myreg = /^((1[3|5|7|8]{1})+\d{9})$/;
                                        if (!myreg.test(mobile)) {
                                            return false;
                                        }
                                        return true;
                                    }

                                    $(function () {
                                        //发送验证码
                                        $('#send_sms').click(function () {
                                            var send_obj = $('#send_sms');
                                            if (send_obj.attr('disabled') || send_obj.hasClass('disabled')) {
                                                return;
                                            }
                                            var phone_obj = $('input[name="phone"]');
                                            var val = phone_obj.val();
                                            if (val) {
                                                if (IsMobile(val)) {
                                                    send_obj.attr('disabled', "disabled");
                                                    send_obj.addClass('disabled');
                                                    start_sms_button(send_obj);
                                                    $.post('register/auth_code', {
                                                        'phone': val,
                                                        'auth_code_img': $('input[name="auth_code_img"]').val()
                                                    }, function (data) {
                                                        if ($.trim(data)) {
                                                            alert(data);
                                                            send_obj.removeClass('disabled');
                                                            send_obj.attr('disabled', false);
                                                            send_obj.html('发送验证码');
                                                            clearInterval(sms_interval);
                                                        }
                                                    });
                                                } else {
                                                    alert("手机号的格式错误");
                                                }
                                            } else {
                                                alert('手机号不能为空');
                                            }
                                        });
                                        $('input[name="phone"]').blur(function () {
                                            var send_obj = $('#send_sms');
                                            send_obj.addClass('disabled');
                                            var val = $(this).val();
                                            if (val) {
                                                if (IsMobile(val)) {
                                                    if (!send_obj.attr('disabled')) {
                                                        send_obj.removeClass('disabled');
                                                    }
                                                } else {
                                                    alert("手机号的格式错误");
                                                }
                                            } else {
                                                alert('手机号不能为空');
                                            }
                                        }).keyup(function () {
                                            if ($(this).val().length == 11) {
                                                $(this).trigger('blur');
                                            }
                                        });
                                        $('form').submit(function () {
                                            if (!$('#tnc:checked').val()) {
                                                alert('请阅读并同意《云SPACE用户协议注册协议》');
                                                return false;
                                            } else {
                                                return true;
                                            }
                                        });
                                    });
                                </script>
                            {/literal}</div>
                                        </div>
                                </div>
                            </div>
                        </div>
                        <div class="clear"></div>
                        <div class="container-fluid">
                            <div class="row">
                                <div class="col-md-4 p left">输入密码</div>
                                <div class="col-md-8 right">   <input type="password" name="password" class="input"></div>
                               </div>
                        </div>
                        <div class="container-fluid">
                            <div class="row">
                                <div class="col-md-4 p left">确认密码</div>
                                <div class="col-md-8 right">  <input type="password" name="rpassword" class="input"></div>
                            </div>
                        </div>

                        <div class=" checkbox" style="padding-left: 32px; padding-right: 10px;">
                            <input type="checkbox" name="tnc" value="1" id="tnc"/>
                            <label for="tnc">我已阅读并同意
                                <a href="{$_root}yunspace/agreement" target="_blank">《云SPACE用户协议注册协议》</a></label>
                        </div>

                        <div class="form_submit">
                            <button type="submit">
                                下一步
                            </button>
                            <input type="hidden" name="register" value="1"/>
                            <input type="hidden" name="account_type" value="1"/>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <div class="clear"></div>
        <div class="reg_log">
            已经有云SPACE的账户，点击<a href="login" style="color: #00c3c3;">登陆</a>
        </div>
    </div>
    <div class="clear"></div>
</div>


<!-- 尾部 -->
    {include file="Web_Static::v2.0/html_footer.tpl"}
</body>
</html>