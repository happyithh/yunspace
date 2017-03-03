<style>
    .error {
        color: #ff0000;
    }

    .success {
        color: #008000;
    }
</style>
<form action="" class="form-horizontal" method="post">
    <input type="hidden" name="security_submit" value="1">
    <input type="hidden" name="url_back" value="{$_REQUEST['url_back']}">

    <div class="form-body" id="form_p">
        <h3 class="form-section">修改绑定手机</h3>

        <div class="form-group">
            <label class="col-md-3 control-label">绑定手机号码</label>

            <div class="col-md-4">
                <input type="text" class="pull-left form-control old_phone" value={$__user['phone']} readonly>
                <span class="pull-left tel_mess"></span>
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-3 control-label">验证码</label>

            <div class="col-md-4">
                <div class="input-group">
                  <input type="text" class="form-control code" placeholder="验证码" >

                  <span class="input-group-btn">
                      <button type="button" class="btn btn-danger send">发送验证码</button>
                  </span>
                </div>
                <span class="code_mess"></span>
            </div>
        </div>
    </div>

    <div class="form-actions">
        <div class="row">
            <div class="col-md-offset-3 col-md-9">
                <a href='javascript:;' class="btn btn-info next">
                    下一步
                </a>
                {if $account eq 'user'}
                    <a href="{$_root}user_center/user_admin/account" class="btn btn-default">
                        返回
                    </a>
                {/if}
                {if $account eq 'vendor'}
                    <a href="{$_root}vendor_center/vendor_admin/account" class="btn btn-default">
                        返回
                    </a>
                {/if}
            </div>
        </div>
    </div>
</form>

<script>

    $(document).ready(function () {
        var index = 59;
        var send = $(".send");
        send.click(function () {
            var phone = $(".old_phone").val();
            var time = setInterval(function () {
                if (index < 0) {
                    clearInterval(time);
                    var btn = "发送验证码";
                    send.html(btn).attr('disabled', false);
                    index = 59;
                } else {
                    var delay = index + "秒后可重新发送";
                    send.html(delay).attr('disabled', true);
                }
                index--;
            }, 1000);
            $.ajax({
                type: 'post',
                url: '{$_route}account_bind?action=send_sms_code',
                data: {
                    phone: phone
                },
                success: function (data) {

                }
            })
        });
        //若有错误，禁止下一步
        $('.next').click(function () {
            var code = $(".code").val();
            if(code == ''){
                $(".code_mess").html('<i class="glyphicon glyphicon-remove">验证码不能为空！！</i>').addClass('error');
                return false;
            }
            $.ajax({
                type: 'post',
                url: '{$_route}account_bind?action=check_sms_code',
                data: {
                    code: code
                },
                success: function (data) {
                    console.log(data);
                    if (data.status == 0) {
                        var htm = '<i class="glyphicon glyphicon-remove">验证码不正确！！</i>';
                        $('.code_mess').removeClass("success");
                        $(".code_mess").html(htm).addClass("error");
                        return false;
                    } else {
                        window.location.href = '{$_route}account?action=nextPhone';
                    }
                },
                dataType: 'json'
            })
        })

    })
</script>