/**
 * Created by Administrator on 2015/6/16.
 */
function transPanel(id,callback){
    $(id).siblings('.active')
        .addClass('active-end')
        .one("webkitTransitionEnd", (function () {
            $(this).removeClass('active active-end');
            if(callback){
                callback();
            }
    }));
    $(id).addClass('active');
}
$(function(){
    /*页面切换*/
    $("#register-panel").click(function(){
        transPanel('.js-register-panel');
    });
    $("#forget-password-panel").click(function(){
        transPanel('.js-forget-pannel');
    });
    //$("#password-reset-panel").click(function(){
    //    $(".user-panel").css({
    //        transform:"translate(-50%,0)"
    //    })
    //})
    $("#login-panel").click(function(){
        transPanel('.js-login-panel');
    })
    $("#back1").click(function(){
        transPanel('.js-login-panel');
    })
    $("#back2").click(function(){
        transPanel('.js-forget-pannel');
    })
    /*手机号码正则*/
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
    /*密码验证*/
    function IsPassword(password) {
        if (password.length <7) {
            return false;
        }
        var myreg = /^\w{6,18}$/;
        if (!myreg.test(password)) {
            return false;
        }
        return true;
    }
    /*登录页面*/
    var loginUsername,loginPassword='';
    $(".js-login").click(function(){
        loginUsername=$(".js-login-username").val();
        loginPassword=$(".js-login-password").val();
        $.ajax({
            type:'post',
            url:'login_success',
            dataType:'json',
            data:{
                username:loginUsername,
                password:loginPassword
            },
            success:function(data){
                console.log(data);
                if(data['msg']==''){
                    $(".js-warning2").html("");
                    window.location.href=data.data;
                }else{
                    $(".js-warning2").html(data['msg']);
                }
            }
        })
    });

    /*注册页面*/
    var regUsername,regPhone,regCode,regPassword,warning='';
    $(".js-close-register").click(function(){
        $(".js-cover").hide();
        $(".js-modal1").hide();
        $(".js-reg-password,.js-reg-username,.js-reg-phone,.js-reg-code").val('');
        $(".js-reg-send-code").html('发送验证码');
        $(".user-panel").css({
            transform:"translate(0%,0)"
        })
    })
    $(".js-reg-phone").keyup(function(){
        regPhone=$(this).val();
        if(!IsMobile(regPhone)){
            $(".js-reg-send-code").attr("disabled",true);
        }else{
            $(".js-reg-send-code").attr("disabled",false);
        }
    });
    $(".js-reg-send-code").click(function(){
        var time=30;
        $(".js-reg-phone").trigger("blur");
        $(this).attr("disabled",true);
        var setTime=setInterval(function(){
            time--;
            var info="重新发送("+time+")";
            $(".js-reg-send-code").html(info);
            if(time<1){
                var info="重新发送";
                $(".js-reg-send-code").html(info);
                $(".js-reg-send-code").attr("disabled",false);
                clearInterval(setTime);
            }
        },1000);
        $.ajax({
            type:'post',
            url:'auth_code',
            dataType:'json',
            data:{
                phone:regPhone
            },
            success:function(data){

            }
        })
    });

    $(".js-register").click(function(){
        regCode=$('.js-reg-code').val();
        regUsername= $(".js-reg-username").val();
        regPhone=$(".js-reg-phone").val();
        regPassword=$(".js-reg-password").val();
        $.ajax({
            type:'post',
            url:'reg_success',
            dataType:'json',
            data:{
                auth_code:regCode,
                phone:regPhone,
                username:regUsername,
                password:regPassword
            },
            success:function(data){
                console.log(data);
                if(data['msg']==''){
                    $(".js-cover").show();
                     $(".js-modal1").show();
                    $(".js-warning1").html();
                    $(".js-ok").click(function(){
                        $("#login-panel").trigger('click');
                        $(".js-cover").hide();
                        $(".js-modal1").hide();
                    })
                }else{
                    $(".js-warning1").html(data['msg']);
                }
            }
        })
    });

    /*忘记密码*/
    /*验证手机是否存在*/
    $(".js-forget-phone").keyup(function(){
        var forgetPhone=$(this).val();
        $.ajax({
            type:'post',
            url:'phone_validate',
            dataType:'json',
            data:{
                phone:forgetPhone
            },
            success:function(data){
                console.log(data);
                if(data['msg']==''){
                    $(".js-forget-send-code").attr("disabled",false);
                }else{
                    $(".js-forget-send-code").attr("disabled",true);
                }
            }
        })
    })
    /*发送验证码*/
    $(".js-forget-send-code").click(function(){
        var time=30;
        var forgetPhone1=$(".js-forget-phone").val();
        $(this).attr("disabled",true);
        var setTime=setInterval(function(){
            time--;
            var info="重新发送("+time+")";
            $(".js-forget-send-code").html(info);
            if(time<1){
                var info="重新发送";
                $(".js-forget-send-code").html(info);
                $(".js-forget-send-code").attr("disabled",false);
                clearInterval(setTime);
            }
        },1000);
        $.ajax({
            type:'post',
            url:'auth_code',
            dataType:'json',
            data:{
                phone:forgetPhone1
            },
            success:function(data){}
        })
    });
    /*立即重置*/
    $(".js-password-reset-panel").click(function(){
        var forgetPhone2=$(".js-forget-phone").val();
        var forgetCode=$(".js-forget-code").val();
        $.ajax({
            type:'post',
            url:'code_validate',
            dataType:'json',
            data:{
                code:forgetCode,
                phone:forgetPhone2
            },
            success:function(data){
                console.log(data);
                if(data['msg']==''){
                    $(".js-warning3").html("");
                    transPanel('.js-password-reset-panel');
                }else{
                    $(".js-warning3").html(data['msg']);
                }
            }
        })
    })

    /*重置密码*/
    $("#forget-password-finish").click(function(){
       var resetPhone=$(".js-forget-phone").val();
       var resetPassword=$(".js-reset-new-password").val();
       var rePassword=$(".js-reset-rewrite-password").val();
        if(resetPassword!=rePassword){
            $(".js-warning4").html('*两次密码不一致！！');
            return false;
        }
        $.ajax({
            type:'post',
            url:'update_password',
            dataType:'json',
            data:{
                password:resetPassword,
                phone:resetPhone
            },
            success:function(data){
                console.log(data);
                if(data['msg']==''){
                    $(".js-cover2").show();
                    $(".js-modal2").show();
                    $(".js-reset-phone,.js-reset-new-password,.js-reset-rewrite-password,.js-forget-phone,.js-forget-code").val("");
                    $(".js-forget-send-code").html("发送验证码");
                    $(".js-warning4").html("");
                    $(".js-close-reset").click(function(){
                        transPanel('.js-login-panel');
                        $(".js-cover2").hide();
                        $(".js-modal2").hide();
                    })
                }else{
                    $(".js-warning4").html(data['msg']);
                }
            }
        })
    });

    $(".agree").on("click",function(){
        $(".cover-agreement").fadeIn(400);
        $(".agreement").css({
            top:"5%",
            opacity:"1"
        })
    });
    $(".close-agreement,.cover-agreement").on("click",function(){
        $(".cover-agreement").fadeOut(400);
        $(".agreement").css({
            top:"100%",
            opacity:"0"
        })
    })








})
