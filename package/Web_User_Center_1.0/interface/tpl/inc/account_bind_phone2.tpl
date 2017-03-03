<style>
    .error {
        color: #ff0000;
    }

    .success {
        color: #008000;
    }
</style>
<form action="" class="form-horizontal" method="post">
    <div class="form-body" id="form_p">
        <h3 class="form-section">绑定手机</h3>

        <div class="form-group">
            <label class="col-md-3 control-label">绑定手机号码</label>

            <div class="col-md-4">
                <input type="text" class="pull-left form-control tel" placeholder="绑定手机号码">
                <span class="pull-left tel_mess"></span>
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-3 control-label">验证码</label>

            <div class="col-md-2">
                <input type="text" class="form-control code2" placeholder="验证码">
                <span class="code_mess"></span>
            </div>
            <div class="col-md-2">
                <button type="button" class="btn btn-danger send">
                    发送验证码
                </button>
            </div>
        </div>

    </div>
    <div class="form-actions">
        <div class="row">
            <div class="col-md-offset-3 col-md-9">
                <a href="javascript:;" class="btn btn-info changePhone">
                    提交
                </a>
                <a href="javascript:window.history.go(-1)" class="btn btn-default">
                    返回
                </a>
            </div>
        </div>
    </div>
</form>

<script>
    $(document).ready(function () {
        var index = 59;
        var send = $(".send");
        send.click(function () {
            var tel = $(".tel").val();
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
                    phone: tel
                },
                success: function (data) {

                }
            })
        });

        $('.changePhone').click(function(){
            var tel = $(".tel").val();
            var code = $(".code2").val();
            if(tel==''){
                $(".tel_mess").html('<i class="glyphicon glyphicon-remove">手机号码不能为空</i>').addClass('error');
                return false;
            }
            if(!IsMobile(tel)){
                $(".tel_mess").html('<i class="glyphicon glyphicon-remove">手机号码格式有误</i>').addClass('error');
                return false;
            }

            if(code == ''){
                $(".code_mess").html('<i class="glyphicon glyphicon-remove">验证码不能为空</i>').addClass('error');
                return false;
            }
            $.post('{$_route}account_bind?action=check_code_and_phone',{ phone:tel,code:code },function(data){
                console.log(data);
                if(data.status==1){
                    window.location.href = '{$_route}account';
                }else{
                    if(data.data=='phone'){
                        $(".tel_mess").html('<i class="glyphicon glyphicon-remove">'+data.msg+'</i>').addClass('error');
                    }else if(data.data=='code'){
                        $(".code_mess").html('<i class="glyphicon glyphicon-remove">'+data.msg+'</i>').addClass('error');
                    }
                    return false;
                }
            },'json')


        })

        {literal}

        function IsMobile(mobile) {
            if (mobile.length != 11) {
                return false;
            }
            var myreg = /^((1[3|5|7|8]{1})+\d{9})$/;
            if (!myreg.exec(mobile)) {
                return false;
            }
            return true;
        }
        {/literal}

    })

</script>