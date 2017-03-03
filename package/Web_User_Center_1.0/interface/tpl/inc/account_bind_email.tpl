<style>
    .success{
        color:#008000;
    }
    .error{
        color:#ff0000;
    }
</style>
<form action="" class="form-horizontal" method="post" enctype="multipart/form-data">
    <input type="hidden" name="security_submit" value="1">
    <input type="hidden" name="url_back" value="{$_REQUEST['url_back']}">

    <div class="form-body">
        <h3 class="form-section">绑定邮箱</h3>

        <div class="form-group">
            <label class="col-md-3 control-label">绑定邮箱</label>
            <div class="col-md-4">
                <input type="text" class="form-control email" placeholder="绑定邮箱" name="data[绑定邮箱]" value={$__user['email']}>
                <span class="email_mess"></span>
            </div>
        </div>
    </div>

    <div class="form-actions">
        <div class="row">
            <div class="col-md-offset-3 col-md-9">
                <button type="button" class="btn btn-info identity_email">
                    验证邮箱
                </button>
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
    $(document).ready(function(){
        {literal}
        function IsEmail(email) {
            if (email.length == 0) {
                return false;
            }
            var myreg = /^([\.a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[\.a-zA-Z0-9_-])+$/ ;
            if (!myreg.test(email)) {
               //alert(email);
                return false;
            }
            return true;
        }
        {/literal}
        $('.email').blur(function() {
             var email=$('.email').val();
            if(IsEmail(email)&&email!=''){
//                    var info='<i class="glyphicon glyphicon-ok">邮箱格式正确！！</i>';
//                    $('.email_mess').removeClass('error');
//                    $('.email_mess').html(info).addClass('success');
                $.ajax({
                    type:'post',
                    url:'{$_route}account_bind?action=check_email',
                    data:{
                        email:email
                    },
                    success:function(json){
//                        alert(json.code);
                        if(json.code=='error'){
                            var info='<i class="glyphicon glyphicon-remove">该邮箱已绑定！！</i>';
                            $('.email_mess').removeClass('success');
                            $('.email_mess').html(info).addClass('error');
                        }else{
                            var info='<i class="glyphicon glyphicon-ok">该邮箱可以绑定！！</i>';
                            $('.email_mess').removeClass('error');
                            $('.email_mess').html(info).addClass('success');
                        }
                    },
                    dataType:'json'
                });
            }else{
                var info='<i class="glyphicon glyphicon-remove">请输入正确的邮箱格式！！</i>';
                $('.email_mess').removeClass('success');
                $('.email_mess').html(info).addClass('error');
            }
        });

        $('.identity_email').click(function() {
            $('.email').trigger('blur');
            if(!$('.email_mess').hasClass('error')){
                var email=$('.email').val();
                $.ajax({
                    type:'post',
                    url:'{$_route}account_bind?action=send_email',
                    data:{
                        email:email
                    },
                    success:function(json){
                        if(json.code=='success'){
                            window.location.href='{$_route}account_bind?action=send_email_success&success=1';
                        }else{
                            //发送邮件是异步，无论是否发送成功都提示发送成功
                            window.location.href='{$_route}account_bind?action=send_email_success&success=1';
                        }
                    },
                    dataType:'json'
                })
           }
        })
    })
</script>