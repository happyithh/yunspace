<!DOCTYPE html>
<html>
<head lang="en">
    <title>{$title}</title>
    <meta content="" name="description"/>
    {include "Admin::inc/html_head.tpl"}
    <style>
        .success {
            color: #008000;
        }

        .error {
            color: #ff0000;
        }
    </style>
</head>
<body style="background:#FaFaFa !important">


<div class="portlet tabbable">
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-database"></i>修改密码
        </div>
    </div>
    <div class="portlet-body form">
        <form class="form-horizontal" role="form" action='?'>
            <input name="action" value="submit_admin" type="hidden">
            <div class="form-body">
                <div class="form-group">
                    <label class="col-md-3 control-label">用户名</label>

                    <div class="col-md-5">
                        <input class="form-control input-lg" value='{$username}' type="text" readonly>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label">手机号</label>

                    <div class="col-md-5">
                        <input class="form-control phone" placeholder="请输入手机号" type="text" name="admin[phone]" value="{$phone}">
                        <span class="phone_mess"></span>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label">邮箱</label>

                    <div class="col-md-5">
                        <input class="form-control phone" placeholder="请输入邮箱" type="text" name="admin[email]" value="{$email}">
                        <span class="phone_mess"></span>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label">原密码</label>

                    <div class="col-md-5">
                        <input class="form-control  oldPassword" placeholder="请输入原始密码" type="password" name="admin[old_password]">
                        <span class="password_mess"></span>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label">新密码</label>

                    <div class="col-md-5">
                        <input class="form-control newPassword" placeholder="密码为6-18位字符" type="password" name="admin[password]">
                        <span class="newPassword_mess"></span>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label">确认密码</label>

                    <div class="col-md-5">
                        <input class="form-control  rePassword" placeholder="两次密码必须一致" type="password" name="admin[repassword]">
                        <span class="rePassword_mess"></span>
                    </div>
                </div>
            </div>
            <div class="form-actions text-center">
                <button type="button" class="btn btn-default">
                    返回
                </button>
                <button type="submit" class="btn btn-success">
                    提交
                </button>
            </div>
        </form>
    </div>
</div>


<!-- BEGIN CORE PLUGINS -->
<script src="plugins/jquery-1.11.0.min.js" type="text/javascript"></script>
<script>
    $(function () {
        $('.phone').blur(function () {
            var phone = $('.phone').val();
            if (phone != '') {
                $.ajax({
                    type: 'post',
                    url: '?',
                    data: {
                        check_phone:1,
                        phone: phone
                    },
                    success: function (json) {
                        // alert(json);
                        if (json == 'success') {
                            var info = '<i class="glyphicon glyphicon-ok">手机号正确</i>';
                            $('.phone_mess').removeClass('error');
                            $('.phone_mess').html(info).addClass('success');
                        }else if(json == 'successu'){
                            var info = '<i class="glyphicon glyphicon-ok">手机号已修改</i>';
                            $('.phone_mess').removeClass('error');
                            $('.phone_mess').html(info).addClass('success');
                        } else if(json == 'errors'){
                            var info = '<i class="glyphicon glyphicon-remove">手机号格式错误</i>';
                            $('.phone_mess').removeClass('success');
                            $('.phone_mess').html(info).addClass('error');
                        }else {
                            var info = '<i class="glyphicon glyphicon-remove">手机号修改失败！</i>';
                            $('.phone_mess').removeClass('success');
                            $('.phone_mess').html(info).addClass('error');
                        }
                    }

                })
            } else {
                var info = '<i class="glyphicon glyphicon-remove">手机号不能为空！！</i>';
                $('.phone_mess').removeClass('success');
                $('.phone_mess').html(info).addClass('error');
            }
        });
        $('.oldPassword').blur(function () {
            var password = $('.oldPassword').val();
            if (password != '') {
                $.ajax({
                    type: 'post',
                    url: '?',
                    data: {
                        check_password:1,
                        password: password
                    },
                    success: function (json) {
                        // alert(json);
                        if (json == 'success') {
                            var info = '<i class="glyphicon glyphicon-ok">原始密码正确！！</i>';
                            $('.password_mess').removeClass('error');
                            $('.password_mess').html(info).addClass('success');
                        } else {
                            var info = '<i class="glyphicon glyphicon-remove">原始密码错误！！</i>';
                            $('.password_mess').removeClass('success');
                            $('.password_mess').html(info).addClass('error');
                        }
                    }

                })
            } else {
                var info = '<i class="glyphicon glyphicon-remove">原始密码不能为空！！</i>';
                $('.password_mess').removeClass('success');
                $('.password_mess').html(info).addClass('error');
            }
        });
        {literal}
        function IsPassword(password) {
            if (password.length == 0) {
                return false;
            }


            var myreg = /^.{6,18}$/;
            if (!myreg.test(password)) {
//                alert(mobile);
                return false;
            }
            return true;
        }

        {/literal}

        $('.newPassword').blur(function () {
            var password = $('.newPassword').val();
            if (IsPassword(password)) {
                var info = '<i class="glyphicon glyphicon-ok">密码格式正确！！</i>';
                $('.newPassword_mess').removeClass('error');
                $('.newPassword_mess').html(info).addClass('success');
            } else {
                var info = '<i class="glyphicon glyphicon-remove">密码格式不正确！！</i>';
                $('.newPassword_mess').removeClass('success');
                $('.newPassword_mess').html(info).addClass('error');
            }
        });

        $('.rePassword').blur(function () {
            var password = $('.newPassword').val();
            var rePassword = $('.rePassword').val();
            if (password == rePassword) {
                var info = '<i class="glyphicon glyphicon-ok">两次密码一致！！</i>';
                $('.rePassword_mess').removeClass('error');
                $('.rePassword_mess').html(info).addClass('success');
            } else {
                var info = '<i class="glyphicon glyphicon-remove">两次密码不一致！！</i>';
                $('.rePassword_mess').removeClass('success');
                $('.rePassword_mess').html(info).addClass('error');
            }
        });

        $('form').submit(function (e) {
            $('.phone').trigger('blur');
            $('.oldPassword').trigger('blur');
            $('.newPassword').trigger('blur');
            $('.rePassword').trigger('blur');
            if ($('.password_mess').hasClass('error') || $('.newPassword_mess').hasClass('error') || $('.rePassword_mess').hasClass('error') || $('.phone_mess').hasClass('error')) {
                e.preventDefault();
            }
        })

    });

</script>
<!-- END JAVASCRIPTS -->
</body>
</html>