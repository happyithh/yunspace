<!DOCTYPE html>
<html>
<head>
    {include file="Web_Static::v2.0/html_goto_mobile.tpl" url="m/user_center/"}
    {include 'Web::inc/html_head.tpl'}
    <link rel="stylesheet" type="text/css" href="css/login.css">
    <style>
        .error{
            color:#ff0000;
        }
        .success{
            color:#008000;
        }
    </style>
</head>
<body>
<!--头部  -->
{include 'Web::inc/header_nav.tpl'}
<div class="container login_outside">
    <div class="row con clearfix banner_wrap">
        <div class="login_body">
            <div class="login_banner col-md-8">
                <img src="images/banner-2.jpg"  class="img-responsive">
            </div>

                <div class="login_form col-md-4">
                    <script>
                        function divTab(o, index) {
                            $(o).slideUp();
                            $(o).eq(index).removeClass('hide').slideDown();
                        }
                    </script>
                    <div class="div_tabs">
                        <div>
                            <div class="login_header">
                                <h3>登录 云·SPACE</h3>
                            </div>
                            <form action="{$_home}login" method="post">
                                <div class="form-group form-group-log">
                                    <input class="form-control form-log" type="text" name="username" placeholder="请输入用户名/邮箱或手机号"/>
                                </div>
                                <div class="form-group form-group-log">
                                    <input class="form-control form-log" type="password" name="password" placeholder="请输入密码"/>
                                </div>
                                <div class="form-group form-group-log">
                                    <button type="submit" class="butt_2">
                                        登录
                                    </button>
                                </div>
                                <input type="hidden" name="login" value="1">
                                <input type="hidden" name="url_back" value="{$url_back}">
                            </form>
                            <div class="login_forget">
                                <a href="javascript:void(0);" onclick="divTab('.div_tabs>div',1)">忘记用户名或密码?</a>
                            </div>
                        </div>
                        <div class="hide">
                            <div class="login_header">
                                <h3>忘记密码</h3>
                            </div>
                            <form action="{$_home}user_admin" class="form_1">
                                <div class="form-group form-group-log">
                                    <input class="form-control form-log tel" type="text" placeholder="请输入用户名/邮箱或手机号"/>
                                    <span class="pull-left tel_mess"></span>
                                </div>

                                <div class="form-group form-group-log">
                                    <div style="float: left; width: 70%;">
                                        <input class="form-control form-log code" type="text" placeholder="请输入验证码" style="width: 95%; height: 50px;">
                                        <span class="code_mess"></span>
                                    </div>
                                    <div style="float: right; width: 30%; height: 50px;">
                                        <button type="button" class="butt_1 send"/>
                                        发送验证码
                                        </button>
                                    </div>
                                </div>

                                <div class="form-group form-group-log">
                                    <button href="javascript:void(0);" class="butt_2 next"  onclick="" type="button" class="next">
                                        下一步
                                    </button>
                                </div>
                            </form>
                            <div class="login_forget">
                                <a href="javascript:void(0);" onclick="divTab('.div_tabs>div',0)">返回登录?</a>
                            </div>
                        </div>
                        <div class="hide">
                            <div class="login_header">
                                <h3>重置密码</h3>
                            </div>
                            <form action="{$_root}user_center/forget/forget_step3" class="form_2">
                                <div class="form-group form-group-log">
                                    <input class="form-control form-log password" type="password" placeholder="密码为6-18位字符" name="password"/>
                                    <span class="password_mess"></span>
                                </div>

                                <div class="form-group form-group-log">
                                    <input class="form-control form-log rePassword" type="password" placeholder="请再一次输入新密码"/>
                                    <span class="rePassword_mess"></span>
                                </div>
                                <div class="form-group form-group-log">
                                    <button type="submit" class="butt_2">
                                        完成
                                    </button>
                                </div>
                            </form>
                            <div class="login_forget">
                                <a href="javascript:void(0);" onclick="divTab('.div_tabs>div',0)">返回登录?</a>
                            </div>
                        </div>
                    </div>
                    <div class="form_line"></div>
                    <div class="container-fluid" style="padding-left: 0px; padding-right: 35px;">
                        <div class="row">
                            <div class="reg  col-md-6 enroll_l">
                                <a href="register">用户注册</a>
                            </div>
                            <div class="reg col-md-6 enroll_r">
                                <a href="vendor_register">供应商注册</a>
                            </div>
                            <div class="clear"></div>
                        </div>
                    </div>
                </div>

        </div>
    </div>
</div>
<div style="margin-top:50px;" class="mt50"></div>
{include file="Web_Static::v2.0/html_footer.tpl"}
<script>

    $(document).ready(function(){
        var index=59;
        var send=$(".send");
        {literal}
        //手机号码格式验证
        function IsMobile(mobile) {
            if (mobile.length == 0) {
                return false;
            }
            if (mobile.length != 11) {
                return false;
            }

            var myreg = /^((1[3|5|7|8]{1})+\d{9})$/;
            if (!myreg.test(mobile)) {
                alert(mobile);
                return false;
            }
            return true;
        }
        {/literal}
        //验证手机号码是否注册
        $(".tel").blur(function() {
            var tel=$(".tel").val();
            if (IsMobile(tel)) {
                $.ajax({
                    type:'post',
                    url:'{$_root}user_center/forget/forget_step1',
                    data:{
                        tel:tel
                    },
                    success:function(data){
                        if(data.code=='error'){
                            var message='<i class="glyphicon glyphicon-remove">用户名不存在！！</i>';
                            $('.tel_mess').removeClass("success");
                            $('.tel_mess').html(message).addClass("error");
                            send.attr('disabled',true);
                        }else{
                            $('.tel_mess').removeClass("error");
                            $('.tel_mess').html('').addClass("success");
                            send.attr('disabled',false);
                        }
                    },
                    dataType:'json'
                })
            }else{
                var message='<i class="glyphicon glyphicon-remove">请输入正确的手机号码！！</i>';
                $('.tel_mess').removeClass("success");
                $('.tel_mess').html(message).addClass("error");
                send.attr('disabled',true);
            }
        })
        //发送验证码
        send.click(function(){
            var tel=$(".tel").val();
            var time=setInterval(function() {
                if(index<0){
                    clearInterval(time);
                    var btn="发送验证码";
                    send.html(btn).attr('disabled',false);
                    index=59;
                }else{
                    var delay=index+"秒后可重新发送";
                    send.html(delay).attr('disabled',true);
                }
                index--;
            },1000);
            $.ajax({
                type: 'post',
                url: '{$_root}user_center/forget/forget_step2?action=sendSMS',
                data:{
                    phone:tel
                },
                success:function(data){

                }
            })
        });
        //验证码对比
        $(".code").blur(function() {
            var code=$(".code").val();
            if(!$(".tel").val()){
                return false;
            }
            $.ajax({
                type: 'post',
                url: '{$_root}user_center/forget/forget_step2?action=code',
                data:{
                    code:code
                },
                success:function(data){
                    if(data.code=='error'){
                        //alert(data.code);
                        var htm='<i class="glyphicon glyphicon-remove">验证码不正确！！</i>';
                        $('.code_mess').removeClass("success");
                        $(".code_mess").html(htm).addClass("error");
                    }else{
                        var htm='<i class="glyphicon glyphicon-ok">验证码正确！！</i>';
                        $('.code_mess').removeClass("error");
                        $(".code_mess").html(htm).addClass('success');
                    }
                },
                dataType:'json'
            })
        });

        //若有错误，禁止下一步
        $('.next').click(function() {
            var tel=$(".tel").val();
            var code=$(".code").val();
            $.ajax({
                type: 'post',
                url: '{$_root}user_center/forget/forget_step2?action=next',
                data: {
                    phone: tel,
                    code: code
                },
                success: function (data) {
                    if (data.code == "success") {
                        divTab('.div_tabs>div', 2);
                    }
                },
                dataType: 'json'
            })
        })
        {literal}
        //密码格式验证
        function IsPassword(password) {
            if (password.length < 6) {
                return false;
            }
            if (password.length > 18) {
                return false;
            }

            var myreg = /^\w{6,18}$/;
            if (!myreg.test(password)) {
                return false;
            }
            return true;
        }
        {/literal}
        //验证密码格式
        $(".password").blur(function() {
            var password=$('.password').val();
            if(IsPassword(password)) {
                var info='';
                $(this).next('span').removeClass('error');
                $(this).next('span').addClass('success').html(info);
            }else {
                var info='<i class="glyphicon glyphicon-remove">密码格式不正确！！</i>';
                $(this).next('span').removeClass('success');
                $(this).next('span').addClass('error').html(info);
            };
        })
        //两次密码是否一致
        $(".rePassword").blur(function() {
            var password=$('.password').val();
            var password2=$(".rePassword").val();
            if(password==password2) {
                var info='';
                $(this).next('span').removeClass('error');
                $(this).next('span').addClass('success').html(info);

            }else {
                var info='<i class="glyphicon glyphicon-remove">两次密码不一致！！</i>';
                $(this).next('span').removeClass('success');
                $(this).next('span').addClass('error').html(info);
            };
        })

        //密码不一致阻止提交
        $('.form_2').submit(function(e) {
            var password=$('.password').val();
            var password2=$(".rePassword").val();
            if(password!=password2){
                e.preventDefault();
            }
        })


    })

</script>
</body>
</html>